unit EnterRcvItem;

{ Item pop-up for Receive Stock: one piece of stock bought from a supplier.

  Smaller than the pawn / purchase item form (TfrmEnterItems): stock from a
  supplier is not reported to the police, so only what the store needs to sell
  it -- category, description, weight and unit, KT, length, cost, price -- and
  its stones.

  Save writes the item and its stones; Cancel undoes the edit (stones kept as
  cached updates until Save). When the piece belongs to a copy group, the
  "apply to the group" checkbox (checked by default) tells the caller to copy
  the change to the group's other unsold pieces -- this form itself only ever
  saves the current item. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, RzButton,
  RzEdit, RzDBEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RzPanel, RzRadGrp,
  RzDBRGrp, RzCmboBx, RzDBCmbo, RzLabel;

type
  TfrmEnterRcvItem = class(TForm)
    gbItem: TGroupBox;
    lblCategory: TLabel;
    lkCategory: TDBLookupComboBox;
    lblDescription: TLabel;
    edDescription: TDBEdit;
    lblWeight: TLabel;
    edWeight: TRzDBNumericEdit;
    lblWeightUnit: TLabel;
    lkWeightUnit: TDBLookupComboBox;
    lblKT: TLabel;
    edKT: TDBEdit;
    lblLength: TLabel;
    edLength: TDBEdit;
    lblCost: TLabel;
    edCost: TRzDBNumericEdit;
    lblPrice: TLabel;
    edPrice: TRzDBNumericEdit;
    gbStones: TGroupBox;
    pnStoneButtons: TPanel;
    btnAddStone: TBitBtn;
    btnEditStone: TBitBtn;
    btnRemoveStone: TRzBitBtn;
    dbgStones: TDBGrid;
    dsItem: TDataSource;
    dsCategories: TDataSource;
    dsWeightUnits: TDataSource;
    dsStones: TDataSource;
    qryStones: TFDQuery;
    qryStonescShape: TWideStringField;
    qryStonescColor: TWideStringField;
    qryStonesSTONE_NO: TIntegerField;
    qryStonesINV_ITEM_NO: TIntegerField;
    qryStonesSTONE_NUMBER: TIntegerField;
    qryStonesSTONE_SHAPE: TWideStringField;
    qryStonesSTONE_COLOR: TWideStringField;
    qryStonesCT: TFloatField;
    qryStonesWT: TFloatField;
    qryStonesSTONE_TYPE: TWideStringField;
    qryStonesSTONE_WEIGHT_UNIT: TWideStringField;
    Label13: TLabel;
    cbBrand: TDBComboBox;
    DBEdit7: TDBEdit;
    Label14: TLabel;
    DBEdit10: TDBEdit;
    Label17: TLabel;
    cbGender: TRzDBComboBox;
    Label1: TLabel;
    chkApplyToGroup: TCheckBox;
    gbButtons: TGroupBox;
    btnCancel: TBitBtn;
    btnSave: TRzBitBtn;
    RzLabel1: TRzLabel;
    edCopies: TRzNumericEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddStoneClick(Sender: TObject);
    procedure btnEditStoneClick(Sender: TObject);
    procedure btnRemoveStoneClick(Sender: TObject);
    procedure qryStonesCalcFields(DataSet: TDataSet);
    procedure qryStonesNewRecord(DataSet: TDataSet);
  private
    function Item: TDataSet;
    procedure EditStone(NewStone: boolean);
  public
    NewRow: boolean;
    // How many pieces the item's copy group has (0/1: not in a group). More
    // than 1 shows chkApplyToGroup, checked; the caller reads it after Save.
    GroupSize: integer;
  end;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, EnterPawnStoneInfo, uPawnDialogs, GLbUtils;

{ The item being entered: the caller's dataset (Receive Stock's qryItem), set
  in dsItem.DataSet before ShowModal. }
function TfrmEnterRcvItem.Item: TDataSet;
begin
  Result := dsItem.DataSet;
end;

procedure TfrmEnterRcvItem.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  dsCategories.DataSet := DM.clnInventoryCategories;
  dsWeightUnits.DataSet := DM.clnWeigthUnits;
  FillCombo(cbBrand, DM.clnInventoryBrands, 'INV_ITEM_BRAND', '', '');   // brands typed before

  if NewRow then
    begin
      Caption := 'New Received Item';
      Item.Append;
      if Item.FieldByName('WEIGHT_UNIT').IsNull and (DefaultWeightMeasureUnit <> '') then
        Item.FieldByName('WEIGHT_UNIT').AsString := DefaultWeightMeasureUnit;   // Store Settings
    end
  else
    begin
      Caption := 'Edit Received Item - ' + Item.FieldByName('INV_ITEM_BARCODE').AsString;
      Item.Edit;
    end;

  // Quantity: only when adding -- that many identical pieces, each with its
  // own barcode (Receive Stock makes the copies after Save).
  RzLabel1.Visible := NewRow;
  edCopies.Visible := NewRow;
  edCopies.Value := 1;

  chkApplyToGroup.Visible := not NewRow and (GroupSize > 1);
  if chkApplyToGroup.Visible then
    begin
      chkApplyToGroup.Caption := Format('Apply these changes to all %d pieces of this group', [GroupSize]);
      chkApplyToGroup.Checked := True;
    end;

  qryStones.Close;
  qryStones.ParamByName('INV_ITEM_NO').AsInteger := Item.FieldByName('INV_ITEM_NO').AsInteger;
  qryStones.Open;

  if NewRow then
    edCopies.SetFocus      // Quantity first when adding
  else
    edDescription.SetFocus;
