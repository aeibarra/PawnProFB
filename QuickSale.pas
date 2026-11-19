unit QuickSale;

{ Quick Sale: sells ONE For Sale item straight from the client screen's Items
  tab (right click, "Quick Sale"), without going through the Active Items List
  and its sale drawer.

  The store types the sale price; subtotal, tax (STORE.SALES_TAX_PERC) and
  total follow as it is typed. Complete Sale saves it through TDM.CompleteSale,
  exactly like the drawer: a numbered sale ticket (SALES / SALE_LINES), the item
  set to Sold, all or nothing. No whole-sale discount here -- the sale price
  itself is what was agreed. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, RzEdit, RzButton;

type
  TfrmQuickSale = class(TForm)
    lblItemCaption: TLabel;
    lblItem: TLabel;
    lblAskingCaption: TLabel;
    lblAsking: TLabel;
    lblPriceCaption: TLabel;
    edSalePrice: TRzNumericEdit;
    Bevel1: TBevel;
    lblSubtotalCaption: TLabel;
    lblSubtotal: TLabel;
    lblTaxCaption: TLabel;
    lblTax: TLabel;
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    btnCompleteSale: TRzBitBtn;
    btnCancel: TBitBtn;
    procedure edSalePriceChange(Sender: TObject);
    procedure btnCompleteSaleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FInvItemNo: integer;
    FBarcode: string;
    FDescription: string;
    FTaxPerc: Currency;
    FTotal: Currency;
    function LoadItem(InvItemNo: integer): boolean;
    procedure RecalcTotals;
  public
    // Shows the form for one item. True when the item was sold.
    class function Execute(InvItemNo: integer; AOwner: TComponent): boolean;
  end;

implementation

{$R *.dfm}

uses Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, PawnDM, PawnGlobal, uPawnDialogs;

class function TfrmQuickSale.Execute(InvItemNo: integer; AOwner: TComponent): boolean;
var
  Dlg: TfrmQuickSale;
begin
  Result := False;
  Dlg := TfrmQuickSale.Create(AOwner);
  try
    if not Dlg.LoadItem(InvItemNo) then
      exit;
    Result := Dlg.ShowModal = mrOk;
  finally
    Dlg.Free;
  end;
end;

{ Reads the item and checks it can still be sold: another PC may have sold it
  since the client screen was loaded. }
function TfrmQuickSale.LoadItem(InvItemNo: integer): boolean;
var
  Qry: TFDQuery;
  Asking: Currency;
begin
  Result := False;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DM.ConnFB;
    Qry.SQL.Text :=
      'SELECT ii.INV_ITEM_BARCODE, ii.DESCRIPTION, ii.UNIT_PRICE, ii.INV_ITEM_STATUS, ii.SOLD_DATE, ' +
      '       jm.J_METAL_DESC, jt.J_TYPE_DESC ' +
      'FROM INVENTORY_ITEMS ii ' +
      'LEFT JOIN J_METALS jm ON jm.J_METAL = ii.J_METAL ' +
      'LEFT JOIN J_TYPES jt ON jt.J_TYPE = ii.J_TYPE ' +
      'WHERE ii.INV_ITEM_NO = :INV_ITEM_NO';
    Qry.ParamByName('INV_ITEM_NO').AsInteger := InvItemNo;
    Qry.Open;

    if Qry.IsEmpty then
      begin
        PawnInfo('This item was not found.', 'Quick Sale', TWinControl(Owner));
        exit;
      end;

    if (Qry.FieldByName('INV_ITEM_STATUS').AsString <> 'S') or
       not Qry.FieldByName('SOLD_DATE').IsNull then
      begin
        PawnInfo('This item is no longer For Sale.', 'Quick Sale', TWinControl(Owner));
        exit;
      end;

    FInvItemNo := InvItemNo;
    FBarcode := Qry.FieldByName('INV_ITEM_BARCODE').AsString;
    // Same description rule as the sale drawer: the item's own, else metal + type.
    FDescription := Trim(Qry.FieldByName('DESCRIPTION').AsString);
    if FDescription = '' then
      FDescription := Trim(Qry.FieldByName('J_METAL_DESC').AsString + ' ' +
                           Qry.FieldByName('J_TYPE_DESC').AsString);

    lblItem.Caption := FBarcode + '  -  ' + FDescription;
    if Qry.FieldByName('UNIT_PRICE').IsNull then
      begin
        Asking := 0;
        lblAsking.Caption := '(none)';
      end
    else
      begin
        Asking := Qry.FieldByName('UNIT_PRICE').AsCurrency;
        lblAsking.Caption := FormatCurr('$,0.00', Asking);
      end;
  finally
    Qry.Free;
  end;

  FTaxPerc := DM.qryStoreSALES_TAX_PERC.AsCurrency;
  lblTaxCaption.Caption := Format('Tax (%s%%):', [FormatFloat('0.##', FTaxPerc)]);
  edSalePrice.Value := Asking;   // start from the asking price; the store types the agreed one
  RecalcTotals;
  Result := True;
end;

procedure TfrmQuickSale.FormShow(Sender: TObject);
begin
  edSalePrice.SetFocus;
  edSalePrice.SelectAll;
end;

procedure TfrmQuickSale.edSalePriceChange(Sender: TObject);
begin
  RecalcTotals;
end;

procedure TfrmQuickSale.RecalcTotals;
var
  Price, Tax: Currency;
begin
  Price := edSalePrice.Value;
  if Price < 0 then
    Price := 0;
  CalcTaxAndTotal(Price, FTaxPerc, Tax, FTotal);
  lblSubtotal.Caption := FormatCurr('$,0.00', Price);
  lblTax.Caption := FormatCurr('$,0.00', Tax);
  lblTotal.Caption := FormatCurr('$,0.00', FTotal);
  btnCompleteSale.Enabled := Price > 0;
end;

procedure TfrmQuickSale.btnCompleteSaleClick(Sender: TObject);
var
  Lines: TArray<TSaleLine>;
  TicketNo: integer;
begin
  if edSalePrice.Value <= 0 then
    begin
      PawnInfo('Please enter the sale price.', 'Quick Sale', Self);
      edSalePrice.SetFocus;
      exit;
    end;

  if not PawnConfirm(Format('Sell item %s for %s (tax included)?', [FBarcode, lblTotal.Caption]),
                     'Quick Sale', Self) then
    exit;

  SetLength(Lines, 1);
  Lines[0].InvItemNo := FInvItemNo;
  Lines[0].Description := FDescription;
  Lines[0].SalePrice := edSalePrice.Value;

  Screen.Cursor := crHourGlass;
  try
    try
      TicketNo := DM.CompleteSale(Lines, Date, False, 0, FTaxPerc);
    except
      on E: Exception do
        begin
          Screen.Cursor := crDefault;
          PawnWarn(E.Message, 'Quick Sale', Self);
          exit;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  PawnInfo(Format('Sale completed. Receipt No. %d.', [TicketNo]), 'Quick Sale', Self);
  ModalResult := mrOk;
end;

end.
