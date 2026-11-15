unit PurchaseChangeStatus;

{ Purchase counterpart of PawnChangeStatus: the store says what a purchase's
  items are for -- For Sale or Scrap / Melted. Applies to every unclassified
  item of the purchase at once (see TDM.SetPurchaseItemsStatus). The purchase
  transaction itself is not closed; "Undo Items For Sale / Scrap" undoes this. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  Vcl.ExtCtrls, RzPanel, RzRadChk;

type
  TfrmPurchaseChangeStatus = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btnSave: TRzBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    pnItemStatus: TRzPanel;
    rbItemScrap: TRzRadioButton;
    rbItemForSale: TRzRadioButton;
    lblItemCount: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    TransactionNo: integer;
  end;

var
  frmPurchaseChangeStatus: TfrmPurchaseChangeStatus;

implementation

uses PawnDM, PawnGlobal, uPawnDialogs;

{$R *.dfm}

procedure TfrmPurchaseChangeStatus.FormShow(Sender: TObject);
var
  Unclassified, Classified, Locked: integer;
begin
  DM.GetPurchaseItemsState(TransactionNo, Unclassified, Classified, Locked);
  if Unclassified = 1 then
    lblItemCount.Caption := '1 item will be updated.'
  else
    lblItemCount.Caption := Format('%d items will be updated.', [Unclassified]);
end;

procedure TfrmPurchaseChangeStatus.btnSaveClick(Sender: TObject);
var
  ItemAction: integer;
begin
  if not rbItemForSale.Checked and not rbItemScrap.Checked then
    begin
      PawnInfo('Please make a selection.', 'PawnPro', Self);
      exit;
    end;

  if rbItemScrap.Checked then
    ItemAction := PawnDefaultedItemMelted
  else
    ItemAction := PawnDefaultedItemForSale;

  Screen.Cursor := crHourGlass;
  try
    DM.SetPurchaseItemsStatus(TransactionNo, ItemAction);
  finally
    Screen.Cursor := crDefault;
  end;

  ModalResult := mrOk;
end;

end.
