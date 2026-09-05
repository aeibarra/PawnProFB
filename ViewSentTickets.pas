unit ViewSentTickets;

{ A read-only look at what has already gone to LeadsOnline.

  It answers one question the send screen deliberately cannot: "did last week
  actually go out?" The send screen lists what is still OUTSTANDING -- a settled
  ticket leaves it and never comes back -- so once everything has gone it is
  empty. That is the correct answer to a different question, and no comfort at
  all to an operator who wants to see the work.

  Nothing here writes.

  The date range is on SUBMITTED_AT, when we sent it, not on the transaction
  date: the question this screen answers is about our sending, not about when
  the pawn was written.

  Result wording deliberately matches the send screen's, so the two never
  describe one outcome with two different words. What each code means is
  LeadsOnlineErrorText in uLeadsOnlineClient. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, RzEdit, RzButton,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmViewSentTickets = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnExit: TBitBtn;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    lblSentFrom: TLabel;
    lblSentTo: TLabel;
    edSentTo: TRzDateTimeEdit;
    edSentFrom: TRzDateTimeEdit;
    btnRefresh: TRzBitBtn;
    clnSent: TFDMemTable;
    dsSent: TDataSource;
    lblCount: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure BuildGridStructure;
    procedure LoadSent;
  public
    { Public declarations }
  end;

var
  frmViewSentTickets: TfrmViewSentTickets;

implementation

uses
  PawnDM, uPawnDialogs, uLeadsOnlineClient;

{$R *.dfm}

const
  { The send screen's words, on purpose. }
  OutcomeSent    = 'Sent';
  OutcomeAlready = 'Already sent';
  OutcomeTooOld  = 'Too old';
  OutcomeFailed  = 'Failed';

  DefaultDaysBack = 6;  // 6 back plus today = the last seven days

  SQLSent =
    'SELECT S.TRANSACTION_NO, S.SUBMITTED_AT, S.ERROR_CODE, S.ERROR_RESPONSE,' +
    '       T1.TRAN_DATE, T1.TRAN_TYPE, T1.TRAN_TICKET_NO,' +
    '       COALESCE(T2.CUST_LAST, '''') || '', '' || COALESCE(T2.CUST_FIRST, '''') AS CUSTOMER,' +
    '       (SELECT COUNT(*) FROM INVENTORY_ITEMS I' +
    '         WHERE I.TRANSACTION_NO = T1.TRANSACTION_NO) AS ITEM_COUNT,' +
    '       (SELECT COUNT(*) FROM LEADS_SOAP_IMAGE_SENT SI' +
    '         WHERE SI.TRANSACTION_NO = S.TRANSACTION_NO' +
    '           AND SI.IMAGE_CATEGORY = ''Item'' AND SI.ERROR_CODE = 0) AS PHOTOS_SENT,' +
    '       (SELECT COUNT(*) FROM LEADS_SOAP_IMAGE_SENT SI2' +
    '         WHERE SI2.TRANSACTION_NO = S.TRANSACTION_NO' +
    '           AND SI2.IMAGE_CATEGORY = ''CustomerID'' AND SI2.ERROR_CODE = 0) AS IDS_SENT,' +
    '       (SELECT COUNT(*) FROM LEADS_SOAP_IMAGE_SENT SI3' +
    '         WHERE SI3.TRANSACTION_NO = S.TRANSACTION_NO' +
    '           AND SI3.ERROR_CODE <> 0) AS IMAGES_FAILED' +
    '  FROM LEADS_SOAP_SUBMISSION S' +
    '  JOIN TRANSACTIONS T1 ON T1.TRANSACTION_NO = S.TRANSACTION_NO' +
    '  JOIN CUSTOMER T2 ON T2.CUST_NO = T1.CUST_NO' +
    // CAST to DATE so the whole of the "to" day counts. SUBMITTED_AT is a
    // timestamp, and comparing it against a bare date would cut that day off at
    // midnight and hide everything sent today -- the rows most likely to be
    // looked for.
    ' WHERE CAST(S.SUBMITTED_AT AS DATE) BETWEEN :DateFrom AND :DateTo' +
    ' ORDER BY S.SUBMITTED_AT DESC, S.TRANSACTION_NO DESC';

{ How a stored error code reads on screen. Same classification as the send
  screen: 0 accepted; 6 and 13 mean LeadsOnline already hold the ticket; 7 means
  the ticket date is outside the window they keep. }
function OutcomeFor(ACodeIsNull: Boolean; ACode: Integer): string;
begin
  if ACodeIsNull then
    Exit(OutcomeFailed);

  case ACode of
    0:     Result := OutcomeSent;
    6, 13: Result := OutcomeAlready;
    7:     Result := OutcomeTooOld;
  else
    Result := OutcomeFailed;
  end;
end;

procedure TfrmViewSentTickets.FormCreate(Sender: TObject);
begin
  BuildGridStructure;
end;

procedure TfrmViewSentTickets.BuildGridStructure;
begin
  clnSent.Close;
  clnSent.FieldDefs.Clear;
  clnSent.FieldDefs.Add('SUBMITTED_AT', ftDateTime);
  clnSent.FieldDefs.Add('TRAN_DATE', ftDate);
  clnSent.FieldDefs.Add('TRAN_TYPE', ftString, 1);
  clnSent.FieldDefs.Add('TRAN_TICKET_NO', ftString, 30);
  clnSent.FieldDefs.Add('CUSTOMER', ftString, 80);
  clnSent.FieldDefs.Add('ITEM_COUNT', ftInteger);
  clnSent.FieldDefs.Add('PHOTOS_SENT', ftInteger);
  clnSent.FieldDefs.Add('IDS_SENT', ftInteger);
  clnSent.FieldDefs.Add('OUTCOME', ftString, 20);
  clnSent.FieldDefs.Add('DETAIL', ftString, 250);
  clnSent.FieldDefs.Add('TRANSACTION_NO', ftInteger);
  clnSent.CreateDataSet;
end;

procedure TfrmViewSentTickets.FormShow(Sender: TObject);
begin
  edSentFrom.Date := Date - DefaultDaysBack;
  edSentTo.Date := Date;
  LoadSent;
end;

procedure TfrmViewSentTickets.btnRefreshClick(Sender: TObject);
begin
  LoadSent;
end;

procedure TfrmViewSentTickets.LoadSent;
var
  Q: TFDQuery;
  Code, Failed, Photos, Ids, Rows: Integer;
  CodeIsNull: Boolean;
  Outcome, Detail: string;
begin
  // A backwards range finds nothing, which on this screen reads as "we sent
  // nothing" -- the one wrong answer it must never give.
  if edSentFrom.Date > edSentTo.Date then
  begin
    PawnWarn('The "Sent From" date is after the "Sent To" date, so nothing can ' +
             'be found. Swap them and try again.');
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    Rows := 0;
    Q := TFDQuery.Create(nil);
    try
      Q.Connection := DM.ConnFB;
      Q.SQL.Text := SQLSent;
      Q.ParamByName('DateFrom').AsDate := edSentFrom.Date;
      Q.ParamByName('DateTo').AsDate := edSentTo.Date;
      Q.Open;

      clnSent.DisableControls;
      try
        clnSent.EmptyDataSet;
        while not Q.Eof do
        begin
          CodeIsNull := Q.FieldByName('ERROR_CODE').IsNull;
          Code   := Q.FieldByName('ERROR_CODE').AsInteger;
          Photos := Q.FieldByName('PHOTOS_SENT').AsInteger;
          Ids    := Q.FieldByName('IDS_SENT').AsInteger;
          Failed := Q.FieldByName('IMAGES_FAILED').AsInteger;

          Outcome := OutcomeFor(CodeIsNull, Code);
          if Outcome = OutcomeSent then
          begin
            // "Sent" alone cannot separate a ticket that had no photos from one
            // whose photos failed after the ticket itself was accepted.
            if Failed > 0 then
              Detail := Format('%d image(s) sent, %d failed', [Photos + Ids, Failed])
            else if (Photos + Ids) > 0 then
              Detail := Format('%d image(s) sent', [Photos + Ids])
            else
              Detail := 'No images';
          end
          else
            Detail := LeadsOnlineErrorText(Code,
                        Trim(Q.FieldByName('ERROR_RESPONSE').AsString));

          clnSent.Append;
          clnSent.FieldByName('SUBMITTED_AT').AsDateTime := Q.FieldByName('SUBMITTED_AT').AsDateTime;
          clnSent.FieldByName('TRAN_DATE').AsDateTime := Q.FieldByName('TRAN_DATE').AsDateTime;
          clnSent.FieldByName('TRAN_TYPE').AsString := Q.FieldByName('TRAN_TYPE').AsString;
          clnSent.FieldByName('TRAN_TICKET_NO').AsString := Q.FieldByName('TRAN_TICKET_NO').AsString;
          clnSent.FieldByName('CUSTOMER').AsString := Q.FieldByName('CUSTOMER').AsString;
          clnSent.FieldByName('ITEM_COUNT').AsInteger := Q.FieldByName('ITEM_COUNT').AsInteger;
          clnSent.FieldByName('PHOTOS_SENT').AsInteger := Photos;
          clnSent.FieldByName('IDS_SENT').AsInteger := Ids;
          clnSent.FieldByName('OUTCOME').AsString := Outcome;
          clnSent.FieldByName('DETAIL').AsString := Detail;
          clnSent.FieldByName('TRANSACTION_NO').AsInteger := Q.FieldByName('TRANSACTION_NO').AsInteger;
          clnSent.Post;
          Inc(Rows);
          Q.Next;
        end;
        clnSent.First;
      finally
        clnSent.EnableControls;
      end;
    finally
      Q.Free;
    end;

    // Say "none" in words. An empty grid on its own reads as "it is broken".
    if Rows = 0 then
      lblCount.Caption := 'Nothing was sent to LeadsOnline in this date range.'
    else
      lblCount.Caption :=
        Format('%d ticket(s) sent to LeadsOnline in this date range.', [Rows]);
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ Colour the row the way the send screen does, so a failure is visible without
  reading every line. }
procedure TfrmViewSentTickets.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Outcome: string;
begin
  if not (gdSelected in State) then
  begin
    Outcome := clnSent.FieldByName('OUTCOME').AsString;
    if Outcome = OutcomeFailed then
      DBGrid1.Canvas.Font.Color := clRed
    else if (Outcome = OutcomeSent) or (Outcome = OutcomeAlready) then
      DBGrid1.Canvas.Font.Color := clGreen
    else if Outcome = OutcomeTooOld then
      DBGrid1.Canvas.Font.Color := clGray;
  end;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmViewSentTickets.btnExitClick(Sender: TObject);
begin
  Close;
end;

end.
