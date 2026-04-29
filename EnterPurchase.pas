unit EnterPurchase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, System.UITypes,
  DBCtrls, Mask, RzEdit, RzDBEdit, RzButton, Data.Win.ADODB, RzForms,
  Vcl.ExtCtrls;

type
  TfrmEnterPurchase = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBMemo1: TDBMemo;
    Label3: TLabel;
    edAmount: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edTicketNo: TDBEdit;
    qryNextTicket: TADODataSet;
    qryNextTicketTableName: TStringField;
    qryNextTicketLastKey: TIntegerField;
    RzDBDateTimeEdit1: TRzDBDateTimeEdit;
    RzDBDateTimeEdit2: TRzDBDateTimeEdit;
    btnSave: TRzBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEnterPurchase: TfrmEnterPurchase;

implementation

uses PawnDM, PawnGlobal;

{$R *.dfm}

procedure TfrmEnterPurchase.FormShow(Sender: TObject);
begin
  if NewRow then
    begin
      qryNextTicket.Open;
      DM.qryTransactions.Append;
      DM.qryTransactionsTRAN_TYPE.AsString := 'U';
      DM.qryTransactionsTRAN_TICKET_NO.AsInteger := qryNextTicketLastKey.AsInteger + 1;
      DM.qryTransactionsTRAN_MATURITY.AsDateTime := IncMonth(Date, 1);
      DM.qryTransactionsTRAN_INTEREST.AsFloat := 0.0;
    end
  else
    begin
      DM.qryTransactions.Edit;
    end;

  edAmount.SetFocus;  
end;

procedure TfrmEnterPurchase.btnSaveClick(Sender: TObject);
begin
  if DM.qryTransactionsTRAN_PAWN_AMOUNT.AsFloat <= 0 then
    begin
      MessageDlg('Please enter purchase amount.', mtInformation, [mbOk], 0);
      edAmount.SetFocus;
      exit;
    end;

  if NewRow then
    begin
      qryNextTicket.Edit;
      qryNextTicketLastKey.AsInteger := DM.qryTransactionsTRAN_TICKET_NO.AsInteger;
      qryNextTicket.Post;
    end;

  DM.qryTransactionsTRAN_TIME.AsDateTime := Time;

  DM.qryTransactions.Post;
  ModalResult := mrOk;
end;

procedure TfrmEnterPurchase.btnCancelClick(Sender: TObject);
begin
  DM.qryTransactions.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmEnterPurchase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DM.qryTransactions.State in [dsEdit, dsInsert] then
    DM.qryTransactions.Cancel;
end;

end.
