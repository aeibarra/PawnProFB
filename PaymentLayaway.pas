unit PaymentLayaway;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons, System.UITypes,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, RzEdit, RzDBEdit, Data.DB;

type
  TfrmPaymentLayaway = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TRzBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    edAmount: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    MemoComment: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    NewRow: boolean;
  end;

var
  frmPaymentLayaway: TfrmPaymentLayaway;

implementation

{$R *.dfm}

uses PawnDM;

procedure TfrmPaymentLayaway.btnCancelClick(Sender: TObject);
begin
  DM.qryPayments.Cancel;
  ModalResult := mrCancel;
end;

function AskCloseLayawayWhenPaid: Boolean;
var
  Dlg: TTaskDialog;
begin
//  Result := False;

  Dlg := TTaskDialog.Create(nil);
  try
    Dlg.Caption := 'Layaway';
    Dlg.Title := 'Layaway Paid in Full';
    Dlg.Text :=
      'The layaway balance is now $0.00.' + sLineBreak +
      'Would you like to close the layaway and release the items to the customer?';

    Dlg.MainIcon := tdiInformation;
    Dlg.CommonButtons := []; // we will define custom buttons

    with Dlg.Buttons.Add do
    begin
      Caption := 'Close Layaway && Release Items';
      ModalResult := mrYes;
      Default := True;
    end;

    with Dlg.Buttons.Add do
    begin
      Caption := 'Leave Layaway Open';
      ModalResult := mrNo;
    end;

    Result := Dlg.Execute and (Dlg.ModalResult = mrYes);
  finally
    Dlg.Free;
  end;
end;

procedure TfrmPaymentLayaway.btnSaveClick(Sender: TObject);
var
  TotalPaid: Currency;
  PricBalance: Currency;
  CloseLayaway: boolean;
  StartedFBTrans: Boolean;
begin
  CloseLayaway := false;
  StartedFBTrans := False;
  if DM.qryPaymentsPAY_AMOUNT.AsCurrency <= 0 then
  begin
    MessageDlg('Please enter amount to pay.', mtInformation, [mbOk], 0);
    edAmount.SetFocus;
    exit;
  end;

  TotalPaid := DM.GetTotalPaid;
  if NewRow then
    TotalPaid := TotalPaid + DM.qryPaymentsPAY_AMOUNT.AsCurrency;
  PricBalance := DM.qryTransactionscTotalSalesAmount.AsCurrency - TotalPaid;

  if PricBalance = 0  then
    CloseLayaway := AskCloseLayawayWhenPaid;

  if PricBalance < 0  then
  begin
    if MessageDlg('You are paying more than the balance. Continue?', mtInformation, [mbYes, mbNo], 0) = mrNo then
      exit;
  end;

  DM.qryPaymentsPAY_PRINCIPAL.AsCurrency := DM.qryPaymentsPAY_AMOUNT.AsCurrency;
  DM.qryPaymentsPRINC_BALANCE.AsCurrency := PricBalance;
  DM.qryPaymentsPAY_INTEREST.AsCurrency := 0;
  DM.qryPaymentsINTEREST_BALANCE.AsCurrency := 0;

  if not DM.ConnFB.InTransaction then
  begin
    DM.ConnFB.StartTransaction;
    StartedFBTrans := True;
  end;

  try
    DM.qryPayments.Post;

    DM.qryTransactions.Edit;
    DM.qryTransactionsPRINC_BALANCE.AsFloat := DM.qryPaymentsPRINC_BALANCE.AsFloat;
    DM.qryTransactionsINTEREST_BALANCE.AsFloat := DM.qryPaymentsINTEREST_BALANCE.AsFloat;
    DM.qryTransactions.Post;

    if CloseLayaway then
      DM.LaywayClosePayoffBalance(DM.qryTransactionsTRANSACTION_NO.AsInteger, false);

    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Commit;
  except
    if StartedFBTrans and DM.ConnFB.InTransaction then
      DM.ConnFB.Rollback;
    raise;
  end;

  ModalResult := mrOk;

end;

procedure TfrmPaymentLayaway.FormShow(Sender: TObject);
begin
  if NewRow then
  begin
    DM.qryPayments.Append;
  end
  else
  begin
    DM.qryPayments.Edit;
  end;

  edAmount.SetFocus;
end;

end.
