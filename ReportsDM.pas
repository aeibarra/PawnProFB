unit ReportsDM;

interface

uses
  System.SysUtils, System.Classes, ppProd, ppClass, ppReport, ppComm, ppRelatv,
  ppDB, ppDBPipe, Data.DB, DateUtils, ppBands, ppCache, ppDesignLayer,
  ppParameter, ppPrnabl, ppCtrls, ppVar, ppStrtch, ppMemo, ppSubRpt,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMReports = class(TDataModule)
    qryPrnPayReceipt: TFDQuery;
    dsPrnPayReceipt: TDataSource;
    plPrnPayReceipt: TppDBPipeline;
    RepPrintPayReceipt: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText139: TppDBText;
    ppDBText140: TppDBText;
    ppDBText141: TppDBText;
    ppDBText142: TppDBText;
    ppDBText156: TppDBText;
    ppDBText1: TppDBText;
    DBPStoreInfo: TppDBPipeline;
    qryPrnPayReceiptTransactionNo: TIntegerField;
    qryPrnPayReceiptPayDate: TDateField;
    qryPrnPayReceiptPayInterest: TFloatField;
    qryPrnPayReceiptPayPrincipal: TFloatField;
    qryPrnPayReceiptTranDate: TDateField;
    qryPrnPayReceiptTranPawnAmount: TFloatField;
    qryPrnPayReceiptTranTicketNo: TWideStringField;
    qryPrnPayReceiptPrincBalance: TFloatField;
    qryPrnPayReceiptCustFirst: TWideStringField;
    qryPrnPayReceiptCustMid: TWideStringField;
    qryPrnPayReceiptCustLast: TWideStringField;
    qryPrnPayReceiptCustPhCell: TWideStringField;
    qryPrnPayReceiptCustPhHome: TWideStringField;
    qryPrnPayReceiptCustPhBussiness: TWideStringField;
    qryPrnPayReceiptcFullName: TWideStringField;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel1: TppLabel;
    qryPrnPayReceiptcCustomerPhones: TWideStringField;
    qryPrnPayReceiptcCustId: TWideStringField;
    qryPrnPayReceiptCustFlDrvLic: TWideStringField;
    qryPrnPayReceiptCustIDType: TWideStringField;
    qryPrnPayReceiptCustID: TWideStringField;
    qryPrnPayReceiptCustIDAgencyState: TWideStringField;
    ppDBText4: TppDBText;
    qryTranItems: TFDQuery;
    dsTranItems: TDataSource;
    qryTranItemsDescription: TWideStringField;
    qryTranItemsKT: TFloatField;
    qryTranItemsWeight: TFloatField;
    qryTranItemsWUnit: TWideStringField;
    ppLine1: TppLine;
    qryTranItemsInvItemCount: TIntegerField;
    ppLabel2: TppLabel;
    ppDBText5: TppDBText;
    dbpTranItems: TppDBPipeline;
    ppLabel3: TppLabel;
    ppDBText6: TppDBText;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppMemo1: TppMemo;
    ppMemo2: TppMemo;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText10: TppDBText;
    qryPrnPayReceiptPayAmount: TFloatField;
    ppLabel9: TppLabel;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppPageSummaryBand1: TppPageSummaryBand;
    qryPrnPayReceiptcDueDate: TDateTimeField;
    rptEnvelopeItemLabel: TppReport;
    dbpEnvelopeItemLabel: TppDBPipeline;
    qryInvItem: TFDQuery;
    dsInvItem: TDataSource;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    qryInvItemDescription: TWideStringField;
    qryInvItemWeight: TFloatField;
    qryInvItemKT: TFloatField;
    qryInvItemSizeLength: TFloatField;
    qryInvItemTranDate: TDateField;
    qryInvItemTranTicketNo: TWideStringField;
    qryInvItemCustFirst: TWideStringField;
    qryInvItemCustMid: TWideStringField;
    qryInvItemCustLast: TWideStringField;
    qryInvItemcFullName: TWideStringField;
    ppDetailBand2: TppDetailBand;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    qryInvItemcKT: TWideStringField;
    qryInvItemTranType: TWideStringField;
    qryInvItemQty: TIntegerField;
    ppDBText21: TppDBText;
    ppLabel10: TppLabel;
    lblItemPos: TppLabel;
    dbpLayawayInfo: TppDBPipeline;
    RepLayawayRcpt: TppReport;
    dbpStore: TppDBPipeline;
    qryLayawayRcpt: TFDQuery;
    dsLayawayRcpt: TDataSource;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand3: TppDetailBand;
    ppLabel11: TppLabel;
    qryLayawayRcptCustNo: TIntegerField;
    qryLayawayRcptCustLast: TWideStringField;
    qryLayawayRcptCustFirst: TWideStringField;
    qryLayawayRcptCustMid: TWideStringField;
    qryLayawayRcptCustAddr: TWideStringField;
    qryLayawayRcptCustApt: TWideStringField;
    qryLayawayRcptCustCity: TWideStringField;
    qryLayawayRcptCustState: TWideStringField;
    qryLayawayRcptCustZip: TWideStringField;
    qryLayawayRcptCustPhoneNumber: TWideStringField;
    qryLayawayRcptItemDescription: TWideStringField;
    qryLayawayRcptWeight: TFloatField;
    qryLayawayRcptWeightUnit: TWideStringField;
    qryLayawayRcptTranDate: TDateField;
    qryLayawayRcptTranMaturity: TDateField;
    qryLayawayRcptTranPawnAmount: TFloatField;
    qryLayawayRcptTranSalesTax: TFloatField;
    qryLayawayRcptTotalAmount: TFloatField;
    qryLayawayRcptTranTicketNo: TWideStringField;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppLine4: TppLine;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLine5: TppLine;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppDBText31: TppDBText;
    ppLabel17: TppLabel;
    ppLine6: TppLine;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    qryLayawayRcptUnitPrice: TFMTBCDField;
    ppDBText34: TppDBText;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    qryLayawayRcptcCustName: TWideStringField;
    qryLayawayRcptcFPhone: TWideStringField;
    qryLayawayRcptcWeightUnit: TWideStringField;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    qryLayawayRcptcSalesTax: TCurrencyField;
    qryLayawayRcptcTotalItemCost: TCurrencyField;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    lblLayawaySubTotal: TppLabel;
    ppLabel27: TppLabel;
    lblLayawayTotal: TppLabel;
    ppLabel28: TppLabel;
    lblLayawayBalance: TppLabel;
    ppSubReportPayments: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDesignLayers4: TppDesignLayers;
    ppDesignLayer4: TppDesignLayer;
    ppDetailBand4: TppDetailBand;
    qryLayawayPayments: TFDQuery;
    dsLayawayPayments: TDataSource;
    dbpLayawayPayments: TppDBPipeline;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppLine9: TppLine;
    ppDBCalc1: TppDBCalc;
    ppTitleBand1: TppTitleBand;
    ppSummaryBand2: TppSummaryBand;
    qryLayawayPaymentsPaymentNo: TIntegerField;
    qryLayawayPaymentsPayDate: TDateField;
    qryLayawayPaymentsPayAmount: TFloatField;
    qryLayawayPaymentsPrincBalance: TFloatField;
    ppDBText39: TppDBText;
    ppLabel31: TppLabel;
    ppLine11: TppLine;
    ppFooterBand2: TppFooterBand;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel34: TppLabel;
    ppLine10: TppLine;
    ppLabel35: TppLabel;
    ppShape1: TppShape;
    ppLabel36: TppLabel;
    ppDBText40: TppDBText;
    lbPrnRcvDate: TppLabel;
    qryLayawayRcptTranStatus: TWideStringField;
    qryLayawayRcptDDate: TDateField;
    procedure qryPrnPayReceiptCalcFields(DataSet: TDataSet);
    procedure qryInvItemCalcFields(DataSet: TDataSet);
    procedure qryLayawayRcptCalcFields(DataSet: TDataSet);
    procedure lblLayawaySubTotalGetText(Sender: TObject; var Text: string);
    procedure ppLabel27GetText(Sender: TObject; var Text: string);
    procedure lblLayawayTotalGetText(Sender: TObject; var Text: string);
    procedure lblLayawayBalanceGetText(Sender: TObject; var Text: string);
    procedure lbPrnRcvDateGetText(Sender: TObject; var Text: string);
  private
    LayawayBalance: Currency;
    function CalcPaymentDueDate(const PawnDate, LastPaymentDate: TDateTime): TDateTime;
  public
    procedure PrintToTray(const AReport: TppReport; const APrinterName, ATrayName: string);
    procedure PrintPaymentReceipt(PaymentNo: integer; const PrinterName, PrinterTray: string);
    procedure PrintItemEnvelopeLable(InvItemNo: integer; ItemPos, TotalItems: integer);
    procedure PrintLAYAWAYReceipt(TransactionNo: integer; const PrinterName, PrinterTray: string);
  end;

