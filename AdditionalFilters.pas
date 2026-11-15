unit AdditionalFilters;

{ Additional filters for the client search screen (TfrmClients).

  Each ticked box keeps the customers who have AT LEAST ONE transaction matching
  it; several ticked boxes are OR-ed ("show me clients with an active pawn OR an
  active layaway"). Nothing ticked = no extra filter.

  Pawn transaction status (Active / Inactive) comes from TRANSACTIONS.TRAN_STATUS.
  Redeemed / Defaulted (undecided) / Scrap / For Sale look at the pawn's ITEMS,
  so a pawn with mixed items (some redeemed, some defaulted) matches both. The
  three defaulted outcomes -- undecided, Scrap, For Sale -- never overlap. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  RzRadChk;

type
  TClientFilter = (cfPawnActive, cfPawnInactive, cfPawnRedeemed, cfPawnDefaulted,
                   cfPawnScrap, cfPawnForSale, cfPurchases, cfLayawayActive, cfLayawayClosed);
  TClientFilters = set of TClientFilter;

  TfrmAdditionalFilters = class(TForm)
    gbButtons: TGroupBox;
    gbFilters: TGroupBox;
    btnCancel: TBitBtn;
    btnApplyFilters: TBitBtn;
    gbPawns: TGroupBox;
    chkPawnActive: TRzCheckBox;
    chkPawnInactive: TRzCheckBox;
    chkPawnRedeemed: TRzCheckBox;
    chkPawnDefaulted: TRzCheckBox;
    chkPawnScrap: TRzCheckBox;
    chkPawnForSale: TRzCheckBox;
    gbLayaways: TGroupBox;
    chkLayawayActive: TRzCheckBox;
    chkLayawayClosed: TRzCheckBox;
    chkPurchases: TRzCheckBox;
  private
    function GetFilters: TClientFilters;
    procedure SetFilters(const Value: TClientFilters);
  public
    property Filters: TClientFilters read GetFilters write SetFilters;
  end;

{ ' AND EXISTS (...)' clause for the CUSTOMER query (alias-free: correlates on
  CUSTOMER.CUST_NO), or '' when no filter is set. }
function ClientFiltersSQL(const AFilters: TClientFilters): string;

{ Short human-readable summary for the label next to the Filters button,
  e.g. 'Filters: Pawns (Active, For Sale) - Layaways (Active)'. '' when none. }
function ClientFiltersText(const AFilters: TClientFilters): string;

var
  frmAdditionalFilters: TfrmAdditionalFilters;

implementation

{$R *.dfm}

const
  // Item-level tests on a pawn's items (correlated on t = TRANSACTIONS).
  PawnHasItemSQL =
    '(t.TRAN_TYPE = ''P'' AND EXISTS (SELECT 1 FROM INVENTORY_ITEMS i ' +
    'WHERE i.TRANSACTION_NO = t.TRANSACTION_NO AND %s))';

function FilterCondition(F: TClientFilter): string;
begin
  case F of
    cfPawnActive:     Result := '(t.TRAN_TYPE = ''P'' AND t.TRAN_STATUS = ''A'')';
    cfPawnInactive:   Result := '(t.TRAN_TYPE = ''P'' AND t.TRAN_STATUS = ''I'')';
    cfPawnRedeemed:   Result := Format(PawnHasItemSQL, ['i.REDEEMED_DATE IS NOT NULL']);
    // Undecided: defaulted, but the store has not yet said For Sale or Scrap
    // (those have their own boxes, so the three never overlap). Same rule as
    // the Transaction List's "undecided defaulted items" checkbox.
    cfPawnDefaulted:  Result := Format(PawnHasItemSQL,
                          ['i.INV_ITEM_STATUS = ''P'' AND i.DEFAULTED_DATE IS NOT NULL AND i.REDEEMED_DATE IS NULL ' +
                           'AND i.FORSALE_DATE IS NULL AND i.MELTED_DATE IS NULL AND i.SOLD_DATE IS NULL']);
    cfPawnScrap:      Result := Format(PawnHasItemSQL, ['i.INV_ITEM_STATUS = ''C''']);
    cfPawnForSale:    Result := Format(PawnHasItemSQL, ['i.INV_ITEM_STATUS = ''S'' AND i.SOLD_DATE IS NULL']);
    cfPurchases:      Result := '(t.TRAN_TYPE = ''U'')';
    cfLayawayActive:  Result := '(t.TRAN_TYPE = ''L'' AND t.TRAN_STATUS = ''A'')';
    cfLayawayClosed:  Result := '(t.TRAN_TYPE = ''L'' AND t.TRAN_STATUS = ''I'')';
  else
    Result := '';
  end;
end;

function ClientFiltersSQL(const AFilters: TClientFilters): string;
var
  F: TClientFilter;
  Conds: string;
begin
  Result := '';
  Conds := '';
  for F := Low(TClientFilter) to High(TClientFilter) do
    if F in AFilters then
      begin
        if Conds <> '' then
          Conds := Conds + ' OR ';
        Conds := Conds + FilterCondition(F);
      end;

  if Conds <> '' then
    Result := ' AND EXISTS (SELECT 1 FROM TRANSACTIONS t ' +
              'WHERE t.CUST_NO = CUSTOMER.CUST_NO AND (' + Conds + ')) ';
end;

function ClientFiltersText(const AFilters: TClientFilters): string;

  procedure AddTo(var S: string; const Item: string);
  begin
    if S <> '' then
      S := S + ', ';
    S := S + Item;
  end;

  procedure AddGroup(var S: string; const Group, Items: string);
  begin
    if Items = '' then
      exit;
    if S <> '' then
      S := S + ' - ';
    S := S + Group + ' (' + Items + ')';
  end;

var
  Pawns, Layaways: string;
begin
  Pawns := '';
  if cfPawnActive in AFilters then AddTo(Pawns, 'Active');
  if cfPawnInactive in AFilters then AddTo(Pawns, 'Inactive');
  if cfPawnRedeemed in AFilters then AddTo(Pawns, 'Redeemed');
  if cfPawnDefaulted in AFilters then AddTo(Pawns, 'Defaulted - undecided');
  if cfPawnScrap in AFilters then AddTo(Pawns, 'Scrap');
  if cfPawnForSale in AFilters then AddTo(Pawns, 'For Sale');

  Layaways := '';
  if cfLayawayActive in AFilters then AddTo(Layaways, 'Active');
  if cfLayawayClosed in AFilters then AddTo(Layaways, 'Closed');

  Result := '';
  AddGroup(Result, 'Pawns', Pawns);
  if cfPurchases in AFilters then
    begin
      if Result <> '' then
        Result := Result + ' - ';
      Result := Result + 'Purchases';
    end;
  AddGroup(Result, 'Layaways', Layaways);

  if Result <> '' then
    Result := 'Filters: ' + Result;
end;

{ TfrmAdditionalFilters }

function TfrmAdditionalFilters.GetFilters: TClientFilters;
begin
  Result := [];
  if chkPawnActive.Checked then Include(Result, cfPawnActive);
  if chkPawnInactive.Checked then Include(Result, cfPawnInactive);
  if chkPawnRedeemed.Checked then Include(Result, cfPawnRedeemed);
  if chkPawnDefaulted.Checked then Include(Result, cfPawnDefaulted);
  if chkPawnScrap.Checked then Include(Result, cfPawnScrap);
  if chkPawnForSale.Checked then Include(Result, cfPawnForSale);
  if chkPurchases.Checked then Include(Result, cfPurchases);
  if chkLayawayActive.Checked then Include(Result, cfLayawayActive);
  if chkLayawayClosed.Checked then Include(Result, cfLayawayClosed);
end;

procedure TfrmAdditionalFilters.SetFilters(const Value: TClientFilters);
begin
  chkPawnActive.Checked := cfPawnActive in Value;
  chkPawnInactive.Checked := cfPawnInactive in Value;
  chkPawnRedeemed.Checked := cfPawnRedeemed in Value;
  chkPawnDefaulted.Checked := cfPawnDefaulted in Value;
  chkPawnScrap.Checked := cfPawnScrap in Value;
  chkPawnForSale.Checked := cfPawnForSale in Value;
  chkPurchases.Checked := cfPurchases in Value;
  chkLayawayActive.Checked := cfLayawayActive in Value;
  chkLayawayClosed.Checked := cfLayawayClosed in Value;
end;

end.
