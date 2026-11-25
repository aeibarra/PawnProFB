unit SellItems;

{ "Sell Items" screen -- moves For Sale items to Sold until the POS exists.
  Cash sale, no customer. The 80 mm receipt is still to be built (see
  Docs/ThermalReceipts_Plan.md); its Print button is already in place.

  Left: every item currently For Sale (INV_ITEM_STATUS 'S', not sold), from
  purchases, defaulted pawns and supplier stock, narrowed by barcode /
  description. Items already in this sale are hidden from it.
  Right: the items of this sale, with an editable Sale Price that starts from
  UNIT_PRICE, a discount for the whole sale ($ or %), and the store's tax.

  The same register as the Items screen's sale drawer: the sale itself (lines,
  totals, checks, Complete Sale, the locked completed ticket with its receipt
  number until New Sale / Clear) is TSaleTicket in uSaleTicket.pas, shared by
  both. Complete Sale -> TDM.CompleteSale: all or nothing, saved as a numbered
  sale ticket (SALES / SALE_LINES).

  Opened two ways: from the main toolbar, modeless (one instance, frees itself
  on close), or modally from the Items screen with its selected item. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Data.DB, System.UITypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RzButton, RzEdit, uSaleTicket;

type
  TfrmSellItems = class(TForm)
    pnFind: TPanel;
    lblFind: TLabel;
    edFind: TEdit;
    btnFind: TRzBitBtn;
    pnLists: TPanel;
    gbForSale: TGroupBox;
    gridForSale: TDBGrid;
    pnForSaleButtons: TPanel;
    btnAddToSale: TRzBitBtn;
    lblForSaleCount: TLabel;
    qryForSale: TFDQuery;
    dsForSale: TDataSource;
    clnSale: TFDMemTable;
    dsSale: TDataSource;
    btnClose: TBitBtn;
    Panel1: TPanel;
    pnSaleStrip: TPanel;
    lblSaleCount: TLabel;
    btnToggleSale: TRzToolButton;
    btnSaleItem: TRzToolButton;
    btnBackToStock: TRzToolButton;
    gbThisSale: TGroupBox;
    gridSale: TDBGrid;
    pnSaleButtons: TPanel;
    lblDiscount: TLabel;
    btnRemoveFromSale: TRzBitBtn;
    edDiscount: TRzNumericEdit;
    cbDiscountType: TComboBox;
    pnSaleTotals: TPanel;
    lblSoldDate: TLabel;
    lblSubtotalCaption: TLabel;
    lblSubtotal: TLabel;
    lblDiscountCaption: TLabel;
    lblDiscountAmt: TLabel;
    lblTaxCaption: TLabel;
    lblTax: TLabel;
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    edSoldDate: TRzDateTimeEdit;
    btnNewSale: TRzBitBtn;
    btnCompleteSale: TRzBitBtn;
    btnPrintSalesReceipt: TRzBitBtn;
    lblRcptNo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure edFindKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddToSaleClick(Sender: TObject);
    procedure gridForSaleDblClick(Sender: TObject);
    procedure btnRemoveFromSaleClick(Sender: TObject);
    procedure gridSaleKeyPress(Sender: TObject; var Key: Char);
    procedure gridSaleExit(Sender: TObject);
    procedure DiscountChange(Sender: TObject);
    procedure btnCompleteSaleClick(Sender: TObject);
    procedure btnNewSaleClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnToggleSaleClick(Sender: TObject);
    procedure btnPrintSalesReceiptClick(Sender: TObject);
    procedure dsForSaleDataChange(Sender: TObject; Field: TField);
  private
    // The open sale, shared rules with the Items screen's drawer.
    FTicket: TSaleTicket;
    procedure OpenForSale(const AFind: string; LocateItemNo: integer = 0);
    procedure ApplyInSaleFilter(LocateItemNo: integer = 0);
    procedure qryForSaleFilterInSale(DataSet: TDataSet; var Accept: Boolean);
    function AddCurrentForSaleItem: boolean;
    procedure SaleChanged(Sender: TObject);
    procedure PostSaleEdit;
    procedure WMPostSaleEdit(var Msg: TMessage); message WM_POST_SALE_EDIT;
    procedure RecalcTotals;
    procedure UpdateSaleLock;
    procedure UpdateSaleButtons;
  public
    { True when opened from the main toolbar: modeless like Clients and Items
      (one instance, frees itself on close). False (default) when the Items
      screen shows it modally. }
    Modeless: boolean;

    { Adds one item to this sale (the Items screen passes its selected item
      before showing this screen). False when that item is not For Sale. }
    function AddItemToSale(InvItemNo: integer): boolean;

    { Re-reads the For Sale list (items sold or changed elsewhere). }
    procedure RefreshForSale;
  end;