var
  DMReports: TDMReports;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses PawnDM, PawnGlobal;

{$R *.dfm}

procedure TDMReports.lblLayawayBalanceGetText(Sender: TObject;
  var Text: string);
begin
  Text := Format('%m', [LayawayBalance]);
end;

procedure TDMReports.lblLayawaySubTotalGetText(Sender: TObject;
  var Text: string);
begin
  Text := Format('%m', [DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency]);
end;

procedure TDMReports.lblLayawayTotalGetText(Sender: TObject; var Text: string);
begin
  Text := Format('%m', [DM.qryTransactionscTotalSalesAmount.AsCurrency]);
end;

procedure TDMReports.lbPrnRcvDateGetText(Sender: TObject; var Text: string);
begin
  if (qryLayawayRcptTranStatus.AsString = TranStatus_Inactive) and (qryLayawayRcptDDate.AsDateTime > 0) then
    begin
      Text := FormatDateTime('mm/dd/yyyy', qryLayawayRcptDDate.AsDateTime);
    end
  else
    begin
      Text := '';
    end;
end;

procedure TDMReports.ppLabel27GetText(Sender: TObject; var Text: string);
begin
  Text := Format('%m', [DM.qryTransactionsTRAN_SALES_TAX.AsCurrency]);
end;

