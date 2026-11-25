unit Inventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, System.UITypes, System.Types,
  Buttons, DB, Mask, ComCtrls,
  FireDAC.Comp.Client, Data.SqlTimSt,
  RzForms, RzButton, RzTreeVw, RzSplit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  RzPanel, RzEdit, Vcl.WinXCtrls, uSaleTicket;

type
  TfrmInventory = class(TForm)
    gbBottom: TGroupBox;
    Panel1: TPanel;
    pnTop: TPanel;
    pnCategories: TRzSizePanel;
    dsCategories: TDataSource;
    dsInvItems: TDataSource;
    dsStones: TDataSource;
    Panel6: TPanel;
    Panel5: TPanel;
    dbgItems: TDBGrid;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    dbGridStones: TDBGrid;
    gbItemStatus: TGroupBox;
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
    qryInvItemsStatusDate: TDateField;
    qryInvItemsDaysInStatus: TIntegerField;
    qryInvItemsPawnedDate: TDateField;
    qryInvItemsPurchaseDate: TDateField;
    qryInvItemsLayawayDate: TDateField;
    qryInvItemsForSaleDate: TDateField;
    qryInvItemsRedeemedDate: TDateField;
    qryInvItemsDefaultedDate: TDateField;
    qryInvItemsMeltedDate: TDateField;
    qryInvItemsSoldDate: TDateField;
    CheckBox1: TCheckBox;
    qryStones: TFDQuery;
    gbBarcode: TGroupBox;
    edBarcode: TEdit;
    btnUndoSale: TRzBitBtn;
    btnSellItems: TRzBitBtn;
    pnSales: TSplitView;
    pnSaleStrip: TPanel;
    btnToggleSale: TRzToolButton;
    lblSaleCount: TLabel;
    gbThisSale: TGroupBox;
    pnSaleButtons: TPanel;
    lblDiscount: TLabel;
    edDiscount: TRzNumericEdit;
    cbDiscountType: TComboBox;
    lblDiscountCaption: TLabel;
    lblDiscountAmt: TLabel;
    btnRemoveFromSale: TRzBitBtn;
    pnSaleTotals: TPanel;
    lblSoldDate: TLabel;
    edSoldDate: TRzDateTimeEdit;
    lblSubtotalCaption: TLabel;
    lblSubtotal: TLabel;
    lblTaxCaption: TLabel;
    lblTax: TLabel;
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    btnCompleteSale: TRzBitBtn;
    btnSaleItem: TRzToolButton;
    btnBackToStock: TRzToolButton;
    clnSale: TFDMemTable;
    dsSale: TDataSource;
    chkSold: TCheckBox;
    Panel2: TPanel;
    Panel3: TPanel;
    gridSale: TDBGrid;
    btnNewSaleClearOldSale: TRzBitBtn;
    lblRcptNo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dsInvItemsDataChange(Sender: TObject; Field: TField);
    procedure btnSellItemsClick(Sender: TObject);
    procedure btnUndoSaleClick(Sender: TObject);
    procedure btnToggleSaleClick(Sender: TObject);
    procedure pnSalesSliding(Sender: TObject);
    procedure pnSalesOpened(Sender: TObject);
    procedure btnSaleItemClick(Sender: TObject);
    procedure btnBackToStockClick(Sender: TObject);
    procedure DiscountChange(Sender: TObject);
    procedure btnCompleteSaleClick(Sender: TObject);
    procedure dbgItemsDblClick(Sender: TObject);
    procedure dbgItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnNewSaleClearOldSaleClick(Sender: TObject);
  private
    Param_LineNo_qryInvItems: integer;
    FSavedUncheckedCategories: string;   // read in FormCreate, applied after the tree loads
    // The open sale: lines, items hidden from the list, totals, completed
    // state. Shared with the Sell Items screen (uSaleTicket.pas).
    FTicket: TSaleTicket;
    procedure SaleChanged(Sender: TObject);
    procedure ApplyInSaleFilter(LocateItemNo: integer = 0);
    procedure qryInvItemsFilterInSale(DataSet: TDataSet; var Accept: Boolean);
    procedure gridSaleKeyPress(Sender: TObject; var Key: Char);
    procedure gridSaleExit(Sender: TObject);
    procedure PostSaleEdit;
    procedure WMPostSaleEdit(var Msg: TMessage); message WM_POST_SALE_EDIT;
    procedure UpdateSaleLock;
    procedure PositionPrintButtons(Sender: TObject);
    procedure RecalcSaleTotals;
    function GetSelectedTreeCategories: string;
    function GetUncheckedTreeCategories: string;
    procedure ApplyUncheckedTreeCategories(const ACatNos: string);
    function BuildStatusTrailHint: string;
    procedure UpdateSaleButtons;
    function CurrentItemIsForSale: boolean;
  public
    procedure LoadCategoryTree;
    procedure ShowItem(InvItemNo: integer; const Barcode: string);
  end;

