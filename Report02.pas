unit Report02;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, ppProd, ppClass,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, ppVar, ppPrnabl, ppCtrls, ppBands,
  ppCache, ppDesignLayer, ppParameter, RzLabel, RzPanel, RzRadChk,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.Generics.Collections, System.DateUtils, RzCmboBx;

type
  TfrmReport02 = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    btnExit: TBitBtn;
    btnPreview: TRzBitBtn;
    btnPrint: TRzBitBtn;
    GroupBox3: TGroupBox;
    rbPawnList: TRadioButton;
    rbPawnWithPayments: TRadioButton;
    qryPawnAndPurchases: TFDQuery;
    qryPawnAndPurchasesCustFirst: TWideStringField;
    qryPawnAndPurchasesCustMid: TWideStringField;
    qryPawnAndPurchasesCustLast: TWideStringField;
    qryPawnAndPurchasesCustPhCell: TWideStringField;
    qryPawnAndPurchasesTranTicketNo: TWideStringField;
    qryPawnAndPurchasesTranType: TWideStringField;
    qryPawnAndPurchasesTranPawnAmount: TFloatField;
    qryPawnAndPurchasesTranInterest: TFloatField;
    qryPawnAndPurchasesPrincBalance: TFloatField;
    qryPawnAndPurchasesInsterestBalance: TFloatField;
    qryPawnAndPurchasesTransactionNo: TIntegerField;
    qryPawnAndPurchasesTranDate: TDateField;
    qryPawnAndPurchasesTranTime: TTimeField;
    qryPawnAndPurchasesTranMaturity: TDateField;
    dsPawnAndPurchases: TDataSource;
    DBPPawnAndPurchases: TppDBPipeline;
    RepPawnAndPurchases: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppDetailBand1: TppDetailBand;
    ppTitleBand1: TppTitleBand;
    lblRep1PawnAndPurchaseTitle: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    qryPawnAndPurchasescFullName: TWideStringField;
    ppDBText1: TppDBText;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    lblTranType: TppLabel;
    lblFromToDates: TppLabel;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLabel9: TppLabel;
    ppDBText7: TppDBText;
    ppLine2: TppLine;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    qryPawnAndPurchasesTranTypeDesc: TWideStringField;
    qryTranPayments: TFDQuery;
    dsTranPayments: TDataSource;
    DBPTranPayments: TppDBPipeline;
    RepTranPayments: TppReport;
    qryTranPaymentscFullName: TWideStringField;
    qryTranPaymentsPayDate: TDateField;
    qryTranPaymentsPayAmount: TFloatField;
    qryTranPaymentsPayPrincipal: TFloatField;
    qryTranPaymentsPayInterest: TFloatField;
    qryTranPaymentsCustFirst: TWideStringField;
    qryTranPaymentsCustMid: TWideStringField;
    qryTranPaymentsCustLast: TWideStringField;
    qryTranPaymentsCustPhCell: TWideStringField;
    qryTranPaymentsTranTicketNo: TWideStringField;
    qryTranPaymentsTranType: TWideStringField;
    qryTranPaymentsTranPawnAmount: TFloatField;
    qryTranPaymentsTranInterest: TFloatField;
    qryTranPaymentsPrincBalance: TFloatField;
    qryTranPaymentsInsterestBalance: TFloatField;
    qryTranPaymentsTranDate: TDateField;
    qryTranPaymentsTranTime: TTimeField;
    qryTranPaymentsTranMaturity: TDateField;
    qryTranPaymentsTranTypeDesc: TWideStringField;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppDetailBand2: TppDetailBand;
    ppTitleBand2: TppTitleBand;
    ppLabel10: TppLabel;
    lblFromToDates2: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppSystemVariable4: TppSystemVariable;
    ppLine3: TppLine;
    ppLabel3: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppLine4: TppLine;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBText15: TppDBText;
    ppDBCalc7: TppDBCalc;
    ppLabel16: TppLabel;
    ppDBText14: TppDBText;
    pnDateRange: TRzPanel;
    edFrom: TRzDateTimeEdit;
    edTo: TRzDateTimeEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    rbTranStatusActive: TRzRadioButton;
    rbDateRange: TRzRadioButton;
    cbActiveWithin: TRzComboBox;
    rbListItemsForSale: TRzRadioButton;
    qryItemsForSale: TFDQuery;
    dsItemsForSale: TDataSource;
    DBPItemsForSale: TppDBPipeline;
    RepItemsForSale: TppReport;
    ppTitleBand3: TppTitleBand;
    lblFSTitle: TppLabel;
    ppSystemVariable5: TppSystemVariable;
    ppSystemVariable6: TppSystemVariable;
    lblFSAsOf: TppLabel;
    ppDetailBand3: TppDetailBand;
    dbFSBarcode: TppDBText;
    dbFSDescription: TppDBText;
    dbFSSource: TppDBText;
    dbFSTicketNo: TppDBText;
    dbFSForSaleSince: TppDBText;
    dbFSQty: TppDBText;
    dbFSUnitCost: TppDBText;
    dbFSUnitPrice: TppDBText;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    dbFSCategory: TppDBText;
    lblFSHBarcode: TppLabel;
    lblFSHDescription: TppLabel;
    lblFSHSource: TppLabel;
    lblFSHTicketNo: TppLabel;
    lblFSHForSaleSince: TppLabel;
    lblFSHQty: TppLabel;
    lblFSHUnitCost: TppLabel;
    lblFSHUnitPrice: TppLabel;
    ppLine7: TppLine;
    ppLine8: TppLine;
    lblFSSubtotal: TppLabel;
    calcFSCost: TppDBCalc;
    calcFSPrice: TppDBCalc;
    ppSummaryBand3: TppSummaryBand;
    ppLine9: TppLine;
    lblFSSumTitle: TppLabel;
    lblFSSumCount: TppLabel;
    lblFSSumMissing: TppLabel;
    lblFSSumCostCap: TppLabel;
    lblFSSumCost: TppLabel;
    lblFSSumPriceCap: TppLabel;
    lblFSSumPrice: TppLabel;
    ppDesignLayers3: TppDesignLayers;
    ppDesignLayer3: TppDesignLayer;
    ppParameterList3: TppParameterList;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryPawnAndPurchasesCalcFields(DataSet: TDataSet);
    procedure lblTranTypeGetText(Sender: TObject; var Text: string);
    procedure lblFromToDatesGetText(Sender: TObject; var Text: string);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryTranPaymentsCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rbDateRangeClick(Sender: TObject);
  private
    Param_LineNo_qryPawnAndPurchases: integer;
    Param_LineNo_qryTranPayments: integer;
    // Live interest balance is computed via the interest engine (not the stored,
    // point-in-time TRANSACTIONS.INTEREST_BALANCE, which goes stale as interest
    // accrues between payments). Cached per transaction: interest is "as of today"
    // so each pawn is computed once and reused across the two-pass render.
    FInterestByTran: TDictionary<Integer, Currency>;
    FqryPay: TFDQuery;
    function LiveInterestBalance(TranNo: Integer; PawnDate: TDateTime;
      Amount, Rate: Currency): Currency;
    function ActiveLimitMonths: Integer;
    function ActivePawnFilter: string;
    procedure Report_1(Preview: boolean);
    procedure LoadSelection;
    procedure SaveSelection;
    procedure Report_2(Preview: boolean);
    procedure Report_ItemsForSale(Preview: boolean);
    procedure ExecReport(Preview: boolean);
  public
    { Public declarations }
  end;