procedure TDMReports.PrintItemEnvelopeLable(InvItemNo: integer; ItemPos, TotalItems: integer);
begin

  if InvItemNo <= 0 then
    exit;

  qryInvItem.Close;
  qryInvItem.Params.ParamByName('INV_ITEM_NO').AsInteger := InvItemNo;
  qryInvItem.Open;

  with rptEnvelopeItemLabel.PrinterSetup do
  begin
      PrinterName := 'Brother QL-820NWB';

      // DK-1201 Label Size
      PaperName   := '1.1" x 3.5"';

      // Small safety margins for Brother printers
      MarginLeft   := 0.00;
      MarginRight  := 0.00;
      MarginTop    := 0.00;
      MarginBottom := 0.00;
  end;

  lblItemPos.Caption := Format('%d of %d', [ItemPos, TotalItems]);

  rptEnvelopeItemLabel.PrintReport;
end;

procedure TDMReports.PrintToTray(const AReport: TppReport; const APrinterName, ATrayName: string);
var
  Bins: TArray<string>;
  HasTray: Boolean;
  S: string;
begin
  // Get available trays
  Bins := GetPrinterBinNames(APrinterName);

  // Decide whether the requested tray exists (case-insensitive compare)
  HasTray := False;
  for S in Bins do
    if SameText(S, ATrayName) then
    begin
      HasTray := True;
      Break;
    end;

  // Configure ReportBuilder for direct printing
  AReport.DeviceType := 'Printer';
  AReport.ShowPrintDialog := False;
  AReport.PrinterSetup.PrinterName := APrinterName;

  if HasTray then
    AReport.PrinterSetup.BinName := ATrayName  // exact name from the driver
  else
    AReport.PrinterSetup.BinName := '';        // fall back to printer default bin

  // (Optional) set paper/duplex/etc. here as needed
  // AReport.PrinterSetup.PaperName := 'Letter';
  // AReport.PrinterSetup.Duplex := dpVertical;

  AReport.Print;
end;

function TDMReports.CalcPaymentDueDate(const PawnDate, LastPaymentDate: TDateTime): TDateTime;
var
  Y, M, D: Word;
  TargetDay: Word;
begin
  DecodeDate(PawnDate, Y, M, TargetDay);

  // Step 1: one month after last payment
  Result := IncMonth(LastPaymentDate, 1);

  // Step 2: force day-of-month to match PawnDate�s day
  DecodeDate(Result, Y, M, D);
  if not TryEncodeDate(Y, M, TargetDay, Result) then
    // If that day doesn�t exist (e.g. pawned 31st ? April)
    Result := EndOfAMonth(Y, M);
end;

procedure TDMReports.PrintPaymentReceipt(PaymentNo: integer; const PrinterName, PrinterTray: string);
begin
  DM.RefreshStoreQry;

  qryPrnPayReceipt.Close;
  qryPrnPayReceipt.Params.ParamByName('PAYMENT_NO').AsInteger := PaymentNo;
  qryPrnPayReceipt.Open;

  qryTranItems.Close;
  qryTranItems.Params.ParamByName('PAYMENT_NO').AsInteger := PaymentNo;
  qryTranItems.Open;

  PrintToTray(RepPrintPayReceipt, PrinterName, PrinterTray);
