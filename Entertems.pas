unit Entertems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Mask, DB, Grids,
  DBGrids, RzButton, System.UITypes, RzCmboBx, RzDBCmbo,
  RzPanel, RzRadGrp, RzDBRGrp, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEnterItems = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    dsTypes: TDataSource;
    dsStyles: TDataSource;
    dsMetal: TDataSource;
    dsInvItems: TDataSource;
    dsCategories: TDataSource;
    dsStones: TDataSource;
    btnSave: TRzBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    edItemCount: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBLookupComboBox4: TDBLookupComboBox;
    cbBrand: TDBComboBox;
    DBEdit7: TDBEdit;
    edItemDesc: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    GroupBox3: TGroupBox;
    Panel9: TPanel;
    btnAddStone: TBitBtn;
    btnEditStone: TBitBtn;
    DBGrid2: TDBGrid;
    btnRemoveStone: TRzBitBtn;
    Label18: TLabel;
    RzDBRadioGroup1: TRzDBRadioGroup;
    dsWeigthUnits: TDataSource;
    cbWeightUnit: TDBLookupComboBox;
    updStones: TFDUpdateSQL;
    qryStones: TFDQuery;
    qryStonesSTONE_NO: TIntegerField;
    qryStonesINV_ITEM_NO: TIntegerField;
    qryStonesSTONE_NUMBER: TIntegerField;
    qryStonesSTONE_SHAPE: TWideStringField;
    qryStonesSTONE_COLOR: TWideStringField;
    qryStonesCT: TFloatField;
    qryStonesWT: TFloatField;
    qryStonesSTONE_TYPE: TWideStringField;
    qryStonesSTONE_WEIGHT_UNIT: TWideStringField;
    qryStonescShape: TWideStringField;
    qryStonescColor: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure clnStonesCalcFields(DataSet: TDataSet);
    procedure clnStonesNewRecord(DataSet: TDataSet);
    procedure btnAddStoneClick(Sender: TObject);
    procedure btnEditStoneClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRemoveStoneClick(Sender: TObject);
  private
    { Private declarations }
    function SumUnitPriceForCurrentLayawayItemsExcludingCurrentItem: Currency;
    function ValidateLayawayItemsTotal: Boolean;
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEnterItems: TfrmEnterItems;

implementation

Uses SearchClient, PawnDM, EnterPawnStoneInfo, PawnGlobal, GLbUtils, uPawnDialogs;

{$R *.dfm}

procedure TfrmEnterItems.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  edItemDesc.SetFocus;

  FillCombo(cbBrand, DM.clnInventoryBrands, 'INV_ITEM_BRAND', '', '');

  if NewRow then
    begin
      frmClients.qryInvItems.Append;
    end
  else
    begin
      frmClients.qryInvItems.Edit;
    end;

  qryStones.Params.ParamByName('INV_ITEM_NO').AsInteger := dsInvItems.DataSet.FieldByName('INV_ITEM_NO').AsInteger;
  qryStones.Open;
end;

procedure TfrmEnterItems.clnStonesCalcFields(DataSet: TDataSet);
begin
  if DM.clnJStoneShapes.Locate('J_SHAPE', qryStonesSTONE_SHAPE.AsString, []) then
    qryStonescShape.AsString := DM.clnJStoneShapesJ_SHAPE_DESC.AsString;
  if DM.clnJStoneColors.Locate('J_STONE_COLOR', qryStonesSTONE_COLOR.AsString, []) then
    qryStonescColor.AsString := DM.clnJStoneColorsJ_STONE_DESC.AsString;
end;

procedure TfrmEnterItems.clnStonesNewRecord(DataSet: TDataSet);
begin
  qryStonesINV_ITEM_NO.AsInteger := dsInvItems.DataSet.FieldByName('INV_ITEM_NO').AsInteger;
  qryStonesSTONE_WEIGHT_UNIT.AsString := DefaultWeightMeasureUnit;
end;

procedure TfrmEnterItems.btnRemoveStoneClick(Sender: TObject);
begin
  qryStones.Delete;
end;

procedure TfrmEnterItems.btnAddStoneClick(Sender: TObject);
begin
  frmEnterPawnStoneInfo := TfrmEnterPawnStoneInfo.Create(Self);
  try
    frmEnterPawnStoneInfo.NewRow := true;
    frmEnterPawnStoneInfo.ShowModal;
  finally
    frmEnterPawnStoneInfo.Free;
  end;
end;

procedure TfrmEnterItems.btnEditStoneClick(Sender: TObject);
begin
  frmEnterPawnStoneInfo := TfrmEnterPawnStoneInfo.Create(Self);
  try
    frmEnterPawnStoneInfo.NewRow := false;
    frmEnterPawnStoneInfo.ShowModal;
  finally
    frmEnterPawnStoneInfo.Free;
  end;
