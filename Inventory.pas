unit Inventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, IniFiles,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Printers, System.UITypes,
  Buttons, DB, Mask, ComCtrls,
  FireDAC.Comp.Client, Data.SqlTimSt,
  RzForms, RzButton, RzTreeVw, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmInventory = class(TForm)
    gbBottom: TGroupBox;
    Panel1: TPanel;
    Splitter1: TSplitter;
    pnTop: TPanel;
    pnCategories: TPanel;
    Panel4: TPanel;
    btnAddCat: TBitBtn;
    btnEditCat: TBitBtn;
    dsCategories: TDataSource;
    dsInvItems: TDataSource;
    dsStones: TDataSource;
    Panel6: TPanel;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    Panel7: TPanel;
    btnAddItem: TBitBtn;
    btnEditItem: TBitBtn;
    GroupBox1: TGroupBox;
    Panel9: TPanel;
    dbGridStones: TDBGrid;
    btnAddStone: TBitBtn;
    btnEditStone: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    chkSale: TCheckBox;
    chkPawn: TCheckBox;
    qryCategories: TFDQuery;
    qryInvItems: TFDQuery;
    qryInvItemsInvItemNo: TIntegerField;
    qryInvItemsInvItemBarcode: TWideStringField;
    qryInvItemsInvCatNo: TIntegerField;
    qryInvItemsJType: TWideStringField;
    qryInvItemsJStyle: TWideStringField;
    qryInvItemsJMetal: TWideStringField;
    qryInvItemsInvItemCount: TIntegerField;
    qryInvItemsNote: TWideStringField;
    qryInvItemsSizeLength: TFloatField;
    qryInvItemsWeight: TFloatField;
    qryInvItemsWeightUnit: TWideStringField;
    qryInvItemsKT: TFloatField;
    qryInvItemsCreated: TSQLTimeStampField;
    qryInvItemsUnitCost: TFMTBCDField;
    qryInvItemsUnitPrice: TFMTBCDField;
    qryInvItemsInvItemStatus: TWideStringField;
    qryInvItemsTransactionNo: TIntegerField;
    qryInvItemsInvOriginalItemNo: TIntegerField;
    qryInvItemsInvItemBrand: TWideStringField;
    qryCategoriesInvCatNo: TIntegerField;
    qryCategoriesInvCategory: TWideStringField;
    FormState: TRzFormState;
    btnPrintLabel: TRzBitBtn;
    btnPrintOneLabel: TRzBitBtn;
    btnClose: TBitBtn;
    chkTree: TRzCheckTree;
    SpeedButton1: TSpeedButton;
    btnSearch: TRzBitBtn;
    lblTotals: TLabel;
    qryInvItemsOwnerAppNumber: TWideStringField;
    qryInvItemsModelNumber: TWideStringField;
    qryInvItemsSerialNumber: TWideStringField;
    qryInvItemsGender: TWideStringField;
    qryInvItemsDescription: TWideStringField;
    qryInvItemsJTypeDesc: TWideStringField;
    qryInvItemsJStyleDesc: TWideStringField;
    qryInvItemsJMetalDesc: TWideStringField;
    qryInvItemsStatusDesc: TWideStringField;
    qryInvItemsTotalWeight: TFloatField;
    CheckBox1: TCheckBox;
    qryStones: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnAddCatClick(Sender: TObject);
    procedure btnEditCatClick(Sender: TObject);
    procedure TreeClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnEditItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddStoneClick(Sender: TObject);
    procedure chkSaleClick(Sender: TObject);
    procedure qryInvItemsCalcFields(DataSet: TDataSet);
    procedure qryInvItemsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure qryInvItemsNewRecord(DataSet: TDataSet);
    procedure qryStonesCalcFields(DataSet: TDataSet);
    procedure qryStonesNewRecord(DataSet: TDataSet);
    procedure btnPrintLabelClick(Sender: TObject);
    procedure btnPrintOneLabelClick(Sender: TObject);
    procedure btnEditStoneClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    Param_LineNo_qryInvItems: integer;
    function GetSelectedTreeCategories: string;
  public
    { Public declarations }
//    CategorySelected: integer;
    ShowFilter: string;
    procedure LoadCategoryTree;
  end;

var
  frmInventory: TfrmInventory;

implementation