var
  frmSellItems: TfrmSellItems;

{ Keeps an open toolbar Sell Items screen in step after a sale made elsewhere. }
procedure RefreshSellItemsScreen;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, uPawnDialogs, SearchClient, Inventory;

const
  ForSaleSQL =
    'SELECT ii.INV_ITEM_NO, ii.INV_ITEM_BARCODE, ii.INV_ITEM_COUNT, ii.DESCRIPTION, ' +
    '       jt.J_TYPE_DESC, jm.J_METAL_DESC, ii.KT, ii.WEIGHT, ii.WEIGHT_UNIT, ' +
    '       ii.UNIT_COST, ii.UNIT_PRICE ' +
    'FROM INVENTORY_ITEMS ii ' +
    'LEFT JOIN J_TYPES jt ON ii.J_TYPE = jt.J_TYPE ' +
    'LEFT JOIN J_METALS jm ON ii.J_METAL = jm.J_METAL ' +
    'WHERE ii.INV_ITEM_STATUS = ''S'' AND ii.SOLD_DATE IS NULL ';

procedure RefreshSellItemsScreen;
begin
  if (frmSellItems <> nil) and not (csDestroying in frmSellItems.ComponentState) then
    frmSellItems.RefreshForSale;
end;

{ ---- setup ---------------------------------------------------------------- }

procedure TfrmSellItems.FormCreate(Sender: TObject);
begin
  FTicket := TSaleTicket.Create(Self, clnSale);
  FTicket.OnChange := SaleChanged;

  // Items in this sale are hidden from the For Sale list.
  qryForSale.OnFilterRecord := qryForSaleFilterInSale;

  // A price typed in the sale grid is saved on Enter, or when the grid loses
  // focus, not only when moving to another row.
  gridSale.OnKeyPress := gridSaleKeyPress;
  gridSale.OnExit := gridSaleExit;

  edSoldDate.Date := Date;
  lblTaxCaption.Caption := Format('Tax (%s%%):', [FormatFloat('0.##', FTicket.TaxPerc)]);
  OpenForSale('');
  UpdateSaleLock;
end;

procedure TfrmSellItems.FormShow(Sender: TObject);
begin
  edFind.SetFocus;
end;

// Items left in an open (not completed) sale are lost on close: ask first.
// Covers the Close button, Esc and the window's X.
procedure TfrmSellItems.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FTicket.Completed and (FTicket.Count > 0) then
    CanClose := PawnConfirm('Close without completing this sale?', 'Sell Items', Self);
end;

procedure TfrmSellItems.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Modeless then
    Action := caFree;
end;

procedure TfrmSellItems.FormDestroy(Sender: TObject);
begin
  // Cleared here, not in FormClose: caFree is deferred, and PawnMain must not
  // create a second instance while this one is still being released.
  if frmSellItems = Self then
    frmSellItems := nil;
end;

procedure TfrmSellItems.btnCloseClick(Sender: TObject);
begin
  if Modeless then
    Close
  else
    ModalResult := mrCancel;   // the Items screen refreshes either way
end;

{ ---- the For Sale list ---------------------------------------------------- }

procedure TfrmSellItems.OpenForSale(const AFind: string; LocateItemNo: integer);
var
  F: string;