end;

procedure TDMReports.qryInvItemCalcFields(DataSet: TDataSet);
begin
  qryInvItemcFullName.AsString := GetFullName(qryInvItemCustFirst.AsString, qryInvItemCustMid.AsString, qryInvItemCustLast.AsString);
  if qryInvItemKT.AsFloat > 0 then
    qryInvItemcKT.AsString := FloatToStr(qryInvItemKT.AsFloat) + ' KT'
  else
    qryInvItemcKT.AsString := '';
end;

procedure TDMReports.qryLayawayRcptCalcFields(DataSet: TDataSet);
var
  Tax, Total: Currency;
begin
  qryLayawayRcptcCustName.AsString := GetFullName(qryLayawayRcptCustFirst.AsString,
                                                  qryLayawayRcptCustMid.AsString,
                                                  qryLayawayRcptCustLast.AsString);

  qryLayawayRcptcFPhone.AsString := FormatPhoneUSA(qryLayawayRcptCustPhoneNumber.AsString);

  if DM.clnWeigthUnits.Locate('WeigthUnitValue', qryLayawayRcptWeightUnit.AsString, []) then
    qryLayawayRcptcWeightUnit.AsString := DM.clnWeigthUnitsWeightUnit.AsString;

  CalcTaxAndTotal(qryLayawayRcptUnitPrice.AsCurrency, DM.qryStoreSALES_TAX_PERC.AsCurrency, Tax, Total);

  qryLayawayRcptcSalesTax.AsCurrency := Tax;
  qryLayawayRcptcTotalItemCost.AsCurrency := Total;
end;

procedure TDMReports.qryPrnPayReceiptCalcFields(DataSet: TDataSet);
begin
  qryPrnPayReceiptcFullName.AsString := GetFullName(qryPrnPayReceiptCustFirst.AsString, qryPrnPayReceiptCustMid.AsString, qryPrnPayReceiptCustLast.AsString);

  qryPrnPayReceiptcCustomerPhones.AsString := CombinePhones(' / ',  [qryPrnPayReceiptCustPhCell.AsString,
                                                                     qryPrnPayReceiptCustPhHome.AsString,
                                                                     qryPrnPayReceiptCustPhBussiness.AsString]);

  if (trim(qryPrnPayReceiptCustIDType.AsString) <> '') and (trim(qryPrnPayReceiptCustID.AsString) <> '') and (trim(qryPrnPayReceiptCustIDAgencyState.AsString) <> '') then
    begin
      qryPrnPayReceiptcCustId.AsString := trim(qryPrnPayReceiptCustIDAgencyState.AsString) + ' / ' +
                                          MaskCustomerID(trim(qryPrnPayReceiptCustIDType.AsString), trim(qryPrnPayReceiptCustID.AsString));
    end
  else
    begin
      qryPrnPayReceiptcCustId.AsString := MaskCustomerID('Florida DL', qryPrnPayReceiptCustFlDrvLic.AsString);
    end;

  qryPrnPayReceiptcDueDate.AsDateTime := CalcPaymentDueDate(qryPrnPayReceiptTranDate.AsDateTime , DM.LastPaymentForTransaction(qryPrnPayReceiptTransactionNo.AsInteger));
end;

procedure TDMReports.PrintLAYAWAYReceipt(TransactionNo: integer; const PrinterName, PrinterTray: string);
begin
  qryLayawayRcpt.Close;
  qryLayawayRcpt.Params.ParamByName('TRANSACTION_NO').AsInteger := TransactionNo;
  qryLayawayRcpt.Open;

  LayawayBalance := OpenSQLStatementFB('select coalesce(SUM(PAY_AMOUNT), 0) as TotalPaid from PAYMENTS where TRANSACTION_NO = ' + DM.qryTransactionsTRANSACTION_NO.AsString);
  LayawayBalance := DM.qryTransactionscTotalSalesAmount.AsCurrency - LayawayBalance;

  qryLayawayPayments.Close;
  qryLayawayPayments.Params.ParamByName('TRANSACTION_NO').AsInteger := DM.qryTransactionsTRANSACTION_NO.AsInteger;
  qryLayawayPayments.Open;

  ppSubReportPayments.Visible := qryLayawayPayments.RecordCount > 0;

  PrintToTray(RepLayawayRcpt, PrinterName, PrinterTray);
end;

end.