end;

procedure TfrmEnterItems.btnSaveClick(Sender: TObject);
var
  StoneNeedPosting: boolean;
begin
  if frmClients.qryInvItemsINV_CAT_NO.IsNull then
    begin
      MessageDlg('Please select Item Category.', mtInformation, [mbOk], 0);
      exit;
    end;

  if not ValidateLayawayItemsTotal then
    exit;

  frmClients.qryInvItems.Post;
  DM.AddInventoryBrand(frmClients.qryInvItemsINV_ITEM_BRAND.AsString);

  StoneNeedPosting := (NewRow and (qryStones.RecordCount > 0)) or (not NewRow and qryStones.UpdatesPending);

  if StoneNeedPosting then
    begin
      qryStones.DisableControls;
      try
        qryStones.First;
        while not qryStones.Eof do
        begin
          if (qryStonesINV_ITEM_NO.AsInteger <= 0) or qryStonesINV_ITEM_NO.IsNull then
            begin
              qryStones.Edit;
              qryStonesINV_ITEM_NO.AsInteger := frmClients.qryInvItems.FieldByName('INV_ITEM_NO').AsInteger;
              qryStones.Post;
            end;

          qryStones.Next;
        end;

      finally
        qryStones.EnableControls;
      end;

      qryStones.ApplyUpdates(0);
      qryStones.CommitUpdates;
    end;



//  if trim(frmClients.qryInvItems.FieldByName('INV_ITEM_BARCODE').AsString) = '' then
//    begin
//      frmClients.qryInvItems.Edit;
//      frmClients.qryInvItems.FieldByName('INV_ITEM_BARCODE').AsString := DM.GetBarcode(dsInvItems.DataSet.FieldByName('INV_ITEM_NO').AsInteger); //Format('%.6d', [dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger]);
//      frmClients.qryInvItems.Post;
//    end;

  ModalResult := mrOk;

end;

function TfrmEnterItems.SumUnitPriceForCurrentLayawayItemsExcludingCurrentItem: Currency;
var
  Query: TFDQuery;
  CurrentInvItemNo: Integer;
begin
  Result := 0;

  if DM.qryTransactionsTRANSACTION_NO.IsNull then
    Exit;

  if frmClients.qryInvItemsINV_ITEM_NO.IsNull then
    CurrentInvItemNo := 0
  else
    CurrentInvItemNo := frmClients.qryInvItemsINV_ITEM_NO.AsInteger;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DM.ConnFB;
    Query.SQL.Text :=
      'select coalesce(sum(UNIT_PRICE), 0) as TOTAL_UNIT_PRICE ' +
      'from INVENTORY_ITEMS ' +
      'where TRANSACTION_NO = :TRANSACTION_NO';
    if CurrentInvItemNo > 0 then
      Query.SQL.Add('  and INV_ITEM_NO <> :INV_ITEM_NO');

    Query.Params.ParamByName('TRANSACTION_NO').AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;
    if CurrentInvItemNo > 0 then
      Query.Params.ParamByName('INV_ITEM_NO').AsInteger := CurrentInvItemNo;
    Query.Open;

    Result := Query.FieldByName('TOTAL_UNIT_PRICE').AsCurrency;
  finally
    Query.Free;
  end;
end;

function TfrmEnterItems.ValidateLayawayItemsTotal: Boolean;
var
  ExistingItemsTotal: Currency;
  NewItemsTotal: Currency;
  LayawayAmount: Currency;
begin
  Result := True;

  if DM.qryTransactionsTRAN_TYPE.AsString <> TranLayaway then
    Exit;

  ExistingItemsTotal := SumUnitPriceForCurrentLayawayItemsExcludingCurrentItem;
  NewItemsTotal := ExistingItemsTotal + frmClients.qryInvItemsUNIT_PRICE.AsCurrency;
  LayawayAmount := DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency;

  if NewItemsTotal > LayawayAmount then
  begin
    Result := PawnConfirm(
      Format('The total item prices (%m) are greater than the layaway amount (%m).' + sLineBreak + sLineBreak +
             'Do you want to proceed with saving this item?',
             [NewItemsTotal, LayawayAmount]),
      'Layaway Item Total',
      Self);
  end;
end;

procedure TfrmEnterItems.btnCancelClick(Sender: TObject);
begin
  frmClients.qryInvItems.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmEnterItems.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if frmClients.qryInvItems.State in [dsEdit, dsInsert] then
    begin
      frmClients.qryInvItems.Cancel;
    end;
end;

end.
