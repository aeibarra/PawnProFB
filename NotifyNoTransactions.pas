unit NotifyNoTransactions;

{ Declaring to LeadsOnline that a day had no pawn activity.

  Gema Jewelers' local police want to be TOLD when a day was quiet rather than
  infer it from silence. Without this they have to log into the LeadsOnline
  website by hand; the web service exposes SetNoTransactionDayForStore, so the
  store never has to leave PawnPro.

  THIS IS A STATEMENT TO LAW ENFORCEMENT THAT NOTHING HAPPENED. That is not a
  figure of speech, and it drives every rule here. Where convenience and
  truthfulness disagree, truthfulness wins: a missing declaration is a gap
  somebody can notice and chase, while a false one is a lie nobody will ever
  question.

  Hence:

    * The day is checked against TRANSACTIONS first, and a day with pawns or
      purchases is REFUSED outright, with the count shown. A clerk half-reading
      a confirmation must not be able to file a false statement.

    * Declaring TODAY before 5pm warns loudly, because the day is not over. It
      warns rather than refuses -- a shop closing early has a legitimate reason.
      The warning keys on the DATE, not the clock alone: declaring yesterday at
      9am is correct and passes silently, and a warning that fires during
      ordinary use is one clerks learn to click through.

    * Neither button takes focus (TRzToolButton), and nothing on this form is a
      Default button. Enter does nothing at all here. Sending by accident is the
      failure this form is shaped to prevent.

  Every attempt is recorded, successes and failures alike -- the grid exists to
  show what went wrong. See Docs/NoTransactionDay_Design.md. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, Vcl.Mask, RzEdit, RzButton, RzLabel, RzPanel,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmNotifyNoTransactions = class(TForm)
    pnLeft: TRzPanel;
    grHistory: TDBGrid;
    pnRight: TRzPanel;
    lblDate: TRzLabel;
    edDate: TRzDateTimeEdit;
    btnNotify: TRzToolButton;
    btnCancel: TRzToolButton;
    lblResult: TRzLabel;
    clnHistory: TFDMemTable;
    dsHistory: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNotifyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edDateChange(Sender: TObject);
  private
    procedure BuildGridStructure;
    procedure LoadHistory;
    function TransactionsOn(ADate: TDate): Integer;
    function DateIsAcceptable(ADate: TDate): Boolean;
    procedure RecordAttempt(ADate: TDate; ACodeIsNull: Boolean; ACode: Integer;
      const AResponse: string);
    procedure ShowResult(const AText: string; AColor: TColor);
  public
    { Public declarations }
  end;

var
  frmNotifyNoTransactions: TfrmNotifyNoTransactions;

implementation

uses
  System.DateUtils, System.StrUtils, PawnDM, PawnGlobal, uPawnDialogs,
  uLeadsOnlineClient;

{$R *.dfm}

const
  { Before this hour, declaring TODAY is warned about. The working day is not
    over and a pawn may still walk in. }
  EndOfTradingHour = 17;

  SQLCountTransactions =
    'SELECT COUNT(*) AS N FROM TRANSACTIONS ' +
    ' WHERE TRAN_DATE = :ActivityDate ' +
    '   AND TRAN_TYPE IN (''P'', ''U'')';

  { Failures are kept as well as successes: the grid is here to show what went
    wrong. MATCHING lets a retry after a connection failure overwrite the
    earlier attempt instead of colliding with UQ_LEADS_SOAP_NO_ACTIVITY. }
  SQLRecordAttempt =
    'UPDATE OR INSERT INTO LEADS_SOAP_NO_ACTIVITY ' +
    '  (ACTIVITY_DATE, DECLARED_AT, ERROR_CODE, ERROR_RESPONSE) ' +
    '  VALUES (:ActivityDate, CURRENT_TIMESTAMP, :ErrorCode, :ErrorResponse) ' +
    '  MATCHING (ACTIVITY_DATE)';

  SQLHistory =
    'SELECT ACTIVITY_DATE, DECLARED_AT, ERROR_CODE, ERROR_RESPONSE ' +
    '  FROM LEADS_SOAP_NO_ACTIVITY ' +
    ' ORDER BY ACTIVITY_DATE DESC';

procedure TfrmNotifyNoTransactions.FormCreate(Sender: TObject);
begin
  BuildGridStructure;
end;

procedure TfrmNotifyNoTransactions.BuildGridStructure;
begin
  clnHistory.Close;
  clnHistory.FieldDefs.Clear;
  clnHistory.FieldDefs.Add('ACTIVITY_DATE', ftDate);
  clnHistory.FieldDefs.Add('DECLARED_AT', ftDateTime);
  clnHistory.FieldDefs.Add('RESULT', ftString, 20);
  clnHistory.FieldDefs.Add('DETAIL', ftString, 250);
  clnHistory.CreateDataSet;
end;

procedure TfrmNotifyNoTransactions.FormShow(Sender: TObject);
begin
  // Yesterday: the commonest correct answer, and the one that needs no warning.
  edDate.Date := Date - 1;
  lblResult.Caption := '';
  LoadHistory;
  edDateChange(nil);
end;

{ What the day actually holds, so the operator is told rather than just refused.

  Pawns and purchases only -- those are what LeadsOnline is told about. }
function TfrmNotifyNoTransactions.TransactionsOn(ADate: TDate): Integer;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text := SQLCountTransactions;
    Q.ParamByName('ActivityDate').AsDate := ADate;
    Q.Open;
    Result := Q.FieldByName('N').AsInteger;
  finally
    Q.Free;
  end;
end;

procedure TfrmNotifyNoTransactions.ShowResult(const AText: string; AColor: TColor);
begin
  lblResult.Caption := AText;
  lblResult.Font.Color := AColor;
end;

{ Live feedback as the date changes, so the operator knows before pressing
  anything. Showing the COUNT matters: "it will not let me" produces a phone
  call, "there were 3 transactions that day" answers itself. }
procedure TfrmNotifyNoTransactions.edDateChange(Sender: TObject);
var
  N: Integer;
begin
  if edDate.Date > Date then
  begin
    ShowResult('That date is in the future.', clRed);
    Exit;
  end;

  N := TransactionsOn(edDate.Date);
  if N > 0 then
    ShowResult(Format('%d transaction(s) on this date -- it cannot be declared ' +
                      'as having no activity.', [N]), clRed)
  else
    ShowResult('No pawns or purchases recorded on this date.', clGreen);
end;

{ The gate. Everything that would make the declaration untrue is caught here. }
function TfrmNotifyNoTransactions.DateIsAcceptable(ADate: TDate): Boolean;
var
  N: Integer;
begin
  Result := False;

  if ADate > Date then
  begin
    PawnWarn('That date is in the future. A day cannot be declared before it ' +
             'has happened.', 'No activity', Self);
    Exit;
  end;

  N := TransactionsOn(ADate);
  if N > 0 then
  begin
    PawnError(Format('There %s %d transaction%s on %s, so this day cannot be ' +
                     'declared as having had no activity.' + sLineBreak + sLineBreak +
                     'Send those to LeadsOnline from the export screen instead.',
                     [IfThen(N = 1, 'is', 'are'), N, IfThen(N = 1, '', 's'),
                      FormatDateTime('mm/dd/yyyy', ADate)]),
              'No activity', Self);
    Exit;
  end;

  // The day is not over. A warning, not a refusal: a shop that closes early has
  // a legitimate reason to close the day out. Keyed on the date, so declaring an
  // earlier day at any hour passes silently.
  if (ADate = Date) and (HourOf(Now) < EndOfTradingHour) then
    if not PawnConfirm(
         Format('It is only %s, and you are about to tell LeadsOnline that ' +
                'TODAY had no pawns.' + sLineBreak + sLineBreak +
                'The day is not over. If a pawn is taken later, this ' +
                'declaration will be wrong and law enforcement will have been ' +
                'told something untrue.' + sLineBreak + sLineBreak +
                'Declare today anyway?', [FormatDateTime('h:nn am/pm', Now)]),
         'The day is not over') then
      Exit;

  Result := True;
end;

procedure TfrmNotifyNoTransactions.RecordAttempt(ADate: TDate; ACodeIsNull: Boolean;
  ACode: Integer; const AResponse: string);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text := SQLRecordAttempt;
    Q.ParamByName('ActivityDate').AsDate := ADate;
    if ACodeIsNull then
      Q.ParamByName('ErrorCode').Clear
    else
      Q.ParamByName('ErrorCode').AsInteger := ACode;
    Q.ParamByName('ErrorResponse').AsString := Copy(AResponse, 1, 500);
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TfrmNotifyNoTransactions.LoadHistory;
var
  Q: TFDQuery;
  Code: Integer;
  CodeIsNull: Boolean;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.ConnFB;
    Q.SQL.Text := SQLHistory;
    Q.Open;

    clnHistory.DisableControls;
    try
      clnHistory.EmptyDataSet;
      while not Q.Eof do
      begin
        CodeIsNull := Q.FieldByName('ERROR_CODE').IsNull;
        Code := Q.FieldByName('ERROR_CODE').AsInteger;

        clnHistory.Append;
        clnHistory.FieldByName('ACTIVITY_DATE').AsDateTime := Q.FieldByName('ACTIVITY_DATE').AsDateTime;
        clnHistory.FieldByName('DECLARED_AT').AsDateTime := Q.FieldByName('DECLARED_AT').AsDateTime;
        if (not CodeIsNull) and (Code = 0) then
        begin
          clnHistory.FieldByName('RESULT').AsString := 'Declared';
          clnHistory.FieldByName('DETAIL').AsString := '';
        end
        else
        begin
          clnHistory.FieldByName('RESULT').AsString := 'Failed';
          // Same wording as the export screen; an operator should not have to
          // learn a second vocabulary for the same service.
          if CodeIsNull then
            clnHistory.FieldByName('DETAIL').AsString :=
              Trim(Q.FieldByName('ERROR_RESPONSE').AsString)
          else
            clnHistory.FieldByName('DETAIL').AsString :=
              LeadsOnlineErrorText(Code, Trim(Q.FieldByName('ERROR_RESPONSE').AsString));
        end;
        clnHistory.Post;
        Q.Next;
      end;
      clnHistory.First;
    finally
      clnHistory.EnableControls;
    end;
  finally
    Q.Free;
  end;
end;

procedure TfrmNotifyNoTransactions.btnNotifyClick(Sender: TObject);
var
  StoreId: Integer;
  Client: TLeadsOnlineClient;
  Res: TLeadsOnlineResult;
  Err: string;
  Reached: Boolean;
  ADate: TDate;
begin
  ADate := edDate.Date;

  if not DateIsAcceptable(ADate) then
    Exit;

  if not TryStrToInt(Trim(DM.qryStoreLEADS_STORE_ID.AsString), StoreId) then
  begin
    PawnError('The LeadsOnline Store ID must be numeric. It is currently ' +
              AnsiQuotedStr(Trim(DM.qryStoreLEADS_STORE_ID.AsString), '"') + '.',
              'No activity', Self);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    Client := TLeadsOnlineClient.Create(StoreId,
                Trim(DM.qryStoreLEADS_ONLINE_API_USER.AsString),
                DM.qryStoreLEADS_ONLINE_API_PASSWORD.AsString,
                DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean);
    try
      Reached := Client.TrySetNoTransactionDay(ADate, Res, Err);
    finally
      Client.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  { Two outcomes, handled differently on purpose.

    NOT REACHED is a connection problem and is worth trying again.

    REACHED AND REFUSED is LeadsOnline's own business logic talking. We do not
    reproduce their rules here -- duplicate day, date out of range, store not
    configured -- because that means chasing a moving target in someone else's
    system. Their website is authoritative and already handles every case, so
    the operator is sent there. }
  if not Reached then
  begin
    RecordAttempt(ADate, True, 0, Err);
    ShowResult('Could not reach LeadsOnline. Please try again.', clRed);
    PawnWarn('Could not reach LeadsOnline:' + sLineBreak + sLineBreak + Err +
             sLineBreak + sLineBreak +
             'Nothing was sent. This is a connection problem, so it is worth ' +
             'trying again.', 'No activity', Self);
  end
  else if Res.ErrorCode = 0 then
  begin
    RecordAttempt(ADate, False, 0, '');
    ShowResult(Format('Declared: no activity on %s.',
                      [FormatDateTime('mm/dd/yyyy', ADate)]), clGreen);
    PawnInfo(Format('LeadsOnline has been told that %s had no pawn activity.',
                    [FormatDateTime('mm/dd/yyyy', ADate)]), 'No activity', Self);
  end
  else
  begin
    RecordAttempt(ADate, False, Res.ErrorCode, Res.ErrorResponse);
    ShowResult('LeadsOnline refused this date -- see the list.', clRed);
    PawnError('LeadsOnline did not accept this date:' + sLineBreak + sLineBreak +
              LeadsOnlineErrorText(Res.ErrorCode, Res.ErrorResponse) +
              sLineBreak + sLineBreak +
              'This one has to be done on the LeadsOnline website.',
              'No activity', Self);
  end;

  LoadHistory;
end;

procedure TfrmNotifyNoTransactions.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
