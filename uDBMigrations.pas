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
  CURRENT_DB_VERSION = 15;

{ Ensures the connected database is at CURRENT_DB_VERSION, applying any pending
  steps. Raises on failure — the caller must treat that as fatal (do not run the
  app against a half-migrated database).

  ONLY THE MACHINE THAT HOLDS THE DATABASE MAY CALL THIS. Every step is
  idempotent, but idempotent is not the same as concurrency-safe: two PCs
  starting together can both pass the same `if not ColumnExists` guard and issue
  the same DDL, which Firebird rejects with a metadata lock error. Since a failed
  migration is fatal, that would stop tills from opening. Workstations call
  DatabaseIsCurrent instead. }
procedure EnsureDatabaseCurrent(Conn: TFDConnection);

{ Read-only counterpart for a machine that must NOT migrate. True when the
  database is already at CURRENT_DB_VERSION.

  Creates and alters nothing, and never raises: a missing APP_STATE — or any
  other failure to read the version — counts as "not current", which is exactly
  the situation the caller has to catch. }
function DatabaseIsCurrent(Conn: TFDConnection): Boolean;

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

function IndexExists(Conn: TFDConnection; const AIndexName: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = :N';
    Qry.Params.ParamByName('N').AsString := AIndexName;
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

function ColumnExists(Conn: TFDConnection; const ARelationName, AColumnName: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := Conn;
    Qry.SQL.Text := 'SELECT 1 FROM RDB$RELATION_FIELDS ' +
                    ' WHERE RDB$RELATION_NAME = :R AND RDB$FIELD_NAME = :F';
    Qry.Params.ParamByName('R').AsString := ARelationName;
    Qry.Params.ParamByName('F').AsString := AColumnName;
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

{ v6: LeadsOnline SOAP export channel — store settings + submission log.

  Purely additive. LEADS_ONLINE_EXPORT_METHOD defaults to 'C' (CSV over FTP),
  so every already-deployed store keeps exactly the behaviour it has today until
  someone deliberately switches it to 'S'.

  No LEADS_ONLINE_API_STORE_ID: STORE.LEADS_STORE_ID already holds LeadsOnline's
  store number (the CSV path builds image filenames from it) and it is the same
  value SOAP's LoginInfo.storeId wants.

  Deliberately no NOT NULL on the two new switches. This runs at startup and a
  failure here stops the app from opening at all on three live stores; a
  DEFAULT plus an explicit backfill gets the same result with fewer ways to
  fail, and the reading code coalesces NULL anyway.

  Mirror of Schema/Migrations/PawnPro_FB5_LeadsOnlineSoap.sql. }
procedure Step6_LeadsOnlineSoap(Conn: TFDConnection);
begin
  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_API_USER') then
    ExecDDL(Conn, 'ALTER TABLE STORE ADD LEADS_ONLINE_API_USER VARCHAR(50)');

  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_API_PASSWORD') then
    ExecDDL(Conn, 'ALTER TABLE STORE ADD LEADS_ONLINE_API_PASSWORD VARCHAR(255)');

  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_EXPORT_METHOD') then
    ExecDDL(Conn, 'ALTER TABLE STORE ADD LEADS_ONLINE_EXPORT_METHOD CHAR(1) DEFAULT ''C''');

  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_USE_SANDBOX') then
    ExecDDL(Conn, 'ALTER TABLE STORE ADD LEADS_ONLINE_USE_SANDBOX BOOLEAN DEFAULT FALSE');

  // Firebird applies a new column's DEFAULT to future inserts, not to rows that
  // already exist — those read NULL until told otherwise. Idempotent by IS NULL.
  ExecDDL(Conn,
    'UPDATE STORE SET LEADS_ONLINE_EXPORT_METHOD = ''C'' ' +
    ' WHERE LEADS_ONLINE_EXPORT_METHOD IS NULL');

  ExecDDL(Conn,
    'UPDATE STORE SET LEADS_ONLINE_USE_SANDBOX = FALSE ' +
    ' WHERE LEADS_ONLINE_USE_SANDBOX IS NULL');

  if RelationExists(Conn, 'LEADS_SOAP_SUBMISSION') then
    Exit;

  // SOAP hands back no ticket id, so the composite key below is the only handle
  // on a submitted ticket. Stored exactly as transmitted — see the .sql file.
  ExecDDL(Conn,
    'CREATE TABLE LEADS_SOAP_SUBMISSION (' +
    '  ID               INTEGER      GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
    '  TRANSACTION_NO   INTEGER      NOT NULL,' +
    '  TICKET_TYPE      VARCHAR(20)  NOT NULL,' +
    '  TICKET_NUMBER    VARCHAR(50)  NOT NULL,' +
    '  TICKET_DATETIME  VARCHAR(30)  NOT NULL,' +
    '  SUBMITTED_AT     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
    '  ERROR_CODE       INTEGER,' +
    '  ERROR_RESPONSE   VARCHAR(500),' +
    '  IS_VOID          BOOLEAN      DEFAULT FALSE NOT NULL,' +
    '  CONSTRAINT PK_LEADS_SOAP_SUBMISSION PRIMARY KEY (ID),' +
    '  CONSTRAINT UQ_LEADS_SOAP_SUBMISSION UNIQUE (TRANSACTION_NO))');
end;

{ v7: LeadsOnline becomes opt-in.

  Not every store is a LeadsOnline customer, so the default for a NEW store is
  now 'N' (not using) rather than 'C'. Existing rows are deliberately left
  alone: Step6 backfilled them to 'C', so stores already exporting by CSV keep
  working. Only future inserts see the new default, which in practice means
  only brand-new store databases.

  Mirror of Schema/Migrations/PawnPro_FB5_LeadsOnlineOptIn.sql. }
procedure Step7_LeadsOnlineOptIn(Conn: TFDConnection);
begin
  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_EXPORT_METHOD') then
    Exit;

  ExecDDL(Conn,
    'ALTER TABLE STORE ALTER COLUMN LEADS_ONLINE_EXPORT_METHOD SET DEFAULT ''N''');
end;

{ v8: skip transactions the CSV export already reported.

  Answers what a store does with its history on the day it moves to SOAP. The
  CSV export already logs what it sent (EXPORT_LOG_FILE_DETAIL), so the SOAP
  screen can leave those out and offer only what was never reported at all --
  including gaps mid-history, which a "start from this date" cutoff would miss.

  DEFAULT TRUE suits every store: one with CSV history wants it, and a new one
  has an empty export log so it excludes nothing.

  Mirror of Schema/Migrations/PawnPro_FB5_LeadsOnlineSkipCsvSent.sql. }
procedure Step8_LeadsOnlineSkipCsvSent(Conn: TFDConnection);
begin
  if not ColumnExists(Conn, 'STORE', 'LEADS_ONLINE_SKIP_CSV_SENT') then
    ExecDDL(Conn,
      'ALTER TABLE STORE ADD LEADS_ONLINE_SKIP_CSV_SENT BOOLEAN DEFAULT TRUE');

  // Firebird applies a new DEFAULT to future inserts only; existing rows read
  // NULL until set. Idempotent by IS NULL.
  ExecDDL(Conn,
    'UPDATE STORE SET LEADS_ONLINE_SKIP_CSV_SENT = TRUE ' +
    ' WHERE LEADS_ONLINE_SKIP_CSV_SENT IS NULL');
end;

{ v9: LEADS_SOAP_IMAGE_SENT -- images uploaded to LeadsOnline over SOAP.

  Deferred from Step6 until the vendor spec confirmed what UploadImage returns:
  Response.errorResponse carries a unique server-side name for the image, and it
  is the only handle DeleteImage can use. Without storing it, an image sent in
  error could never be withdrawn.

  Keyed by (TRANSACTION_NO, IMAGES_DATA_NO) like EXPORT_IMAGE_SENT, because a
  customer ID photo is one IMAGES_DATA row shared across that customer's
  transactions.

  Mirror of Schema/Migrations/PawnPro_FB5_LeadsSoapImageSent.sql. }
procedure Step9_LeadsSoapImageSent(Conn: TFDConnection);
begin
  if RelationExists(Conn, 'LEADS_SOAP_IMAGE_SENT') then
    Exit;

  ExecDDL(Conn,
    'CREATE TABLE LEADS_SOAP_IMAGE_SENT (' +
    '  ID               INTEGER      GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
    '  TRANSACTION_NO   INTEGER      NOT NULL,' +
    '  IMAGES_DATA_NO   INTEGER      NOT NULL,' +
    '  IMAGE_CATEGORY   VARCHAR(20)  NOT NULL,' +
    '  ITEM_INDEX       INTEGER,' +
    '  SERVER_FILENAME  VARCHAR(255),' +
    '  UPLOADED_AT      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
    '  ERROR_CODE       INTEGER,' +
    '  ERROR_RESPONSE   VARCHAR(500),' +
    '  CONSTRAINT PK_LEADS_SOAP_IMAGE_SENT PRIMARY KEY (ID),' +
    '  CONSTRAINT UQ_LEADS_SOAP_IMAGE_SENT UNIQUE (TRANSACTION_NO, IMAGES_DATA_NO))');
end;

{ Step 10 — LEADS_SOAP_EXCLUDED.

  Transactions the store has decided must never go to LeadsOnline. A store
  joining the web service brings its whole history: Perez Cash has 13,516 pawns
  and purchases that never appeared in any CSV export, the oldest from 2000.
  Nothing removes a transaction from the candidate list until the service has
  answered about it, so without this they queue forever in front of the few
  rows that matter.

  Deliberately NOT a sentinel ERROR_CODE on LEADS_SOAP_SUBMISSION: that table's
  TICKET_TYPE / TICKET_NUMBER / TICKET_DATETIME are NOT NULL and hold exactly
  what was transmitted. These were never transmitted, so there is nothing
  truthful to put there.

  Mirror of Schema/Migrations/PawnPro_FB5_LeadsSoapExcluded.sql. }
procedure Step10_LeadsSoapExcluded(Conn: TFDConnection);
begin
  if RelationExists(Conn, 'LEADS_SOAP_EXCLUDED') then
    Exit;

  ExecDDL(Conn,
    'CREATE TABLE LEADS_SOAP_EXCLUDED (' +
    '  TRANSACTION_NO  INTEGER    NOT NULL,' +
    '  EXCLUDED_AT     TIMESTAMP  DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
    '  REASON          VARCHAR(255),' +
    '  CONSTRAINT PK_LEADS_SOAP_EXCLUDED PRIMARY KEY (TRANSACTION_NO))');
end;

{ v11: status char for pawn items defaulted to For Sale / Scrap before the app
  wrote it. Data fix only, no schema change.

  Defaulting a pawn used to write only FORSALE_DATE / MELTED_DATE and leave
  INV_ITEM_STATUS = 'P', so those items were invisible to anything that reads
  For Sale / Scrap stock by the char. Derived purely from the existing dates;
  For Sale wins if both are set (same rule as TDM.PawnItemStatusChar). Sold rows
  are never touched. Idempotent by its own WHERE.

  Mirror of Schema/Migrations/PawnPro_FB5_DefaultedPawnItemsStatus.sql. }
procedure Step11_DefaultedPawnItemsStatus(Conn: TFDConnection);
begin
  ExecDDL(Conn,
    'UPDATE INVENTORY_ITEMS ii ' +
    '   SET ii.INV_ITEM_STATUS = ''S'' ' +
    ' WHERE ii.INV_ITEM_STATUS = ''P'' ' +
    '   AND ii.SOLD_DATE    IS NULL ' +
    '   AND ii.FORSALE_DATE IS NOT NULL ' +
    '   AND EXISTS (SELECT 1 FROM TRANSACTIONS t ' +
    '                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO ' +
    '                  AND t.TRAN_TYPE = ''P'')');

  ExecDDL(Conn,
    'UPDATE INVENTORY_ITEMS ii ' +
    '   SET ii.INV_ITEM_STATUS = ''C'' ' +
    ' WHERE ii.INV_ITEM_STATUS = ''P'' ' +
    '   AND ii.SOLD_DATE    IS NULL ' +
    '   AND ii.FORSALE_DATE IS NULL ' +
    '   AND ii.MELTED_DATE  IS NOT NULL ' +
    '   AND EXISTS (SELECT 1 FROM TRANSACTIONS t ' +
    '                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO ' +
    '                  AND t.TRAN_TYPE = ''P'')');
end;

{ v12: sale tickets. SALES (one row per ticket, money as it was on the day,
  voided tickets kept) and SALE_LINES (one row per item), plus the TABLE_KEYS
  'SaleTicketNo' counter, starting at 3999 (SaleTicketStartAfter): tickets
  begin at 4000-4008 and grow by a random step (see TDM.CompleteSale). Until
  now a sale only flipped items to Sold.

  Deliberately no FK from SALE_LINES to INVENTORY_ITEMS: creating one needs
  INVENTORY_ITEMS free of other attachments, and this runs at startup while
  store workstations may be connected -- a failed step would stop the app.
  The FK to SALES is safe: that table is brand new and nobody else uses it.
  Without that FK nothing indexes SALE_LINES.INV_ITEM_NO, so it gets its own
  index (every "is this item on a ticket?" lookup uses it), and SALES gets one
  on SALE_DATE for the ticket history list. Both on the new tables only.

  Mirror of Schema/Migrations/PawnPro_FB5_SalesTickets.sql. }
{ Days declared to LeadsOnline as having had no pawn activity, through the web
  service's SetNoTransactionDayForStore. Asked for by Gema, whose local police
  want to be told rather than infer it from silence.

  Every attempt is recorded, failures included: the notification screen's grid
  exists to show what went wrong, and a table of successes only could not do
  that. Written with UPDATE OR INSERT MATCHING (ACTIVITY_DATE) so a retry after
  a connection failure overwrites the earlier attempt instead of colliding with
  the unique constraint. }
procedure Step13_LeadsSoapNoActivity(Conn: TFDConnection);
begin
  if not RelationExists(Conn, 'LEADS_SOAP_NO_ACTIVITY') then
    ExecDDL(Conn,
      'CREATE TABLE LEADS_SOAP_NO_ACTIVITY (' +
      '  ID              INTEGER   GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
      '  ACTIVITY_DATE   DATE      NOT NULL,' +
      '  DECLARED_AT     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,' +
      '  ERROR_CODE      INTEGER,' +
      '  ERROR_RESPONSE  VARCHAR(500),' +
      '  CONSTRAINT PK_LEADS_SOAP_NO_ACTIVITY PRIMARY KEY (ID),' +
      '  CONSTRAINT UQ_LEADS_SOAP_NO_ACTIVITY UNIQUE (ACTIVITY_DATE))');
end;

{ v15: Receive Stock -- supplier (wholesale) purchases. SUPPLIERS, one
  STOCK_RECEIPTS row per supplier invoice, one STOCK_RECEIPT_LINES row per item
  received (description, cost and price as on the day). Received items are
  ordinary INVENTORY_ITEMS rows, For Sale, with TRANSACTION_NO NULL -- never in a
  police export or a pawn list.

  Nothing on INVENTORY_ITEMS changes but its delete trigger, which now also logs
  the receipt (INVENTORY_ITEMS_DELETED.STOCK_RECEIPT_NO). No FK from the lines to
  INVENTORY_ITEMS, as with SALE_LINES. Tested while another connection held an
  uncommitted change on INVENTORY_ITEMS.

  Mirror of Schema/Migrations/PawnPro_FB5_StockReceipts.sql. }
procedure Step15_StockReceipts(Conn: TFDConnection);
begin
  if not RelationExists(Conn, 'SUPPLIERS') then
    ExecDDL(Conn,
      'CREATE TABLE SUPPLIERS ' +
      '       ( ' +
      '         SUPPLIER_NO         INTEGER        GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL, ' +
      '         SUPPLIER_NAME       VARCHAR(80)    NOT NULL, ' +
      '         CONTACT_NAME        VARCHAR(60), ' +
      '         PHONE               VARCHAR(20), ' +
      '         EMAIL               VARCHAR(80), ' +
      '         ADDRESS             VARCHAR(120), ' +
      '         CITY_ST_ZIP         VARCHAR(80), ' +
      '         NOTES               VARCHAR(500), ' +
      '         ACTIVE              BOOLEAN        DEFAULT TRUE NOT NULL, ' +
      '         CREATED             TIMESTAMP      DEFAULT CURRENT_TIMESTAMP, ' +
      '         CONSTRAINT PK_SUPPLIERS PRIMARY KEY (SUPPLIER_NO), ' +
      '         CONSTRAINT UQ_SUPPLIERS_NAME UNIQUE (SUPPLIER_NAME) ' +
      '       )');

  if not RelationExists(Conn, 'STOCK_RECEIPTS') then
    ExecDDL(Conn,
      'CREATE TABLE STOCK_RECEIPTS ' +
      '       ( ' +
      '         STOCK_RECEIPT_NO    INTEGER        GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL, ' +
      '         SUPPLIER_NO         INTEGER        NOT NULL, ' +
      '         RECEIVED_DATE       DATE           DEFAULT CURRENT_DATE NOT NULL, ' +
      '         INVOICE_NO          VARCHAR(40), ' +
      '         INVOICE_DATE        DATE, ' +
      '         INVOICE_TOTAL       DECIMAL(18,2), ' +
      '         PAY_TYPE_NO         INTEGER, ' +
      '         NOTES               VARCHAR(500), ' +
      '         RECEIPT_STATUS      CHAR(1)        DEFAULT ''A'' NOT NULL, ' +
      '         VOID_DATE           TIMESTAMP, ' +
      '         VOID_REASON         VARCHAR(120), ' +
      '         CREATED             TIMESTAMP      DEFAULT CURRENT_TIMESTAMP, ' +
      '         CONSTRAINT PK_STOCK_RECEIPTS PRIMARY KEY (STOCK_RECEIPT_NO), ' +
      '         CONSTRAINT FK_STOCK_RECEIPTS_SUPPLIERS FOREIGN KEY (SUPPLIER_NO) REFERENCES SUPPLIERS (SUPPLIER_NO) ' +
      '       )');

  if not RelationExists(Conn, 'STOCK_RECEIPT_LINES') then
    ExecDDL(Conn,
      'CREATE TABLE STOCK_RECEIPT_LINES ' +
      '       ( ' +
      '         STOCK_RECEIPT_LINE_NO INTEGER      GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL, ' +
      '         STOCK_RECEIPT_NO    INTEGER        NOT NULL, ' +
      '         INV_ITEM_NO         INTEGER        NOT NULL, ' +
      '         DESCRIPTION         VARCHAR(120), ' +
      '         UNIT_COST           DECIMAL(18,2), ' +
      '         UNIT_PRICE          DECIMAL(18,2), ' +
      '         COPY_GROUP          INTEGER, ' +
      '         CONSTRAINT PK_STOCK_RECEIPT_LINES PRIMARY KEY (STOCK_RECEIPT_LINE_NO), ' +
      '         CONSTRAINT FK_STOCK_RECEIPT_LINES_RECEIPTS FOREIGN KEY (STOCK_RECEIPT_NO) REFERENCES STOCK_RECEIPTS (STOCK_RECEIPT_NO) ' +
      '       )');

  // Copy groups came after the first v15 build: a DB that already has the
  // table gets the column here.
  if not ColumnExists(Conn, 'STOCK_RECEIPT_LINES', 'COPY_GROUP') then
    ExecDDL(Conn, 'ALTER TABLE STOCK_RECEIPT_LINES ADD COPY_GROUP INTEGER');
  if not ColumnExists(Conn, 'INVENTORY_ITEMS_DELETED', 'STOCK_RECEIPT_NO') then
    ExecDDL(Conn, 'ALTER TABLE INVENTORY_ITEMS_DELETED ADD STOCK_RECEIPT_NO INTEGER');

  if not IndexExists(Conn, 'STOCK_RECEIPTS_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX STOCK_RECEIPTS_IDX1 ON STOCK_RECEIPTS (RECEIVED_DATE)');

  if not IndexExists(Conn, 'STOCK_RECEIPT_LINES_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX STOCK_RECEIPT_LINES_IDX1 ON STOCK_RECEIPT_LINES (INV_ITEM_NO)');

  // The v14 deleted-items trigger, now also recording the stock receipt.
  ExecDDL(Conn,
      'CREATE OR ALTER TRIGGER TRG_INV_ITEMS_DELETED_LOG FOR INVENTORY_ITEMS ' +
      'ACTIVE BEFORE DELETE POSITION 0 SQL SECURITY INVOKER AS ' +
      'DECLARE VARIABLE TICKET VARCHAR(30); ' +
      'DECLARE VARIABLE TTYPE CHAR(1); ' +
      'DECLARE VARIABLE DEL_WITH CHAR(1) = ''I''; ' +
      'BEGIN ' +
      '  SELECT TRAN_TICKET_NO, TRAN_TYPE FROM TRANSACTIONS ' +
      '   WHERE TRANSACTION_NO = OLD.TRANSACTION_NO ' +
      '    INTO :TICKET, :TTYPE; ' +
      ' ' +
      '  /* Deleted with its transaction: that row is already gone, so take the ' +
      '     ticket the transaction trigger left behind. */ ' +
      '  IF (RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_NO'') = CAST(OLD.TRANSACTION_NO AS VARCHAR(20))) THEN ' +
      '  BEGIN ' +
      '    DEL_WITH = ''T''; ' +
      '    TICKET = COALESCE(TICKET, RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TICKET'')); ' +
      '    TTYPE = COALESCE(TTYPE, RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TYPE'')); ' +
      '  END ' +
      ' ' +
      '  INSERT INTO INVENTORY_ITEMS_DELETED ( ' +
      '    INV_ITEM_NO, INV_ITEM_BARCODE, INV_CAT_NO, J_TYPE, J_STYLE, J_METAL, GENDER, ' +
      '    INV_ITEM_COUNT, DESCRIPTION, NOTE, INV_ITEM_BRAND, MODEL_NUMBER, SERIAL_NUMBER, ' +
      '    OWNER_APP_NUMBER, SIZE_LENGTH, WEIGHT, WEIGHT_UNIT, KT, UNIT_COST, UNIT_PRICE, ' +
      '    INV_ITEM_STATUS, TRANSACTION_NO, TRAN_TICKET_NO, TRAN_TYPE, INV_ORIGINAL_ITEM_NO, ' +
      '    CREATED, PAWNED_DATE, PURCHASE_DATE, REDEEMED_DATE, DEFAULTED_DATE, MELTED_DATE, ' +
      '    FORSALE_DATE, SOLD_DATE, LAYAWAY_DATE, ' +
      '    STONES, SALE_TICKETS, STOCK_RECEIPT_NO, DELETED_WITH, DELETED_ON, DELETE_REASON) ' +
      '  VALUES ( ' +
      '    OLD.INV_ITEM_NO, OLD.INV_ITEM_BARCODE, OLD.INV_CAT_NO, OLD.J_TYPE, OLD.J_STYLE, OLD.J_METAL, OLD.GENDER, ' +
      '    OLD.INV_ITEM_COUNT, OLD.DESCRIPTION, OLD.NOTE, OLD.INV_ITEM_BRAND, OLD.MODEL_NUMBER, OLD.SERIAL_NUMBER, ' +
      '    OLD.OWNER_APP_NUMBER, OLD.SIZE_LENGTH, OLD.WEIGHT, OLD.WEIGHT_UNIT, OLD.KT, OLD.UNIT_COST, OLD.UNIT_PRICE, ' +
      '    OLD.INV_ITEM_STATUS, OLD.TRANSACTION_NO, :TICKET, :TTYPE, OLD.INV_ORIGINAL_ITEM_NO, ' +
      '    OLD.CREATED, OLD.PAWNED_DATE, OLD.PURCHASE_DATE, OLD.REDEEMED_DATE, OLD.DEFAULTED_DATE, OLD.MELTED_DATE, ' +
      '    OLD.FORSALE_DATE, OLD.SOLD_DATE, OLD.LAYAWAY_DATE, ' +
      '    (SELECT CAST(LEFT(LIST(s.STONE_NUMBER || ''x '' || TRIM(COALESCE(s.STONE_TYPE, '''') || '' '' || ' +
      '                                 s.STONE_SHAPE || ''/'' || s.STONE_COLOR) || ' +
      '                           COALESCE('' '' || CAST(s.CT AS DECIMAL(9,3)) || ''ct'', ''''), ''; ''), 1000) AS VARCHAR(1000)) ' +
      '       FROM STONES s WHERE s.INV_ITEM_NO = OLD.INV_ITEM_NO), ' +
      '    (SELECT CAST(LEFT(LIST(sa.SALE_TICKET_NO || ' +
      '                           IIF(sa.SALE_STATUS = ''V'', '' (voided)'', ''''), '', ''), 500) AS VARCHAR(500)) ' +
      '       FROM SALE_LINES l JOIN SALES sa ON sa.SALE_NO = l.SALE_NO ' +
      '      WHERE l.INV_ITEM_NO = OLD.INV_ITEM_NO), ' +
      '    (SELECT FIRST 1 rl.STOCK_RECEIPT_NO FROM STOCK_RECEIPT_LINES rl ' +
      '      WHERE rl.INV_ITEM_NO = OLD.INV_ITEM_NO), ' +
      '    :DEL_WITH, ' +
      '    LEFT(COALESCE(RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_HOST''), ' +
      '                  RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_ADDRESS''), CURRENT_USER), 255), ' +
      '    LEFT(RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DELETE_REASON''), 200)); ' +
      'END');
end;

{ v14: log of deleted items and transactions. INVENTORY_ITEMS_DELETED and
  TRANSACTIONS_DELETED keep a copy of each deleted row with who (the PC) /
  when / why; BEFORE DELETE triggers fill them, so every path is caught,
  including a transaction's items and payments deleted by cascade. The app
  passes the typed reason through the transaction context (TDM.DeleteWithLog).

  Triggers only add to INVENTORY_ITEMS / TRANSACTIONS, they change no data, and
  CREATE OR ALTER makes the step safe to repeat.

  Mirror of Schema/Migrations/PawnPro_FB5_DeletedRecordsLog.sql. }
procedure Step14_DeletedRecordsLog(Conn: TFDConnection);
begin
  if not RelationExists(Conn, 'INVENTORY_ITEMS_DELETED') then
    ExecDDL(Conn,
      'CREATE TABLE INVENTORY_ITEMS_DELETED ' +
      '       ( ' +
      '         DEL_NO              BIGINT         GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL, ' +
      '         INV_ITEM_NO         INTEGER        NOT NULL, ' +
      '         INV_ITEM_BARCODE    VARCHAR(30), ' +
      '         INV_CAT_NO          INTEGER, ' +
      '         J_TYPE              CHAR(1), ' +
      '         J_STYLE             CHAR(1), ' +
      '         J_METAL             CHAR(1), ' +
      '         GENDER              CHAR(1), ' +
      '         INV_ITEM_COUNT      INTEGER, ' +
      '         DESCRIPTION         VARCHAR(120), ' +
      '         NOTE                VARCHAR(80), ' +
      '         INV_ITEM_BRAND      VARCHAR(30), ' +
      '         MODEL_NUMBER        VARCHAR(40), ' +
      '         SERIAL_NUMBER       VARCHAR(40), ' +
      '         OWNER_APP_NUMBER    VARCHAR(40), ' +
      '         SIZE_LENGTH         DOUBLE PRECISION, ' +
      '         WEIGHT              DOUBLE PRECISION, ' +
      '         WEIGHT_UNIT         CHAR(1), ' +
      '         KT                  DOUBLE PRECISION, ' +
      '         UNIT_COST           DECIMAL(18,2), ' +
      '         UNIT_PRICE          DECIMAL(18,2), ' +
      '         INV_ITEM_STATUS     CHAR(1), ' +
      '         TRANSACTION_NO      INTEGER, ' +
      '         TRAN_TICKET_NO      VARCHAR(30), ' +
      '         TRAN_TYPE           CHAR(1), ' +
      '         INV_ORIGINAL_ITEM_NO INTEGER, ' +
      '         CREATED             TIMESTAMP, ' +
      '         PAWNED_DATE         DATE, ' +
      '         PURCHASE_DATE       DATE, ' +
      '         REDEEMED_DATE       DATE, ' +
      '         DEFAULTED_DATE      DATE, ' +
      '         MELTED_DATE         DATE, ' +
      '         FORSALE_DATE        DATE, ' +
      '         SOLD_DATE           DATE, ' +
      '         LAYAWAY_DATE        DATE, ' +
      '         STONES              VARCHAR(1000), ' +
      '         SALE_TICKETS        VARCHAR(500), ' +
      '         DELETED_WITH        CHAR(1), ' +
      '         DELETED_AT          TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL, ' +
      '         DELETED_ON          VARCHAR(255), ' +
      '         DELETE_REASON       VARCHAR(200), ' +
      '         CONSTRAINT PK_INVENTORY_ITEMS_DELETED PRIMARY KEY (DEL_NO) ' +
      '       )');

  if not RelationExists(Conn, 'TRANSACTIONS_DELETED') then
    ExecDDL(Conn,
      'CREATE TABLE TRANSACTIONS_DELETED ' +
      '       ( ' +
      '         DEL_NO              BIGINT         GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL, ' +
      '         TRANSACTION_NO      INTEGER        NOT NULL, ' +
      '         TRAN_TICKET_NO      VARCHAR(30), ' +
      '         TRAN_TYPE           CHAR(1), ' +
      '         TRAN_STATUS         CHAR(1), ' +
      '         TRAN_CLOSE_REASON   SMALLINT, ' +
      '         TRAN_DATE           DATE, ' +
      '         TRAN_TIME           TIME, ' +
      '         TRAN_MATURITY       DATE, ' +
      '         CUST_NO             INTEGER, ' +
      '         CUST_NAME           VARCHAR(120), ' +
      '         TRAN_PAWN_AMOUNT    DOUBLE PRECISION, ' +
      '         TRAN_INTEREST       DOUBLE PRECISION, ' +
      '         PRINC_BALANCE       DOUBLE PRECISION, ' +
      '         TRAN_SALES_TAX      DOUBLE PRECISION, ' +
      '         TRAN_COMMENT        BLOB SUB_TYPE 1 SEGMENT SIZE 80, ' +
      '         ITEM_COUNT          INTEGER, ' +
      '         PAYMENT_COUNT       INTEGER, ' +
      '         PAYMENTS_TOTAL      DOUBLE PRECISION, ' +
      '         DELETED_AT          TIMESTAMP      DEFAULT CURRENT_TIMESTAMP NOT NULL, ' +
      '         DELETED_ON          VARCHAR(255), ' +
      '         DELETE_REASON       VARCHAR(200), ' +
      '         CONSTRAINT PK_TRANSACTIONS_DELETED PRIMARY KEY (DEL_NO) ' +
      '       )');

  ExecDDL(Conn,
      'CREATE OR ALTER TRIGGER TRG_TRANSACTIONS_DELETED_LOG FOR TRANSACTIONS ' +
      'ACTIVE BEFORE DELETE POSITION 0 SQL SECURITY INVOKER AS ' +
      'BEGIN ' +
      '  /* For the items the cascade deletes next: see TRG_INV_ITEMS_DELETED_LOG. */ ' +
      '  RDB$SET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_NO'', OLD.TRANSACTION_NO); ' +
      '  RDB$SET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TICKET'', OLD.TRAN_TICKET_NO); ' +
      '  RDB$SET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TYPE'', OLD.TRAN_TYPE); ' +
      ' ' +
      '  INSERT INTO TRANSACTIONS_DELETED ( ' +
      '    TRANSACTION_NO, TRAN_TICKET_NO, TRAN_TYPE, TRAN_STATUS, TRAN_CLOSE_REASON, ' +
      '    TRAN_DATE, TRAN_TIME, TRAN_MATURITY, CUST_NO, CUST_NAME, ' +
      '    TRAN_PAWN_AMOUNT, TRAN_INTEREST, PRINC_BALANCE, TRAN_SALES_TAX, TRAN_COMMENT, ' +
      '    ITEM_COUNT, PAYMENT_COUNT, PAYMENTS_TOTAL, ' +
      '    DELETED_ON, DELETE_REASON) ' +
      '  VALUES ( ' +
      '    OLD.TRANSACTION_NO, OLD.TRAN_TICKET_NO, OLD.TRAN_TYPE, OLD.TRAN_STATUS, OLD.TRAN_CLOSE_REASON, ' +
      '    OLD.TRAN_DATE, OLD.TRAN_TIME, OLD.TRAN_MATURITY, OLD.CUST_NO, ' +
      '    (SELECT LEFT(TRIM(COALESCE(c.CUST_FIRST, '''') || '' '' || COALESCE(c.CUST_LAST, '''')), 120) ' +
      '       FROM CUSTOMER c WHERE c.CUST_NO = OLD.CUST_NO), ' +
      '    OLD.TRAN_PAWN_AMOUNT, OLD.TRAN_INTEREST, OLD.PRINC_BALANCE, OLD.TRAN_SALES_TAX, OLD.TRAN_COMMENT, ' +
      '    (SELECT COUNT(*) FROM INVENTORY_ITEMS i WHERE i.TRANSACTION_NO = OLD.TRANSACTION_NO), ' +
      '    (SELECT COUNT(*) FROM PAYMENTS p WHERE p.TRANSACTION_NO = OLD.TRANSACTION_NO), ' +
      '    (SELECT SUM(p.PAY_AMOUNT) FROM PAYMENTS p WHERE p.TRANSACTION_NO = OLD.TRANSACTION_NO), ' +
      '    LEFT(COALESCE(RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_HOST''), ' +
      '                  RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_ADDRESS''), CURRENT_USER), 255), ' +
      '    LEFT(RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DELETE_REASON''), 200)); ' +
      'END');

  ExecDDL(Conn,
      'CREATE OR ALTER TRIGGER TRG_INV_ITEMS_DELETED_LOG FOR INVENTORY_ITEMS ' +
      'ACTIVE BEFORE DELETE POSITION 0 SQL SECURITY INVOKER AS ' +
      'DECLARE VARIABLE TICKET VARCHAR(30); ' +
      'DECLARE VARIABLE TTYPE CHAR(1); ' +
      'DECLARE VARIABLE DEL_WITH CHAR(1) = ''I''; ' +
      'BEGIN ' +
      '  SELECT TRAN_TICKET_NO, TRAN_TYPE FROM TRANSACTIONS ' +
      '   WHERE TRANSACTION_NO = OLD.TRANSACTION_NO ' +
      '    INTO :TICKET, :TTYPE; ' +
      ' ' +
      '  /* Deleted with its transaction: that row is already gone, so take the ' +
      '     ticket the transaction trigger left behind. */ ' +
      '  IF (RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_NO'') = CAST(OLD.TRANSACTION_NO AS VARCHAR(20))) THEN ' +
      '  BEGIN ' +
      '    DEL_WITH = ''T''; ' +
      '    TICKET = COALESCE(TICKET, RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TICKET'')); ' +
      '    TTYPE = COALESCE(TTYPE, RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DEL_TRAN_TYPE'')); ' +
      '  END ' +
      ' ' +
      '  INSERT INTO INVENTORY_ITEMS_DELETED ( ' +
      '    INV_ITEM_NO, INV_ITEM_BARCODE, INV_CAT_NO, J_TYPE, J_STYLE, J_METAL, GENDER, ' +
      '    INV_ITEM_COUNT, DESCRIPTION, NOTE, INV_ITEM_BRAND, MODEL_NUMBER, SERIAL_NUMBER, ' +
      '    OWNER_APP_NUMBER, SIZE_LENGTH, WEIGHT, WEIGHT_UNIT, KT, UNIT_COST, UNIT_PRICE, ' +
      '    INV_ITEM_STATUS, TRANSACTION_NO, TRAN_TICKET_NO, TRAN_TYPE, INV_ORIGINAL_ITEM_NO, ' +
      '    CREATED, PAWNED_DATE, PURCHASE_DATE, REDEEMED_DATE, DEFAULTED_DATE, MELTED_DATE, ' +
      '    FORSALE_DATE, SOLD_DATE, LAYAWAY_DATE, ' +
      '    STONES, SALE_TICKETS, DELETED_WITH, DELETED_ON, DELETE_REASON) ' +
      '  VALUES ( ' +
      '    OLD.INV_ITEM_NO, OLD.INV_ITEM_BARCODE, OLD.INV_CAT_NO, OLD.J_TYPE, OLD.J_STYLE, OLD.J_METAL, OLD.GENDER, ' +
      '    OLD.INV_ITEM_COUNT, OLD.DESCRIPTION, OLD.NOTE, OLD.INV_ITEM_BRAND, OLD.MODEL_NUMBER, OLD.SERIAL_NUMBER, ' +
      '    OLD.OWNER_APP_NUMBER, OLD.SIZE_LENGTH, OLD.WEIGHT, OLD.WEIGHT_UNIT, OLD.KT, OLD.UNIT_COST, OLD.UNIT_PRICE, ' +
      '    OLD.INV_ITEM_STATUS, OLD.TRANSACTION_NO, :TICKET, :TTYPE, OLD.INV_ORIGINAL_ITEM_NO, ' +
      '    OLD.CREATED, OLD.PAWNED_DATE, OLD.PURCHASE_DATE, OLD.REDEEMED_DATE, OLD.DEFAULTED_DATE, OLD.MELTED_DATE, ' +
      '    OLD.FORSALE_DATE, OLD.SOLD_DATE, OLD.LAYAWAY_DATE, ' +
      '    (SELECT CAST(LEFT(LIST(s.STONE_NUMBER || ''x '' || TRIM(COALESCE(s.STONE_TYPE, '''') || '' '' || ' +
      '                                 s.STONE_SHAPE || ''/'' || s.STONE_COLOR) || ' +
      '                           COALESCE('' '' || CAST(s.CT AS DECIMAL(9,3)) || ''ct'', ''''), ''; ''), 1000) AS VARCHAR(1000)) ' +
      '       FROM STONES s WHERE s.INV_ITEM_NO = OLD.INV_ITEM_NO), ' +
      '    (SELECT CAST(LEFT(LIST(sa.SALE_TICKET_NO || ' +
      '                           IIF(sa.SALE_STATUS = ''V'', '' (voided)'', ''''), '', ''), 500) AS VARCHAR(500)) ' +
      '       FROM SALE_LINES l JOIN SALES sa ON sa.SALE_NO = l.SALE_NO ' +
      '      WHERE l.INV_ITEM_NO = OLD.INV_ITEM_NO), ' +
      '    :DEL_WITH, ' +
      '    LEFT(COALESCE(RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_HOST''), ' +
      '                  RDB$GET_CONTEXT(''SYSTEM'', ''CLIENT_ADDRESS''), CURRENT_USER), 255), ' +
      '    LEFT(RDB$GET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DELETE_REASON''), 200)); ' +
      'END');

  if not IndexExists(Conn, 'INVENTORY_ITEMS_DELETED_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX INVENTORY_ITEMS_DELETED_IDX1 ON INVENTORY_ITEMS_DELETED (INV_ITEM_NO)');

  if not IndexExists(Conn, 'TRANSACTIONS_DELETED_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX TRANSACTIONS_DELETED_IDX1 ON TRANSACTIONS_DELETED (TRANSACTION_NO)');
end;

procedure Step12_SalesTickets(Conn: TFDConnection);
begin
  if not RelationExists(Conn, 'SALES') then
    ExecDDL(Conn,
      'CREATE TABLE SALES (' +
      '  SALE_NO          INTEGER        GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
      '  SALE_TICKET_NO   INTEGER        NOT NULL,' +
      '  SALE_DATE        DATE           DEFAULT CURRENT_DATE NOT NULL,' +
      '  CUST_NO          INTEGER,' +
      '  SUBTOTAL         DECIMAL(18,2)  NOT NULL,' +
      '  DISCOUNT_TYPE    CHAR(1),' +
      '  DISCOUNT_VALUE   DECIMAL(18,2),' +
      '  DISCOUNT_AMOUNT  DECIMAL(18,2)  DEFAULT 0 NOT NULL,' +
      '  TAX_PERC         DECIMAL(9,4)   DEFAULT 0 NOT NULL,' +
      '  TAX_AMOUNT       DECIMAL(18,2)  DEFAULT 0 NOT NULL,' +
      '  TOTAL            DECIMAL(18,2)  NOT NULL,' +
      '  PAY_TYPE_NO      INTEGER        DEFAULT 1,' +
      '  SALE_STATUS      CHAR(1)        DEFAULT ''C'' NOT NULL,' +
      '  VOID_DATE        TIMESTAMP,' +
      '  VOID_REASON      VARCHAR(120),' +
      '  CREATED          TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,' +
      '  CONSTRAINT PK_SALES PRIMARY KEY (SALE_NO),' +
      '  CONSTRAINT UQ_SALES_TICKET_NO UNIQUE (SALE_TICKET_NO))');

  if not RelationExists(Conn, 'SALE_LINES') then
    ExecDDL(Conn,
      'CREATE TABLE SALE_LINES (' +
      '  SALE_LINE_NO     INTEGER        GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL,' +
      '  SALE_NO          INTEGER        NOT NULL,' +
      '  INV_ITEM_NO      INTEGER        NOT NULL,' +
      '  ITEM_COUNT       INTEGER,' +
      '  DESCRIPTION      VARCHAR(120),' +
      '  UNIT_COST        DECIMAL(18,2),' +
      '  LIST_PRICE       DECIMAL(18,2),' +
      '  SALE_PRICE       DECIMAL(18,2)  NOT NULL,' +
      '  DISCOUNT_SHARE   DECIMAL(18,2)  DEFAULT 0 NOT NULL,' +
      '  NET_PRICE        DECIMAL(18,2)  NOT NULL,' +
      '  CONSTRAINT PK_SALE_LINES PRIMARY KEY (SALE_LINE_NO),' +
      '  CONSTRAINT FK_SALE_LINES_SALES FOREIGN KEY (SALE_NO) REFERENCES SALES (SALE_NO))');

  if not IndexExists(Conn, 'SALE_LINES_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX SALE_LINES_IDX1 ON SALE_LINES (INV_ITEM_NO)');
  if not IndexExists(Conn, 'SALES_IDX1') then
    ExecDDL(Conn, 'CREATE ASC INDEX SALES_IDX1 ON SALES (SALE_DATE)');

  ExecDDL(Conn,
    'INSERT INTO TABLE_KEYS (TABLE_NAME, LAST_KEY) ' +
    '  SELECT ''' + SaleTicketNo + ''', ' + IntToStr(SaleTicketStartAfter) + ' FROM RDB$DATABASE ' +
    '   WHERE NOT EXISTS (SELECT 1 FROM TABLE_KEYS WHERE TABLE_NAME = ''' + SaleTicketNo + ''')');
end;

{ ---- orchestrator ------------------------------------------------------- }

function DatabaseIsCurrent(Conn: TFDConnection): Boolean;
begin
  try
    Result := GetDbVersion(Conn) >= CURRENT_DB_VERSION;
  except
    // APP_STATE absent, or unreadable. Either way the host has not brought this
    // database up to date, so report "behind" rather than propagating: the
    // caller's job is to say so plainly, not to crash with a SQL error.
    Result := False;
  end;
end;

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

  if V < 6 then
  begin
    Step6_LeadsOnlineSoap(Conn);
    SetDbVersion(Conn, 6);
  end;

  if V < 7 then
  begin
    Step7_LeadsOnlineOptIn(Conn);
    SetDbVersion(Conn, 7);
  end;

  if V < 8 then
  begin
    Step8_LeadsOnlineSkipCsvSent(Conn);
    SetDbVersion(Conn, 8);
  end;

  if V < 9 then
  begin
    Step9_LeadsSoapImageSent(Conn);
    SetDbVersion(Conn, 9);
  end;

  if V < 10 then
  begin
    Step10_LeadsSoapExcluded(Conn);
    SetDbVersion(Conn, 10);
  end;

  if V < 11 then
  begin
    Step11_DefaultedPawnItemsStatus(Conn);
    SetDbVersion(Conn, 11);
  end;

  if V < 12 then
  begin
    Step12_SalesTickets(Conn);
    SetDbVersion(Conn, 12);
  end;

  if V < 13 then
  begin
    Step13_LeadsSoapNoActivity(Conn);
    SetDbVersion(Conn, 13);
  end;

  if V < 14 then
  begin
    Step14_DeletedRecordsLog(Conn);
    SetDbVersion(Conn, 14);
  end;

  if V < 15 then
  begin
    Step15_StockReceipts(Conn);
    SetDbVersion(Conn, 15);
  end;

  // Future steps: if V < 16 then begin Step16_...(Conn); SetDbVersion(Conn, 16); end;
end;

end.