var
  frmReport02: TfrmReport02;

implementation

{$R *.dfm}

uses PawnGlobal, PawnDM, GLbUtils, uPawnDialogs;

const
  Report02IniSection = 'Report02';

procedure TfrmReport02.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReport02.FormCreate(Sender: TObject);
begin
  Param_LineNo_qryPawnAndPurchases := qryPawnAndPurchases.SQL.IndexOf(' --<PARAMS>');
  Param_LineNo_qryTranPayments := qryTranPayments.SQL.IndexOf(' --<PARAMS>');

  FInterestByTran := TDictionary<Integer, Currency>.Create;
  FqryPay := TFDQuery.Create(Self);
  FqryPay.Connection := DM.ConnFB;
  FqryPay.SQL.Text :=
    'select PAY_DATE, PAY_INTEREST, PRINC_BALANCE ' +
    'from PAYMENTS where TRANSACTION_NO = :t order by PAY_DATE, PAYMENT_NO';
end;

procedure TfrmReport02.FormDestroy(Sender: TObject);
begin
  SaveSelection;
  FInterestByTran.Free;
  // FqryPay is owned by the form (Self) and freed with it.
end;

// Interest owed as of today, from the same engine the payment screen uses.
// Cached: "as of today" is constant for this form instance, so each transaction
// is queried once regardless of how many report rows/passes reference it.
function TfrmReport02.LiveInterestBalance(TranNo: Integer; PawnDate: TDateTime;
  Amount, Rate: Currency): Currency;