uses PawnMain, PawnDM, EditInvCategory, EditInvItem, PawnGlobal,
  EnterStoneInfo;

{$R *.dfm}

procedure TfrmInventory.LoadCategoryTree;
var
  Iidx: integer;
  TreeNode: TTreeNode;
begin
  // Synthesize the "Categories" root node. Used to come from a UNION-SELECT
  // sentinel row (InvCatNo = 0) on qryCategories; that prevented FireDAC
  // from inserting/editing the table, so the root is now app-side.
  TreeNode := chkTree.Items.Add(nil, 'Categories');
  TreeNode.ImageIndex := 0;
  TreeNode.SelectedIndex := 0;
  TreeNode.StateIndex := STATE_CHECKED;
  TreeNode.Data := Pointer(0);

  qryCategories.First;
  Iidx := 0;
  while not qryCategories.Eof do
  begin
    chkTree.Items.AddChild(TreeNode, qryCategoriesInvCategory.AsString);
    TreeNode.Item[Iidx].ImageIndex := 1;
    TreeNode.Item[Iidx].SelectedIndex := 1;
    TreeNode.Item[Iidx].Data := Pointer(qryCategoriesInvCatNo.AsInteger);
    TreeNode.Item[Iidx].StateIndex := STATE_CHECKED;
    inc(Iidx);

    qryCategories.Next;
  end;
  TreeNode.Expand(true);
end;

function TfrmInventory.GetSelectedTreeCategories: string;
var
  List: TStringList;
  TotalNodes: integer;
  
  procedure CollectCheckedNodes(Node: TTreeNode);
  var
    i: integer;
    InvCatNoStr: string;
  begin
    if Node = nil then
      exit;

    // Add current node if checked
    if (Node.StateIndex = STATE_CHECKED) and (Integer(Node.Data) <> 0) then
    begin
      InvCatNoStr := IntToStr(Integer(Node.Data));
      if List.IndexOf(InvCatNoStr) < 0 then
        List.Add(InvCatNoStr);
    end;
    
    // Recursively process children
    for i := 0 to Node.Count - 1 do
      CollectCheckedNodes(Node.Item[i]);
  end;

var
  i: integer;
begin
  Result := '';
  List := TStringList.Create;
  try
    // Collect all checked nodes starting from root items
    for i := 0 to chkTree.Items.Count - 1 do
      CollectCheckedNodes(chkTree.Items[i]);
    
    // Return blank if none selected or all selected
    TotalNodes := chkTree.Items.Count;
    if (List.Count = 0) or (List.Count = (TotalNodes-1)) then
      Result := ''
    else
      Result := List.CommaText;
  finally
    List.Free;
  end;
end;

procedure TfrmInventory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmInventory := nil;

//  PostMessage(frmPawnMain.Handle, sx_CloseInventory, 0, 0);
end;

procedure TfrmInventory.FormShow(Sender: TObject);
begin
  qryCategories.Open;

  LoadCategoryTree;

  pnTop.Focused;
end;

procedure TfrmInventory.btnAddCatClick(Sender: TObject);
begin
  frmEditInvCat := TfrmEditInvCat.Create(Application);
  try
    frmEditInvCat.NewRow := true;
    if frmEditInvCat.ShowModal = mrOK then;
//      LoadCategoryTree;
  finally
    frmEditInvCat.Free;
  end;
end;

procedure TfrmInventory.btnEditCatClick(Sender: TObject);
//var
//  S: string;
//  i: integer;
begin
  if qryCategoriesInvCatNo.AsInteger <> 0 then
    begin
      frmEditInvCat := TfrmEditInvCat.Create(Application);
      try
        frmEditInvCat.NewRow := false;
        if frmEditInvCat.ShowModal = mrOK then;
{          begin
            S := qryCategoriesInvCategory.AsString;
            LoadCategoryTree;
            for i := 0 to Tree.Node[0].Count do
            begin
              if Tree.Node[i].Text = S then
                begin
                  Tree.ActiveNode := Tree.Node[i];
                  break;
                end;
            end;
          end;  }
      finally
        frmEditInvCat.Free;
      end;
    end;
end;