var
  frmInventory: TfrmInventory;

implementation

uses PawnDM, EditInvItem, PawnGlobal, ItemHistory, SellItems, uPawnDialogs, SearchClient;

{$R *.dfm}

const
  InventoryIniSection = 'Inventory';

{ INV_ITEM_STATUS char -> the status label the colour table is keyed by (the
  same colours as the client screen's item grid). A pawn item still 'P' with
  a defaulted date is a Defaulted item whose fate is not decided yet. }
function InvItemStatusLabel(const AStatus: string; IsDefaulted: boolean): string;
begin
  if AStatus = 'P' then
    begin
      if IsDefaulted then
        Result := PawnItemStatus_Defaulted
      else
        Result := PawnItemStatus_Pawned;
    end
  else if AStatus = 'S' then
    Result := PawnItemStatus_ForSale
  else if AStatus = 'L' then
    Result := PawnItemStatus_Layaway
  else if AStatus = 'R' then
    Result := PawnItemStatus_Redeemed
  else if AStatus = 'D' then
    Result := PawnItemStatus_Sold
  else if AStatus = 'C' then
    Result := PawnItemStatus_Melted
  else
    Result := '';
end;

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

{ Category ticks are remembered as the UNticked ones, so a category added
  later starts ticked like before. Comma list of INV_CAT_NO. }
function TfrmInventory.GetUncheckedTreeCategories: string;
var
  i: integer;
  Node: TTreeNode;
begin
  Result := '';
  for i := 0 to chkTree.Items.Count - 1 do
    begin
      Node := chkTree.Items[i];
      if (Integer(Node.Data) <> 0) and (chkTree.ItemState[Node.AbsoluteIndex] = csUnchecked) then
        begin
          if Result <> '' then
            Result := Result + ',';
          Result := Result + IntToStr(Integer(Node.Data));
        end;
    end;
end;

procedure TfrmInventory.ApplyUncheckedTreeCategories(const ACatNos: string);
var
  List: TStringList;
  i: integer;
  Node: TTreeNode;
begin
  if Trim(ACatNos) = '' then
    exit;

  List := TStringList.Create;
  try
    List.CommaText := ACatNos;
    for i := 0 to chkTree.Items.Count - 1 do
      begin
        Node := chkTree.Items[i];
        if (Integer(Node.Data) <> 0) and (List.IndexOf(IntToStr(Integer(Node.Data))) >= 0) then
          // Goes through the tree so the "Categories" root shows partly ticked.
          chkTree.ChangeNodeCheckState(Node, csUnchecked);
      end;
  finally
    List.Free;
  end;
end;

procedure TfrmInventory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // Remember the Item Status choice for next time (per user, local INI).
  try
    DM.RegIniFile.WriteBool(InventoryIniSection, 'ShowForSale', chkSale.Checked);
    DM.RegIniFile.WriteBool(InventoryIniSection, 'ShowPawned', chkPawn.Checked);
    DM.RegIniFile.WriteBool(InventoryIniSection, 'ShowLayaway', CheckBox1.Checked);
    DM.RegIniFile.WriteBool(InventoryIniSection, 'ShowSold', chkSold.Checked);

    // Category panel: collapsed or not, and its open width (HotSpotPosition
    // holds the width it reopens to while collapsed).
    DM.RegIniFile.WriteBool(InventoryIniSection, 'CategoriesClosed', pnCategories.HotSpotClosed);
    if pnCategories.HotSpotClosed then
      DM.RegIniFile.WriteInteger(InventoryIniSection, 'CategoriesWidth', pnCategories.HotSpotPosition)
    else
      DM.RegIniFile.WriteInteger(InventoryIniSection, 'CategoriesWidth', pnCategories.Width);

    DM.RegIniFile.WriteString(InventoryIniSection, 'UncheckedCategories', GetUncheckedTreeCategories);
  except
    // cosmetic: never block closing the screen
  end;

  Action := caFree;
  frmInventory := nil;
end;

procedure TfrmInventory.FormShow(Sender: TObject);
begin
  lblRcptNo.Caption := '';
  qryCategories.Open;

  LoadCategoryTree;
  ApplyUncheckedTreeCategories(FSavedUncheckedCategories);
  PositionPrintButtons(nil);

  pnTop.Focused;
end;

procedure TfrmInventory.FormCreate(Sender: TObject);
var
  W: integer;
begin
  Param_LineNo_qryInvItems := qryInvItems.SQL.IndexOf(' --<PARAMS>');

  // Last Item Status choice; first time = as the DFM has the checkboxes.
  try
    chkSale.Checked := DM.RegIniFile.ReadBool(InventoryIniSection, 'ShowForSale', True);
    chkPawn.Checked := DM.RegIniFile.ReadBool(InventoryIniSection, 'ShowPawned', True);
    CheckBox1.Checked := DM.RegIniFile.ReadBool(InventoryIniSection, 'ShowLayaway', True);
    chkSold.Checked := DM.RegIniFile.ReadBool(InventoryIniSection, 'ShowSold', chkSold.Checked);

    W := DM.RegIniFile.ReadInteger(InventoryIniSection, 'CategoriesWidth', pnCategories.Width);
    if (W >= 100) and (W <= 600) then
      pnCategories.Width := W;
    if DM.RegIniFile.ReadBool(InventoryIniSection, 'CategoriesClosed', False) then
      pnCategories.CloseHotSpot;
    FSavedUncheckedCategories := DM.RegIniFile.ReadString(InventoryIniSection, 'UncheckedCategories', '');
  except
  end;

  // The sale drawer is kept open in the DFM so it stays editable in the
  // designer (a TSplitView saved closed loses its OpenedWidth). Start it
  // closed here, without the animation.
  pnSales.UseAnimation := False;
  pnSales.Opened := False;
  pnSales.UseAnimation := True;

  // The two print buttons keep to the form's right edge (see
  // PositionPrintButtons); Panel7 resizes with the form, the category panel
  // and the drawer, so its OnResize covers every case.
  Panel7.OnResize := PositionPrintButtons;

  // Items in the open sale are hidden from the list (see ApplyInSaleFilter).
  qryInvItems.OnFilterRecord := qryInvItemsFilterInSale;

  // A price typed in the sale grid is saved on Enter, or when the grid loses
  // focus, not only when moving to another row (see gridSaleKeyPress).
  gridSale.OnKeyPress := gridSaleKeyPress;
  gridSale.OnExit := gridSaleExit;

  FTicket := TSaleTicket.Create(Self, clnSale);
  FTicket.OnChange := SaleChanged;
  UpdateSaleLock;
  edSoldDate.Date := Date;
  lblTaxCaption.Caption := Format('Tax (%s%%):', [FormatFloat('0.##', FTicket.TaxPerc)]);
  RecalcSaleTotals;
  UpdateSaleButtons;
end;

procedure TfrmInventory.btnToggleSaleClick(Sender: TObject);
begin
  pnSales.Opened := not pnSales.Opened;
end;

// While the drawer slides, its contents are hidden: re-laying out the grid
// and totals at every animation step is what made them blink. Back to Stock
// only works on the sale grid, so it shows only while the drawer is open.
procedure TfrmInventory.pnSalesSliding(Sender: TObject);
begin
  gbThisSale.Visible := False;
  btnBackToStock.Visible := False;
end;

procedure TfrmInventory.pnSalesOpened(Sender: TObject);
begin
  gbThisSale.Visible := True;
  btnBackToStock.Visible := True;
end;

{ ---- This Sale drawer ---------------------------------------------------- }

{ Puts the item selected in the list into this sale (the whole row, whatever
  its quantity), and opens the drawer so the user sees it land. Only For Sale
  items qualify; an item already in the sale is just selected there. }
procedure TfrmInventory.btnSaleItemClick(Sender: TObject);
begin
  if FTicket.Completed then
    begin
      PawnInfo('This sale is already completed. Press New Sale / Clear to start the next one.',
               'This Sale', Self);
      exit;
    end;

  if not qryInvItems.Active or qryInvItems.IsEmpty then
    begin
      PawnInfo('Please select an item in the list.', 'This Sale', Self);
      exit;
    end;

  if not CurrentItemIsForSale then
    begin
      PawnInfo(Format('Item %s is not For Sale (status: %s).',
                      [qryInvItemsInvItemBarcode.AsString, qryInvItemsStatusDesc.AsString]),
               'This Sale', Self);
      exit;
    end;

  if not FTicket.Contains(qryInvItemsInvItemNo.AsInteger) then
    begin
      FTicket.AddItem(qryInvItemsInvItemNo.AsInteger, qryInvItemsInvItemBarcode.AsString,
        qryInvItemsInvItemCount.AsInteger,
        TSaleTicket.ItemDescription(qryInvItemsDescription.AsString,
                                    qryInvItemsJMetalDesc.AsString, qryInvItemsJTypeDesc.AsString),
        qryInvItemsUnitCost.AsVariant, qryInvItemsUnitPrice.AsVariant);
      // The item moves: out of the list, into the sale.
      ApplyInSaleFilter;
    end
  else
    clnSale.Locate('INV_ITEM_NO', qryInvItemsInvItemNo.AsInteger, []);

  if not pnSales.Opened then
    pnSales.Opened := True;
end;

{ ---- items in the open sale are hidden from the list --------------------- }

procedure TfrmInventory.qryInvItemsFilterInSale(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := (FTicket = nil) or not FTicket.Contains(qryInvItemsInvItemNo.AsInteger);
end;

{ Re-applies the filter after the sale changed. Nothing is written to the
  database until Complete Sale, so this is only what the list shows: an item
  added to the sale leaves the list, one taken back out returns to it and is
  selected (LocateItemNo). Otherwise the cursor stays near where it was, so
  the next item is ready for the next right-arrow click. }
procedure TfrmInventory.ApplyInSaleFilter(LocateItemNo: integer);
var
  OldRecNo: integer;
begin
  if not qryInvItems.Active then
    exit;

  OldRecNo := qryInvItems.RecNo;
  qryInvItems.DisableControls;
  try
    qryInvItems.Filtered := False;
    qryInvItems.Filtered := FTicket.HasOpenItems;

    if (LocateItemNo = 0) or not qryInvItems.Locate('InvItemNo', LocateItemNo, []) then
      if (OldRecNo > 0) and not qryInvItems.IsEmpty then
        if OldRecNo <= qryInvItems.RecordCount then
          qryInvItems.RecNo := OldRecNo
        else
          qryInvItems.Last;
  finally
    qryInvItems.EnableControls;
  end;
  UpdateSaleButtons;
end;

// Takes the selected row out of this sale. Nothing was written to the
// database yet, so the item simply stays in stock as For Sale.
procedure TfrmInventory.btnBackToStockClick(Sender: TObject);
begin
  FTicket.RemoveCurrent;
end;

{ Enter in the sale grid hands the typed price to the field but leaves the row
  in edit: TDBGrid only posts when the cursor moves to another row, so on the
  last row the totals never caught up. The post is queued, not done here, so
  the grid first finishes its own Enter handling (writing the editor's text
  into the field). The first Enter, which only opens the editor, finds the
  row unchanged and posts nothing. }
procedure TfrmInventory.gridSaleKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    PostMessage(Handle, WM_POST_SALE_EDIT, 0, 0);
end;

procedure TfrmInventory.WMPostSaleEdit(var Msg: TMessage);
begin
  PostSaleEdit;
end;

// Leaving the grid (e.g. clicking the discount) also saves a price being typed.
procedure TfrmInventory.gridSaleExit(Sender: TObject);
begin
  if gridSale.EditorMode then
    gridSale.EditorMode := False;   // writes the editor's text into the field
  PostSaleEdit;
end;

{ Posts a pending price edit; OnChange recalculates the totals. A bad value
  (e.g. letters) is reported and the row stays in edit to be corrected. }
procedure TfrmInventory.PostSaleEdit;
var
  Err: string;
begin
  if not FTicket.PostPendingEdit(Err) then
    PawnWarn(Err, 'This Sale', Self);
end;

// A price posted, a line added or removed: totals, and a removed item goes
// back into the list, selected.
procedure TfrmInventory.SaleChanged(Sender: TObject);
var
  Removed: integer;
begin
  RecalcSaleTotals;
  Removed := FTicket.TakeRemovedItemNo;
  if Removed <> 0 then
    ApplyInSaleFilter(Removed);
end;

procedure TfrmInventory.DiscountChange(Sender: TObject);
begin
  RecalcSaleTotals;
end;

{ Totals (rules in TSaleTicket.Totals). An out-of-range discount shows in red. }
procedure TfrmInventory.RecalcSaleTotals;
var
  T: TSaleTotals;
begin
  if FTicket = nil then
    exit;   // a discount control's OnChange while the form is still loading
  T := FTicket.Totals(cbDiscountType.ItemIndex = 1, edDiscount.Value);
  if T.DiscountInvalid then
    edDiscount.Font.Color := clRed
  else
    edDiscount.Font.Color := clWindowText;

  lblSubtotal.Caption := FormatCurr('$,0.00', T.Subtotal);
  if T.Discount = 0 then
    lblDiscountAmt.Caption := '$0.00'
  else
    lblDiscountAmt.Caption := FormatCurr('-$,0.00', T.Discount);
  lblTax.Caption := FormatCurr('$,0.00', T.Tax);
  lblTotal.Caption := FormatCurr('$,0.00', T.Total);
  lblSaleCount.Caption := IntToStr(FTicket.Count);
  btnCompleteSale.Enabled := not FTicket.Completed and (FTicket.Count > 0);
end;

procedure TfrmInventory.btnCloseClick(Sender: TObject);
begin
  Close;
end;

// Formats the current row's status history for the grid hint. The ordering rule
// lives in ItemHistory so the hint and the Item History form always agree; the
// dates already loaded in the grid are reused, so hovering costs no round trip.
function TfrmInventory.BuildStatusTrailHint: string;

  function DateOf(AField: TDateField): TDateTime;
  begin
    if AField.IsNull then
      Result := 0
    else
      Result := AField.AsDateTime;
  end;

begin
  Result := ItemStatusTrailToText(
    BuildItemStatusTrail(DateOf(qryInvItemsPawnedDate),
                         DateOf(qryInvItemsPurchaseDate),
                         DateOf(qryInvItemsLayawayDate),
                         DateOf(qryInvItemsForSaleDate),
                         DateOf(qryInvItemsRedeemedDate),
                         DateOf(qryInvItemsDefaultedDate),
                         DateOf(qryInvItemsMeltedDate),
                         DateOf(qryInvItemsSoldDate)));
end;

procedure TfrmInventory.dsInvItemsDataChange(Sender: TObject; Field: TField);
begin
  // Field <> nil means a single field changed, not a row move - trail is unchanged.
  if Field <> nil then
    Exit;

  if qryInvItems.Active and not qryInvItems.IsEmpty then
    dbgItems.Hint := BuildStatusTrailHint
  else
    dbgItems.Hint := '';

  UpdateSaleButtons;
end;

{ The one rule for "can be sold": status For Sale and not sold yet. Pawned,
  Layaway, Redeemed, Scrap and Sold items never reach a sale. }
function TfrmInventory.CurrentItemIsForSale: boolean;
begin
  Result := qryInvItems.Active and not qryInvItems.IsEmpty and
            (qryInvItemsInvItemStatus.AsString = 'S') and qryInvItemsSoldDate.IsNull;
end;

{ Add to Sale stays visible but is enabled only on a For Sale item; Undo Sale
  only for an item sold through Sell Items -- a layaway payoff is undone by
  Reactivate Layaway instead. }
procedure TfrmInventory.UpdateSaleButtons;
begin
  if FTicket = nil then
    exit;   // the list's OnDataChange while the form is still loading
  btnSaleItem.Enabled := CurrentItemIsForSale and not FTicket.Completed;
  // VCL still shows hints on a disabled button, so say why it is greyed out.
  if FTicket.Completed then
    btnSaleItem.Hint := 'This sale is completed - press New Sale / Clear first'
  else if btnSaleItem.Enabled then
    btnSaleItem.Hint := 'Add the selected item to this sale'
  else if qryInvItems.Active and not qryInvItems.IsEmpty then
    btnSaleItem.Hint := Format('Only For Sale items can be sold - this item is %s',
                               [InvItemStatusLabel(qryInvItemsInvItemStatus.AsString,
                                                   not qryInvItemsDefaultedDate.IsNull)])
  else
    btnSaleItem.Hint := 'Select a For Sale item to add it to this sale';
  btnUndoSale.Visible := qryInvItems.Active and not qryInvItems.IsEmpty and
                         (qryInvItemsInvItemStatus.AsString = 'D') and
                         qryInvItemsLayawayDate.IsNull;
end;

{ Barcode cell painted in the item's status colour. }
procedure TfrmInventory.dbgItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  C: TPawnStatusColor;
begin
  if (Column.Field <> qryInvItemsInvItemBarcode) or qryInvItems.IsEmpty then
    exit;

  C := GetPawnStatusColor(InvItemStatusLabel(qryInvItemsInvItemStatus.AsString,
                                             not qryInvItemsDefaultedDate.IsNull));
  dbgItems.Canvas.Brush.Color := C.BG;
  dbgItems.Canvas.Font.Color := C.FG;
  dbgItems.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

{ Double-click edits the item: Description, Quantity, Unit Price and Note
  (the rest of the form is shown read-only for now). }
procedure TfrmInventory.dbgItemsDblClick(Sender: TObject);
var
  Dlg: TfrmEditInvItem;
  ItemNo: integer;
begin
  if not qryInvItems.Active or qryInvItems.IsEmpty then
    exit;

  ItemNo := qryInvItemsInvItemNo.AsInteger;
  Dlg := TfrmEditInvItem.Create(Self);
  try
    Dlg.dsInvItems.DataSet := qryInvItems;
    Dlg.NewRow := False;
    if Dlg.ShowModal <> mrOk then
      exit;
  finally
    Dlg.Free;
  end;

  // Keep a copy already in this sale in step (its Sale Price is left alone:
  // it may hold a discount typed in the drawer).
  if not FTicket.Completed and clnSale.Locate('INV_ITEM_NO', ItemNo, []) then
    begin
      clnSale.Edit;
      clnSale.FieldByName('INV_ITEM_COUNT').AsInteger := qryInvItemsInvItemCount.AsInteger;
      if Trim(qryInvItemsDescription.AsString) <> '' then
        clnSale.FieldByName('DESCRIPTION').AsString := Trim(qryInvItemsDescription.AsString);
      clnSale.Post;
    end;

  // Re-run the list so server-side columns (Total Weight) follow the edit.
  btnSearchClick(nil);
  qryInvItems.Locate('InvItemNo', ItemNo, []);
end;

procedure TfrmInventory.btnSellItemsClick(Sender: TObject);
var
  Dlg: TfrmSellItems;
begin
  Dlg := TfrmSellItems.Create(Self);
  try
    // Bring the selected item along when it is For Sale.
    if CurrentItemIsForSale then
      Dlg.AddItemToSale(qryInvItemsInvItemNo.AsInteger);

    // The screen stays open after a sale (for the next one), so refresh
    // whatever way it was closed.
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;

  if qryInvItems.Active then
    btnSearchClick(nil);
end;

{ An item sold on a sale ticket is put back by voiding that whole ticket (all
  its items return to For Sale, the ticket stays in history as Voided). An
  item sold before tickets existed has no ticket and is put back on its own. }
procedure TfrmInventory.btnUndoSaleClick(Sender: TObject);
var
  ItemNo, SaleNo, TicketNo, LineCount: integer;
  Total: Currency;
  Reason: string;
begin
  ItemNo := qryInvItemsInvItemNo.AsInteger;

  if DM.FindSaleOfItem(ItemNo, SaleNo, TicketNo, LineCount, Total) then
    begin
      if not PawnConfirm(Format('Item %s was sold on sale ticket #%d (%d item(s), total %s).' + sLineBreak +
                                'Void the whole ticket? All its items go back to For Sale.',
                                [qryInvItemsInvItemBarcode.AsString, TicketNo, LineCount,
                                 FormatCurr('$,0.00', Total)]), 'Void Sale', Self) then
        exit;

      Reason := '';
      if not PawnPrompt('Reason for voiding (optional):', 'Void Sale', Reason, Self) then
        exit;

      try
        DM.VoidSale(SaleNo, Reason);
      except
        on E: Exception do
          PawnWarn(E.Message, 'Void Sale', Self);
      end;
    end
  else
    begin
      if not PawnConfirm('Undo the sale of item ' + qryInvItemsInvItemBarcode.AsString + '?' + sLineBreak +
                         'It goes back to For Sale.', 'Undo Sale', Self) then
        exit;

      if not DM.UnsellItem(ItemNo) then
        PawnWarn('This item could not be put back to For Sale.', 'Undo Sale', Self);
    end;

  RefreshClientsAfterItemChange;
  btnSearchClick(nil);
  qryInvItems.Locate('InvItemNo', ItemNo, []);
end;

{ Saves the drawer's sale as a numbered ticket (TDM.CompleteSale). The drawer
  stays open with the ticket on screen, locked, and its receipt number next to
  New Sale / Clear, which empties it for the next customer. The drawer is
  never closed for the user. No ticket is printed yet. }
procedure TfrmInventory.btnCompleteSaleClick(Sender: TObject);
var
  Msg: string;
begin
  PostSaleEdit;
  case FTicket.Validate(edSoldDate.Date, cbDiscountType.ItemIndex = 1, edDiscount.Value, Msg) of
    spNone: ;
    spEmpty: exit;
    spNoPrice:
      begin
        PawnInfo(Msg, 'Complete Sale', Self);
        gridSale.SetFocus;
        gridSale.SelectedField := clnSale.FieldByName('SALE_PRICE');
        exit;
      end;
    spDiscount:
      begin
        RecalcSaleTotals;
        PawnInfo(Msg, 'Complete Sale', Self);
        edDiscount.SetFocus;
        exit;
      end;
    spFutureDate:
      begin
        PawnInfo(Msg, 'Complete Sale', Self);
        edSoldDate.SetFocus;
        exit;
      end;
  end;

  RecalcSaleTotals;
  if not PawnConfirm(Format('Complete the sale of %d item(s) for %s (tax included)?',
                            [FTicket.Count, lblTotal.Caption]), 'Complete Sale', Self) then
    exit;

  Screen.Cursor := crHourGlass;
  try
    try
      FTicket.Complete(edSoldDate.Date, cbDiscountType.ItemIndex = 1, edDiscount.Value);
    except
      on E: Exception do
        begin
          Screen.Cursor := crDefault;
          PawnWarn(E.Message, 'Complete Sale', Self);
          btnSearchClick(nil);
          exit;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  RefreshClientsAfterItemChange;
  RefreshSellItemsScreen;

  UpdateSaleLock;
  btnSearchClick(nil);
end;

{ Print Labels / Print One Label stay at the form's right edge, just left of
  the drawer's closed strip. They sit in Panel7, which the docked drawer
  narrows as it opens; placing them by the FORM's edge rather than Panel7's
  means an open drawer slides over them (Panel7 clips them) instead of
  pushing them left, and resizing the form moves them with the edge. }
procedure TfrmInventory.PositionPrintButtons(Sender: TObject);
const
  Gap = 8;
var
  RightX: integer;
begin
  RightX := Panel7.ScreenToClient(ClientToScreen(Point(ClientWidth - pnSales.CompactWidth, 0))).X - Gap * 2;
  btnPrintOneLabel.Left := RightX - btnPrintOneLabel.Width;
  btnPrintLabel.Left := btnPrintOneLabel.Left - Gap - btnPrintLabel.Width;
end;

{ Locks the drawer on a saved ticket or opens it for a new sale, as
  FTicket.Completed says. While locked: nothing can be added, removed or
  re-priced, the totals stay as saved, and only New Sale / Clear is enabled. }
procedure TfrmInventory.UpdateSaleLock;
var
  Locked: boolean;
begin
  Locked := FTicket.Completed;
  if Locked then
    begin
      ApplyInSaleFilter;   // a completed ticket's items are Sold: nothing to hide
      lblRcptNo.Caption := Format('Receipt No. %d', [FTicket.TicketNo]);
    end
  else
    lblRcptNo.Caption := '';

  btnNewSaleClearOldSale.Enabled := Locked;
  gridSale.ReadOnly := Locked;
  edDiscount.Enabled := not Locked;
  cbDiscountType.Enabled := not Locked;
  edSoldDate.Enabled := not Locked;
  btnRemoveFromSale.Enabled := not Locked;
  btnBackToStock.Enabled := not Locked;

  RecalcSaleTotals;
  UpdateSaleButtons;
end;

{ Clears the completed ticket off the drawer and gets it ready for the next
  sale. The ticket itself is saved; this only empties the screen. }
procedure TfrmInventory.btnNewSaleClearOldSaleClick(Sender: TObject);
begin
  FTicket.Clear;
  ApplyInSaleFilter;
  edDiscount.Value := 0;
  cbDiscountType.ItemIndex := 0;
  edSoldDate.Date := Date;
  UpdateSaleLock;
end;

{ Interim, until the full sale screen: the client screen's Items tab opens
  this screen on one For Sale item (right click, "Sell this item...") so the
  store can move it to the sale drawer and complete the sale.

  Looks the item up by INV_ITEM_NO, not by barcode: an old item may have no
  barcode, and a barcode is not guaranteed unique. The barcode is put in the
  box only so the screen shows what it is filtered on; clearing it and
  pressing Search returns to the normal list. }
procedure TfrmInventory.ShowItem(InvItemNo: integer; const Barcode: string);
begin
  if WindowState = wsMinimized then
    WindowState := wsNormal;
  Show;
  BringToFront;

  edBarcode.Text := Barcode;
  Screen.Cursor := crHourGlass;
  try
    qryStones.Close;
    qryInvItems.Close;
    qryInvItems.SQL[Param_LineNo_qryInvItems] := 'WHERE ii.INV_ITEM_NO = ' + IntToStr(InvItemNo);
    qryInvItems.Open;
    qryStones.Open;
    lblTotals.Caption := 'Item from the client screen';
  finally
    Screen.Cursor := crDefault;
  end;

  if qryInvItems.IsEmpty then
    PawnInfo('This item was not found.', 'Items', Self);
  UpdateSaleButtons;
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
  // Barcode search: find that one item whatever its status or category, so a
  // scanned item already Sold / Pawned / on Layaway shows as such instead of
  // "not found". Empty box = the normal filtered list.
  if Trim(edBarcode.Text) <> '' then
    begin
      Screen.Cursor := crHourGlass;
      try
        qryStones.Close;
        qryInvItems.Close;
        qryInvItems.SQL[Param_LineNo_qryInvItems] :=
          'WHERE UPPER(ii.INV_ITEM_BARCODE) = ' + QuotedStr(UpperCase(Trim(edBarcode.Text)));
        qryInvItems.Open;
        qryStones.Open;
        lblTotals.Caption := 'Barcode search: ' + qryInvItems.RecordCount.ToString + ' item(s)';
      finally
        Screen.Cursor := crDefault;
      end;

      if qryInvItems.IsEmpty then
        if clnSale.Locate('INV_ITEM_BARCODE', Trim(edBarcode.Text), [loCaseInsensitive]) then
          PawnInfo('Item ' + Trim(edBarcode.Text) + ' is already in this sale.', 'Items', Self)
        else
          PawnInfo('No item has barcode ' + Trim(edBarcode.Text) + '.', 'Items', Self);
      UpdateSaleButtons;
      edBarcode.SetFocus;
      edBarcode.SelectAll;   // the next scan replaces it
      exit;
    end;

  StatusList := '';
  if chkSale.Checked then
    AddStatus('S');
  if chkPawn.Checked then
    AddStatus('P');
  if CheckBox1.Checked then
    AddStatus('L');
  if chkSold.Checked then
    AddStatus('D');

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

end.