begin
  if FInterestByTran.TryGetValue(TranNo, Result) then
    Exit;

  FqryPay.Close;
  FqryPay.ParamByName('t').AsInteger := TranNo;
  FqryPay.Open;
  Result := DM.GetCurrentInterestBalance(Date, PawnDate, Amount, Rate, FqryPay);
  FInterestByTran.Add(TranNo, Result);
end;

procedure TfrmReport02.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  // The date range always opens on the current month; it is not remembered.
  edFrom.Date := StartOfTheMonth(Date);
  edTo.Date := DateOf(EndOfTheMonth(Date));

  LoadSelection;

  if cbActiveWithin.ItemIndex < 0 then
    cbActiveWithin.ItemIndex := 1;   // two years
  rbDateRangeClick(nil);
end;

{ The user's last choices (per user, local INI) -- report type, which list
  and the "active within" period. First time: the DFM defaults. The From / To
  dates are not part of it: they always open on the current month. }
procedure TfrmReport02.LoadSelection;
var
  Idx: integer;
begin
  try
    if DM.RegIniFile.ReadBool(Report02IniSection, 'ListOfPayments', rbPawnWithPayments.Checked) then
      rbPawnWithPayments.Checked := True
    else
      rbPawnList.Checked := True;

    if DM.RegIniFile.ReadBool(Report02IniSection, 'ItemsForSale', False) then
      rbListItemsForSale.Checked := True
    else if DM.RegIniFile.ReadBool(Report02IniSection, 'ActivePawns', rbTranStatusActive.Checked) then
      rbTranStatusActive.Checked := True
    else
      rbDateRange.Checked := True;

    Idx := DM.RegIniFile.ReadInteger(Report02IniSection, 'ActiveWithin', cbActiveWithin.ItemIndex);
    if (Idx >= 0) and (Idx < cbActiveWithin.Items.Count) then
      cbActiveWithin.ItemIndex := Idx;
  except
    // cosmetic: fall back to the defaults
  end;
end;

procedure TfrmReport02.SaveSelection;
begin
  try
    DM.RegIniFile.WriteBool(Report02IniSection, 'ListOfPayments', rbPawnWithPayments.Checked);
    DM.RegIniFile.WriteBool(Report02IniSection, 'ActivePawns', rbTranStatusActive.Checked);
    DM.RegIniFile.WriteBool(Report02IniSection, 'ItemsForSale', rbListItemsForSale.Checked);
    DM.RegIniFile.WriteInteger(Report02IniSection, 'ActiveWithin', cbActiveWithin.ItemIndex);
    // Dates used to be remembered; drop what earlier versions left behind.
    DM.RegIniFile.DeleteKey(Report02IniSection, 'FromDate');
    DM.RegIniFile.DeleteKey(Report02IniSection, 'ToDate');
  except
  end;
end;

procedure TfrmReport02.lblTranTypeGetText(Sender: TObject; var Text: string);
begin
  if qryPawnAndPurchasesTranType.AsString = 'P' then
    Text := 'Pawn'
  else if qryPawnAndPurchasesTranType.AsString = 'U' then
    Text := 'Purchase'
end;

procedure TfrmReport02.lblFromToDatesGetText(Sender: TObject; var Text: string);
begin
  // In date-range mode this is the range. In active-pawns mode it is the age
  // limit in force -- printed so a short report is never mistaken for an empty
  // one, or for the whole list.
  if rbDateRange.Checked then
    Text := 'From ' + FormatDateTime('mm/dd/yyyy', edFrom.Date) + ' To ' + FormatDateTime('mm/dd/yyyy', edTo.Date)
  else if ActiveLimitMonths = 0 then
    Text := 'Every active pawn on file, with no age limit'
  else
    Text := Format('Active pawns written since %s (last %d months)',
                   [FormatDateTime('mm/dd/yyyy', IncMonth(Date, -ActiveLimitMonths)),
                    ActiveLimitMonths]);
end;

{ How far back the active-pawns list reaches, in months; 0 means no limit.

  The list needs a bound because TRAN_STATUS is only ever cleared when a store
  records a redeem or a default, and most do not. Every legacy pawn therefore
  still reads as open: unbounded, this report prints 56,325 pawns at Ricardo
  back to 1958, and all 22,558 Kendale has ever written, where the real working
  list is a few hundred. See Docs/Report02_ActivePawns_Design.md.

  The limit is a control, not a constant, and 'No limit' reproduces the old
  behaviour exactly. A store that DOES keep its statuses may legitimately hold
  a pawn older than any default we pick, and silently dropping it would turn a
  noisy report into a wrong one. }