end;

{ ---- stones (cached until Save) ------------------------------------------- }

procedure TfrmEnterRcvItem.qryStonesCalcFields(DataSet: TDataSet);
begin
  if DM.clnJStoneShapes.Locate('J_SHAPE', qryStonesSTONE_SHAPE.AsString, []) then
    qryStonescShape.AsString := DM.clnJStoneShapesJ_SHAPE_DESC.AsString;
  if DM.clnJStoneColors.Locate('J_STONE_COLOR', qryStonesSTONE_COLOR.AsString, []) then
    qryStonescColor.AsString := DM.clnJStoneColorsJ_STONE_DESC.AsString;
end;

procedure TfrmEnterRcvItem.qryStonesNewRecord(DataSet: TDataSet);
begin
  // A new item has no number until it is saved: set on Save.
  if not Item.FieldByName('INV_ITEM_NO').IsNull then
    qryStonesINV_ITEM_NO.AsInteger := Item.FieldByName('INV_ITEM_NO').AsInteger;
  qryStonesSTONE_WEIGHT_UNIT.AsString := DefaultWeightMeasureUnit;
end;

// The same stone pop-up as the pawn / purchase item form, on this form's stones.
procedure TfrmEnterRcvItem.EditStone(NewStone: boolean);
begin
  if not NewStone and qryStones.IsEmpty then
    exit;
  frmEnterPawnStoneInfo := TfrmEnterPawnStoneInfo.Create(Self);
  try
    frmEnterPawnStoneInfo.NewRow := NewStone;
    frmEnterPawnStoneInfo.StonesSource := dsStones;
    frmEnterPawnStoneInfo.PlainLabels := True;
    frmEnterPawnStoneInfo.ShowModal;
  finally
    frmEnterPawnStoneInfo.Free;
    frmEnterPawnStoneInfo := nil;
  end;
end;

procedure TfrmEnterRcvItem.btnAddStoneClick(Sender: TObject);
begin
  EditStone(True);
end;

procedure TfrmEnterRcvItem.btnEditStoneClick(Sender: TObject);
begin
  EditStone(False);
end;

procedure TfrmEnterRcvItem.btnRemoveStoneClick(Sender: TObject);
begin
  if not qryStones.IsEmpty then
    qryStones.Delete;
end;

{ ---- save / cancel ---------------------------------------------------------- }

procedure TfrmEnterRcvItem.btnSaveClick(Sender: TObject);
var
  ItemNo: integer;
begin
  if Item.FieldByName('INV_CAT_NO').IsNull then
    begin
      PawnInfo('Please select the item category.', Caption, Self);
      lkCategory.SetFocus;
      exit;
    end;
  if Trim(Item.FieldByName('DESCRIPTION').AsString) = '' then
    begin
      PawnInfo('Please enter the item description.', Caption, Self);
      edDescription.SetFocus;
      exit;
    end;

  try
    Item.Post;   // a new item gets its number (and barcode) here
    ItemNo := Item.FieldByName('INV_ITEM_NO').AsInteger;

    if qryStones.UpdatesPending then
      begin
        qryStones.DisableControls;
        try
          qryStones.First;
          while not qryStones.Eof do
            begin
              if qryStonesINV_ITEM_NO.IsNull or (qryStonesINV_ITEM_NO.AsInteger <= 0) then
                begin
                  qryStones.Edit;
                  qryStonesINV_ITEM_NO.AsInteger := ItemNo;
                  qryStones.Post;
                end;
              qryStones.Next;
            end;
        finally
          qryStones.EnableControls;
        end;
        if qryStones.ApplyUpdates(0) > 0 then
          raise Exception.Create('The stones could not be saved.');
        qryStones.CommitUpdates;
      end;
  except
    on E: Exception do
      begin
        PawnWarn(E.Message, Caption, Self);
        exit;
      end;
  end;

  DM.AddInventoryBrand(Item.FieldByName('INV_ITEM_BRAND').AsString);   // next time it is in the list
  ModalResult := mrOk;
end;

procedure TfrmEnterRcvItem.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

// Cancel, Esc or the close box: nothing is saved.
procedure TfrmEnterRcvItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
    begin
      if qryStones.Active then
        qryStones.CancelUpdates;
      if Item.State in dsEditModes then
        Item.Cancel;
    end;
end;

end.
