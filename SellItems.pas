unit SellItems;

{ Temporary "Sell Items" screen -- moves For Sale items to Sold until the POS
  exists. Cash sale, no customer, no receipt yet (a 3" receipt comes later).

  Left: every item currently For Sale (INV_ITEM_STATUS 'S', not sold), from
  purchases and defaulted pawns, narrowed by barcode / description.
  Right: the items of this sale, with an editable Sale Price that starts from
  UNIT_PRICE (discounts). Tax is the store's SALES_TAX_PERC, shown only.

  Complete Sale -> TDM.CompleteSale: all or nothing, saved as a numbered sale
  ticket (SALES / SALE_LINES), same as the Inventory sale drawer. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Data.DB, System.UITypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RzButton, RzEdit;

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
    gbThisSale: TGroupBox;
    gridSale: TDBGrid;
    pnSaleButtons: TPanel;
    btnRemoveFromSale: TRzBitBtn;
    lblPriceHint: TLabel;
    gbTotals: TGroupBox;
    lblSoldDate: TLabel;
    edSoldDate: TRzDateTimeEdit;
    lblSubtotalCaption: TLabel;
    lblSubtotal: TLabel;
    lblTaxCaption: TLabel;
    lblTax: TLabel;
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    btnCompleteSale: TRzBitBtn;
    btnClose: TBitBtn;
    qryForSale: TFDQuery;
    dsForSale: TDataSource;
    clnSale: TFDMemTable;
    dsSale: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure edFindKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddToSaleClick(Sender: TObject);
    procedure gridForSaleDblClick(Sender: TObject);
    procedure btnRemoveFromSaleClick(Sender: TObject);
    procedure btnCompleteSaleClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure clnSaleAfterChange(DataSet: TDataSet);
    procedure clnSaleBeforeInsert(DataSet: TDataSet);
  private
    FTaxPerc: Currency;
    FAdding: boolean;   // only AddCurrentForSaleItem may insert rows
    procedure CreateSaleTable;
    procedure OpenForSale(const AFind: string);
    function AddCurrentForSaleItem: boolean;
    procedure RecalcTotals;
  public
    { Adds one item to this sale before the screen is shown (Active Items List
      passes its selected item). False when that item is not For Sale. }
    function AddItemToSale(InvItemNo: integer): boolean;
  end;

var
  frmSellItems: TfrmSellItems;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, uPawnDialogs, SearchClient;

const
  ForSaleSQL =
    'SELECT ii.INV_ITEM_NO, ii.INV_ITEM_BARCODE, ii.INV_ITEM_COUNT, ii.DESCRIPTION, ' +
    '       jt.J_TYPE_DESC, jm.J_METAL_DESC, ii.KT, ii.WEIGHT, ii.WEIGHT_UNIT, ' +
    '       ii.UNIT_COST, ii.UNIT_PRICE ' +
    'FROM INVENTORY_ITEMS ii ' +
    'LEFT JOIN J_TYPES jt ON ii.J_TYPE = jt.J_TYPE ' +
    'LEFT JOIN J_METALS jm ON ii.J_METAL = jm.J_METAL ' +
    'WHERE ii.INV_ITEM_STATUS = ''S'' AND ii.SOLD_DATE IS NULL ';

{ ---- setup ---------------------------------------------------------------- }

procedure TfrmSellItems.FormCreate(Sender: TObject);
begin
  CreateSaleTable;
  edSoldDate.Date := Date;
  FTaxPerc := DM.qryStoreSALES_TAX_PERC.AsCurrency;
  lblTaxCaption.Caption := Format('Tax (%s%%):', [FormatFloat('0.##', FTaxPerc)]);
  OpenForSale('');
  RecalcTotals;
end;

procedure TfrmSellItems.FormShow(Sender: TObject);
begin
  edFind.SetFocus;
end;

procedure TfrmSellItems.CreateSaleTable;
begin
  clnSale.Close;
  clnSale.FieldDefs.Clear;
  clnSale.FieldDefs.Add('INV_ITEM_NO', ftInteger);
  clnSale.FieldDefs.Add('INV_ITEM_BARCODE', ftWideString, 30);
  clnSale.FieldDefs.Add('INV_ITEM_COUNT', ftInteger);
  clnSale.FieldDefs.Add('DESCRIPTION', ftWideString, 250);
  clnSale.FieldDefs.Add('UNIT_COST', ftCurrency);
  clnSale.FieldDefs.Add('SALE_PRICE', ftCurrency);
  clnSale.CreateDataSet;

  // Only Sale Price is editable: the other grid columns are ReadOnly in the
  // DFM (TField.ReadOnly would also block Append from filling them).
  clnSale.FieldByName('INV_ITEM_NO').Visible := False;
  TCurrencyField(clnSale.FieldByName('UNIT_COST')).DisplayFormat := '$,0.00';
  TCurrencyField(clnSale.FieldByName('SALE_PRICE')).DisplayFormat := '$,0.00';
end;

procedure TfrmSellItems.OpenForSale(const AFind: string);
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
  qryForSale.Open;

  if qryForSale.FindField('UNIT_COST') is TNumericField then
    TNumericField(qryForSale.FieldByName('UNIT_COST')).DisplayFormat := '$,0.00';
  if qryForSale.FindField('UNIT_PRICE') is TNumericField then
    TNumericField(qryForSale.FieldByName('UNIT_PRICE')).DisplayFormat := '$,0.00';

  lblForSaleCount.Caption := Format('%d item(s) For Sale', [qryForSale.RecordCount]);
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
          if AddItemToSale(ItemNo) then
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
              edFind.SelectAll;
            end;
          edFind.SetFocus;
          exit;
        end;
    end;

  OpenForSale(Code);
  edFind.SetFocus;
  edFind.SelectAll;
end;

function TfrmSellItems.AddItemToSale(InvItemNo: integer): boolean;
begin
  Result := False;
  if clnSale.Locate('INV_ITEM_NO', InvItemNo, []) then
    exit(True);   // already in this sale

  // Look it up in the full For Sale list, not just the filtered view.
  if not qryForSale.Locate('INV_ITEM_NO', InvItemNo, []) then
    begin
      OpenForSale('');
      if not qryForSale.Locate('INV_ITEM_NO', InvItemNo, []) then
        exit;
    end;

  Result := AddCurrentForSaleItem;
end;

function TfrmSellItems.AddCurrentForSaleItem: boolean;
var
  Desc: string;
begin
  Result := False;
  if not qryForSale.Active or qryForSale.IsEmpty then
    exit;

  if clnSale.Locate('INV_ITEM_NO', qryForSale.FieldByName('INV_ITEM_NO').AsInteger, []) then
    exit(True);

  Desc := Trim(qryForSale.FieldByName('DESCRIPTION').AsString);
  if Desc = '' then
    Desc := Trim(qryForSale.FieldByName('J_METAL_DESC').AsString + ' ' +
                 qryForSale.FieldByName('J_TYPE_DESC').AsString);

  FAdding := True;
  try
    clnSale.Append;
    clnSale.FieldByName('INV_ITEM_NO').AsInteger := qryForSale.FieldByName('INV_ITEM_NO').AsInteger;
    clnSale.FieldByName('INV_ITEM_BARCODE').AsString := qryForSale.FieldByName('INV_ITEM_BARCODE').AsString;
    clnSale.FieldByName('INV_ITEM_COUNT').AsInteger := qryForSale.FieldByName('INV_ITEM_COUNT').AsInteger;
    clnSale.FieldByName('DESCRIPTION').AsString := Desc;
    if not qryForSale.FieldByName('UNIT_COST').IsNull then
      clnSale.FieldByName('UNIT_COST').AsCurrency := qryForSale.FieldByName('UNIT_COST').AsCurrency;
    if not qryForSale.FieldByName('UNIT_PRICE').IsNull then
      clnSale.FieldByName('SALE_PRICE').AsCurrency := qryForSale.FieldByName('UNIT_PRICE').AsCurrency;
    clnSale.Post;
  finally
    FAdding := False;
  end;

  Result := True;
end;

procedure TfrmSellItems.btnAddToSaleClick(Sender: TObject);
begin
  if not AddCurrentForSaleItem then
    PawnInfo('Please select an item from the For Sale list.', 'Sell Items', Self);
end;

procedure TfrmSellItems.gridForSaleDblClick(Sender: TObject);
begin
  AddCurrentForSaleItem;
end;

procedure TfrmSellItems.btnRemoveFromSaleClick(Sender: TObject);
begin
  if not clnSale.IsEmpty then
    clnSale.Delete;
end;

{ ---- totals --------------------------------------------------------------- }

{ The grid is editable for Sale Price only; arrowing past the last row must not
  create an empty sale line. }
procedure TfrmSellItems.clnSaleBeforeInsert(DataSet: TDataSet);
begin
  if not FAdding then
    Abort;
end;

procedure TfrmSellItems.clnSaleAfterChange(DataSet: TDataSet);
begin
  RecalcTotals;
end;

procedure TfrmSellItems.RecalcTotals;
var
  Subtotal, Tax, Total: Currency;
  BM: TBookmark;
begin
  Subtotal := 0;
  if clnSale.Active then
    begin
      BM := clnSale.GetBookmark;
      clnSale.DisableControls;
      try
        clnSale.First;
        while not clnSale.Eof do
          begin
            Subtotal := Subtotal + clnSale.FieldByName('SALE_PRICE').AsCurrency;
            clnSale.Next;
          end;
        if clnSale.BookmarkValid(BM) then
          clnSale.GotoBookmark(BM);
      finally
        clnSale.FreeBookmark(BM);
        clnSale.EnableControls;
      end;
    end;

  CalcTaxAndTotal(Subtotal, FTaxPerc, Tax, Total);
  lblSubtotal.Caption := FormatCurr('$,0.00', Subtotal);
  lblTax.Caption := FormatCurr('$,0.00', Tax);
  lblTotal.Caption := FormatCurr('$,0.00', Total);
  btnCompleteSale.Enabled := clnSale.Active and not clnSale.IsEmpty;
end;

{ ---- complete ------------------------------------------------------------- }

procedure TfrmSellItems.btnCompleteSaleClick(Sender: TObject);
var
  Lines: TArray<TSaleLine>;
  i, TicketNo: integer;
begin
  if clnSale.State in dsEditModes then
    clnSale.Post;

  if clnSale.IsEmpty then
    exit;

  // Every item needs a real price.
  clnSale.First;
  while not clnSale.Eof do
    begin
      if clnSale.FieldByName('SALE_PRICE').AsCurrency <= 0 then
        begin
          PawnInfo(Format('Please enter a sale price for item %s.',
                          [clnSale.FieldByName('INV_ITEM_BARCODE').AsString]), 'Sell Items', Self);
          gridSale.SetFocus;
          gridSale.SelectedField := clnSale.FieldByName('SALE_PRICE');
          exit;
        end;
      clnSale.Next;
    end;

  if not PawnConfirm(Format('Sell %d item(s) for %s (tax included)?',
                            [clnSale.RecordCount, lblTotal.Caption]), 'Complete Sale', Self) then
    exit;

  SetLength(Lines, clnSale.RecordCount);
  i := 0;
  clnSale.First;
  while not clnSale.Eof do
    begin
      Lines[i].InvItemNo := clnSale.FieldByName('INV_ITEM_NO').AsInteger;
      Lines[i].Description := clnSale.FieldByName('DESCRIPTION').AsString;
      Lines[i].SalePrice := clnSale.FieldByName('SALE_PRICE').AsCurrency;
      Inc(i);
      clnSale.Next;
    end;

  Screen.Cursor := crHourGlass;
  try
    try
      // No whole-sale discount on this screen: discounts are typed per item.
      TicketNo := DM.CompleteSale(Lines, edSoldDate.Date, False, 0, FTaxPerc);
      RefreshClientsAfterItemChange;
    except
      on E: Exception do
        begin
          Screen.Cursor := crDefault;
          PawnWarn(E.Message, 'Complete Sale', Self);
          OpenForSale(edFind.Text);
          exit;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  PawnInfo(Format('Sale completed. Ticket #%d.', [TicketNo]), 'Complete Sale', Self);
  ModalResult := mrOk;
end;

procedure TfrmSellItems.btnCloseClick(Sender: TObject);
begin
  if not clnSale.IsEmpty and
     not PawnConfirm('Close without completing this sale?', 'Sell Items', Self) then
    exit;
  ModalResult := mrCancel;
end;

end.