function TfrmReport02.ActiveLimitMonths: Integer;
begin
  case cbActiveWithin.ItemIndex of
    0: Result := 12;
    2: Result := 60;
    3: Result := 0;
  else
    Result := 24;   // the default, and what an unset combo falls back to
  end;
end;

{ TRAN_DATE, deliberately, not TRAN_MATURITY: maturity is derived from the pawn
  terms and is not reliably populated in pumped legacy rows, so bounding on it
  would reintroduce the very unmaintained-column problem this bound exists to
  work around. TRAN_DATE is always present. }
function TfrmReport02.ActivePawnFilter: string;
begin
  Result := 'and T2.TRAN_TYPE = ''P'' and T2.TRAN_STATUS = ''A'' ';
  if ActiveLimitMonths > 0 then
    Result := Result + Format('and T2.TRAN_DATE >= DATEADD(-%d MONTH TO CURRENT_DATE) ',
                              [ActiveLimitMonths]);
end;

procedure TfrmReport02.qryPawnAndPurchasesCalcFields(DataSet: TDataSet);
begin
  qryPawnAndPurchasescFullName.AsString := GetFullName(qryPawnAndPurchasesCustFirst.AsString,qryPawnAndPurchasesCustMid.AsString, qryPawnAndPurchasesCustLast.AsString);

  // Live interest owed (engine-computed), replacing the stale stored column.
  // Purchases carry no interest rate, so the engine returns 0 for them.
  qryPawnAndPurchasesInsterestBalance.AsCurrency :=
    LiveInterestBalance(qryPawnAndPurchasesTransactionNo.AsInteger,
                        qryPawnAndPurchasesTranDate.AsDateTime,
                        qryPawnAndPurchasesTranPawnAmount.AsCurrency,
                        qryPawnAndPurchasesTranInterest.AsCurrency);
end;

procedure TfrmReport02.qryTranPaymentsCalcFields(DataSet: TDataSet);
begin
  qryTranPaymentscFullName.AsString := GetFullName(qryTranPaymentsCustFirst.AsString, qryTranPaymentsCustMid.AsString, qryTranPaymentsCustLast.AsString);
end;

procedure TfrmReport02.Report_1(Preview: boolean);
begin
  Screen.Cursor := crHourGlass;
  try
    qryPawnAndPurchases.Close;

    if rbDateRange.Checked then  //Params selection
      begin
        lblRep1PawnAndPurchaseTitle.Caption := 'Pawns and Purchases';
        lblFromToDates.Visible := true;
        qryPawnAndPurchases.SQL[Param_LineNo_qryPawnAndPurchases] := 'and T2.TRAN_DATE between :FromDate and :ToDate ';
        qryPawnAndPurchases.Params.ParamByName('FromDate').AsDate := edFrom.Date;
        qryPawnAndPurchases.Params.ParamByName('ToDate').AsDate := edTo.Date;
      end
    else
      begin
        // The limit stays on the page: it was hidden here, which is how an
        // 800-row report and a 3-row one looked like the same thing.
        lblFromToDates.Visible := true;
        lblRep1PawnAndPurchaseTitle.Caption := 'List of Active Pawns';
        qryPawnAndPurchases.SQL[Param_LineNo_qryPawnAndPurchases] := ActivePawnFilter;
      end;

    qryPawnAndPurchases.Open;
  finally
    Screen.Cursor := crDefault;
  end;

  RepPawnAndPurchases.DeviceType := PrnPreview[Preview];
  RepPawnAndPurchases.Print;
end;

procedure TfrmReport02.Report_2(Preview: boolean);
begin
  Screen.Cursor := crHourGlass;
  try
    qryTranPayments.Close;

    if rbDateRange.Checked then
      begin
        qryTranPayments.SQL[Param_LineNo_qryTranPayments] := 'and T4.PAY_DATE between :FromDate and :ToDate ';
        qryTranPayments.Params.ParamByName('FromDate').AsDate := edFrom.Date;
        qryTranPayments.Params.ParamByName('ToDate').AsDate := edTo.Date;
      end
    else
      begin
        qryTranPayments.SQL[Param_LineNo_qryTranPayments] := ActivePawnFilter;
      end;

    qryTranPayments.Open;
  finally
    Screen.Cursor := crDefault;
  end;

  RepTranPayments.DeviceType := PrnPreview[Preview];
  RepTranPayments.Print;
