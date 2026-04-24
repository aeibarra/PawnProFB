unit Entertems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Mask, ADODB, DB, Grids,
  DBGrids, DBClient, Provider, RzButton, System.UITypes, RzCmboBx, RzDBCmbo,
  RzPanel, RzRadGrp, RzDBRGrp;

type
  TfrmEnterItems = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    qryTypes: TADOQuery;
    qryTypesJType: TStringField;
    qryTypesJTypeDesc: TStringField;
    qryStyles: TADOQuery;
    qryStylesJStyle: TStringField;
    qryStylesJStyleDesc: TStringField;
    qryMetal: TADOQuery;
    qryMetalJMetal: TStringField;
    qryMetalJMetalDesc: TStringField;
    dsTypes: TDataSource;
    dsStyles: TDataSource;
    dsMetal: TDataSource;
    qryCategories: TADOQuery;
    qryCategoriesInvCatNo: TAutoIncField;
    qryCategoriesInvCategory: TStringField;
    dsInvItems: TDataSource;
    dsCategories: TDataSource;
    qryBrands: TADODataSet;
    qryBrandsInvItemBrand: TStringField;
    qryStones: TADOQuery;
    qryStonesStoneNo: TAutoIncField;
    qryStonesInvItemNo: TIntegerField;
    qryStonesStoneNumber: TIntegerField;
    qryStonesStoneShape: TStringField;
    qryStonesStoneColor: TStringField;
    qryStonesCT: TFloatField;
    qryStonesWT: TFloatField;
    qryStonesStoneType: TStringField;
    qryStoneShapes: TADOQuery;
    qryStoneShapesJShape: TStringField;
    qryStoneShapesJShapeDesc: TStringField;
    qryStoneColors: TADOQuery;
    qryStoneColorsJStoneColor: TStringField;
    qryStoneColorsJStoneDesc: TStringField;
    dsStones: TDataSource;
    prvStones: TDataSetProvider;
    clnStones: TClientDataSet;
    clnStonescShape: TStringField;
    clnStonescColor: TStringField;
    clnStonesStoneNo: TAutoIncField;
    clnStonesInvItemNo: TIntegerField;
    clnStonesStoneNumber: TIntegerField;
    clnStonesStoneShape: TStringField;
    clnStonesStoneColor: TStringField;
    clnStonesCT: TFloatField;
    clnStonesWT: TFloatField;
    clnStonesStoneType: TStringField;
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
    qryStonesStoneWeightUnit: TStringField;
    clnStonesStoneWeightUnit: TStringField;
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

  qryBrands.Open;
  cbBrand.Items.Clear;
  while not qryBrands.Eof do
    begin
      if trim(qryBrandsInvItemBrand.AsString) <> '' then
        cbBrand.Items.Add(qryBrandsInvItemBrand.AsString);
      qryBrands.Next;
    end;
  qryBrands.Close;

  qryTypes.Open;
  qryStyles.Open;
  qryMetal.Open;
  qryCategories.Open;

  qryStoneShapes.Open;
  qryStoneColors.Open;

  if NewRow then
    begin
      frmClients.qryInvItems.Append;
    end
  else
    begin
      frmClients.qryInvItems.Edit;
    end;

  clnStones.Params.ParamByName('InvItemNo').AsInteger := dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger;
  clnStones.Open;

  DM.GetWeightUnits(clnWeigthUnits);
end;

procedure TfrmEnterItems.clnStonesCalcFields(DataSet: TDataSet);
begin
  if qryStoneShapes.Locate('JShape', clnStonesStoneShape.AsString, []) then
    clnStonescShape.AsString := qryStoneShapesJShapeDesc.AsString;
  if qryStoneColors.Locate('JStoneColor', clnStonesStoneColor.AsString, []) then
    clnStonescColor.AsString := qryStoneColorsJStoneDesc.AsString;
end;

procedure TfrmEnterItems.clnStonesNewRecord(DataSet: TDataSet);
begin
  clnStonesInvItemNo.AsInteger := dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger;
  clnStonesStoneWeightUnit.AsString := DefaultWeightMeasureUnit;
end;

procedure TfrmEnterItems.btnRemoveStoneClick(Sender: TObject);
begin
  clnStones.Delete;
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
begin
  if frmClients.qryInvItemsInvCatNo.IsNull then
    begin
      MessageDlg('Please select Item Category.', mtInformation, [mbOk], 0);
      exit;
    end;

  frmClients.qryInvItems.Post;
  clnStones.ApplyUpdates(0);

  if trim(frmClients.qryInvItems.FieldByName('InvItemBarcode').AsString) = '' then
    begin
      frmClients.qryInvItems.Edit;
      frmClients.qryInvItems.FieldByName('InvItemBarcode').AsString := DM.GetBarcode(dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger); //Format('%.6d', [dsInvItems.DataSet.FieldByName('InvItemNo').AsInteger]);
      frmClients.qryInvItems.Post;
    end;

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
