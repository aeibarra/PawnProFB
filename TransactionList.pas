unit TransactionList;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ppDesignLayer, ppParameter, Vcl.Mask,
  RzEdit, Data.DB, ppBands, ppClass, ppCtrls, ppStrtch,
  ppMemo, ppPrnabl, ppVar, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, Vcl.ExtCtrls, RzCommon, RzForms, RzButton, RzTabs,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmTransactionList = class(TForm)
    GroupBox2: TGroupBox;
    lblFDate: TLabel;
    lblTDate: TLabel;
    qryTranList: TFDQuery;
    dsTranList: TDataSource;
    qryTranListTransactionNo: TIntegerField;
    qryTranListCustNo: TIntegerField;
    qryTranListTranDate: TDateField;
    qryTranListTranTicketNo: TWideStringField;
    qryTranListTranComment: TMemoField;
    qryTranListTranMaturity: TDateField;
    qryTranListTranType: TWideStringField;
    qryTranListTranStatus: TWideStringField;
    qryTranListTranVoidDate: TSQLTimeStampField;
    qryTranListTranPawnAmount: TFloatField;
    qryTranListTranInterest: TFloatField;
    qryTranListPrincBalance: TFloatField;
    qryTranListInsterestBalance: TFloatField;
    qryTranListCustLast: TWideStringField;
    qryTranListCustFirst: TWideStringField;
    qryTranListCustMid: TWideStringField;
    qryTranListcCustFullName: TWideStringField;
    qryTranListcTransaction: TWideStringField;
    qryTranTotals: TFDQuery;
    qryTranTotalsTranType: TWideStringField;
    qryTranTotalsTranTypeDesc: TWideStringField;
    qryTranTotalsTotalAmount: TFloatField;
    qryTranTotalsTranCount: TIntegerField;
    DBPTranList: TppDBPipeline;
    RepTranList: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBText1: TppDBText;
    ppLine1: TppLine;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppDBText2: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppLine2: TppLine;
    ppDBCalc2: TppDBCalc;
    ppSummaryBand1: TppSummaryBand;
    ppDBMemo1: TppDBMemo;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppDBCalc3: TppDBCalc;
    ppLabel7: TppLabel;
    ppDBCalc4: TppDBCalc;
    qryInvItems: TFDQuery;
    qryInvItemscTotalWeight: TFloatField;
    qryInvItemscStatus: TWideStringField;
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
    qryInvItemsKT: TFloatField;
    qryInvItemsCreated: TSQLTimeStampField;
    qryInvItemsUnitCost: TFMTBCDField;
    qryInvItemsUnitPrice: TFMTBCDField;
    qryInvItemsInvItemStatus: TWideStringField;
    qryInvItemsTransactionNo: TIntegerField;
    qryInvItemsInvOriginalItemNo: TIntegerField;
    qryInvItemsInvItemBrand: TWideStringField;
    qryInvItemsOwnerAppNumber: TWideStringField;
    qryInvItemsModelNumber: TWideStringField;
    qryInvItemsSerialNumber: TWideStringField;
    qryInvItemsGender: TWideStringField;
    qryInvItemsDescription: TWideStringField;
    dsInvItems: TDataSource;
    edFDate: TRzDateTimeEdit;
    edToDate: TRzDateTimeEdit;
    FormState: TRzFormState;
    PropertyStore: TRzPropertyStore;
    btnSearch: TRzBitBtn;
    GroupBox3: TGroupBox;
    btnExit: TBitBtn;
    qryTotals: TFDQuery;
    dsTotals: TDataSource;
    qryTotalsPawnedCount: TIntegerField;
    qryTotalsRedeemedCount: TIntegerField;
    qryTotalsDefaultedCount: TIntegerField;
    qryDefaultTotals: TFDQuery;
    qryDefaultTotalsDefaultedMeltedCount: TIntegerField;
    qryDefaultTotalsDefaultedForSaleCount: TIntegerField;
    dsDefaultTotals: TDataSource;
    PgCntrlTransactionType: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    pnTotalPawn: TPanel;
    btnPrint: TBitBtn;
    DBGridTran: TDBGrid;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox5: TGroupBox;
    DBGrid2: TDBGrid;
    cbStatus: TComboBox;
    Label2: TLabel;
    DBGrid4: TDBGrid;
    qryInvItemsJTypeDesc: TWideStringField;
    qryInvItemsJStyleDesc: TWideStringField;
    qryInvItemsJMetalDesc: TWideStringField;
    qryInvItemsWeightUnit: TWideStringField;
    qryInvItemsPawnedDate: TDateField;
    qryInvItemsPurchaseDate: TDateField;
    qryInvItemsRedeemedDate: TDateField;
    qryInvItemsDefaultedDate: TDateField;
    qryInvItemsMeltedDate: TDateField;
    qryInvItemsForSaleDate: TDateField;
    qryInvItemsSoldDate: TDateField;
    qryInvItemsLayawayDate: TDateField;
    DBGrid6: TDBGrid;
    pnIntems: TPanel;
    gridItems: TDBGrid;
    pnDetail: TPanel;
    Splitter1: TSplitter;
    GroupBox6: TGroupBox;
    pnPurchase: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure qryTranListCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
    procedure ppLabel2GetText(Sender: TObject; var Text: string);
    procedure FormCreate(Sender: TObject);
    procedure qryInvItemsCalcFields(DataSet: TDataSet);
    procedure qryTranListAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure PgCntrlTransactionTypeChange(Sender: TObject);
  private
    Param_LineNo_qryTranList: integer;
    function PawnStatusTotals: string;
    function PawnDefaultedStatusTotals: string;
    procedure TransactionListOpen;
    procedure RefreshInvItems;
  public
    { Public declarations }
  end;