end;

{ Three lists share this form: active pawns, items For Sale, and every pawn
  and purchase in a date range. Only the controls that apply to the chosen
  list stay enabled, and the report-type caption says what it will print:
  the active list holds pawns only, the date range pawns and purchases. }
{ Every item For Sale today (INV_ITEM_STATUS = 'S'), grouped by category:
  purchases and defaulted pawns alike. A snapshot, so the active-within and
  date-range choices do not apply.

  UNIT_COST and UNIT_PRICE are per line, not per piece: the purchase cost is
  spread over the lines by weight with no item count involved
  (SPU_CALC_UNIT_COST_FROM_WEIGHT), and a sale takes one price per line. So
  the totals add them up as they are; Qty is printed for information only.

  An item without a cost or a price adds nothing to that total, so the
  summary counts them -- otherwise a low total could not be told from a
  missing one. }
procedure TfrmReport02.Report_ItemsForSale(Preview: boolean);
var
  Q: TFDQuery;
  Cnt, NoCost, NoPrice: integer;
  Missing: string;
begin
  Screen.Cursor := crHourGlass;
  try
    qryItemsForSale.Close;
    qryItemsForSale.Open;

    Q := TFDQuery.Create(nil);
    try
      Q.Connection := DM.ConnFB;
      Q.SQL.Text :=
        'select count(*), coalesce(sum(UNIT_COST), 0), coalesce(sum(UNIT_PRICE), 0), ' +
        '  sum(iif(coalesce(UNIT_COST, 0) = 0, 1, 0)), sum(iif(coalesce(UNIT_PRICE, 0) = 0, 1, 0)) ' +
        'from INVENTORY_ITEMS where INV_ITEM_STATUS = ''S''';
      Q.Open;
      Cnt := Q.Fields[0].AsInteger;
      lblFSSumCost.Caption := FormatCurr('$,0.00', Q.Fields[1].AsCurrency);
      lblFSSumPrice.Caption := FormatCurr('$,0.00', Q.Fields[2].AsCurrency);
      NoCost := Q.Fields[3].AsInteger;
      NoPrice := Q.Fields[4].AsInteger;
    finally
      Q.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if qryItemsForSale.IsEmpty then
  begin
    PawnInfo('There are no items For Sale.', 'Items For Sale', Self);
    exit;
  end;

  lblFSAsOf.Caption := 'As of ' + FormatDateTime('mm/dd/yyyy', Date);
  if Cnt = 1 then
    lblFSSumCount.Caption := '1 item For Sale'
  else
    lblFSSumCount.Caption := Format('%d items For Sale', [Cnt]);

  Missing := '';
  if NoCost > 0 then
    Missing := Format('%d without a cost', [NoCost]);
  if NoPrice > 0 then
  begin
    if Missing <> '' then
      Missing := Missing + ', ';
    Missing := Missing + Format('%d without a price', [NoPrice]);
  end;
  if Missing <> '' then
    Missing := Missing + ' (not in the totals)';
  lblFSSumMissing.Caption := Missing;

  RepItemsForSale.DeviceType := PrnPreview[Preview];
  RepItemsForSale.Print;
end;

procedure TfrmReport02.rbDateRangeClick(Sender: TObject);
begin
  pnDateRange.Enabled := rbDateRange.Checked;
  // Greyed out unless active mode, so it is obvious which list it qualifies.
  cbActiveWithin.Enabled := rbTranStatusActive.Checked;

  // The Items For Sale list has no report type to choose.
  GroupBox3.Enabled := not rbListItemsForSale.Checked;
  rbPawnList.Enabled := GroupBox3.Enabled;
  rbPawnWithPayments.Enabled := GroupBox3.Enabled;

  if rbDateRange.Checked then
    rbPawnList.Caption := 'List of Pawns and Purchases'
  else
    rbPawnList.Caption := 'List of Pawns';
end;

procedure TfrmReport02.btnPrintClick(Sender: TObject);
begin
  ExecReport(false);
end;

procedure TfrmReport02.ExecReport(Preview: boolean);
begin
  if rbListItemsForSale.Checked then
    Report_ItemsForSale(Preview)
  else if rbPawnList.Checked then
    begin
      Report_1(Preview);
    end
  else if rbPawnWithPayments.Checked then
    begin
      Report_2(Preview);
    end;
end;

procedure TfrmReport02.btnPreviewClick(Sender: TObject);
begin
  ExecReport(true);
end;

end.
