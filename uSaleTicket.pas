unit uSaleTicket;

{ The sale ticket being built on screen ("This Sale"), shared by the two
  registers: the Items screen's sale drawer (Inventory.pas) and the Sell Items
  screen (SellItems.pas). One set of rules, so both always behave the same:

    - lines: one row per item (the whole row, whatever its quantity); only the
      Sale Price is typed; a line cannot be created by arrowing off the grid;
    - which items are in the open sale (each screen hides them from its list);
    - totals: Subtotal = sum of Sale Prices; a discount for the whole sale ($
      or % of the subtotal) before tax, never more than the subtotal (out of
      range is reported, not capped); tax at the store rate;
    - the checks before Complete Sale (prices, discount, sale date);
    - Complete Sale (DM.CompleteSale) and the locked "completed" state that
      shows the receipt number until New Sale / Clear.

  Non-visual on purpose: each screen keeps its own layout (grid, discount
  boxes, labels, buttons) and only asks this class. The money rules
  themselves stay where they were (CalcSaleDiscount / CalcTaxAndTotal in
  PawnGlobal, DM.CompleteSale), also used by Quick Sale. }

interface

uses
  System.SysUtils, System.Classes, System.Variants, Winapi.Messages, Data.DB,
  FireDAC.Comp.Client, PawnDM;

const
  // Posted by a screen's sale grid on Enter: TDBGrid posts only when the row
  // changes, so the screen posts the typed price itself once the grid has
  // finished its own Enter handling (see PostPendingEdit).
  WM_POST_SALE_EDIT = WM_USER + 101;

type
  TSaleTotals = record
    Subtotal, Discount, Tax, Total: Currency;
    DiscountInvalid: boolean;   // out of range: shown red, blocks Complete Sale
  end;

  TSaleProblem = (spNone, spEmpty, spNoPrice, spDiscount, spFutureDate);

  TSaleTicket = class(TComponent)
  private
    FLines: TFDMemTable;
    FInSale: TArray<integer>;     // INV_ITEM_NOs in the open sale
    FAdding: boolean;             // only AddItem may insert rows
    FCompleted: boolean;
    FTicketNo: integer;
    FTaxPerc: Currency;
    FRemovedItemNo: integer;      // set before a delete, taken after it
    FOnChange: TNotifyEvent;
    procedure LinesBeforeInsert(DataSet: TDataSet);
    procedure LinesBeforeDelete(DataSet: TDataSet);
    procedure LinesAfterChange(DataSet: TDataSet);
    procedure SetInSale(InvItemNo: integer; Value: boolean);
  public
    { AOwner: the screen (frees it). ALines: the screen's memtable (its grid's
      dataset); its structure is created here and its Before/After events are
      taken over. }
    constructor Create(AOwner: TComponent; ALines: TFDMemTable); reintroduce;

    { "Metal Type" when an item has no description. }
    class function ItemDescription(const Desc, Metal, JType: string): string;

    function Contains(InvItemNo: integer): boolean;
    function HasOpenItems: boolean;    // anything to hide from the list
    function Count: integer;

    { Adds an item to the open sale. True when it is in the sale afterwards
      (already there counts); False when the sale is completed. }
    function AddItem(InvItemNo: integer; const Barcode: string; ItemCount: integer;
      const Description: string; const UnitCost, UnitPrice: Variant): boolean;
    procedure RemoveCurrent;

    { The item of the line just removed (0 if none), once: the screen puts it
      back in its list and selects it. }
    function TakeRemovedItemNo: integer;

    { Posts a price being typed. False, with the message, on a bad value; the
      row stays in edit to be corrected. }
    function PostPendingEdit(out ErrMsg: string): boolean;

    function Totals(DiscountIsPercent: boolean; const DiscountEntered: Currency): TSaleTotals;

    { The checks before Complete Sale. On spNoPrice the cursor is on that line. }
    function Validate(SoldDate: TDateTime; DiscountIsPercent: boolean;
      const DiscountEntered: Currency; out Msg: string): TSaleProblem;

    { Saves the ticket (DM.CompleteSale) and locks it: Completed, TicketNo. }
    function Complete(SoldDate: TDateTime; DiscountIsPercent: boolean;
      const DiscountEntered: Currency): integer;

    { Empties the screen for the next sale (the saved ticket is not touched). }
    procedure Clear;

    property Lines: TFDMemTable read FLines;
    property Completed: boolean read FCompleted;
    property TicketNo: integer read FTicketNo;
    property TaxPerc: Currency read FTaxPerc;
    { After every posted price, added or removed line: recalc, re-filter. }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses PawnGlobal;

