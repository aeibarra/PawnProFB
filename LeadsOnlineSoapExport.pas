unit LeadsOnlineSoapExport;

{
  LeadsOnline SOAP export -- the per-ticket channel.

  This is the second of two export channels and is selected per store by
  STORE.LEADS_ONLINE_EXPORT_METHOD. The CSV+FTP screen
  (TfrmExportPoliceInformation) is untouched and remains the default.

  Why this is a separate screen rather than a tab on the CSV one: the unit of
  work is different. CSV exports a whole batch as one file and reports
  "exported 42 transactions". SOAP submits ONE TICKET PER CALL, so some succeed
  and some fail, and the operator has to see 42 individual outcomes and be able
  to act on just the failures.

  RETRY SEMANTICS -- the non-obvious part. Per the vendor spec, re-submitting a
  ticket whose key LeadsOnline already holds is normally an error; the error is
  suppressed ONLY when the ticket matches "the last successful ticket
  submitted". So a lost response can be recovered by resending immediately, but
  NOT by sweeping up failures at the end of the run: by then other tickets have
  been sent and the exemption is gone. Hence:
    - the retry is inline, inside TLeadsOnlineClient.Execute, same ticket,
      before the loop advances;
    - and a duplicate error (6 or 13) is read as "already accepted", not as a
      failure, so a row that really did land is never left looking unsent.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Data.DB,
  RzEdit, RzRadChk, RzPanel, RzButton, RzForms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  // TLeadsOnlineClient and TicketKey both appear in method signatures below.
  uLeadsOnlineClient, LeadsOnlineWS, Vcl.Menus;

type
  /// What happened to one ticket. "Unreachable" is kept separate from
  /// "Rejected" on purpose: a rejection tells you nothing about the next
  /// ticket, but repeated unreachables mean the line is down and there is no
  /// point working through the rest one 30-second timeout at a time.
  TSubmitOutcome = (soAccepted, soRejected, soUnreachable, soSkipped);

  TfrmLeadsOnlineSoapExport = class(TForm)
    GroupBox2: TGroupBox;
    btnExit: TBitBtn;
    GroupBox1: TGroupBox;
    lblProgress: TLabel;
    pbSubmit: TProgressBar;
    lblSandbox: TLabel;
    lblCount: TLabel;
    btnRefresh: TBitBtn;
    grdTickets: TDBGrid;
    clnTickets: TFDMemTable;
    dsTickets: TDataSource;
    /// Saves and restores this window's size and position per user, through
    /// DM.RegIniFile -- the same mechanism Inventory and the client screens
    /// use. State lands in %LOCALAPPDATA%\PawnPro\PawnPro.ini, keyed by form
    /// name, so it is per workstation and never touches the shared database.
    FormState: TRzFormState;
    gbExportTranSelection: TGroupBox;
    rbSendDateRange: TRzRadioButton;
    rbSendAllNotSentYet: TRzRadioButton;
    pnDateRange: TRzPanel;
    Label1: TLabel;
    Label3: TLabel;
    edFDate: TRzDateTimeEdit;
    edTDate: TRzDateTimeEdit;
    GroupBox3: TGroupBox;
    btnCheckAll: TButton;
    btnClearAll: TButton;
    btnSubmit: TRzBitBtn;
    popMnuGrid: TPopupMenu;
    ExcludeSelected1: TMenuItem;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure ScopeChanged(Sender: TObject);
    procedure DateRangeChanged(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure grdTicketsCellClick(Column: TColumn);
    procedure grdTicketsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ExcludeSelected1Click(Sender: TObject);
    procedure popMnuGridPopup(Sender: TObject);
  private
    FRunning: Boolean;
    FCancelled: Boolean;
    /// While set, the grid shows only the ticked rows. Turned on when a run
    /// starts so the operator watches exactly what is being sent, rather than
    /// the worked rows scrolling away among thousands of untouched ones.
    FShowOnlySelected: Boolean;
    procedure ShowOnlySelected(AValue: Boolean);
    procedure clnTicketsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure BuildGridStructure;
    procedure LoadCandidates;
    function StoreIdOrComplain(out AStoreId: Integer): Boolean;
    function CredentialsConfigured: Boolean;
    /// Number of rows currently ticked. Walks the memtable rather than keeping
    /// a running count -- rows change from several places (load, tick, check
    /// all, clear all) and a counter that drifts would be worse than useless
    /// on a screen whose whole job is "send exactly these".
    /// The column genuinely under the pointer, which is not the one OnCellClick
    /// reports while the grid is in dgRowSelect mode.
    function ClickedColumn: TColumn;
    function SelectedCount: Integer;
    /// How many ticked rows are newer than RecentExclusionMonths. Excluding old
    /// history is housekeeping; excluding a recent pawn means a transaction that
    /// never reaches law enforcement, so the confirmation has to separate them.
    function SelectedRecentCount: Integer;
    procedure UpdateCountLabel;
    procedure SetAllSelected(AValue: Boolean);
    procedure SetRunning(AValue: Boolean);
    procedure SetRowOutcome(const AOutcome, ADetail: string);
    procedure RecordSubmission(ATransactionNo: Integer; const ATicketType, ATicketNumber, ATicketDateTime: string; AErrorCode: Integer; const AErrorResponse: string; AIsVoid: Boolean);
    /// One ticket. AClient is owned by the caller and reused across the whole
    /// run -- building one per ticket would open a fresh connection per row.
    function SubmitOne(AClient: TLeadsOnlineClient; ATransactionNo: Integer; out ATransportError: string): TSubmitOutcome;
    /// Uploads this ticket's photos immediately after it is accepted, using the
    /// key that was actually sent. An image failure never turns an accepted
    /// ticket into a failed one: the transaction is reported either way, and
    /// that is the part that matters legally.
    procedure UploadImagesFor(AClient: TLeadsOnlineClient; ATransactionNo: Integer;
      AKey: TicketKey; out ASent, AFailed: Integer);
    procedure RecordImageSent(ATransactionNo, AImagesDataNo: Integer;
      const ACategory: string; AItemIndex: Integer; AItemIndexNull: Boolean;
      const AServerFilename: string; AErrorCode: Integer; const AErrorResponse: string);
  public
    { Public declarations }
  end;

var
  frmLeadsOnlineSoapExport: TfrmLeadsOnlineSoapExport;

implementation

{$R *.dfm}

uses
  System.StrUtils, System.DateUtils,
  PawnDM, LeadsOnlineDM, PawnGlobal, uPawnDialogs, CheckBoxDrawer,
  uLeadsOnlineTicketMap;

const
  ColSelected   = 'SELECTED';
  ColOutcome    = 'OUTCOME';
  ColDetail     = 'DETAIL';
  ColItemImages = 'ITEM_IMAGE_COUNT';
  ColIdImages   = 'ID_IMAGE_COUNT';

  OutcomePending  = '';
  OutcomeSent     = 'Sent';
  OutcomeAlready  = 'Already sent';
  OutcomeFailed   = 'Failed';
  OutcomeSkipped  = 'Skipped';
  OutcomeTooOld   = 'Too old';

  /// LeadsOnline error 7 -- ticketDateTime outside the window they keep.
  LeadsErrTicketDateOutOfRange = 7;

  /// How many tickets in a row may fail to reach LeadsOnline before the run
  /// gives up. Three is enough to rule out one unlucky ticket while capping the
  /// wasted wait at about three minutes rather than one per remaining row.
  MaxConsecutiveUnreachable = 3;

  /// The same idea inside one ticket's images. Lower than the ticket limit
  /// because by this point a ticket has already been accepted: the cost of
  /// stopping early is only that its photos are offered again next run, while
  /// the cost of carrying on is a timeout per remaining photo.
  MaxConsecutiveImageFailures = 2;

  { Candidates: pawns and buys LeadsOnline has not accepted yet.

    The ('P','U') filter is the SAME one the CSV export applies (LeadsOnlineDM
    qryGetDataToExp), so both channels report an identical set of transactions
    and can be compared during the parallel run.

    VOIDED TRANSACTIONS ARE EXCLUDED. A ticket that was voided before it was
    ever sent is not something LeadsOnline needs to hear about -- reporting a
    transaction and its cancellation at once adds noise, not information. (The
    mapper still sets isVoid, which is what a future UpdateTransaction path will
    need for a ticket voided AFTER it was accepted.)

    SETTLED outcomes are excluded; retryable failures are kept so they can be
    tried again. An outcome is settled when asking again cannot change it:

      0       accepted.
      6, 13   LeadsOnline already hold this ticket -- see ResultIsAlreadyAccepted.
      7       the ticket date is outside the window LeadsOnline keep. For a past
              date this is permanent: the transaction will never get younger, so
              re-offering it every run would fill the list with work that can
              never be done. (Code 7 also covers FUTURE dates, which usually
              means a data-entry error and would be fixable -- those get settled
              too. Rare enough to accept; revisit if it ever bites.)

    Everything else -- a bad field, a timeout that got as far as a Response --
    stays a candidate.

    The date predicate is appended only for the date-range scope -- see
    LoadCandidates. Everyday use is "everything not sent yet", with no date
    filter at all; the range exists for a store coming onto LeadsOnline with
    years of history that should not all be sent. }
  SQLCandidatesBase =
    'SELECT T1.TRANSACTION_NO, T1.TRAN_TYPE, T1.TRAN_TICKET_NO, T1.TRAN_DATE,' +
    '       COALESCE(T2.CUST_LAST, '''') || '', '' || COALESCE(T2.CUST_FIRST, '''') AS CUSTOMER,' +
    '       (SELECT COUNT(*) FROM INVENTORY_ITEMS I' +
    '         WHERE I.TRANSACTION_NO = T1.TRANSACTION_NO) AS ITEM_COUNT,' +
    // Item photos hang off the items (IMAGE_TYPE_NO 2, keyed by INV_ITEM_NO);
    // ID photos hang off the customer (type 1, keyed by CUST_NO). Both are
    // shown so the operator can see what is about to go with the ticket -- and
    // notice when something is missing BEFORE sending rather than afterwards.
    //
    // These count what WILL BE SENT, not what exists, so they must apply the
    // same two rules as SQLTicketImages: already-uploaded images are excluded,
    // and only the newest customer ID photo counts. A column that says "3" and
    // then sends one teaches the operator to distrust the column.
    '       (SELECT COUNT(*) FROM IMAGES_DATA IM' +
    '         JOIN INVENTORY_ITEMS I2 ON I2.INV_ITEM_NO = IM.IMAG_REF_TO_ROW_NO' +
    '        WHERE IM.IMAGE_TYPE_NO = 2' +
    '          AND I2.TRANSACTION_NO = T1.TRANSACTION_NO' +
    '          AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_IMAGE_SENT SI' +
    '                           WHERE SI.TRANSACTION_NO = T1.TRANSACTION_NO' +
    '                             AND SI.IMAGES_DATA_NO = IM.IMAGES_DATA_NO' +
    '                             AND SI.ERROR_CODE = 0)) AS ITEM_IMAGE_COUNT,' +
    // 0 or 1. A customer photographed several times over the years has several
    // rows, but only the most recent is ever sent.
    '       (SELECT COUNT(*) FROM IMAGES_DATA IM2' +
    '        WHERE IM2.IMAGE_TYPE_NO = 1' +
    '          AND IM2.IMAG_REF_TO_ROW_NO = T1.CUST_NO' +
    '          AND IM2.IMAGES_DATA_NO = (SELECT MAX(IM4.IMAGES_DATA_NO) FROM IMAGES_DATA IM4' +
    '                                     WHERE IM4.IMAGE_TYPE_NO = 1' +
    '                                       AND IM4.IMAG_REF_TO_ROW_NO = T1.CUST_NO)' +
    '          AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_IMAGE_SENT SI2' +
    '                           WHERE SI2.TRANSACTION_NO = T1.TRANSACTION_NO' +
    '                             AND SI2.IMAGES_DATA_NO = IM2.IMAGES_DATA_NO' +
    '                             AND SI2.ERROR_CODE = 0)) AS ID_IMAGE_COUNT,' +
    '       S.ERROR_CODE AS LAST_ERROR_CODE, S.ERROR_RESPONSE AS LAST_ERROR_RESPONSE' +
    '  FROM TRANSACTIONS T1' +
    '  JOIN CUSTOMER T2 ON T2.CUST_NO = T1.CUST_NO' +
    '  LEFT JOIN LEADS_SOAP_SUBMISSION S ON S.TRANSACTION_NO = T1.TRANSACTION_NO' +
    ' WHERE T1.TRAN_TYPE IN (''P'', ''U'')' +
    '   AND COALESCE(T1.TRAN_CLOSE_REASON, 0) <> 1' +
    // Excluded by the store, permanently. See SQLExcludeTransaction.
    '   AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_EXCLUDED X' +
    '                    WHERE X.TRANSACTION_NO = T1.TRANSACTION_NO)' +
    '   AND (S.ID IS NULL OR S.ERROR_CODE IS NULL' +
    '        OR S.ERROR_CODE NOT IN (0, 6, 7, 13))';

  { Marks one transaction as never-to-be-sent.

    UPDATE OR INSERT rather than INSERT so that re-excluding an already-excluded
    row is harmless -- the operator cannot see the exclusion list, so they have
    no way of knowing what is already on it.

    The table carries no EXCLUDED_BY because PawnPro has no application login,
    so there is no user to name. EXCLUDED_AT answers the question anyone
    actually asks later: when was this decided. }
  SQLExcludeTransaction =
    'UPDATE OR INSERT INTO LEADS_SOAP_EXCLUDED' +
    '  (TRANSACTION_NO, EXCLUDED_AT, REASON)' +
    '  VALUES (:TransactionNo, CURRENT_TIMESTAMP, :Reason)' +
    '  MATCHING (TRANSACTION_NO)';

  /// Reason written for every exclusion made from this screen. A column rather
  /// than a constant string in case a future screen excludes for another cause.
  ExcludeReasonOperator = 'Excluded on the LeadsOnline export screen';

  /// A transaction younger than this is not old history, and excluding it means
  /// a pawn that never reaches law enforcement. The confirmation calls those
  /// out separately -- see ExcludeSelected1Click.
  RecentExclusionMonths = 12;

  { Every image belonging to one ticket, in one pass.

    ITEM_INDEX is computed here, not in Pascal, and it is the whole reason this
    query exists in this shape: LeadsOnline address an item photo by the item's
    0-BASED POSITION WITHIN THE TICKET AS SENT. The mapper builds its items with
    ORDER BY INV_ITEM_NO, so ROW_NUMBER() over that same ordering reproduces the
    index exactly. Deriving it any other way would eventually put a photo on the
    wrong item.

    Customer ID photos take the LAST one on file (highest IMAGES_DATA_NO): a
    customer photographed again over the years has several, and the current one
    is the one worth reporting. NULL item index -- it does not apply to them.

    Already-uploaded images are excluded by LEADS_SOAP_IMAGE_SENT, per
    transaction, because one customer ID photo is shared across all of that
    customer's tickets. }
  SQLTicketImages =
    'SELECT IM.IMAGES_DATA_NO, ''Item'' AS IMAGE_CATEGORY,' +
    '       (SELECT COUNT(*) FROM INVENTORY_ITEMS I3' +
    '         WHERE I3.TRANSACTION_NO = I2.TRANSACTION_NO' +
    '           AND I3.INV_ITEM_NO < I2.INV_ITEM_NO) AS ITEM_INDEX' +
    '  FROM IMAGES_DATA IM' +
    '  JOIN INVENTORY_ITEMS I2 ON I2.INV_ITEM_NO = IM.IMAG_REF_TO_ROW_NO' +
    ' WHERE IM.IMAGE_TYPE_NO = 2' +
    '   AND I2.TRANSACTION_NO = :TransactionNo' +
    '   AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_IMAGE_SENT S' +
    '                    WHERE S.TRANSACTION_NO = :TransactionNo' +
    '                      AND S.IMAGES_DATA_NO = IM.IMAGES_DATA_NO' +
    '                      AND S.ERROR_CODE = 0)' +
    ' UNION ALL ' +
    'SELECT IM2.IMAGES_DATA_NO, ''CustomerID'' AS IMAGE_CATEGORY, NULL AS ITEM_INDEX' +
    '  FROM IMAGES_DATA IM2' +
    ' WHERE IM2.IMAGE_TYPE_NO = 1' +
    '   AND IM2.IMAG_REF_TO_ROW_NO = (SELECT T.CUST_NO FROM TRANSACTIONS T' +
    '                                  WHERE T.TRANSACTION_NO = :TransactionNo)' +
    '   AND IM2.IMAGES_DATA_NO = (SELECT MAX(IM3.IMAGES_DATA_NO) FROM IMAGES_DATA IM3' +
    '                              WHERE IM3.IMAGE_TYPE_NO = 1' +
    '                                AND IM3.IMAG_REF_TO_ROW_NO = IM2.IMAG_REF_TO_ROW_NO)' +
    '   AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_IMAGE_SENT S2' +
    '                    WHERE S2.TRANSACTION_NO = :TransactionNo' +
    '                      AND S2.IMAGES_DATA_NO = IM2.IMAGES_DATA_NO' +
    '                      AND S2.ERROR_CODE = 0)';

  SQLRecordImageSent =
    'UPDATE OR INSERT INTO LEADS_SOAP_IMAGE_SENT' +
    '  (TRANSACTION_NO, IMAGES_DATA_NO, IMAGE_CATEGORY, ITEM_INDEX,' +
    '   SERVER_FILENAME, UPLOADED_AT, ERROR_CODE, ERROR_RESPONSE)' +
    '  VALUES (:TransactionNo, :ImagesDataNo, :ImageCategory, :ItemIndex,' +
    '          :ServerFilename, CURRENT_TIMESTAMP, :ErrorCode, :ErrorResponse)' +
    '  MATCHING (TRANSACTION_NO, IMAGES_DATA_NO)';

  SQLCandidatesDateFilter = '   AND T1.TRAN_DATE BETWEEN :DateFrom AND :DateTo';

  { Appended when STORE.LEADS_ONLINE_SKIP_CSV_SENT is set. The CSV export logs
    every transaction it wrote into an export file, so this leaves out anything
    the store has already reported through that channel -- which on a store with
    history is the difference between offering ~29,000 transactions and ~550.

    Deliberately a per-transaction test rather than a "start reporting from"
    date: gaps in the middle of the history stay visible, where a date cutoff
    would silently abandon them. }
  SQLCandidatesSkipCsvSent =
    '   AND NOT EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D' +
    '                    WHERE D.TRANSACTION_NO = T1.TRANSACTION_NO)';

  SQLCandidatesOrder      = ' ORDER BY T1.TRAN_DATE, T1.TRANSACTION_NO';

  { One row per transaction, rewritten on every attempt. The key columns hold
    what was actually TRANSMITTED -- never recompute them from current data, or
    an edited ticket number leaves us addressing a ticket LeadsOnline has never
    seen and UpdateTransaction can never find it again. }
  SQLRecordSubmission =
    'UPDATE OR INSERT INTO LEADS_SOAP_SUBMISSION' +
    '  (TRANSACTION_NO, TICKET_TYPE, TICKET_NUMBER, TICKET_DATETIME,' +
    '   SUBMITTED_AT, ERROR_CODE, ERROR_RESPONSE, IS_VOID)' +
    '  VALUES (:TransactionNo, :TicketType, :TicketNumber, :TicketDateTime,' +
    '          CURRENT_TIMESTAMP, :ErrorCode, :ErrorResponse, :IsVoid)' +
    '  MATCHING (TRANSACTION_NO)';

{ ---- helpers ------------------------------------------------------------- }

{ Parameters are bound through STATICALLY TYPED helpers, never through a
  Variant. An earlier version took `array of Variant` and assigned P.Value,
  leaving FireDAC to infer each type: that works for integers and dies on dates
  with "[FireDAC][Stan]-19 Data type conversion is not supported". Trying to
  fix it by switching on VarType did not help either, because what a control's
  Date property boxes into is not something the caller can see -- Raize ships
  as DCUs, so the declared type is not even readable here.

  With typed parameters there is nothing to infer and nothing to guess: if a
  value cannot be a TDateTime the COMPILER says so, instead of a customer
  finding out. }

function NewQuery(const ASQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := DM.ConnFB;
  Result.SQL.Text := ASQL;
end;

/// Row detail for an accepted ticket: says what happened to its photos, because
/// "Sent" alone leaves the operator unable to tell a ticket with no images from
/// one whose images silently failed.
function DescribeImages(ASent, AFailed: Integer; const APrefix: string): string;
begin
  Result := APrefix;
  if (ASent = 0) and (AFailed = 0) then
    Exit;

  if Result <> '' then
    Result := Result + ' — ';
  if AFailed = 0 then
    Result := Result + Format('%d image(s) sent', [ASent])
  else
    Result := Result + Format('%d image(s) sent, %d failed', [ASent, AFailed]);
end;

function OpenSQL(const ASQL: string): TFDQuery;
begin
  Result := NewQuery(ASQL);
  try
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

function OpenForTransaction(const ASQL: string; ATransactionNo: Integer): TFDQuery;
begin
  Result := NewQuery(ASQL);
  try
    Result.ParamByName('TransactionNo').DataType := ftInteger;
    Result.ParamByName('TransactionNo').AsInteger := ATransactionNo;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

function OpenForDateRange(const ASQL: string; AFrom, ATo: TDateTime): TFDQuery;
begin
  Result := NewQuery(ASQL);
  try
    // TRAN_DATE is a DATE column with no time part, so both bounds are
    // truncated: a stray time on the "to" bound would push same-day rows
    // outside the BETWEEN and silently hide the newest transactions.
    Result.ParamByName('DateFrom').DataType := ftDate;
    Result.ParamByName('DateFrom').AsDateTime := Trunc(AFrom);
    Result.ParamByName('DateTo').DataType := ftDate;
    Result.ParamByName('DateTo').AsDateTime := Trunc(ATo);
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

{ ---- form ---------------------------------------------------------------- }

procedure TfrmLeadsOnlineSoapExport.FormShow(Sender: TObject);
begin
  lblProgress.Caption := '';
  Caption := 'LeadsOnline Export (Web Service)';

  // Unmissable when pointed at the sandbox. A store that believes it has
  // reported to law enforcement but has been talking to the test system is the
  // worst outcome this screen can produce, and it is otherwise silent.
  lblSandbox.Visible := DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean;

  // Range defaults to this year: the only reason to use it is a store coming
  // onto LeadsOnline that wants the current year rather than all its history.
  edFDate.Date := EncodeDate(YearOf(Date), 1, 1);
  edTDate.Date := Date;

  BuildGridStructure;
  rbSendAllNotSentYet.Checked := True;   // the daily workflow
  ScopeChanged(nil);                     // applies the enable state AND loads

  if not CredentialsConfigured then
    clnTickets.EmptyDataSet;
end;

procedure TfrmLeadsOnlineSoapExport.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Closing mid-run would leave the loop writing to a dying form.
  CanClose := not FRunning;
  if not CanClose then
    PawnWarn('A submission is still running. Use Cancel first.');
end;

procedure TfrmLeadsOnlineSoapExport.btnExitClick(Sender: TObject);
begin
  if FRunning then
    FCancelled := True     // the button doubles as Cancel while running
  else
    Close;
end;

procedure TfrmLeadsOnlineSoapExport.DateRangeChanged(Sender: TObject);
begin
  if (not FRunning) and rbSendDateRange.Checked then
    LoadCandidates;
end;

procedure TfrmLeadsOnlineSoapExport.ScopeChanged(Sender: TObject);
begin
  // Enabling the panel cascades to the labels and both date edits, which is how
  // the CSV export screen does it (pnDateRange.Enabled := rb...Checked).
  pnDateRange.Enabled := rbSendDateRange.Checked;
  Label1.Enabled := pnDateRange.Enabled;
  Label3.Enabled := pnDateRange.Enabled;
  edFDate.Enabled := pnDateRange.Enabled;
  edTDate.Enabled := pnDateRange.Enabled;
  if not FRunning then
    LoadCandidates;
end;

procedure TfrmLeadsOnlineSoapExport.btnRefreshClick(Sender: TObject);
begin
  LoadCandidates;
end;

function TfrmLeadsOnlineSoapExport.CredentialsConfigured: Boolean;
begin
  Result := (Trim(DM.qryStoreLEADS_STORE_ID.AsString) <> '') and
            (Trim(DM.qryStoreLEADS_ONLINE_API_USER.AsString) <> '') and
            (Trim(DM.qryStoreLEADS_ONLINE_API_PASSWORD.AsString) <> '');
  if not Result then
    PawnWarn('This store has no LeadsOnline web-service credentials yet.' + sLineBreak + sLineBreak +
             'Enter the Store ID, API user name and API password in ' +
             'LeadsOnline Settings, and use Test Connection to check them.');
end;

function TfrmLeadsOnlineSoapExport.StoreIdOrComplain(out AStoreId: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(DM.qryStoreLEADS_STORE_ID.AsString), AStoreId);
  if not Result then
    PawnError('The LeadsOnline Store ID must be numeric. It is currently ' +
              AnsiQuotedStr(Trim(DM.qryStoreLEADS_STORE_ID.AsString), '"') + '.');
end;

procedure TfrmLeadsOnlineSoapExport.BuildGridStructure;
begin
  clnTickets.Close;
  clnTickets.FieldDefs.Clear;
  clnTickets.FieldDefs.Add(ColSelected, ftBoolean);
  clnTickets.FieldDefs.Add('TRANSACTION_NO', ftInteger);
  clnTickets.FieldDefs.Add('TRAN_DATE', ftDate);
  clnTickets.FieldDefs.Add('TRAN_TYPE', ftString, 1);
  clnTickets.FieldDefs.Add('TRAN_TICKET_NO', ftString, 30);
  clnTickets.FieldDefs.Add('CUSTOMER', ftString, 80);
  clnTickets.FieldDefs.Add('ITEM_COUNT', ftInteger);
  clnTickets.FieldDefs.Add(ColItemImages, ftInteger);
  clnTickets.FieldDefs.Add(ColIdImages, ftInteger);
  clnTickets.FieldDefs.Add(ColOutcome, ftString, 20);
  clnTickets.FieldDefs.Add(ColDetail, ftString, 250);
  clnTickets.CreateDataSet;
  clnTickets.OnFilterRecord := clnTicketsFilterRecord;
end;

procedure TfrmLeadsOnlineSoapExport.LoadCandidates;
var
  Q: TFDQuery;
  Prev, SkipCsv: string;
begin
  // Self-sufficient on purpose. This used to rely on FormShow having run first,
  // and when OnShow was not wired in the .dfm every path through here died with
  // "cannot perform this operation on a closed dataset" -- a confusing symptom
  // a long way from its cause. Building the structure on demand costs nothing
  // and removes the ordering dependency entirely.
  if not clnTickets.Active then
    BuildGridStructure;

  // A reload always shows the whole list again -- leaving the post-run filter
  // on would make a fresh Refresh look like it found almost nothing.
  ShowOnlySelected(False);

  Screen.Cursor := crHourGlass;
  try
    // The CSV-already-sent exclusion is a stored per-store setting rather than
    // a control on this screen: it is decided once when a store moves onto the
    // web service, and an operator running the daily export has no way to judge
    // it. Configured in LeadsOnline Settings.
    SkipCsv := '';
    if DM.qryStoreLEADS_ONLINE_SKIP_CSV_SENT.AsBoolean then
      SkipCsv := SQLCandidatesSkipCsvSent;

    if rbSendDateRange.Checked then
      Q := OpenForDateRange(SQLCandidatesBase + SkipCsv + SQLCandidatesDateFilter + SQLCandidatesOrder,
                            edFDate.Date, edTDate.Date)
    else
      Q := OpenSQL(SQLCandidatesBase + SkipCsv + SQLCandidatesOrder);
    try
      clnTickets.DisableControls;
      try
        clnTickets.EmptyDataSet;
        while not Q.Eof do
        begin
          clnTickets.Append;
          clnTickets.FieldByName(ColSelected).AsBoolean := True;
          clnTickets.FieldByName('TRANSACTION_NO').AsInteger := Q.FieldByName('TRANSACTION_NO').AsInteger;
          clnTickets.FieldByName('TRAN_DATE').AsDateTime := Q.FieldByName('TRAN_DATE').AsDateTime;
          clnTickets.FieldByName('TRAN_TYPE').AsString := Q.FieldByName('TRAN_TYPE').AsString;
          clnTickets.FieldByName('TRAN_TICKET_NO').AsString := Q.FieldByName('TRAN_TICKET_NO').AsString;
          clnTickets.FieldByName('CUSTOMER').AsString := Q.FieldByName('CUSTOMER').AsString;
          clnTickets.FieldByName('ITEM_COUNT').AsInteger := Q.FieldByName('ITEM_COUNT').AsInteger;
          clnTickets.FieldByName(ColItemImages).AsInteger := Q.FieldByName(ColItemImages).AsInteger;
          clnTickets.FieldByName(ColIdImages).AsInteger := Q.FieldByName(ColIdImages).AsInteger;

          // Carry a previous failure forward so the operator can see WHY this
          // row is still here rather than having to submit it to find out.
          if not Q.FieldByName('LAST_ERROR_CODE').IsNull then
          begin
            Prev := Trim(Q.FieldByName('LAST_ERROR_RESPONSE').AsString);
            clnTickets.FieldByName(ColOutcome).AsString := OutcomeFailed;
            clnTickets.FieldByName(ColDetail).AsString :=
              'Previous attempt: ' + LeadsOnlineErrorText(
                Q.FieldByName('LAST_ERROR_CODE').AsInteger, Prev);
          end;
          clnTickets.Post;
          Q.Next;
        end;
        clnTickets.First;
      finally
        clnTickets.EnableControls;
      end;
    finally
      Q.Free;
    end;

    UpdateCountLabel;
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ Which column was actually clicked.

  The Column passed to OnCellClick cannot be trusted here, because the grid runs
  with dgRowSelect: in row-select mode TDBGrid keeps no current column, so it
  reports the FIRST one for a click anywhere on the row -- and the first one is
  the tick box. Every click therefore toggled the row, which is precisely the
  bug this exists to fix.

  Hit-testing the live cursor position is reliable at this moment because the
  event is raised from the grid's own mouse handling, with the pointer still
  where the operator put it. Returns nil if the click landed on the indicator
  strip, a title, or past the last column. }
function TfrmLeadsOnlineSoapExport.ClickedColumn: TColumn;
var
  Pt: TPoint;
  Cell: TGridCoord;
  Idx: Integer;
begin
  Result := nil;
  Pt := grdTickets.ScreenToClient(Mouse.CursorPos);
  Cell := grdTickets.MouseCoord(Pt.X, Pt.Y);

  Idx := Cell.X;
  if dgIndicator in grdTickets.Options then
    Dec(Idx);

  if (Cell.Y > 0) and (Idx >= 0) and (Idx < grdTickets.Columns.Count) then
    Result := grdTickets.Columns[Idx];
end;

procedure TfrmLeadsOnlineSoapExport.grdTicketsCellClick(Column: TColumn);
var
  Clicked: TColumn;
begin
  // Click the tick column to include/exclude a row.
  //
  // Not while the post-run filter is showing only the selected rows: unticking
  // would fail the filter and the row would vanish from the results the
  // operator is reading. Refresh (or Check all / Clear all) brings the whole
  // list back and re-enables ticking.
  if FRunning or FShowOnlySelected then
    Exit;

  // Column is ignored on purpose -- see ClickedColumn.
  Clicked := ClickedColumn;
  if (Clicked = nil) or (not SameText(Clicked.FieldName, ColSelected)) then
    Exit;

  clnTickets.Edit;
  clnTickets.FieldByName(ColSelected).AsBoolean := not clnTickets.FieldByName(ColSelected).AsBoolean;
  clnTickets.Post;
  UpdateCountLabel;
end;

procedure TfrmLeadsOnlineSoapExport.grdTicketsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Outcome: string;
begin
  // The tick column is a boolean; drawn as a box it reads at a glance, where
  // "True"/"False" text does not.
  if SameText(Column.FieldName, ColSelected) then
  begin
    // Greyed while the results filter is on, because ticking is disabled there
    // -- a box that looks clickable but ignores clicks is worse than one that
    // plainly is not.
    if FShowOnlySelected then
      grdTickets.Canvas.Brush.Color := clBtnFace;
    grdTickets.Canvas.FillRect(Rect);
    DrawCheckBox(grdTickets.Canvas, Rect, 0.6,
                 clnTickets.FieldByName(ColSelected).AsBoolean,
                 (gdSelected in State) and (not FShowOnlySelected));
    Exit;
  end;

  if SameText(Column.FieldName, ColOutcome) then
  begin
    Outcome := clnTickets.FieldByName(ColOutcome).AsString;
    if Outcome = OutcomeFailed then
      grdTickets.Canvas.Font.Color := clRed
    else if (Outcome = OutcomeSent) or (Outcome = OutcomeAlready) then
      grdTickets.Canvas.Font.Color := clGreen
    else if (Outcome = OutcomeTooOld) or (Outcome = OutcomeSkipped) then
      // Settled, but nothing was reported -- neither success nor a problem to
      // chase, so it should not read as either.
      grdTickets.Canvas.Font.Color := clGrayText;
  end;
  grdTickets.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmLeadsOnlineSoapExport.clnTicketsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  // A Pascal filter rather than a Filter expression string: the field is a
  // boolean in a memtable, and expression-parser behaviour for booleans varies
  // enough that this is one less thing to be wrong at a customer site.
  Accept := (not FShowOnlySelected) or
            DataSet.FieldByName(ColSelected).AsBoolean;
end;

procedure TfrmLeadsOnlineSoapExport.ShowOnlySelected(AValue: Boolean);
begin
  if FShowOnlySelected = AValue then
    Exit;
  FShowOnlySelected := AValue;
  if clnTickets.Active then
  begin
    clnTickets.Filtered := AValue;
    clnTickets.First;
  end;
  UpdateCountLabel;
end;

function TfrmLeadsOnlineSoapExport.SelectedCount: Integer;
var
  BM: TBookmark;
begin
  Result := 0;
  if (not clnTickets.Active) or clnTickets.IsEmpty then
    Exit;

  BM := clnTickets.GetBookmark;
  clnTickets.DisableControls;
  try
    clnTickets.First;
    while not clnTickets.Eof do
    begin
      if clnTickets.FieldByName(ColSelected).AsBoolean then
        Inc(Result);
      clnTickets.Next;
    end;
    if clnTickets.BookmarkValid(BM) then
      clnTickets.GotoBookmark(BM);
  finally
    clnTickets.EnableControls;
    clnTickets.FreeBookmark(BM);
  end;
end;

function TfrmLeadsOnlineSoapExport.SelectedRecentCount: Integer;
var
  BM: TBookmark;
  Cutoff: TDateTime;
begin
  Result := 0;
  if (not clnTickets.Active) or clnTickets.IsEmpty then
    Exit;

  Cutoff := IncMonth(Date, -RecentExclusionMonths);

  BM := clnTickets.GetBookmark;
  clnTickets.DisableControls;
  try
    clnTickets.First;
    while not clnTickets.Eof do
    begin
      if clnTickets.FieldByName(ColSelected).AsBoolean and
         (not clnTickets.FieldByName('TRAN_DATE').IsNull) and
         (clnTickets.FieldByName('TRAN_DATE').AsDateTime >= Cutoff) then
        Inc(Result);
      clnTickets.Next;
    end;
    if clnTickets.BookmarkValid(BM) then
      clnTickets.GotoBookmark(BM);
  finally
    clnTickets.EnableControls;
    clnTickets.FreeBookmark(BM);
  end;
end;

procedure TfrmLeadsOnlineSoapExport.UpdateCountLabel;
begin
  // "3 of 214 ticked" rather than a bare total: with Check all / Clear all the
  // number that matters is how many are about to be SENT, and on a store with
  // years of history those two numbers are wildly different.
  //
  // While the run filter is on, "of N" would compare the list against itself
  // and always read "3 of 3", which says nothing -- so say what is on screen
  // instead.
  if FShowOnlySelected then
    lblCount.Caption := Format('showing %d selected', [clnTickets.RecordCount])
  else
    lblCount.Caption := Format('%d of %d ticked',
      [SelectedCount, clnTickets.RecordCount]);
  lblCount.Left := lblCount.Parent.ClientWidth - lblCount.Width - 24;
end;

procedure TfrmLeadsOnlineSoapExport.SetAllSelected(AValue: Boolean);
var
  BM: TBookmark;
begin
  if not clnTickets.Active then
    Exit;

  // Re-selecting is a whole-list operation, so bring the whole list back first.
  // Otherwise "Clear all" while the post-run filter is on would empty the grid
  // in front of the operator -- technically correct, alarming in practice.
  ShowOnlySelected(False);

  if clnTickets.IsEmpty then
    Exit;

  // Keep the row the operator was looking at, and do the whole sweep with the
  // grid detached so it repaints once instead of once per row.
  BM := clnTickets.GetBookmark;
  clnTickets.DisableControls;
  try
    clnTickets.First;
    while not clnTickets.Eof do
    begin
      if clnTickets.FieldByName(ColSelected).AsBoolean <> AValue then
      begin
        clnTickets.Edit;
        clnTickets.FieldByName(ColSelected).AsBoolean := AValue;
        clnTickets.Post;
      end;
      clnTickets.Next;
    end;
    if clnTickets.BookmarkValid(BM) then
      clnTickets.GotoBookmark(BM);
  finally
    clnTickets.EnableControls;
    clnTickets.FreeBookmark(BM);
  end;
  UpdateCountLabel;
end;

procedure TfrmLeadsOnlineSoapExport.btnCheckAllClick(Sender: TObject);
begin
  SetAllSelected(True);
end;

procedure TfrmLeadsOnlineSoapExport.btnClearAllClick(Sender: TObject);
begin
  SetAllSelected(False);
end;

// Greyed out rather than hidden while a run is in progress or nothing is
// ticked, so the item's existence is discoverable but it cannot fire at a
// moment when "the selection" is ambiguous.
procedure TfrmLeadsOnlineSoapExport.popMnuGridPopup(Sender: TObject);
begin
  ExcludeSelected1.Enabled := (not FRunning) and (SelectedCount > 0);
end;

{ Marks the ticked transactions as never-to-be-sent.

  This is the answer to a store joining the web service with decades of history:
  most of it is far older than LeadsOnline will accept, and nothing removes a
  transaction from the candidate list until the service has answered about it,
  so without this the genuinely-unsent rows stay buried under thousands that can
  never succeed.

  The confirmation counts RECENT transactions separately and on purpose. This
  one menu item does two very different things: excluding a 2001 pawn is
  housekeeping, while excluding last week's means a transaction that never
  reaches law enforcement. A single "are you sure?" for both teaches people to
  click through the one that matters. }
procedure TfrmLeadsOnlineSoapExport.ExcludeSelected1Click(Sender: TObject);
var
  Total, Recent, Done: Integer;
  Msg: string;
  Qry: TFDQuery;
  BM: TBookmark;
begin
  if FRunning then
    Exit;

  Total := SelectedCount;
  if Total = 0 then
  begin
    PawnInfo('Tick the transactions to exclude first.');
    Exit;
  end;

  Recent := SelectedRecentCount;

  Msg := Format('Never send %d transaction(s) to LeadsOnline?', [Total]) +
         sLineBreak + sLineBreak +
         'They will stop appearing in this list and will not be sent, now or later.';

  if Recent > 0 then
    Msg := Msg + sLineBreak + sLineBreak +
           Format('WARNING: %d of them %s from the last %d months.',
                  [Recent, IfThen(Recent = 1, 'is', 'are'), RecentExclusionMonths]) +
           sLineBreak +
           'Recent transactions are normally reportable. Excluding one means it ' +
           'is never reported to law enforcement.';

  if not PawnConfirm(Msg) then
    Exit;

  Done := 0;
  Qry := NewQuery(SQLExcludeTransaction);
  try
    Qry.ParamByName('TransactionNo').DataType := ftInteger;
    Qry.ParamByName('Reason').DataType := ftString;
    Qry.ParamByName('Reason').AsString := ExcludeReasonOperator;

    BM := clnTickets.GetBookmark;
    clnTickets.DisableControls;
    try
      clnTickets.First;
      while not clnTickets.Eof do
        begin
          if clnTickets.FieldByName(ColSelected).AsBoolean then
            begin
              Qry.ParamByName('TransactionNo').AsInteger := clnTickets.FieldByName('TRANSACTION_NO').AsInteger;
              Qry.ExecSQL;
              Inc(Done);
            end;
          clnTickets.Next;
        end;
      if clnTickets.BookmarkValid(BM) then
        clnTickets.GotoBookmark(BM);
    finally
      clnTickets.EnableControls;
      clnTickets.FreeBookmark(BM);
    end;
  finally
    Qry.Free;
  end;

  // Reload rather than delete the rows in place: the candidate query is the one
  // definition of what is still sendable, and re-running it proves the
  // exclusions took rather than merely assuming they did.
  LoadCandidates;

  PawnInfo(Format('%d transaction(s) will no longer be sent to LeadsOnline.', [Done]));
end;

procedure TfrmLeadsOnlineSoapExport.SetRunning(AValue: Boolean);
begin
  FRunning := AValue;
  btnSubmit.Enabled := not AValue;
  btnRefresh.Enabled := not AValue;
  btnCheckAll.Enabled := not AValue;
  btnClearAll.Enabled := not AValue;
  // Freeze the whole scope group while sending -- changing the selection
  // mid-run would reload the grid out from under the loop.
  gbExportTranSelection.Enabled := not AValue;
  pbSubmit.Visible := AValue;
  if AValue then
    btnExit.Caption := ' &Cancel'
  else
  begin
    btnExit.Caption := ' &Close';
    lblProgress.Caption := '';
  end;
end;

procedure TfrmLeadsOnlineSoapExport.SetRowOutcome(const AOutcome, ADetail: string);
begin
  clnTickets.Edit;
  clnTickets.FieldByName(ColOutcome).AsString := AOutcome;
  clnTickets.FieldByName(ColDetail).AsString := Copy(ADetail, 1, 250);
  clnTickets.Post;
end;

procedure TfrmLeadsOnlineSoapExport.RecordSubmission(ATransactionNo: Integer;
  const ATicketType, ATicketNumber, ATicketDateTime: string; AErrorCode: Integer;
  const AErrorResponse: string; AIsVoid: Boolean);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text := SQLRecordSubmission;
    Q.ParamByName('TransactionNo').AsInteger := ATransactionNo;
    Q.ParamByName('TicketType').AsString := ATicketType;
    Q.ParamByName('TicketNumber').AsString := ATicketNumber;
    Q.ParamByName('TicketDateTime').AsString := ATicketDateTime;
    Q.ParamByName('ErrorCode').AsInteger := AErrorCode;
    Q.ParamByName('ErrorResponse').AsString := Copy(Trim(AErrorResponse), 1, 500);
    Q.ParamByName('IsVoid').AsBoolean := AIsVoid;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TfrmLeadsOnlineSoapExport.RecordImageSent(ATransactionNo, AImagesDataNo: Integer;
  const ACategory: string; AItemIndex: Integer; AItemIndexNull: Boolean;
  const AServerFilename: string; AErrorCode: Integer; const AErrorResponse: string);
var
  Q: TFDQuery;
begin
  Q := NewQuery(SQLRecordImageSent);
  try
    Q.ParamByName('TransactionNo').AsInteger := ATransactionNo;
    Q.ParamByName('ImagesDataNo').AsInteger := AImagesDataNo;
    Q.ParamByName('ImageCategory').AsString := ACategory;
    if AItemIndexNull then
      Q.ParamByName('ItemIndex').Clear
    else
      Q.ParamByName('ItemIndex').AsInteger := AItemIndex;
    Q.ParamByName('ServerFilename').AsString := Copy(Trim(AServerFilename), 1, 255);
    Q.ParamByName('ErrorCode').AsInteger := AErrorCode;
    Q.ParamByName('ErrorResponse').AsString := Copy(Trim(AErrorResponse), 1, 500);
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TfrmLeadsOnlineSoapExport.UploadImagesFor(AClient: TLeadsOnlineClient;
  ATransactionNo: Integer; AKey: TicketKey; out ASent, AFailed: Integer);
var
  Q: TFDQuery;
  Bytes: TBytes;
  Category: string;
  Cat: ImageCategory;
  ItemIndex, SentIndex, ImagesDataNo: Integer;
  IndexIsNull: Boolean;
  Res: TLeadsOnlineResult;
  Err: string;
  ConsecutiveFail: Integer;
begin
  ASent := 0;
  AFailed := 0;
  ConsecutiveFail := 0;

  if not Assigned(GetImageBytesProc) then
    Exit;   // storage layer not bound; nothing sensible to do

  Q := NewQuery(SQLTicketImages);
  try
    Q.ParamByName('TransactionNo').DataType := ftInteger;
    Q.ParamByName('TransactionNo').AsInteger := ATransactionNo;
    Q.Open;

    // Cancel is honoured BETWEEN images, not just between tickets. Each upload
    // carries the client's own retry, so a ticket with several photos on a dead
    // line would otherwise ignore the button for minutes and read as a hang.
    while (not Q.Eof) and (not FCancelled) and
          (ConsecutiveFail < MaxConsecutiveImageFailures) do
    begin
      ImagesDataNo := Q.FieldByName('IMAGES_DATA_NO').AsInteger;
      Category := Q.FieldByName('IMAGE_CATEGORY').AsString;
      IndexIsNull := Q.FieldByName('ITEM_INDEX').IsNull;
      ItemIndex := Q.FieldByName('ITEM_INDEX').AsInteger;
      // itemIndex is meaningless for a customer photo; their spec says it
      // applies only to ImageCategory.Item, so send a definite 0 rather than
      // whatever a NULL field happens to read back as.
      if IndexIsNull then
        SentIndex := 0
      else
        SentIndex := ItemIndex;

      if SameText(Category, 'CustomerID') then
        Cat := ImageCategory.CustomerID
      else
        Cat := ImageCategory.Item;

      // Original bytes through the pluggable layer, so this works the same
      // whether the store keeps images in the database or on disk -- and
      // without re-encoding what the camera produced.
      Bytes := GetImageBytesProc(ImagesDataNo);

      if Length(Bytes) = 0 then
      begin
        // The row exists but the file does not. Recorded so it is visible
        // rather than silently skipped on every future run. A missing file says
        // nothing about the line, so it does not count toward the give-up rule.
        Inc(AFailed);
        RecordImageSent(ATransactionNo, ImagesDataNo, Category, ItemIndex, IndexIsNull,
                        '', -1, 'The image file could not be found or is empty.');
      end
      else if AClient.TryUploadImage(AKey, Bytes, Cat, SentIndex, Res, Err) then
      begin
        // Reached the service, whatever it said -- so the line is up and any
        // earlier transport failure was a one-off.
        ConsecutiveFail := 0;
        if Res.Succeeded then
        begin
          // On success their errorResponse carries the server's filename for
          // the image -- the only handle DeleteImage will accept later.
          Inc(ASent);
          RecordImageSent(ATransactionNo, ImagesDataNo, Category, ItemIndex, IndexIsNull,
                          Res.ErrorResponse, 0, '');
        end
        else
        begin
          Inc(AFailed);
          RecordImageSent(ATransactionNo, ImagesDataNo, Category, ItemIndex, IndexIsNull,
                          '', Res.ErrorCode, Res.Text);
        end;
      end
      else
      begin
        // Never reached the service. Nothing recorded, for the same reason a
        // ticket is not: we do not know whether they got it, and leaving no row
        // means the next run offers it again.
        Inc(AFailed);
        Inc(ConsecutiveFail);
      end;

      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

function TfrmLeadsOnlineSoapExport.SubmitOne(AClient: TLeadsOnlineClient;
  ATransactionNo: Integer; out ATransportError: string): TSubmitOutcome;
var
  Header, Items, Stones: TFDQuery;
  T: Ticket;
  Res: TLeadsOnlineResult;
  Err, TicketTypeName, TicketNumber, TicketDateTime: string;
  Reached, IsVoid: Boolean;
  ImgSent, ImgFailed: Integer;
begin
  ATransportError := '';
  Header := nil; Items := nil; Stones := nil; T := nil;
  try
    Header := OpenForTransaction(SQLTicketHeader, ATransactionNo);
    if Header.IsEmpty then
    begin
      // Not an error: the selection filter allows only P and U, so an empty
      // header means the row changed underneath us.
      SetRowOutcome(OutcomeSkipped, 'Transaction is no longer a pawn or purchase.');
      Exit(soSkipped);
    end;

    Items := OpenForTransaction(SQLTicketItems, ATransactionNo);
    Stones := OpenForTransaction(SQLTicketStones, ATransactionNo);

    try
      T := TLeadsOnlineTicketMapper.BuildTicket(Header, Items, Stones);
    except
      on E: ELeadsOnlineMapping do
      begin
        SetRowOutcome(OutcomeSkipped, E.Message);
        Exit(soSkipped);
      end;
    end;

    // Capture the key EXACTLY as built, before sending: this is what goes in
    // the log, and it is the only handle on the ticket afterwards.
    // Spelled out rather than taken from RTTI: this string is persisted as half
    // the ticket key and must keep meaning exactly what was sent, independent of
    // how the generated proxy happens to name its enum members.
    case T.key.ticketType of
      TicketType.Pawn: TicketTypeName := 'Pawn';
      TicketType.Buy:  TicketTypeName := 'Buy';
    else
      TicketTypeName := '';
    end;
    TicketNumber := T.key.ticketnumber;
    TicketDateTime := T.key.ticketDateTime;
    IsVoid := T.isVoid;

    // TrySubmitTransaction retries transport failures INLINE (same ticket,
    // nothing else sent in between), which is the only retry the vendor's
    // duplicate-suppression rule makes safe.
    Reached := AClient.TrySubmitTransaction(T, Res, Err);

    if not Reached then
    begin
      // Never got a Response. Deliberately NOT logged as an attempt: we do not
      // know whether LeadsOnline saw it, and writing a failure row would make
      // the next run resend it -- which is correct -- while writing a success
      // row would lose it forever. Because nothing is recorded, this row simply
      // reappears in the candidate list next time: the selection query IS the
      // retry queue, which is why there is no pending table.
      SetRowOutcome(OutcomeFailed, Err);
      ATransportError := Err;
      Exit(soUnreachable);
    end;

    RecordSubmission(ATransactionNo, TicketTypeName, TicketNumber, TicketDateTime,
                     Res.ErrorCode, Res.ErrorResponse, IsVoid);

    if Res.Succeeded or ResultIsAlreadyAccepted(Res) then
    begin
      // Images go up in the same run, immediately, using the key just sent --
      // one operator action for the whole job. They are attempted for an
      // already-held ticket too: the ticket exists on their side either way,
      // and its photos may never have made it.
      UploadImagesFor(AClient, ATransactionNo, T.key, ImgSent, ImgFailed);

      if ResultIsAlreadyAccepted(Res) then
        SetRowOutcome(OutcomeAlready, DescribeImages(ImgSent, ImgFailed, Res.Text))
      else
        SetRowOutcome(OutcomeSent, DescribeImages(ImgSent, ImgFailed, ''));
      Result := soAccepted;
    end
    else if Res.ErrorCode = LeadsErrTicketDateOutOfRange then
    begin
      // Settled, not failed: the transaction will never get younger. Shown as a
      // decision rather than in red, and filtered out of the candidate list from
      // here on so it stops presenting itself as work to do.
      SetRowOutcome(OutcomeTooOld, Res.Text);
      Result := soRejected;
    end
    else
    begin
      // A rejection is about THIS ticket (a bad field, a missing value). It says
      // nothing about the next one, so the run carries on.
      SetRowOutcome(OutcomeFailed, Res.Text);
      Result := soRejected;
    end;
  finally
    T.Free;
    Stones.Free;
    Items.Free;
    Header.Free;
  end;
end;

procedure TfrmLeadsOnlineSoapExport.btnSubmitClick(Sender: TObject);
var
  Total, Done, Ok, Failed: Integer;
  TranNo, StoreId, ConsecutiveUnreachable: Integer;
  BM: TBookmark;
  Client: TLeadsOnlineClient;
  Unreachable: Boolean;
  TransportErr, LastTransportErr: string;
begin
  if clnTickets.IsEmpty then
  begin
    PawnInfo('There is nothing to submit for this date range.');
    Exit;
  end;
  if not CredentialsConfigured then
    Exit;
  // Validated once, before the loop. Doing it per ticket would put one modal
  // dialog in front of the operator for every row in the run.
  if not StoreIdOrComplain(StoreId) then
    Exit;

  Total := SelectedCount;
  if Total = 0 then
  begin
    PawnInfo('No transactions are ticked.');
    Exit;
  end;

  // No "are you sure" here on purpose. Ticking the rows is the confirmation --
  // the operator has already said which transactions go, and lblSandbox states
  // which endpoint they go to for as long as the form is open. A second prompt
  // in front of a deliberate act only teaches people to dismiss prompts.

  // Narrow the grid to exactly what is going out, before the first call. The
  // rows being worked stay on screen instead of scrolling away among the
  // thousands that were not ticked.
  ShowOnlySelected(True);

  FCancelled := False;
  SetRunning(True);
  Done := 0; Ok := 0; Failed := 0;
  ConsecutiveUnreachable := 0;
  Unreachable := False;
  LastTransportErr := '';
  pbSubmit.Position := 0;
  pbSubmit.Max := Total;
  // One client for the whole run: one connection, and the endpoint/credentials
  // are resolved once rather than per ticket.
  Client := TLeadsOnlineClient.Create(StoreId,
              Trim(DM.qryStoreLEADS_ONLINE_API_USER.AsString),
              DM.qryStoreLEADS_ONLINE_API_PASSWORD.AsString,
              DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean);
  try
    clnTickets.DisableControls;
    try
      clnTickets.First;
      while (not clnTickets.Eof) and (not FCancelled) do
      begin
        if clnTickets.FieldByName(ColSelected).AsBoolean then
        begin
          TranNo := clnTickets.FieldByName('TRANSACTION_NO').AsInteger;
          Inc(Done);
          lblProgress.Caption := Format('Submitting %d of %d  (ticket %s)',
            [Done, Total, clnTickets.FieldByName('TRAN_TICKET_NO').AsString]);
          pbSubmit.Position := Done;

          BM := clnTickets.GetBookmark;
          try
            clnTickets.EnableControls;   // let the row repaint as it is worked
            try
              case SubmitOne(Client, TranNo, TransportErr) of
                soAccepted:
                  begin
                    Inc(Ok);
                    ConsecutiveUnreachable := 0;
                  end;
                soUnreachable:
                  begin
                    Inc(Failed);
                    Inc(ConsecutiveUnreachable);
                    LastTransportErr := TransportErr;
                  end;
                soSkipped:
                  ConsecutiveUnreachable := 0;
              else
                // soRejected
                Inc(Failed);
                ConsecutiveUnreachable := 0;
              end;
            finally
              clnTickets.DisableControls;
            end;
            if clnTickets.BookmarkValid(BM) then
              clnTickets.GotoBookmark(BM);
          finally
            clnTickets.FreeBookmark(BM);
          end;
          Application.ProcessMessages;   // keeps Cancel responsive

          // The line is down. Stop rather than spend 30 seconds per remaining
          // ticket discovering the same thing: with 40 tickets left that is
          // twenty minutes of a frozen-looking window, and nothing is gained --
          // none of them were recorded, so they all stay listed for next time.
          if ConsecutiveUnreachable >= MaxConsecutiveUnreachable then
          begin
            Unreachable := True;
            Break;
          end;
        end;
        clnTickets.Next;
      end;
    finally
      clnTickets.EnableControls;
    end;
  finally
    Client.Free;
    SetRunning(False);
    // Back to the top: the loop ends on the last row, which leaves the grid
    // scrolled to the bottom with the results the operator wants to read now
    // sitting off-screen above.
    if clnTickets.Active and (not clnTickets.IsEmpty) then
      clnTickets.First;
  end;

  if Unreachable then
  begin
    // Diagnose only now, once, when it actually matters -- and say plainly that
    // nothing was lost, because "Failed" on 30 rows looks alarming otherwise.
    Screen.Cursor := crHourGlass;
    try
      TransportErr := DiagnoseEndpoint(
        IfThen(DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean,
               LeadsOnlineSandboxURL, LeadsOnlineProductionURL));
    finally
      Screen.Cursor := crDefault;
    end;
    PawnError(
      'Stopped: LeadsOnline could not be reached.' + sLineBreak + sLineBreak +
      TransportErr + sLineBreak + sLineBreak +
      Format('%d transaction(s) were accepted before the connection failed. ' +
             'Nothing else was sent and nothing was lost — every remaining ' +
             'transaction is still listed here and will be sent next time you ' +
             'run this. There is no need to send today; run it again when the ' +
             'connection is working.', [Ok]) +
      IfThen(LastTransportErr = '', '',
             sLineBreak + sLineBreak + 'First error: ' + LastTransportErr));
  end
  else if FCancelled then
    PawnWarn(Format('Cancelled after %d of %d.%s%s accepted, %s failed.',
      [Done, Total, sLineBreak, Ok.ToString, Failed.ToString]))
  else if Failed = 0 then
    PawnInfo(Format('All %d transaction(s) accepted by LeadsOnline.', [Ok]))
  else
    PawnWarn(Format('%d accepted, %d failed.%s%s',
      [Ok, Failed, sLineBreak + sLineBreak,
       'Failed rows keep their reason in the grid and stay selectable for a retry.']));
end;

end.
