unit PawnChangeStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  Vcl.ExtCtrls, RzPanel, RzRadChk;

type
  TfrmPawnChangeStatus = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnSave: TRzBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    rbRedeemed: TRadioButton;
    rbDefaulted: TRadioButton;
    pnItemStatus: TRzPanel;
    Label2: TLabel;
    rbItemScrap: TRzRadioButton;
    rbItemForSame: TRzRadioButton;
    procedure btnSaveClick(Sender: TObject);
    procedure rbRedeemedClick(Sender: TObject);
  private
    CloseReason: smallint;
  public
    TransactionNo: integer;
  end;

var
  frmPawnChangeStatus: TfrmPawnChangeStatus;

implementation

uses PawnDM, PawnGlobal;

{$R *.dfm}

procedure TfrmPawnChangeStatus.btnSaveClick(Sender: TObject);
var
  PawnDefaultedItemAction: integer;
begin
  if not rbRedeemed.Checked and not rbDefaulted.Checked then
    begin
      MessageDlg('Please make a selection.', mtInformation, [mbOk], 0);
      exit;
    end;

  CloseReason := 0;
  PawnDefaultedItemAction := 0;

  if rbRedeemed.Checked then
    begin
      CloseReason := PawnCloseReasonRedeemed;
    end
  else if rbDefaulted.Checked then
    begin
      CloseReason := PawnCloseReasonDefaulted;
      if rbItemScrap.Checked then
        PawnDefaultedItemAction := PawnDefaultedItemMelted;
      if rbItemForSame.Checked then
        PawnDefaultedItemAction := PawnDefaultedItemForSale;
    end;

  Screen.Cursor := crHourGlass;
  try
//    DM.TestDateParameter;
    DM.SetPawnAndItemsStatus(TransactionNo, CloseReason, TranStatusInactive, PawnDefaultedItemAction);
  finally
    Screen.Cursor := crDefault;
  end;

  ModalResult := mrOk;
end;

procedure TfrmPawnChangeStatus.rbRedeemedClick(Sender: TObject);
begin
  pnItemStatus.Enabled := rbDefaulted.Checked;
  if not rbDefaulted.Checked then
    begin
      rbItemScrap.Checked := false;
      rbItemForSame.Checked := false;
    end;
end;


end.
