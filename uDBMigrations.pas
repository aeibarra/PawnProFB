unit uDBMigrations;

{
  Startup schema-migration runner (Firebird 5 / FireDAC).

  Replaces the manual "apply the .sql script on each store" step for
  ALREADY-DEPLOYED stores. On startup the app calls EnsureDatabaseCurrent, which:

    1. Bootstraps APP_STATE (+ its stored procs) if the store never got that
       patch — needed because the schema version itself lives in APP_STATE
       (chicken-and-egg: we must be able to read/write the version first).
    2. Reads APP_STATE.DB_SCHEMA_VERSION (0 when the key is absent).
    3. Runs each pending step in order, bumping the stored version after each
       one so a mid-run failure records the progress made.

  Every step is ALSO idempotent (guarded by an existence check), so a store
  that already has an object — e.g. one where the .sql migration was applied by
  hand — is left untouched and simply advanced to the current version.

  Canonical, human-readable copies of every statement live under
  Schema/Migrations/*.sql (and the fresh-store full-deploy script). The DDL is
  duplicated here as strings so the migration ships INSIDE the EXE and can never
  be out of sync with a missing .sql file on a workstation.

  ADDING A MIGRATION:
    - bump CURRENT_DB_VERSION,
    - add a Step<N>_* procedure (idempotent),
    - call it from EnsureDatabaseCurrent under `if V < N`,
    - AND add the matching Schema/Migrations/PawnPro_FB5_*.sql + patch the
      schema / full-deploy scripts (per CLAUDE.md).
}

interface

uses
  FireDAC.Stan.Param, FireDAC.Comp.Client;

const
  // Bump this whenever a new Step<N>_* is added below.
  CURRENT_DB_VERSION = 5;

{ Ensures the connected database is at CURRENT_DB_VERSION, applying any pending
  steps. Raises on failure — the caller must treat that as fatal (do not run the
  app against a half-migrated database). }
procedure EnsureDatabaseCurrent(Conn: TFDConnection);

implementation

uses
  System.SysUtils, PawnGlobal;

{ ---- low-level helpers -------------------------------------------------- }

// Executes a DDL / PSQL statement. ParamCreate/MacroCreate are disabled so that
// ':name' and '&macro' tokens inside PSQL bodies (e.g. stored procedures) are
// sent verbatim to the server instead of being treated as FireDAC bind params.
procedure ExecDDL(Conn: TFDConnection; const SQL: string);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.ResourceOptions.ParamCreate := False;
    Qry.ResourceOptions.MacroCreate := False;
    Qry.SQL.Text := SQL;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function RelationExists(Conn: TFDConnection; const ARelationName: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :N';
    Qry.Params.ParamByName('N').AsString := ARelationName;
    Qry.Open;
    Result := not Qry.Eof;
  finally
    Qry.Free;
  end;
end;

function ProcedureExists(Conn: TFDConnection; const AName: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = :N';
    Qry.Params.ParamByName('N').AsString := AName;
    Qry.Open;
    Result := not Qry.Eof;
  finally
    Qry.Free;
  end;
end;

function FunctionExists(Conn: TFDConnection; const AName: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT 1 FROM RDB$FUNCTIONS WHERE RDB$FUNCTION_NAME = :N';
    Qry.Params.ParamByName('N').AsString := AName;
    Qry.Open;
    Result := not Qry.Eof;
  finally
    Qry.Free;
  end;
end;

function GetDbVersion(Conn: TFDConnection): Integer;
var
  Qry: TFDQuery;
begin
  Result := 0;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT VALUE_INT FROM APP_STATE WHERE STATE_KEY = :K';
    Qry.Params.ParamByName('K').AsString := AppStateKeyDbSchemaVersion;
    Qry.Open;
    if (not Qry.Eof) and (not Qry.Fields[0].IsNull) then
      Result := Qry.Fields[0].AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure SetDbVersion(Conn: TFDConnection; AVersion: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text :=
      'UPDATE OR INSERT INTO APP_STATE (STATE_KEY, VALUE_INT) ' +
      'VALUES (:K, :V) MATCHING (STATE_KEY)';
    Qry.Params.ParamByName('K').AsString := AppStateKeyDbSchemaVersion;
    Qry.Params.ParamByName('V').AsInteger := AVersion;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

{ ---- bootstrap: APP_STATE table + procs (mirror of
       Schema/Migrations/PawnPro_FB5_AddAppState.sql) --------------------- }

procedure EnsureAppState(Conn: TFDConnection);
begin
  // APP_STATE + its procs are always created together, so a single existence
  // check on the table is enough. Skipping when present avoids per-startup DDL
  // (Firebird metadata churn).
  if RelationExists(Conn, 'APP_STATE') then
    Exit;

  ExecDDL(Conn,
    'CREATE TABLE APP_STATE (' +
    '  STATE_KEY       VARCHAR(50)  NOT NULL,' +
    '  STATE_DESC      VARCHAR(255),' +
    '  VALUE_TEXT      VARCHAR(255),' +
    '  VALUE_INT       INTEGER,' +
    '  VALUE_CURRENCY  NUMERIC(18,2),' +
    '  VALUE_DATE      TIMESTAMP,' +
    '  CONSTRAINT PK_APP_STATE PRIMARY KEY (STATE_KEY))');

  ExecDDL(Conn,
    'CREATE OR ALTER PROCEDURE SPS_APP_STATE (P_STATE_KEY VARCHAR(50))' +
    ' RETURNS (STATE_DESC VARCHAR(255), VALUE_TEXT VARCHAR(255), VALUE_INT INTEGER,' +
    '          VALUE_CURRENCY NUMERIC(18,2), VALUE_DATE TIMESTAMP)' +
    ' SQL SECURITY INVOKER AS BEGIN' +
    '   FOR SELECT STATE_DESC, VALUE_TEXT, VALUE_INT, VALUE_CURRENCY, VALUE_DATE' +
    '       FROM APP_STATE WHERE STATE_KEY = :P_STATE_KEY' +
    '       INTO :STATE_DESC, :VALUE_TEXT, :VALUE_INT, :VALUE_CURRENCY, :VALUE_DATE' +
    '   DO SUSPEND;' +
    ' END');

  ExecDDL(Conn,
    'CREATE OR ALTER PROCEDURE SPU_APP_STATE (P_STATE_KEY VARCHAR(50),' +
    '   P_VALUE_TEXT VARCHAR(255), P_VALUE_INT INTEGER,' +
    '   P_VALUE_CURRENCY NUMERIC(18,2), P_VALUE_DATE TIMESTAMP)' +
    ' SQL SECURITY INVOKER AS BEGIN' +
    '   UPDATE OR INSERT INTO APP_STATE' +
    '     (STATE_KEY, VALUE_TEXT, VALUE_INT, VALUE_CURRENCY, VALUE_DATE)' +
    '   VALUES (:P_STATE_KEY, :P_VALUE_TEXT, :P_VALUE_INT, :P_VALUE_CURRENCY, :P_VALUE_DATE)' +
    '   MATCHING (STATE_KEY);' +
    ' END');
end;

{ ---- migration steps ---------------------------------------------------- }

// v1 — EXPORT_IMAGE_SENT (mirror of PawnPro_FB5_AddExportImageSent.sql):
// tracks LeadsOnline customer ID photos sent once per transaction.
procedure Step1_ExportImageSent(Conn: TFDConnection);
begin
  if RelationExists(Conn, 'EXPORT_IMAGE_SENT') then
    Exit;

  ExecDDL(Conn,
    'CREATE TABLE EXPORT_IMAGE_SENT (' +
    '  ID                INTEGER   GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
    '  TRANSACTION_NO    INTEGER   NOT NULL,' +
    '  IMAGES_DATA_NO    INTEGER   NOT NULL,' +
    '  UPLOAD_TIME       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
    '  UPLOAD_FILE_NAME  VARCHAR(50),' +
    '  CONSTRAINT PK_EXPORT_IMAGE_SENT PRIMARY KEY (ID),' +
    '  CONSTRAINT UQ_EXPORT_IMAGE_SENT UNIQUE (TRANSACTION_NO, IMAGES_DATA_NO))');
end;

// v2 - remembers transactions whose customer-ID upload must be retried. Rows
// are created only when the item-image send loop qualifies the transaction.
procedure Step2_ExportImagePending(Conn: TFDConnection);
begin
  if RelationExists(Conn, 'EXPORT_IMAGE_PENDING') then
    Exit;

  ExecDDL(Conn,
    'CREATE TABLE EXPORT_IMAGE_PENDING (' +
    '  TRANSACTION_NO INTEGER NOT NULL,' +
    '  QUEUED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
    '  CONSTRAINT PK_EXPORT_IMAGE_PENDING PRIMARY KEY (TRANSACTION_NO))');
end;

// v3 - drop the retired late-payment report objects. Report01 now computes
// lateness in Pascal (DM.GetInterestAndNextPaymentInfo), so neither the proc nor
// its helper function is referenced anywhere. Mirror of
// PawnPro_FB5_DropLatePaymentReportProc.sql. Drop the procedure first: it depends
// on the function, and Firebird refuses to drop a function still in use.
procedure Step3_DropLatePaymentReportProc(Conn: TFDConnection);
begin
  if ProcedureExists(Conn, 'REP_CUSTOMER_WITH_LATE_PAYMENTS') then
    ExecDDL(Conn, 'DROP PROCEDURE REP_CUSTOMER_WITH_LATE_PAYMENTS');

  if FunctionExists(Conn, 'FN_TRAN_WITH_LATE_PAYMENT') then
    ExecDDL(Conn, 'DROP FUNCTION FN_TRAN_WITH_LATE_PAYMENT');
end;

{ v4: STORE.DEFAULT_WEIGHT_MEASURE_UNIT must hold 'P' or 'G'.

  The column was created nullable with no DEFAULT, so a store that never opened
  the settings screen can sit on NULL. That value now drives the gold price bar
  as well as new item/stone weights, so repair the row and give the column a
  DEFAULT so it cannot come back. A CHAR(1) written as '' reads back as a single
  space, which the NOT IN test catches along with NULL. }
procedure Step4_DefaultWeightMeasureUnit(Conn: TFDConnection);
begin
  ExecDDL(Conn,
    'UPDATE STORE ' +
    '   SET DEFAULT_WEIGHT_MEASURE_UNIT = ''P'' ' +
    ' WHERE DEFAULT_WEIGHT_MEASURE_UNIT IS NULL ' +
    '    OR DEFAULT_WEIGHT_MEASURE_UNIT NOT IN (''G'', ''P'')');

  ExecDDL(Conn,
    'ALTER TABLE STORE ALTER COLUMN DEFAULT_WEIGHT_MEASURE_UNIT SET DEFAULT ''P''');
end;

{ v5: backfill PAWNED_DATE on pawn items copied into a new ticket.

  The copy-items path inserted INV_ITEM_STATUS='P' with no PAWNED_DATE, and
  GetPawnItemStatus reads the dates rather than INV_ITEM_STATUS, so those rows
  showed a blank status. The insert is fixed; this repairs what it already
  wrote, dating each row to its own ticket rather than to today so back-dated
  tickets stay honest. Guarded to rows carrying no entry date at all, so no
  existing date is ever overwritten, and idempotent by the same condition. }
procedure Step5_BackfillPawnedDate(Conn: TFDConnection);
begin
  ExecDDL(Conn,
    'UPDATE INVENTORY_ITEMS ii ' +
    '   SET ii.PAWNED_DATE = (SELECT t.TRAN_DATE ' +
    '                           FROM TRANSACTIONS t ' +
    '                          WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO) ' +
    ' WHERE ii.INV_ITEM_STATUS = ''P'' ' +
    '   AND ii.PAWNED_DATE    IS NULL ' +
    '   AND ii.PURCHASE_DATE  IS NULL ' +
    '   AND ii.LAYAWAY_DATE   IS NULL ' +
    '   AND ii.SOLD_DATE      IS NULL ' +
    '   AND EXISTS (SELECT 1 ' +
    '                 FROM TRANSACTIONS t ' +
    '                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO ' +
    '                  AND t.TRAN_DATE IS NOT NULL)');
end;

{ ---- orchestrator ------------------------------------------------------- }

procedure EnsureDatabaseCurrent(Conn: TFDConnection);
var
  V: Integer;
begin
  EnsureAppState(Conn);

  V := GetDbVersion(Conn);
  if V >= CURRENT_DB_VERSION then
    Exit;

  if V < 1 then
  begin
    Step1_ExportImageSent(Conn);
    SetDbVersion(Conn, 1);
  end;

  if V < 2 then
  begin
    Step2_ExportImagePending(Conn);
    SetDbVersion(Conn, 2);
  end;

  if V < 3 then
  begin
    Step3_DropLatePaymentReportProc(Conn);
    SetDbVersion(Conn, 3);
  end;

  if V < 4 then
  begin
    Step4_DefaultWeightMeasureUnit(Conn);
    SetDbVersion(Conn, 4);
  end;

  if V < 5 then
  begin
    Step5_BackfillPawnedDate(Conn);
    SetDbVersion(Conn, 5);
  end;

  // Future steps: if V < 6 then begin Step6_...(Conn); SetDbVersion(Conn, 6); end;
end;

end.
