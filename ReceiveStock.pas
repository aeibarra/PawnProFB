unit ReceiveStock;

{ Receive Stock: stock bought from a supplier (wholesaler), entered against the
  supplier's invoice. Its items go straight to For Sale. Schema v15:
    STOCK_RECEIPTS        one per supplier invoice   -> the Receipts grid
    STOCK_RECEIPT_LINES   one per item received      -> the Items grid
    SUPPLIERS             picked or typed in the receipt pop-up
  Received items are ordinary INVENTORY_ITEMS rows: status 'S', PURCHASE_DATE /
  FORSALE_DATE = the received date, and NO transaction -- so they never reach a
  police export or a pawn list.

  Same pattern as the Search Customer screen: a grid with New / Edit buttons,
  and every add or edit done in a pop-up where Save writes and Cancel leaves
  everything as it was.
    Receipts: TfrmEditStockReceipt (EditStockReceipt.pas).
    Items:    the item form of pawns and purchases (TfrmEnterItems, in
              ReceiveStockMode). One row per piece: "Copies" makes that many
              more identical items, each with its own barcode. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Data.DB, RzEdit, RzButton, RzForms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmReceiveStock = class(TForm)
    gbReceipts: TGroupBox;
    pnReceiptButtons: TPanel;
    btnNewR: TBitBtn;
    btnEditR: TBitBtn;
    btnVoidR: TBitBtn;
    dbgReceipts: TDBGrid;
    Splitter1: TSplitter;
    gbItems: TGroupBox;
    pnItemButtons: TPanel;
    btnAddItem: TBitBtn;
    lblCopies: TLabel;
    edCopies: TRzNumericEdit;
    btnEditItem: TBitBtn;
    btnRemoveItem: TBitBtn;
    lblTotals: TLabel;
    dbgItems: TDBGrid;
    pnBottom: TPanel;
    btnClose: TBitBtn;
    qryReceipts: TFDQuery;
    dsReceipts: TDataSource;
    qryLines: TFDQuery;
    dsLines: TDataSource;
    qryItem: TFDQuery;
    FormState: TRzFormState;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnNewRClick(Sender: TObject);
    procedure btnEditRClick(Sender: TObject);
    procedure btnVoidRClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnEditItemClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure qryReceiptsAfterScroll(DataSet: TDataSet);
    procedure dsLinesDataChange(Sender: TObject; Field: TField);
    procedure qryItemNewRecord(DataSet: TDataSet);
    procedure qryItemAfterPost(DataSet: TDataSet);
    procedure dbgReceiptsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure RefreshReceipts(LocateReceiptNo: integer = 0);
    procedure RefreshLines(LocateItemNo: integer = 0);
    procedure UpdateState;
    function CurrentReceiptNo: integer;
    function CurrentReceiptVoided: boolean;
    function SelectedItemNo: integer;
    function EditItem(InvItemNo: integer; GroupSize: integer; out ApplyToGroup: boolean): boolean;
    procedure RefreshItemsScreen;
  end;

var
  frmReceiveStock: TfrmReceiveStock;

implementation

{$R *.dfm}

uses System.DateUtils, System.StrUtils, PawnDM, PawnGlobal, Entertems, EditStockReceipt, uPawnDialogs,
  Inventory;

const
  // Items and their cost count only the items still there: a deleted item keeps
  // its line (the record of what came in) but is no longer stock.
  ReceiptsSQL =
    'SELECT r.STOCK_RECEIPT_NO, r.RECEIVED_DATE, s.SUPPLIER_NAME, r.INVOICE_NO, ' +
    '       r.INVOICE_DATE, r.INVOICE_TOTAL, ' +
    '       (SELECT COUNT(*) FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
    '         WHERE l.STOCK_RECEIPT_NO = r.STOCK_RECEIPT_NO) AS ITEMS, ' +
    '       (SELECT COALESCE(SUM(l.UNIT_COST), 0) FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
    '         WHERE l.STOCK_RECEIPT_NO = r.STOCK_RECEIPT_NO) AS ITEMS_COST, ' +
    '       p.PAYMENT_TYPE AS PAY_TYPE, r.RECEIPT_STATUS, ' +
    '       IIF(r.RECEIPT_STATUS = ''V'', ''Voided'', '''') AS STATUS ' +
    'FROM STOCK_RECEIPTS r ' +
    'JOIN SUPPLIERS s ON s.SUPPLIER_NO = r.SUPPLIER_NO ' +
    'LEFT JOIN PAYMENT_TYPES p ON p.PAY_TYPE_NO = r.PAY_TYPE_NO ' +
    'ORDER BY r.STOCK_RECEIPT_NO DESC';

  LinesSQL =
    'SELECT l.STOCK_RECEIPT_LINE_NO, l.INV_ITEM_NO, l.COPY_GROUP, ' +
    // Piece 1..N within its copy group (blank for a single piece).
    '       IIF(l.COPY_GROUP IS NULL, NULL, ' +
    '           ROW_NUMBER() OVER (PARTITION BY l.COPY_GROUP ORDER BY l.STOCK_RECEIPT_LINE_NO)) AS PIECE_NO, ' +
    '       COALESCE(i.INV_ITEM_BARCODE, ''(deleted)'') AS BARCODE, ' +
    '       l.DESCRIPTION, c.INV_CATEGORY AS CATEGORY, i.KT, i.WEIGHT, ' +
    '       l.UNIT_COST, l.UNIT_PRICE, ' +
    // Status in words from the status letter itself, the same labels as the
    // Items screen (InvItemStatusLabel) -- not from the ITEM_STATUS table, which
    // in pumped stores only has some of the letters.
    '       CASE WHEN i.INV_ITEM_NO IS NULL THEN ''Deleted'' ' +
    '            WHEN i.INV_ITEM_STATUS = ''S'' THEN ''' + PawnItemStatus_ForSale + ''' ' +
    '            WHEN i.INV_ITEM_STATUS = ''D'' THEN ''' + PawnItemStatus_Sold + ''' ' +
    '            WHEN i.INV_ITEM_STATUS = ''L'' THEN ''' + PawnItemStatus_Layaway + ''' ' +
    '            WHEN i.INV_ITEM_STATUS = ''P'' THEN ''' + PawnItemStatus_Pawned + ''' ' +
    '            WHEN i.INV_ITEM_STATUS = ''R'' THEN ''' + PawnItemStatus_Redeemed + ''' ' +
    '            WHEN i.INV_ITEM_STATUS = ''C'' THEN ''' + PawnItemStatus_Melted + ''' ' +
    '            ELSE i.INV_ITEM_STATUS END AS STATUS, ' +
    '       IIF(i.INV_ITEM_NO IS NULL, 0, 1) AS ITEM_EXISTS ' +
    'FROM STOCK_RECEIPT_LINES l ' +
    'LEFT JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
    'LEFT JOIN INV_CATEGORIES c ON c.INV_CAT_NO = i.INV_CAT_NO ' +
    'WHERE l.STOCK_RECEIPT_NO = :R ' +
    // A copy group always stays together, where its first piece was entered.
    'ORDER BY COALESCE((SELECT MIN(l2.STOCK_RECEIPT_LINE_NO) FROM STOCK_RECEIPT_LINES l2 ' +
    '                   WHERE l2.STOCK_RECEIPT_NO = l.STOCK_RECEIPT_NO AND l2.COPY_GROUP = l.COPY_GROUP), ' +
    '                  l.STOCK_RECEIPT_LINE_NO), l.STOCK_RECEIPT_LINE_NO';

  // Soft backgrounds for the Group column, one per group (cycling).
  GroupColors: array[0..5] of TColor =
    ($00D8F0FF, $00D8FFD8, $00FFE8D0, $00F0D8FF, $00D0F8F8, $00E0E0FF);

procedure TfrmReceiveStock.FormCreate(Sender: TObject);
begin
  qryReceipts.SQL.Text := ReceiptsSQL;
  qryLines.SQL.Text := LinesSQL;
  qryItem.SQL.Text := 'SELECT * FROM INVENTORY_ITEMS WHERE INV_ITEM_NO = :N';
  RefreshReceipts;
end;

{ Modeless, like Search Customer and the Items screen: the main menu opens it
  once (or brings it to the front), and it frees itself when closed. }
procedure TfrmReceiveStock.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmReceiveStock.FormDestroy(Sender: TObject);
begin
  if frmReceiveStock = Self then
    frmReceiveStock := nil;
end;

procedure TfrmReceiveStock.btnCloseClick(Sender: TObject);
begin
  Close;
end;

{ An open Items screen shows stock: keep it in step with what was received. }
procedure TfrmReceiveStock.RefreshItemsScreen;
begin
  if (frmInventory <> nil) and frmInventory.qryInvItems.Active then
    frmInventory.btnSearchClick(nil);
end;

// F7 / F8: new / edit receipt, as the hints on the buttons say.
procedure TfrmReceiveStock.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F7: begin btnNewRClick(nil);  Key := 0; end;
    VK_F8: begin btnEditRClick(nil); Key := 0; end;
  end;
end;

{ ---- receipts --------------------------------------------------------------- }

procedure TfrmReceiveStock.RefreshReceipts(LocateReceiptNo: integer);
begin
  qryReceipts.DisableControls;
  try
    qryReceipts.Close;
    qryReceipts.Open;
    TDateField(qryReceipts.FieldByName('RECEIVED_DATE')).DisplayFormat := 'mm/dd/yyyy';
    TDateField(qryReceipts.FieldByName('INVOICE_DATE')).DisplayFormat := 'mm/dd/yyyy';
    TNumericField(qryReceipts.FieldByName('INVOICE_TOTAL')).DisplayFormat := '$,0.00';
    TNumericField(qryReceipts.FieldByName('ITEMS_COST')).DisplayFormat := '$,0.00';
    if LocateReceiptNo > 0 then
      qryReceipts.Locate('STOCK_RECEIPT_NO', LocateReceiptNo, []);
  finally
    qryReceipts.EnableControls;
  end;
  RefreshLines;
end;

function TfrmReceiveStock.CurrentReceiptNo: integer;
begin
  Result := 0;
  if qryReceipts.Active and not qryReceipts.IsEmpty then
    Result := qryReceipts.FieldByName('STOCK_RECEIPT_NO').AsInteger;
end;

function TfrmReceiveStock.CurrentReceiptVoided: boolean;
begin
  Result := (CurrentReceiptNo > 0) and (qryReceipts.FieldByName('RECEIPT_STATUS').AsString = 'V');
end;

procedure TfrmReceiveStock.qryReceiptsAfterScroll(DataSet: TDataSet);
begin
  // Skipped while RefreshReceipts reopens and locates: it refreshes once at the end.
  if not qryReceipts.ControlsDisabled then
    RefreshLines;
end;

procedure TfrmReceiveStock.btnNewRClick(Sender: TObject);
var
  N: integer;
begin
  N := 0;
  if TfrmEditStockReceipt.Execute(Self, N) then
    RefreshReceipts(N);
end;

procedure TfrmReceiveStock.btnEditRClick(Sender: TObject);
var
  N: integer;
begin
  N := CurrentReceiptNo;
  if N = 0 then
    exit;
  if CurrentReceiptVoided then
    begin
      PawnInfo('This receipt is voided and cannot be changed.', 'Receive Stock', Self);
      exit;
    end;
  if TfrmEditStockReceipt.Execute(Self, N) then
    RefreshReceipts(N);
end;

procedure TfrmReceiveStock.btnVoidRClick(Sender: TObject);
var
  N: integer;
  Reason: string;
begin
  N := CurrentReceiptNo;
  if (N = 0) or CurrentReceiptVoided then
    exit;
  if not PawnConfirm(Format('Void receipt # %d?' + sLineBreak +
                            'All its items are deleted (kept in the deleted records log). ' +
                            'The receipt stays, marked Voided.', [N]), 'Void Receipt', Self) then
    exit;

  Reason := '';
  repeat
    if not PawnPrompt('Reason for voiding (required):', 'Void Receipt', Reason, Self) then
      exit;
    Reason := Trim(Reason);
  until Reason <> '';

  try
    DM.VoidStockReceipt(N, Reason);
  except
    on E: Exception do
      PawnWarn(E.Message, 'Void Receipt', Self);
  end;
  RefreshReceipts(N);
  RefreshItemsScreen;
end;

{ Voided receipts read grey; a receipt whose items do not add up to its
  invoice total shows that cost in red (a warning only: invoices carry
  shipping, rounding...). }
procedure TfrmReceiveStock.dbgReceiptsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if qryReceipts.Active and not qryReceipts.IsEmpty and not (gdSelected in State) then
    begin
      if qryReceipts.FieldByName('RECEIPT_STATUS').AsString = 'V' then
        dbgReceipts.Canvas.Font.Color := clGrayText
      else if (Column.FieldName = 'ITEMS_COST') and
              not qryReceipts.FieldByName('INVOICE_TOTAL').IsNull and
              (qryReceipts.FieldByName('ITEMS_COST').AsCurrency <>
               qryReceipts.FieldByName('INVOICE_TOTAL').AsCurrency) then
        dbgReceipts.Canvas.Font.Color := clRed;
    end;
  dbgReceipts.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

{ ---- items of the selected receipt ----------------------------------------- }

procedure TfrmReceiveStock.RefreshLines(LocateItemNo: integer);
begin
  qryLines.DisableControls;
  try
    qryLines.Close;
    qryLines.ParamByName('R').AsInteger := CurrentReceiptNo;
    qryLines.Open;
    TNumericField(qryLines.FieldByName('UNIT_COST')).DisplayFormat := '$,0.00';
    TNumericField(qryLines.FieldByName('UNIT_PRICE')).DisplayFormat := '$,0.00';
    if LocateItemNo > 0 then
      qryLines.Locate('INV_ITEM_NO', LocateItemNo, []);
  finally
    qryLines.EnableControls;
  end;
  UpdateState;
end;

// Edit / Remove follow the item selected in the grid.
procedure TfrmReceiveStock.dsLinesDataChange(Sender: TObject; Field: TField);
begin
  if (Field = nil) and not qryLines.ControlsDisabled then
    UpdateState;
end;

function TfrmReceiveStock.SelectedItemNo: integer;
begin
  Result := 0;
  if qryLines.Active and not qryLines.IsEmpty and (qryLines.FieldByName('ITEM_EXISTS').AsInteger = 1) then
    Result := qryLines.FieldByName('INV_ITEM_NO').AsInteger;
end;

{ Buttons, and the totals of the selected receipt: items still on it and their
  cost, against the invoice total (red when they differ). }
procedure TfrmReceiveStock.UpdateState;
var
  HasReceipt, IsOpen: boolean;
  Totals: string;
begin
  HasReceipt := CurrentReceiptNo > 0;
  IsOpen := HasReceipt and not CurrentReceiptVoided;

  btnEditR.Enabled := IsOpen;
  btnVoidR.Enabled := IsOpen;
  btnAddItem.Enabled := IsOpen;
  edCopies.Enabled := IsOpen;
  btnEditItem.Enabled := IsOpen and (SelectedItemNo > 0);
  btnRemoveItem.Enabled := btnEditItem.Enabled;

  if not HasReceipt then
    begin
      gbItems.Caption := ' Items Received ';
      lblTotals.Caption := '';
      exit;
    end;

  gbItems.Caption := Format(' Items Received - Receipt # %d%s ',
                            [CurrentReceiptNo, IfThen(CurrentReceiptVoided, ' (VOIDED)', '')]);
  Totals := Format('Items: %d     Cost: %s',
                   [qryReceipts.FieldByName('ITEMS').AsInteger,
                    FormatCurr('$,0.00', qryReceipts.FieldByName('ITEMS_COST').AsCurrency)]);
  if not qryReceipts.FieldByName('INVOICE_TOTAL').IsNull then
    Totals := Totals + '     Invoice total: ' +
              FormatCurr('$,0.00', qryReceipts.FieldByName('INVOICE_TOTAL').AsCurrency);
  lblTotals.Caption := Totals;
  if not qryReceipts.FieldByName('INVOICE_TOTAL').IsNull and
     (qryReceipts.FieldByName('ITEMS_COST').AsCurrency <> qryReceipts.FieldByName('INVOICE_TOTAL').AsCurrency) then
    lblTotals.Font.Color := clRed
  else
    lblTotals.Font.Color := clWindowText;
end;

{ Opens the item pop-up on InvItemNo, or on a new item (0). Save writes the
  item, Cancel undoes the edit (TfrmEnterItems). True when saved. }
function TfrmReceiveStock.EditItem(InvItemNo: integer; GroupSize: integer;
  out ApplyToGroup: boolean): boolean;
begin
  ApplyToGroup := False;
  qryItem.Close;
  qryItem.ParamByName('N').AsInteger := InvItemNo;   // 0: no row, the pop-up appends one
  qryItem.Open;
  // INV_ITEM_NO is an IDENTITY: fetched with INSERT ... RETURNING on Post.
  qryItem.FieldByName('INV_ITEM_NO').Required := False;
  qryItem.FieldByName('INV_ITEM_NO').AutoGenerateValue := arAutoInc;

  frmEnterItems := TfrmEnterItems.Create(Self);
  try
    frmEnterItems.ReceiveStockMode := True;
    frmEnterItems.NewRow := InvItemNo = 0;
    frmEnterItems.GroupSize := GroupSize;
    frmEnterItems.dsInvItems.DataSet := qryItem;
    Result := frmEnterItems.ShowModal = mrOk;
    ApplyToGroup := Result and frmEnterItems.chkApplyToGroup.Visible and
                    frmEnterItems.chkApplyToGroup.Checked;
  finally
    frmEnterItems.Free;
    frmEnterItems := nil;
  end;
end;

procedure TfrmReceiveStock.qryItemNewRecord(DataSet: TDataSet);
var
  Received: TDateTime;
begin
  Received := DateOf(qryReceipts.FieldByName('RECEIVED_DATE').AsDateTime);
  qryItem.FieldByName('INV_ITEM_STATUS').AsString := TranForSale;   // 'S'
  qryItem.FieldByName('INV_ITEM_COUNT').AsInteger := 1;
  qryItem.FieldByName('WEIGHT_UNIT').AsString := DefaultWeightMeasureUnit;   // STORE default
  qryItem.FieldByName('PURCHASE_DATE').AsDateTime := Received;
  qryItem.FieldByName('FORSALE_DATE').AsDateTime := Received;
  qryItem.FieldByName('TRANSACTION_NO').Clear;   // supplier stock: no transaction
end;

// Same as the client screen: the barcode comes from the new item number.
procedure TfrmReceiveStock.qryItemAfterPost(DataSet: TDataSet);
begin
  if qryItem.FieldByName('INV_ITEM_BARCODE').AsString = '' then
    begin
      qryItem.Edit;
      qryItem.FieldByName('INV_ITEM_BARCODE').AsString :=
        DM.GetBarcode(qryItem.FieldByName('INV_ITEM_NO').AsInteger);
      qryItem.Post;
    end;
end;

procedure TfrmReceiveStock.btnAddItemClick(Sender: TObject);
var
  ReceiptNo, ItemNo, Copies: integer;
  Dummy: boolean;
begin
  ReceiptNo := CurrentReceiptNo;
  if (ReceiptNo = 0) or CurrentReceiptVoided then
    exit;
  if not EditItem(0, 0, Dummy) then
    exit;

  ItemNo := qryItem.FieldByName('INV_ITEM_NO').AsInteger;
  Copies := Round(edCopies.Value);
  try
    DM.SaveStockReceiptLine(ReceiptNo, ItemNo);
    if Copies > 1 then
      DM.CopyStockReceiptItem(ReceiptNo, ItemNo, Copies - 1);
  except
    on E: Exception do
      PawnWarn(E.Message, 'Receive Stock', Self);
  end;
  edCopies.Value := 1;
  RefreshReceipts(ReceiptNo);   // its item count and cost changed
  RefreshLines(ItemNo);
  RefreshItemsScreen;
end;

{ Editing one piece of a copy group: the pop-up's checkbox (checked by
  default) applies the change to the group's other unsold pieces too;
  unchecked, only this piece changes and it stays in its group. }
procedure TfrmReceiveStock.btnEditItemClick(Sender: TObject);
var
  ReceiptNo, ItemNo, Group, Size, UnsoldOthers, Changed: integer;
  ApplyToGroup: boolean;
begin
  ReceiptNo := CurrentReceiptNo;
  ItemNo := SelectedItemNo;
  if (ItemNo = 0) or CurrentReceiptVoided then
    exit;
  if DM.StockReceiptItemIsSold(ItemNo) then
    begin
      PawnInfo('This item is sold or on layaway. Edit it from the Items screen.', 'Receive Stock', Self);
      exit;
    end;
  DM.GetCopyGroupSize(ReceiptNo, ItemNo, Group, Size, UnsoldOthers);
  if not EditItem(ItemNo, Size, ApplyToGroup) then
    exit;
  DM.SaveStockReceiptLine(ReceiptNo, ItemNo);

  if ApplyToGroup then
    try
      Changed := DM.ApplyItemToCopyGroup(ReceiptNo, ItemNo);
      if Changed < Size - 1 then
        PawnInfo(Format('%d other piece(s) of group %d changed. %d sold or on layaway were not changed.',
                        [Changed, Group, Size - 1 - Changed]), 'Receive Stock', Self);
    except
      on E: Exception do
        PawnWarn(E.Message, 'Receive Stock', Self);
    end;

  RefreshReceipts(ReceiptNo);
  RefreshLines(ItemNo);
  RefreshItemsScreen;
end;

procedure TfrmReceiveStock.btnRemoveItemClick(Sender: TObject);
var
  ReceiptNo, ItemNo: integer;
begin
  ReceiptNo := CurrentReceiptNo;
  ItemNo := SelectedItemNo;
  if ItemNo = 0 then
    exit;
  if not PawnConfirm(Format('Remove item %s from this receipt?' + sLineBreak +
                            'The item is deleted (it is kept in the deleted records log).',
                            [qryLines.FieldByName('BARCODE').AsString]), 'Remove Item', Self) then
    exit;
  try
    DM.RemoveStockReceiptItem(ItemNo, 'Removed from stock receipt ' + IntToStr(ReceiptNo));
  except
    on E: Exception do
      PawnWarn(E.Message, 'Remove Item', Self);
  end;
  RefreshReceipts(ReceiptNo);
  RefreshItemsScreen;
end;

{ Deleted items keep their line, greyed: the receipt shows what came in. The
  Group column numbers the pieces added together with "Copies" (1..N) and is
  painted in their group's colour, so each group stands out at a glance. }
procedure TfrmReceiveStock.dbgItemsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  G: integer;
begin
  if qryLines.Active and not qryLines.IsEmpty then
    begin
      if (Column.FieldName = 'PIECE_NO') and not qryLines.FieldByName('COPY_GROUP').IsNull then
        begin
          G := qryLines.FieldByName('COPY_GROUP').AsInteger;
          dbgItems.Canvas.Brush.Color := GroupColors[G mod Length(GroupColors)];
          dbgItems.Canvas.Font.Color := clBlack;
          dbgItems.Canvas.Font.Style := [fsBold];
        end
      else if (qryLines.FieldByName('ITEM_EXISTS').AsInteger = 0) and not (gdSelected in State) then
        dbgItems.Canvas.Font.Color := clGrayText;
    end;
  dbgItems.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