var
  frmTransactionList: TfrmTransactionList;

implementation

uses PawnDM, PawnGlobal;

{$R *.dfm}

procedure TfrmTransactionList.btnExitClick(Sender: TObject);
begin
  Close;

end;

function TfrmTransactionList.PawnStatusTotals: string;
begin
  Result := 'SELECT CAST(SUM(CASE WHEN PAWNED_DATE BETWEEN :FDate AND :ToDate THEN 1 ELSE 0 END) AS INTEGER) AS "PawnedCount", ' + sLineBreak +
            'CAST(SUM(CASE WHEN REDEEMED_DATE BETWEEN :FDate AND :ToDate THEN 1 ELSE 0 END) AS INTEGER) AS "RedeemedCount", ' + sLineBreak +
            'CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN :FDate AND :ToDate THEN 1 ELSE 0 END) AS INTEGER) AS "DefaultedCount" ' + sLineBreak +
            'FROM INVENTORY_ITEMS ' + sLineBreak +
            'WHERE PAWNED_DATE IS NOT NULL;  ' + sLineBreak;
end;

procedure TfrmTransactionList.PgCntrlTransactionTypeChange(Sender: TObject);
begin
  TransactionListOpen;
end;

function TfrmTransactionList.PawnDefaultedStatusTotals: string;
begin
  Result := 'SELECT CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN :FDate AND :ToDate AND MELTED_DATE IS NOT NULL THEN 1 ELSE 0 END) AS INTEGER) AS "DefaultedMeltedCount", ' + sLineBreak +
            'CAST(SUM(CASE WHEN DEFAULTED_DATE BETWEEN :FDate AND :ToDate AND FORSALE_DATE IS NOT NULL THEN 1 ELSE 0 END) AS INTEGER) AS "DefaultedForSaleCount" ' + sLineBreak +
            'FROM INVENTORY_ITEMS WHERE PAWNED_DATE IS NOT NULL ';
end;


procedure TfrmTransactionList.btnPrintClick(Sender: TObject);
var
  SavePos: integer;
begin
  SavePos := qryTranList.RecNo;
  qryTranList.DisableControls;
  try
    qryTranList.IndexFieldNames := 'TranType;TranDate;TranTicketNo';
    RepTranList.Print;
  finally
    qryTranList.IndexFieldNames := 'TranDate;TranTicketNo';
    qryTranList.RecNo := SavePos;
    qryTranList.EnableControls;
  end;
end;

procedure TfrmTransactionList.TransactionListOpen;
var
  St1, St2, TranType, TranTypeStr: string;