procedure TfrmInventory.TreeClick(Sender: TObject);
begin
{  CategorySelected := -1;
  if (Tree.ActiveNode <> nil) and (Tree.ActiveNode <> Tree.Node[0]) then
    begin
      if qryCategories.Locate('InvCategory', Tree.ActiveNode.Text, []) then
        CategorySelected := qryCategoriesInvCatNo.AsInteger;
    end;

  qryInvItems.Close;
  qryInvItems.Parameters.ParamByName('InvCatNo').Value := CategorySelected;
  qryInvItems.Open;}
end;

procedure TfrmInventory.btnAddItemClick(Sender: TObject);
begin
  if qryCategoriesInvCatNo.AsInteger = 0 then
    begin
      MessageDlg('Please select to which category this item belongs to.', mtInformation, [mbOK], 0);
      exit;
    end;

  frmEditInvItem := TfrmEditInvItem.Create(Application);
  try
    frmEditInvItem.dsInvItems.DataSet := qryInvItems;
    frmEditInvItem.NewRow := true;
    if frmEditInvItem.ShowModal = mrOK then
      begin
//        qryInvItems.Close;
//        qryInvItems.Open;
      end;
  finally
    frmEditInvItem.Free;
  end;
end;

procedure TfrmInventory.btnEditItemClick(Sender: TObject);
begin
  if qryInvItemsInvItemNo.AsInteger <= 0 then
    begin
      MessageDlg('Nothing to edit', mtInformation, [mbOK], 0);
      exit;
    end;

  frmEditInvItem := TfrmEditInvItem.Create(Application);
  try
    frmEditInvItem.dsInvItems.DataSet := qryInvItems;
    frmEditInvItem.NewRow := false;
    if frmEditInvItem.ShowModal = mrOK then
      begin
//        qryInvItems.Close;
//        qryInvItems.Open;
      end;
  finally
    frmEditInvItem.Free;
  end;
end;

procedure TfrmInventory.FormCreate(Sender: TObject);
begin
  ShowFilter := '';
  Param_LineNo_qryInvItems := qryInvItems.SQL.IndexOf(' --<PARAMS>');
end;

procedure TfrmInventory.btnAddStoneClick(Sender: TObject);
begin
  frmEnterStoneInfo := TfrmEnterStoneInfo.Create(Self);
  try
    frmEnterStoneInfo.NewRow := true;
    frmEnterStoneInfo.ShowModal;
  finally
    frmEnterStoneInfo.Free;
  end;
end;

procedure TfrmInventory.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInventory.chkSaleClick(Sender: TObject);
begin
  ShowFilter := '';
  if chkSale.Checked then
    ShowFilter := '''S'',';

  if chkPawn.Checked then
    ShowFilter := ShowFilter + '''P'',';

  if qryInvItems.Active then
    begin
//      qryInvItems.Close;
//      qryInvItems.Open;
    end;
end;

procedure TfrmInventory.qryInvItemsCalcFields(DataSet: TDataSet);
begin
//  qryInvItemscTotalWeight.AsFloat := qryInvItemsInvItemCount.AsInteger * qryInvItemsWeight.AsFloat;

//  if qryTypes.Locate('JType', qryInvItemsJType.AsString, []) then
//    qryInvItemscType.AsString := qryTypesJTypeDesc.AsString;
//
//  if qryStyles.Locate('JStyle', qryInvItemsJStyle.AsString, []) then
//     qryInvItemscStyle.AsString := qryStylesJStyleDesc.AsString;
//
//  if qryMetal.Locate('JMetal', qryInvItemsJMetal.AsString, []) then
//    qryInvItemscMetal.AsString := qryMetalJMetalDesc.AsString;
//
//  if qryStatus.Locate('Status', qryInvItemsInvItemStatus.AsString, []) then
//    qryInvItemscStatus.AsString := qryStatusStatusDesc.AsString;
end;

procedure TfrmInventory.qryInvItemsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//  Accept := pos(qryInvItemsInvItemStatus.AsString , ShowFilter) > 0;
end;

procedure TfrmInventory.qryInvItemsNewRecord(DataSet: TDataSet);
begin
  qryInvItemsInvCatNo.AsInteger := qryCategoriesInvCatNo.AsInteger;
  qryInvItemsInvItemCount.AsInteger := 1;
  qryInvItemsInvItemStatus.AsString := 'S';  //For Sale
  qryInvItemsWeightUnit.AsString := DefaultWeightMeasureUnit;
