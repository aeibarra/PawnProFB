unit Entertems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Mask, DB, Grids,
  DBGrids, DBClient, Provider, RzButton, System.UITypes, RzCmboBx, RzDBCmbo,
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
    qryCategories: TFDQuery;
    qryCategoriesINV_CAT_NO: TIntegerField;
    qryCategoriesINV_CATEGORY: TStringField;
    dsInvItems: TDataSource;
    dsCategories: TDataSource;
    qryBrands: TFDQuery;
    qryBrandsINV_ITEM_BRAND: TStringField;
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
    clnWeigthUnits: TClientDataSet;
    dsWeigthUnits: TDataSource;
    cbWeightUnit: TDBLookupComboBox;
    clnWeigthUnitsWeigthUnitValue: TStringField;
    clnWeigthUnitsWeightUnit: TStringField;
    updStones: TFDUpdateSQL;
    qryStones: TFDQuery;
    qryStonesSTONE_NO: TIntegerField;
    qryStonesINV_ITEM_NO: TIntegerField;
    qryStonesSTONE_NUMBER: TIntegerField;
    qryStonesSTONE_SHAPE: TStringField;
    qryStonesSTONE_COLOR: TStringField;
    qryStonesCT: TFloatField;
    qryStonesWT: TFloatField;
    qryStonesSTONE_TYPE: TStringField;
    qryStonesSTONE_WEIGHT_UNIT: TStringField;
    qryStonescShape: TStringField;
    qryStonescColor: TStringField;
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
  public
    { Public declarations }
    NewRow: boolean;
  end;

var
  frmEnterItems: TfrmEnterItems;

implementation

Uses SearchClient, PawnDM, EnterPawnStoneInfo, PawnGlobal, GLbUtils;

{$R *.dfm}

procedure TfrmEnterItems.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  edItemDesc.SetFocus;

  dsTypes.DataSet := DM.clnJTypes;
  dsStyles.DataSet := DM.clnJStyles;
  dsMetal.DataSet := DM.clnJMetals;

  qryBrands.Close;
  qryBrands.Open;
  cbBrand.Items.Clear;
  while not qryBrands.Eof do
    begin
      if trim(qryBrandsINV_ITEM_BRAND.AsString) <> '' then
        cbBrand.Items.Add(qryBrandsINV_ITEM_BRAND.AsString);
      qryBrands.Next;
    end;
  qryBrands.Close;

  qryCategories.Close;
  qryCategories.Open;

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

  DM.GetWeightUnits(clnWeigthUnits);
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

  frmClients.qryInvItems.Post;

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