constructor TSaleTicket.Create(AOwner: TComponent; ALines: TFDMemTable);
begin
  inherited Create(AOwner);
  FLines := ALines;
  FTaxPerc := DM.qryStoreSALES_TAX_PERC.AsCurrency;

  FLines.Close;
  FLines.FieldDefs.Clear;
  FLines.FieldDefs.Add('INV_ITEM_NO', ftInteger);
  FLines.FieldDefs.Add('INV_ITEM_BARCODE', ftWideString, 30);
  FLines.FieldDefs.Add('INV_ITEM_COUNT', ftInteger);
  FLines.FieldDefs.Add('DESCRIPTION', ftWideString, 250);
  FLines.FieldDefs.Add('UNIT_COST', ftCurrency);
  FLines.FieldDefs.Add('SALE_PRICE', ftCurrency);
  FLines.CreateDataSet;

  // Only Sale Price is editable: the other grid columns are ReadOnly in the
  // DFM (TField.ReadOnly would also block AddItem from filling them).
  FLines.FieldByName('INV_ITEM_NO').Visible := False;
  TCurrencyField(FLines.FieldByName('UNIT_COST')).DisplayFormat := '$,0.00';
  TCurrencyField(FLines.FieldByName('SALE_PRICE')).DisplayFormat := '$,0.00';

  FLines.BeforeInsert := LinesBeforeInsert;
  FLines.BeforeDelete := LinesBeforeDelete;
  FLines.AfterPost := LinesAfterChange;
  FLines.AfterDelete := LinesAfterChange;
end;

class function TSaleTicket.ItemDescription(const Desc, Metal, JType: string): string;
begin
  Result := Trim(Desc);
  if Result = '' then
    Result := Trim(Trim(Metal) + ' ' + Trim(JType));
end;

{ ---- lines ----------------------------------------------------------------- }

// Arrowing past the last row of the grid must not create an empty line.
procedure TSaleTicket.LinesBeforeInsert(DataSet: TDataSet);
begin
  if not FAdding then
    Abort;
end;

// Any way a line leaves (Remove, back arrow, Ctrl+Del in the grid) puts its
// item back in the screen's list, after the delete (OnChange).
procedure TSaleTicket.LinesBeforeDelete(DataSet: TDataSet);
begin
  FRemovedItemNo := FLines.FieldByName('INV_ITEM_NO').AsInteger;
  SetInSale(FRemovedItemNo, False);
end;

procedure TSaleTicket.LinesAfterChange(DataSet: TDataSet);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TSaleTicket.TakeRemovedItemNo: integer;
begin
  Result := FRemovedItemNo;
  FRemovedItemNo := 0;
end;

function TSaleTicket.Contains(InvItemNo: integer): boolean;
var
  N: integer;
begin
  Result := False;
  for N in FInSale do
    if N = InvItemNo then
      exit(True);
end;

function TSaleTicket.HasOpenItems: boolean;
begin
  Result := Length(FInSale) > 0;
end;

function TSaleTicket.Count: integer;
begin
  if FLines.Active then
    Result := FLines.RecordCount
  else
    Result := 0;
end;

procedure TSaleTicket.SetInSale(InvItemNo: integer; Value: boolean);
var
  i: integer;
begin
  if Value then
    begin
      if not Contains(InvItemNo) then
        FInSale := FInSale + [InvItemNo];
    end
  else
    for i := High(FInSale) downto 0 do
      if FInSale[i] = InvItemNo then
        Delete(FInSale, i, 1);
end;

function TSaleTicket.AddItem(InvItemNo: integer; const Barcode: string; ItemCount: integer;
  const Description: string; const UnitCost, UnitPrice: Variant): boolean;
begin
  if FCompleted then
    exit(False);
  if FLines.Locate('INV_ITEM_NO', InvItemNo, []) then
    exit(True);   // already in this sale: just selected

  FAdding := True;
  try
    FLines.Append;
    FLines.FieldByName('INV_ITEM_NO').AsInteger := InvItemNo;
    FLines.FieldByName('INV_ITEM_BARCODE').AsString := Barcode;
    FLines.FieldByName('INV_ITEM_COUNT').AsInteger := ItemCount;
    FLines.FieldByName('DESCRIPTION').AsString := Description;
    if not VarIsNull(UnitCost) and not VarIsEmpty(UnitCost) then
      FLines.FieldByName('UNIT_COST').AsCurrency := UnitCost;
    if not VarIsNull(UnitPrice) and not VarIsEmpty(UnitPrice) then
      FLines.FieldByName('SALE_PRICE').AsCurrency := UnitPrice;
    SetInSale(InvItemNo, True);   // before Post: OnChange re-filters the list
    FLines.Post;
  finally
    FAdding := False;
  end;
  Result := True;