end;

procedure TfrmInventory.qryStonesCalcFields(DataSet: TDataSet);
begin
//  if qryStoneShapes.Locate('JShape', qryStonesStoneShape.AsString, []) then
//    qryStonescShape.AsString := qryStoneShapesJShapeDesc.AsString;
//  if qryStoneColors.Locate('JStoneColor', qryStonesStoneColor.AsString, []) then
//    qryStonescColor.AsString := qryStoneColorsJStoneDesc.AsString;
end;

procedure TfrmInventory.qryStonesNewRecord(DataSet: TDataSet);
begin
//  qryStonesInvItemNo.AsInteger := qryInvItemsInvItemNo.AsInteger;
end;

procedure TfrmInventory.SpeedButton1Click(Sender: TObject);
begin
  LoadCategoryTree;
end;

procedure TfrmInventory.btnPrintLabelClick(Sender: TObject);
begin
{  if qryInvItemsInvItemNo.AsInteger <= 0 then
    begin
      MessageDlg('Please select an item to print.', mtInformation, [mbOk], 0);
      exit;
    end;

  frmPrintBarcodeLabels := TfrmPrintBarcodeLabels.Create(Application);
  try
    frmPrintBarcodeLabels.LabelNumber := qryInvItemsInvItemCount.AsInteger;
    frmPrintBarcodeLabels.Barcode := qryInvItemsInvItemBarcode.AsString;
    frmPrintBarcodeLabels.Desc := qryCategoriesInvCategory.AsString;
    frmPrintBarcodeLabels.ShowModal;
  finally
    frmPrintBarcodeLabels.Free;
  end;}
end;

procedure TfrmInventory.btnPrintOneLabelClick(Sender: TObject);
begin
{  if qryInvItemsInvItemNo.AsInteger <= 0 then
    begin
      MessageDlg('Please select an item to print.', mtInformation, [mbOk], 0);
      exit;
    end;

  frmPrintBarcodeLabels := TfrmPrintBarcodeLabels.Create(Application);
  try
//    frmPrintBarcodeLabels.edLabelsNumber.Text := qryInvItemsInvItemCount.AsString;
    frmPrintBarcodeLabels.Barcode := qryInvItemsInvItemBarcode.AsString;
    frmPrintBarcodeLabels.Desc := qryCategoriesInvCategory.AsString;
    frmPrintBarcodeLabels.Visible := false;
    frmPrintBarcodeLabels.Show;
    frmPrintBarcodeLabels.Hide;
    frmPrintBarcodeLabels.btnPrintLabelClick(nil);

  finally
    frmPrintBarcodeLabels.Free;
  end;}
end;

procedure TfrmInventory.btnSearchClick(Sender: TObject);
var
  WhereStr: string;
  SelectedCats: string;
  StatusList: string;

  procedure AddStatus(const AStatus: string);
  begin
    if StatusList <> '' then
      StatusList := StatusList + ', ';
    StatusList := StatusList + QuotedStr(AStatus);
  end;
begin
  StatusList := '';
  if chkSale.Checked then
    AddStatus('S');
  if chkPawn.Checked then
    AddStatus('P');
  if CheckBox1.Checked then
    AddStatus('L');

  if StatusList = '' then
    WhereStr := '1 = 0'
  else
    WhereStr := 'ii.INV_ITEM_STATUS IN (' + StatusList + ')';

  SelectedCats := GetSelectedTreeCategories;
  if SelectedCats <> '' then
  begin
    WhereStr := WhereStr + ' AND ii.INV_CAT_NO IN (' + SelectedCats + ')';
  end;

  Screen.Cursor := crHourGlass;
  try
    qryStones.Close;
    qryInvItems.Close;
    qryInvItems.SQL[Param_LineNo_qryInvItems] := 'WHERE ' + WhereStr;
    qryInvItems.Open;
    qryStones.Open;
    lblTotals.Caption := 'Total Items: ' + qryInvItems.RecordCount.ToString;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmInventory.btnEditStoneClick(Sender: TObject);
begin
  frmEnterStoneInfo := TfrmEnterStoneInfo.Create(Application);
  try
    frmEnterStoneInfo.NewRow := false;
    frmEnterStoneInfo.ShowModal;
  finally
    frmEnterStoneInfo.Free;
  end;
end;

end.