begin
  F := Trim(AFind);
  qryForSale.Close;
  if F = '' then
    qryForSale.SQL.Text := ForSaleSQL + 'ORDER BY ii.INV_ITEM_BARCODE'
  else
    begin
      qryForSale.SQL.Text := ForSaleSQL +
        'AND (UPPER(ii.INV_ITEM_BARCODE) LIKE :FIND OR UPPER(ii.DESCRIPTION) LIKE :FIND) ' +
        'ORDER BY ii.INV_ITEM_BARCODE';
      qryForSale.ParamByName('FIND').AsString := '%' + UpperCase(F) + '%';
    end;
  qryForSale.Filtered := False;
  qryForSale.Open;

  if qryForSale.FindField('UNIT_COST') is TNumericField then
    TNumericField(qryForSale.FieldByName('UNIT_COST')).DisplayFormat := '$,0.00';
  if qryForSale.FindField('UNIT_PRICE') is TNumericField then
    TNumericField(qryForSale.FieldByName('UNIT_PRICE')).DisplayFormat := '$,0.00';

  ApplyInSaleFilter(LocateItemNo);
end;

procedure TfrmSellItems.RefreshForSale;
begin
  OpenForSale(edFind.Text);
end;

procedure TfrmSellItems.qryForSaleFilterInSale(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := not FTicket.Contains(qryForSale.FieldByName('INV_ITEM_NO').AsInteger);
end;

{ What the list shows after the sale changed: an item added to the sale
  leaves it, one taken back out returns and is selected (LocateItemNo);
  otherwise the cursor stays near where it was. Nothing is written yet. }
procedure TfrmSellItems.ApplyInSaleFilter(LocateItemNo: integer);
var
  OldRecNo: integer;
begin
  if not qryForSale.Active then
    exit;

  OldRecNo := qryForSale.RecNo;
  qryForSale.DisableControls;
  try
    qryForSale.Filtered := False;
    qryForSale.Filtered := FTicket.HasOpenItems;

    if (LocateItemNo = 0) or not qryForSale.Locate('INV_ITEM_NO', LocateItemNo, []) then
      if (OldRecNo > 0) and not qryForSale.IsEmpty then
        if OldRecNo <= qryForSale.RecordCount then
          qryForSale.RecNo := OldRecNo
        else
          qryForSale.Last;
  finally
    qryForSale.EnableControls;
  end;
  lblForSaleCount.Caption := Format('%d item(s) For Sale', [qryForSale.RecordCount]);
  UpdateSaleButtons;
end;

{ ---- finding / adding ----------------------------------------------------- }

procedure TfrmSellItems.edFindKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      btnFindClick(Sender);
    end;
end;

{ A scanned (or typed) exact barcode goes straight into this sale; anything
  else narrows the For Sale list. }
procedure TfrmSellItems.btnFindClick(Sender: TObject);
var
  Code: string;
  ItemNo: Variant;
  StatusDesc: string;
begin
  Code := Trim(edFind.Text);

  if Code <> '' then
    begin
      ItemNo := DM.ConnFB.ExecSQLScalar(
        'SELECT FIRST 1 INV_ITEM_NO FROM INVENTORY_ITEMS WHERE UPPER(INV_ITEM_BARCODE) = :CODE',
        [UpperCase(Code)]);
      if not VarIsNull(ItemNo) then
        begin
          if FTicket.Completed then
            PawnInfo('This sale is already completed. Press New Sale / Clear to start the next one.',
                     'Sell Items', Self)
          else if AddItemToSale(ItemNo) then
            begin
              edFind.Text := '';
              OpenForSale('');
            end
          else
            begin
              StatusDesc := VarToStr(DM.ConnFB.ExecSQLScalar(
                'SELECT COALESCE(ist.STATUS_DESC, ii.INV_ITEM_STATUS) FROM INVENTORY_ITEMS ii ' +
                'LEFT JOIN ITEM_STATUS ist ON ii.INV_ITEM_STATUS = ist.STATUS ' +
                'WHERE ii.INV_ITEM_NO = :N', [ItemNo]));
              PawnInfo(Format('Item %s is not For Sale (status: %s).', [Code, StatusDesc]), 'Sell Items', Self);
            end;
          edFind.SetFocus;
          edFind.SelectAll;
          exit;
        end;
    end;

  OpenForSale(Code);
  edFind.SetFocus;
  edFind.SelectAll;
end;

function TfrmSellItems.AddItemToSale(InvItemNo: integer): boolean;
begin
  if FTicket.Contains(InvItemNo) then
    begin
      clnSale.Locate('INV_ITEM_NO', InvItemNo, []);
      exit(True);   // already in this sale
    end;

  // Look it up in the full For Sale list, not just the narrowed view.
  if not qryForSale.Locate('INV_ITEM_NO', InvItemNo, []) then
    begin
      OpenForSale('');
      if not qryForSale.Locate('INV_ITEM_NO', InvItemNo, []) then
        exit(False);
    end;

  Result := AddCurrentForSaleItem;
end;

function TfrmSellItems.AddCurrentForSaleItem: boolean;
begin
  Result := False;
  if not qryForSale.Active or qryForSale.IsEmpty then
    exit;

  Result := FTicket.AddItem(
    qryForSale.FieldByName('INV_ITEM_NO').AsInteger,
    qryForSale.FieldByName('INV_ITEM_BARCODE').AsString,
    qryForSale.FieldByName('INV_ITEM_COUNT').AsInteger,
    TSaleTicket.ItemDescription(qryForSale.FieldByName('DESCRIPTION').AsString,
                                qryForSale.FieldByName('J_METAL_DESC').AsString,
                                qryForSale.FieldByName('J_TYPE_DESC').AsString),
    qryForSale.FieldByName('UNIT_COST').AsVariant,
    qryForSale.FieldByName('UNIT_PRICE').AsVariant);

  // The item moves: out of the list, into the sale.
  if Result then
    ApplyInSaleFilter;
end;

procedure TfrmSellItems.btnAddToSaleClick(Sender: TObject);
begin
  if FTicket.Completed then
    PawnInfo('This sale is already completed. Press New Sale / Clear to start the next one.',
             'Sell Items', Self)
  else if not AddCurrentForSaleItem then
    PawnInfo('Please select an item from the For Sale list.', 'Sell Items', Self);
end;

procedure TfrmSellItems.gridForSaleDblClick(Sender: TObject);
begin
  if not FTicket.Completed then
    AddCurrentForSaleItem;
end;

// Takes the selected line out of this sale; its item returns to the list.
procedure TfrmSellItems.btnRemoveFromSaleClick(Sender: TObject);
begin
  FTicket.RemoveCurrent;
end;

{ ---- prices and totals ---------------------------------------------------- }

{ Enter saves the typed price (TDBGrid would only post on a row change). Queued
  so the grid first writes the editor's text into the field. }
procedure TfrmSellItems.gridSaleKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    PostMessage(Handle, WM_POST_SALE_EDIT, 0, 0);
end;

procedure TfrmSellItems.WMPostSaleEdit(var Msg: TMessage);
begin
  PostSaleEdit;
end;

// Leaving the grid (e.g. clicking the discount) also saves a price being typed.
procedure TfrmSellItems.gridSaleExit(Sender: TObject);
begin
  if gridSale.EditorMode then
    gridSale.EditorMode := False;
  PostSaleEdit;
end;

procedure TfrmSellItems.PostSaleEdit;
var
  Err: string;
begin
  if not FTicket.PostPendingEdit(Err) then
    PawnWarn(Err, 'Sell Items', Self);
end;

// A price posted, a line added or removed: totals, and a removed item goes
// back into the list, selected.
procedure TfrmSellItems.SaleChanged(Sender: TObject);
var
  Removed: integer;
begin
  RecalcTotals;
  Removed := FTicket.TakeRemovedItemNo;
  if Removed <> 0 then
    ApplyInSaleFilter(Removed);
end;

procedure TfrmSellItems.DiscountChange(Sender: TObject);
begin
  RecalcTotals;
end;

{ Totals (rules in TSaleTicket.Totals). An out-of-range discount shows in red. }
procedure TfrmSellItems.RecalcTotals;
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
  UpdateSaleButtons;
end;

{ ---- complete / new sale -------------------------------------------------- }

{ Saves the ticket. The screen then stays on it, locked, with its receipt
  number, until New Sale / Clear. No receipt is printed yet (see
  btnPrintSalesReceiptClick). }
procedure TfrmSellItems.btnCompleteSaleClick(Sender: TObject);
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
        RecalcTotals;
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

  RecalcTotals;
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
          RefreshForSale;
          exit;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  RefreshClientsAfterItemChange;
  // An open Items screen shows these items: keep it in step.
  if (frmInventory <> nil) and frmInventory.qryInvItems.Active then
    frmInventory.btnSearchClick(nil);
  // The other Sell Items copy (toolbar vs. the Items screen's) too.
  if frmSellItems <> Self then
    RefreshSellItemsScreen;

  UpdateSaleLock;
  RefreshForSale;
end;

{ Clears the completed ticket off the screen for the next customer. The
  ticket itself is saved; this only empties the screen. }
procedure TfrmSellItems.btnNewSaleClick(Sender: TObject);
begin
  FTicket.Clear;
  edDiscount.Value := 0;
  cbDiscountType.ItemIndex := 0;
  edSoldDate.Date := Date;
  edFind.Clear;
  OpenForSale('');
  UpdateSaleLock;
  edFind.SetFocus;
end;

{ Locks the screen on a saved ticket or opens it for a new sale, as
  FTicket.Completed says: while locked nothing can be added, removed or
  re-priced, and only New Sale / Clear (and Close) work. }
procedure TfrmSellItems.UpdateSaleLock;
var
  Locked: boolean;
begin
  Locked := FTicket.Completed;
  if Locked then
    lblRcptNo.Caption := Format('Receipt No. %d', [FTicket.TicketNo])
  else
    lblRcptNo.Caption := '';

  btnNewSale.Enabled := Locked;
  gridSale.ReadOnly := Locked;
  edDiscount.Enabled := not Locked;
  cbDiscountType.Enabled := not Locked;
  edSoldDate.Enabled := not Locked;

  RecalcTotals;   // also the add / remove / print buttons
end;

{ The buttons that depend on the list's selection and the sale's lines. Add
  (both buttons): an item selected in the list and the sale still open.
  Remove (both): a line to remove and the sale still open. Print: only on a
  completed ticket (a reprint when the receipt did not come out right). }
procedure TfrmSellItems.UpdateSaleButtons;
var
  CanAdd, CanRemove: boolean;
begin
  if FTicket = nil then
    exit;   // the list's OnDataChange while the form is still loading

  CanAdd := not FTicket.Completed and qryForSale.Active and not qryForSale.IsEmpty;
  CanRemove := not FTicket.Completed and (FTicket.Count > 0);

  btnAddToSale.Enabled := CanAdd;
  btnSaleItem.Enabled := CanAdd;
  btnRemoveFromSale.Enabled := CanRemove;
  btnBackToStock.Enabled := CanRemove;
  btnPrintSalesReceipt.Enabled := FTicket.Completed;

  // VCL still shows hints on a disabled button, so say why it is greyed out.
  if FTicket.Completed then
    btnSaleItem.Hint := 'This sale is completed - press New Sale / Clear first'
  else if CanAdd then
    btnSaleItem.Hint := 'Add the selected item to this sale'
  else
    btnSaleItem.Hint := 'Select an item in the For Sale list to add it to this sale';
end;

procedure TfrmSellItems.dsForSaleDataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then   // a row move or a reopen, not a single field change
    UpdateSaleButtons;
end;

{ No drawer on this screen (the sale is always shown): the strip's top button
  takes you to the sale's lines instead. }
procedure TfrmSellItems.btnToggleSaleClick(Sender: TObject);
begin
  if gridSale.CanFocus then
    gridSale.SetFocus;
end;

{ Prints the completed ticket's receipt again (out of paper, paper jam).
  The 80 mm sales receipt is not built yet (Docs/ThermalReceipts_Plan.md,
  receipt 6): when it is, Complete Sale prints it automatically and this
  button calls the same routine with FTicket.TicketNo. }
procedure TfrmSellItems.btnPrintSalesReceiptClick(Sender: TObject);
begin
  if not FTicket.Completed then
    exit;
  PawnInfo(Format('Printing the receipt for sale No. %d is not available yet.',
                  [FTicket.TicketNo]), 'Print Sales Receipt', Self);
end;

end.
