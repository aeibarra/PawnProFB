unit EnterLayaway;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzEdit, RzDBEdit, Vcl.Mask, System.UITypes,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, RzButton;

type
  TfrmEnterLayaway = class(TForm)
    GroupBox2: TGroupBox;
    btnSave: TRzBitBtn;
    btnCancel: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    DBMemo1: TDBMemo;
    edAmount: TDBEdit;
    edTicketNo: TDBEdit;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    edSalesTax: TDBEdit;
    Label4: TLabel;
    edTotalAmount: TDBEdit;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edAmountKeyPress(Sender: TObject; var Key: Char);
    procedure edAmountExit(Sender: TObject);
  private
    procedure CalculateSalesTaxAndTotalAmount;
    { Private declarations }
  public
    NewRow: boolean;
  end;

var
  frmEnterLayaway: TfrmEnterLayaway;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal;

procedure TfrmEnterLayaway.CalculateSalesTaxAndTotalAmount;
begin
  DM.qryTransactionsTranSalesTax.AsCurrency := DM.qryTransactionsTranPawnAmount.AsCurrency * (DM.qryStoreSalesTaxPerc.AsCurrency / 100);
end;

procedure TfrmEnterLayaway.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmEnterLayaway.btnSaveClick(Sender: TObject);
begin
  if DM.qryTransactionsTranPawnAmount.AsFloat <= 0 then
    begin
      MessageDlg('Please enter purchase amount.', mtInformation, [mbOk], 0);
      edAmount.SetFocus;
      exit;
    end;

  CalculateSalesTaxAndTotalAmount;

  if NewRow then
  begin
    DM.qryTransactionsPrincBalance.AsCurrency := DM.qryTransactionscTotalSalesAmount.AsCurrency;
  end;

  DM.GetNextKey(LayawayTicketNo);

  DM.qryTransactions.Post;

  ModalResult := mrOk;

end;

procedure TfrmEnterLayaway.edAmountExit(Sender: TObject);
begin
  CalculateSalesTaxAndTotalAmount;
end;

procedure TfrmEnterLayaway.edAmountKeyPress(Sender: TObject; var Key: Char);
var
  TranAmount: Currency;
begin
  if Key = #13 then
  begin
    TranAmount := edAmount.EditText.ToExtended;
    if TranAmount <> DM.qryTransactionsTranPawnAmount.AsCurrency then
      DM.qryTransactionsTranPawnAmount.AsCurrency := TranAmount;

    CalculateSalesTaxAndTotalAmount;
    Key := #0;
  end;

end;

procedure TfrmEnterLayaway.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.qryTransactions.Cancel;
end;

procedure TfrmEnterLayaway.FormShow(Sender: TObject);
begin
  if NewRow then
    begin
      DM.qryTransactions.Append;
      DM.qryTransactionsTranType.AsString := TranLayaway; //Lawaway
      DM.qryTransactionsTranTicketNo.AsInteger := DM.GetNextTicketNo(LayawayTicketNo);
      DM.qryTransactionsTranMaturity.AsDateTime := IncMonth(Date, 1);
      DM.qryTransactionsTranInterest.AsFloat := 0.0;
    end
  else
    begin
      DM.qryTransactions.Edit;
    end;

  edAmount.SetFocus;

end;

end.