end;

procedure TSaleTicket.RemoveCurrent;
begin
  if FCompleted then
    exit;   // a completed ticket stays as it was saved
  if FLines.Active and not FLines.IsEmpty then
    FLines.Delete;
end;

function TSaleTicket.PostPendingEdit(out ErrMsg: string): boolean;
begin
  ErrMsg := '';
  Result := True;
  if not FLines.Active or not (FLines.State in dsEditModes) then
    exit;
  try
    FLines.Post;
  except
    on E: Exception do
      begin
        ErrMsg := E.Message;
        Result := False;
      end;
  end;
end;

{ ---- totals and checks ----------------------------------------------------- }

function TSaleTicket.Totals(DiscountIsPercent: boolean; const DiscountEntered: Currency): TSaleTotals;
var
  BM: TBookmark;
begin
  Result.Subtotal := 0;
  if FLines.Active then
    begin
      BM := FLines.GetBookmark;
      FLines.DisableControls;
      try
        FLines.First;
        while not FLines.Eof do
          begin
            Result.Subtotal := Result.Subtotal + FLines.FieldByName('SALE_PRICE').AsCurrency;
            FLines.Next;
          end;
        if FLines.BookmarkValid(BM) then
          FLines.GotoBookmark(BM);
      finally
        FLines.FreeBookmark(BM);
        FLines.EnableControls;
      end;
    end;

  if DiscountIsPercent then
    Result.DiscountInvalid := (DiscountEntered < 0) or (DiscountEntered > 100)
  else
    Result.DiscountInvalid := (DiscountEntered < 0) or (DiscountEntered > Result.Subtotal);
  Result.Discount := CalcSaleDiscount(Result.Subtotal, DiscountIsPercent, DiscountEntered);
  CalcTaxAndTotal(Result.Subtotal - Result.Discount, FTaxPerc, Result.Tax, Result.Total);
end;

function TSaleTicket.Validate(SoldDate: TDateTime; DiscountIsPercent: boolean;
  const DiscountEntered: Currency; out Msg: string): TSaleProblem;
begin
  Msg := '';
  if FLines.State in dsEditModes then
    FLines.Post;

  if FLines.IsEmpty then
    begin
      Msg := 'There are no items in this sale.';
      exit(spEmpty);
    end;

  // Every item needs a real price.
  FLines.First;
  while not FLines.Eof do
    begin
      if FLines.FieldByName('SALE_PRICE').AsCurrency <= 0 then
        begin
          Msg := Format('Please enter a sale price for item %s.',
                        [FLines.FieldByName('INV_ITEM_BARCODE').AsString]);
          exit(spNoPrice);
        end;
      FLines.Next;
    end;

  // The discount shows red when out of range; it must be fixed, not capped.
  if Totals(DiscountIsPercent, DiscountEntered).DiscountInvalid then
    begin
      Msg := 'The discount cannot be more than the sale.';
      exit(spDiscount);
    end;

  if Trunc(SoldDate) > Date then
    begin
      Msg := 'The sale date cannot be in the future.';
      exit(spFutureDate);
    end;

  Result := spNone;
end;

{ ---- complete / clear ------------------------------------------------------ }

function TSaleTicket.Complete(SoldDate: TDateTime; DiscountIsPercent: boolean;
  const DiscountEntered: Currency): integer;
var
  SaleLines: TArray<TSaleLine>;
  i: integer;
begin
  SetLength(SaleLines, FLines.RecordCount);
  i := 0;
  FLines.First;
  while not FLines.Eof do
    begin
      SaleLines[i].InvItemNo := FLines.FieldByName('INV_ITEM_NO').AsInteger;
      SaleLines[i].Description := FLines.FieldByName('DESCRIPTION').AsString;
      SaleLines[i].SalePrice := FLines.FieldByName('SALE_PRICE').AsCurrency;
      Inc(i);
      FLines.Next;
    end;

  Result := DM.CompleteSale(SaleLines, SoldDate, DiscountIsPercent, DiscountEntered, FTaxPerc);

  // Locked on the saved ticket; its items are Sold now, nothing left to hide.
  FCompleted := True;
  FTicketNo := Result;
  FInSale := nil;
end;

procedure TSaleTicket.Clear;
begin
  if FLines.State in dsEditModes then
    FLines.Cancel;
  FCompleted := False;
  FTicketNo := 0;
  FInSale := nil;
  FLines.EmptyDataSet;   // AfterDelete is not fired: callers refresh themselves
end;

end.