begin
  St1 := 'A';
  St2 := 'I';
  if cbStatus.ItemIndex = 1 then
  begin
    St2 := 'A';
  end
  else if cbStatus.ItemIndex = 2 then
  begin
    St1 := 'I';
  end;

  TranType := '';
  TranTypeStr := '';
  case pgCntrlTransactionType.TabIndex of
  0: //Pawn
    begin
      TranType := TranPawn;
      pnDetail.Caption := 'Pawn Items'
    end;
  1: //Purchase
    begin
      TranType := TranPurchase;
      pnDetail.Caption := 'Purchase Items'
    end;
  2: //Lawyaway
    begin
      TranType := TranLayaway;
      pnDetail.Caption := 'Lawyaway Items'
    end;
  3: //For Sale
    begin
      TranType := TranForSale;
      pnDetail.Caption := 'Items for Sale'
    end;
  end;

  if TranType <> '' then
    TranTypeStr := ' AND T1.TRAN_TYPE = :TranType';

  qryTranList.Close;
  qryTranList.SQL[Param_LineNo_qryTranList] := 'WHERE T1.TRAN_STATUS in (:Status1, :Status2) and T1.TRAN_DATE between :FDate and :ToDate' + TranTypeStr;
  qryTranList.Params.ParamByName('Status1').AsString := St1;
  qryTranList.Params.ParamByName('Status2').AsString := St2;
  qryTranList.Params.ParamByName('FDate').AsDate := edFDate.Date;
  qryTranList.Params.ParamByName('ToDate').AsDate := edToDate.Date;
  if TranTypeStr <> '' then
    qryTranList.Params.ParamByName('TranType').AsString := TranType;

  Screen.Cursor := crHourGlass;
  try
    qryTranList.Open;
    // AfterScroll does not fire on Open, so refresh the detail explicitly for the
    // first row of the newly filtered list (or clear it if the list is empty).
    RefreshInvItems;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmTransactionList.btnSearchClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    TransactionListOpen;

    qryTranTotals.Close;
    qryTranTotals.Params.ParamByName('FDate').AsDate := edFDate.Date;
    qryTranTotals.Params.ParamByName('ToDate').AsDate := edToDate.Date;
    qryTranTotals.Open;

    if qryTranTotals.Locate('TranType', TranPawn, []) then
      pnTotalPawn.Caption := Format(' Pawns (%d) %m ', [qryTranTotalsTranCount.AsInteger, qryTranTotalsTotalAmount.AsCurrency]);

    if qryTranTotals.Locate('TranType', TranPurchase, []) then
      pnPurchase.Caption := Format(' Purchases (%d) %m ', [qryTranTotalsTranCount.AsInteger, qryTranTotalsTotalAmount.AsCurrency]);


    qryTotals.Close;
    qryTotals.SQL.Text := PawnStatusTotals;
    qryTotals.Params.ParamByName('FDate').AsDate := edFDate.Date;
    qryTotals.Params.ParamByName('ToDate').AsDate := edToDate.Date;
    qryTotals.Open;

    qryDefaultTotals.Close;
    qryDefaultTotals.SQL.Text := PawnDefaultedStatusTotals;
    qryDefaultTotals.Params.ParamByName('FDate').AsDate := edFDate.Date;
    qryDefaultTotals.Params.ParamByName('ToDate').AsDate := edToDate.Date;
    qryDefaultTotals.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmTransactionList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmTransactionList := nil;
end;

procedure TfrmTransactionList.FormCreate(Sender: TObject);
begin
  Param_LineNo_qryTranList := qryTranList.SQL.IndexOf('--<PARAMS>');

  PropertyStore.Load;
end;

procedure TfrmTransactionList.FormDestroy(Sender: TObject);
begin
  PropertyStore.Save;
end;

procedure TfrmTransactionList.FormShow(Sender: TObject);
begin
  edFDate.Date := EncodeDate(2000, 1, 1);
  edToDate.Date := Date;

  btnSearchClick(nil);
end;

procedure TfrmTransactionList.ppLabel2GetText(Sender: TObject;
  var Text: string);
begin
  Text := 'From ' + FormatDateTime('mm/dd/yyyy', edFDate.Date) + ' To ' + FormatDateTime('mm/dd/yyyy', edToDate.Date)
end;

procedure TfrmTransactionList.qryInvItemsCalcFields(DataSet: TDataSet);
begin
  qryInvItemscTotalWeight.AsFloat := qryInvItemsInvItemCount.AsInteger * qryInvItemsWeight.AsFloat;

  qryInvItemscStatus.AsString := DM.GetItemStatus(qryInvItems);
end;

procedure TfrmTransactionList.qryTranListAfterScroll(DataSet: TDataSet);
begin
  RefreshInvItems;
end;

procedure TfrmTransactionList.RefreshInvItems;
// Re-query the detail (items) grid for the currently selected transaction.
// Called both on master navigation (AfterScroll) and right after the master is
// (re)opened -- opening a dataset does NOT fire AfterScroll, so without the
// explicit call after Open the detail grid keeps showing the previous tab's
// (e.g. Pawn) items when you switch tabs or run a new search.
begin
  qryInvItems.Close;
  if qryTranList.IsEmpty then
    Exit;
  qryInvItems.Params.ParamByName('TransactionNo').AsInteger := qryTranListTransactionNo.AsInteger;
  qryInvItems.Open;
end;

procedure TfrmTransactionList.qryTranListCalcFields(DataSet: TDataSet);
begin
  qryTranListcCustFullName.AsString := trim(trim(qryTranListCustFirst.AsString) + ' ' +
                                       trim(qryTranListCustMid.AsString)) + ' ' +
                                       trim(qryTranListCustLast.AsString);
  qryTranListcTransaction.AsString := GetTransactionStr(qryTranListTranType.AsString);
end;

end.
