unit PawnDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles,
  Db, ADODB, DBClient, Provider, Variants, Vcl.ImgList, DateUtils, System.UITypes, Vcl.StdCtrls,
  RzCommon, System.ImageList, RzCmboBx, Vcl.VirtualImageList, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, SVGIconImageCollection,
  SVGIconVirtualImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet;

type
  TBackupPhase = (bpStarting, bpDatabase, bpImages, bpLogging, bpDone);
  TBackupPhaseProc = reference to procedure(Phase: TBackupPhase);

  TBackupResult = record
    WrittenFile:  string;
    BackupError:  string;
    LogError:     string;
    ImageError:   string;
    CopiedCount:  Integer;
    SkippedCount: Integer;
  end;

  TDM = class(TDataModule)
    qryDummy: TADOQuery;
    ConnDB: TADOConnection;
    DSCustomers: TDataSource;
    DSStates: TDataSource;
    DSTransactions: TDataSource;
    DSPayments: TDataSource;
    DSStore: TDataSource;
    qryStore: TADOQuery;
    qryStorecCity: TStringField;
    qryStorecState: TStringField;
    qryStorecZIp: TStringField;
    qryStoreStoreNo: TStringField;
    qryStoreStoreName: TStringField;
    qryStoreStoreAddr: TStringField;
    qryStoreStoreCityStZIP: TStringField;
    qryStoreStorePhone: TStringField;
    qryStoreStorePoliceID: TStringField;
    qryStoreStoreAdjTopMarg: TIntegerField;
    qryStoreStorenumber: TStringField;
    qryStoreStoreAdjDetailHeight: TIntegerField;
    qryStoreStoreAdjFooterHeight: TIntegerField;
    qryStoreInterestCalcMethod: TIntegerField;
    qryStorePoliceReportToPrint: TIntegerField;
    qryStorePoliceReportLaserCopies: TIntegerField;
    qryStoreDefaultMaturityMonths: TIntegerField;
    QryStates: TADOQuery;
    QryStatesState_Abbr: TStringField;
    QryStatesState_Name: TStringField;
    qryTransactions_: TADOQuery;
    qryTransactions_cComment: TStringField;
    qryTransactions_cTranInsAmount1Month: TCurrencyField;
    qryTransactions_cTotalPay1Month: TCurrencyField;
    qryTransactions_cPawnDefaultDate: TDateTimeField;
    qryTransactions_cTAmountRedeemDefaultDate: TCurrencyField;
    qryTransactions_cAnnualPercRate: TFloatField;
    qryTransactions_TransactionNo: TIntegerField;
    qryTransactions_CustNo: TIntegerField;
    qryTransactions_TranDate: TDateTimeField;
    qryTransactions_TranTicketNo: TStringField;
    qryTransactions_TranComment: TMemoField;
    qryTransactions_TranMaturity: TDateField;
    qryTransactions_TranType: TStringField;
    qryTransactions_TranStatus: TStringField;
    qryTransactions_TranPawnAmount: TFloatField;
    qryTransactions_TranInterest: TFloatField;
    qryTransactions_PrincBalance: TFloatField;
    qryTransactions_InsterestBalance: TFloatField;
    qryTransactions_TranTime: TTimeField;
    qryCustomers: TADOQuery;
    qryCustomersCustno: TIntegerField;
    qryCustomersCustTicketNo: TStringField;
    qryCustomersCustLast: TStringField;
    qryCustomersCustFirst: TStringField;
    qryCustomersCustMid: TStringField;
    qryCustomersCustDOB: TDateField;
    qryCustomersCustGender: TStringField;
    qryCustomersCustRace: TStringField;
    qryCustomersCustHair: TStringField;
    qryCustomersCustEyes: TStringField;
    qryCustomersCustMark: TStringField;
    qryCustomersCustWeight: TFloatField;
    qryCustomersCustHeight: TStringField;
    qryCustomersCustAddr: TStringField;
    qryCustomersCustApt: TStringField;
    qryCustomersCustCity: TStringField;
    qryCustomersCustState: TStringField;
    qryCustomersCustZip: TStringField;
    qryCustomersCustPlaceEmply: TStringField;
    qryCustomersCustFlDrvLic: TStringField;
    qryCustomersCustID: TStringField;
    qryCustomersCustIDType: TStringField;
    qryCustomersCustIDAgencyState: TStringField;
    qryCustomersCustPhHome: TStringField;
    qryCustomersCustPhBussiness: TStringField;
    qryCustomersCustPhBeep: TStringField;
    qryCustomersCustPhCell: TStringField;
    qryCustomersCustComment: TMemoField;
    qrySalesTran_: TADOQuery;
    qrySalesTran_TransactionNo: TIntegerField;
    qrySalesTran_CustNo: TIntegerField;
    qrySalesTran_TranDate: TDateTimeField;
    qrySalesTran_TranTicketNo: TStringField;
    qrySalesTran_TranComment: TMemoField;
    qrySalesTran_TranMaturity: TDateField;
    qrySalesTran_TranType: TStringField;
    qrySalesTran_TranStatus: TStringField;
    qrySalesTran_TranVoidDate: TDateTimeField;
    prvSalesTran: TDataSetProvider;
    clnSalesTran: TClientDataSet;
    clnSalesTranTransactionNo: TIntegerField;
    clnSalesTrancComment: TStringField;
    clnSalesTranCustNo: TIntegerField;
    clnSalesTranTranDate: TDateTimeField;
    clnSalesTranTranTicketNo: TStringField;
    clnSalesTranTranComment: TMemoField;
    clnSalesTranTranMaturity: TDateField;
    clnSalesTranTranType: TStringField;
    clnSalesTranTranStatus: TStringField;
    clnSalesTranTranVoidDate: TDateTimeField;
    dsSalesTran: TDataSource;
    RegIniFile: TRzRegIniFile;
    ImageListBtn: TImageList;
    qryCustomerscCustPhHome: TStringField;
    qryCustomersCCustPhBussiness: TStringField;
    qryCustomersCCustPhBeep: TStringField;
    qryCustomerscCustPhCell: TStringField;
    qryCustomerscCustFlDrvLic: TStringField;
    qryStorePawnDefaultMonths: TIntegerField;
    qryImage: TADOQuery;
    qryImageImagesDataNo: TIntegerField;
    qryImageImageDesc: TStringField;
    qryImageImageData: TBlobField;
    qryStoreLeadsStoreId: TStringField;
    qryStoreLeadsOnlineFTPAddress: TStringField;
    qryStoreLeadsOnlineUserName: TStringField;
    qryStoreLeadsOnlinePassword: TStringField;
    qryImageUploadFileName: TStringField;
    qryStoreFTPPassive: TBooleanField;
    qryTransactions_cTranTotalInterestAtMaturity: TCurrencyField;
    qryTransactions_cTranTotalAmountAtMaturity: TCurrencyField;
    qryStorePawnDateCalculationBase: TStringField;
    qryCustomerscCustAge: TIntegerField;
    clnWeigthUnits: TClientDataSet;
    clnWeigthUnitsWeigthUnitValue: TStringField;
    clnWeigthUnitsWeightUnit: TStringField;
    qryStoreDefaultWeightMeasureUnit: TStringField;
    clnItemStatus: TClientDataSet;
    qryItemStatus: TADOQuery;
    prvItemStatus: TDataSetProvider;
    clnItemStatusStatus: TStringField;
    clnItemStatusStatusDesc: TStringField;
    qryTransactions_TranVoidDate: TDateTimeField;
    qryTransactions_TranCloseReason: TSmallintField;
    qryUpdPawnStatus: TADOQuery;
    qryGetPawnStatusFromItems: TADOQuery;
    qryGetPawnStatusFromItemsPawnStatusCode: TSmallintField;
    qryGetPawnStatusFromItemsItemCount: TIntegerField;
    vilMain: TSVGIconVirtualImageList;
    svgMain: TSVGIconImageCollection;
    ADOQuery1: TADOQuery;
    qryTransactions_cPawnNextMinPayment: TStringField;
    vilMain24: TSVGIconVirtualImageList;
    qryPayments: TADOQuery;
    qryPaymentscComment: TStringField;
    qryPaymentscPeriodNo: TIntegerField;
    qryPaymentsPaymentNo: TAutoIncField;
    qryPaymentsTransactionNo: TIntegerField;
    qryPaymentsPayDate: TDateField;
    qryPaymentsPayAmount: TFloatField;
    qryPaymentsPayComment: TMemoField;
    qryPaymentsPayMethod: TSmallintField;
    qryPaymentsPayInterest: TFloatField;
    qryPaymentsPayPrincipal: TFloatField;
    qryPaymentsPrincBalance: TFloatField;
    qryPaymentsInsterestBalance: TFloatField;
    qryLastPayment: TADOQuery;
    qryLastPaymentLastPaymentDate: TDateField;
    qryPawnPay: TADOQuery;
    qryNextTicketNo: TADOQuery;
    qryNextTicketNoLastKey: TIntegerField;
    qryTotalPaid: TADOQuery;
    qryTotalPaidTotalPaid: TFloatField;
    qryStoreSalesTaxPerc: TFloatField;
    qryTransactions_TranSalesTax: TFloatField;
    qryTransactions_cTotalSalesAmount: TCurrencyField;
    qryItemImages: TADOQuery;
    qryItemImagesImagesDataNo: TIntegerField;
    qryItemImagesImageData: TBlobField;
    qryStoreDefaultPawnInterestRate: TFloatField;
    ConnFB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    qryDummyFB: TFDQuery;
    fn_GetNextKey: TFDStoredProc;
    qryBackupSetings: TFDQuery;
    qryBackupSetingsBACKUP_PATH: TStringField;
    qryBackupSetingsAUTO_BACKUP_WHEN_CLOSE_APP: TBooleanField;
    qryBackupSetingsBACKUP_IMAGES_PATH: TStringField;
    qryTransactions: TFDQuery;
    qryTransactionsTRANSACTION_NO: TIntegerField;
    qryTransactionsCUST_NO: TIntegerField;
    qryTransactionsTRAN_DATE: TDateField;
    qryTransactionsTRAN_TICKET_NO: TStringField;
    qryTransactionsTRAN_COMMENT: TMemoField;
    qryTransactionsTRAN_MATURITY: TDateField;
    qryTransactionsTRAN_TYPE: TStringField;
    qryTransactionsTRAN_STATUS: TStringField;
    qryTransactionsTRAN_VOID_DATE: TSQLTimeStampField;
    qryTransactionsTRAN_PAWN_AMOUNT: TFloatField;
    qryTransactionsTRAN_INTEREST: TFloatField;
    qryTransactionsPRINC_BALANCE: TFloatField;
    qryTransactionsINTEREST_BALANCE: TFloatField;
    qryTransactionsTRAN_TIME: TTimeField;
    qryTransactionsTRAN_CLOSE_REASON: TSmallintField;
    qryTransactionsTRAN_SALES_TAX: TFloatField;
    qryTransactionscComment: TStringField;
    qryTransactionscTranInsAmount1Month: TCurrencyField;
    qryTransactionscTotalPay1Month: TCurrencyField;
    qryTransactionscPawnDefaultDate: TDateTimeField;
    qryTransactionscTAmountRedeemDefaultDate: TCurrencyField;
    qryTransactionscAnnualPercRate: TFloatField;
    qryTransactionscPawnNextMinPayment: TStringField;
    qryTransactionscTranTotalInterestAtMaturity: TCurrencyField;
    qryTransactionscTranTotalAmountAtMaturity: TCurrencyField;
    qryTransactionscTotalSalesAmount: TCurrencyField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qryStoreCalcFields(DataSet: TDataSet);
    procedure qryPaymentsCalcFields(DataSet: TDataSet);
    procedure qryPaymentsNewRecord(DataSet: TDataSet);
    procedure qryTransactionsCalcFields(DataSet: TDataSet);
    procedure qryTransactionsNewRecord(DataSet: TDataSet);
    procedure qryCustomersNewRecord(DataSet: TDataSet);
    procedure clnSalesTranCalcFields(DataSet: TDataSet);
    procedure clnSalesTranNewRecord(DataSet: TDataSet);
    procedure qryCustomersAfterScroll(DataSet: TDataSet);
    procedure qryCustomersBeforePost(DataSet: TDataSet);
    procedure qryCustomersCalcFields(DataSet: TDataSet);
    procedure qryTransactionsTranDateChange(Sender: TField);
    procedure qryCustomersCustFlDrvLicGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryPaymentsAfterPost(DataSet: TDataSet);
    procedure qryTransactionsAfterScroll(DataSet: TDataSet);
  private
    procedure CheckForMissingDBChanges;
    procedure PopulateWeightUnits;
    procedure UpdatePawnItemStatusAndStage(TransactionNo: integer; CloseReason: smallint; PawnDefaultedItemAction: integer);
    function RoutineExists(const Conn: TADOConnection; const Schema, Name, RoutineType: string): Boolean;
    procedure EnsureLatePayObjects(const Conn: TADOConnection);
    function GetPawnPeriod(const PawnDate, CheckDate: TDateTime): Integer;
    procedure SendMessageToRefreshPaymentDueDateText;
  public
    SaveCustQry, SaveConnectionStr: string;
    ReCalcMaturity: boolean;
    function GetConnectionStr: string;
    procedure ConfigureFBConnection;
    procedure ConfigureFBConnectionFor(AConn: TFDConnection);
    function TestFBConnection(out ErrorMsg: string): Boolean;
    function GetNextKey(TableName: string): integer;
    procedure RefreshStoreQry;
    function GetBarcode(Key: integer): string;
    procedure CalcInterest(Amount: currency; var IntRate, IntAmount: extended);
    function LastPaymentForTransaction(TransactionNo: integer): TDateTime;
    function CalcNextInt(PrincipalBalance: Currency; InterestPerc: Currency; Months: integer): Currency;
    procedure LogBackupWithConnection(AConn: TFDConnection; const BckLocation: string);
    function BackupDatabaseToFileWithConnection(AConn: TFDConnection; BackupPath: string): string;
    function ShouldBackupImages: Boolean;
    procedure BackupImagesToFolderWithConnection(AConn: TFDConnection; const SourceFolder, TargetFolder: string; out CopiedCount, SkippedCount: integer; out ErrorMessage: string);
    procedure RunBackup(const ABackupPath, AImageTargetPath: string; ADoImageBackup: Boolean; out AResult: TBackupResult; AOnPhase: TBackupPhaseProc = nil);
    procedure SaveImageToFile(ImagesDataNo: integer; FileName: string);
    procedure ExportImageToPath(ImagesDataNo: integer; DestPath: string);
    function GetImageFilePath(ImagesDataNo: integer; ImageDate: TDateTime): string;
    procedure SaveImageToDatabase(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
    procedure GetImageFromDatabase(ImagesDataNo: integer; ImageComponent: TImage);
    procedure GetImageFromFile(ImagesDataNo: integer; ImageComponent: TImage);
    procedure SaveImageToFile_Method(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
    procedure SaveImageToFile_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
    procedure SaveImageToDatabase_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
    procedure DeleteImageFromDatabase(ImagesDataNo: integer);
    procedure DeleteImageFromFile(ImagesDataNo: integer);
    procedure ExportAllImagesToFolder(var ExportCount: integer; var ErrorMessage: string; ProgressLabel: TLabel = nil);
    function CalcPawnDefaultDate(TransactionDate: TDateTime; PawnDefaultMonths: integer): TDateTime;
    function GetPawnMaturityDate(TransactionDate: TDateTime): TDateTime;
    procedure GetWeightUnits(cln: TClientDataSet);
    function GetWeightUnitAbbr(WeightUnit: string): string;
    procedure FillPawnStatusCombobox(cb: TRzComboBox; StatusToSelect: String);
    procedure SetPawnAndItemsStatus(TransactionNo: integer; CloseReason: smallint; TranStatus: string; PawnDefaultedItemAction: integer);
    procedure PutPawnBackToActive(TransactionNo: integer);
    procedure RefreshADOQry(Qry: TADOQuery);
    procedure RefreshFBQry(Qry: TFDQuery);
    procedure UpdatePawnItemStatus(InvItemNo: integer; const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
    function GetPawnStatusFromItems(TransactionNo: integer): integer;
    procedure UpdatePawnStatusBaseOnItems(TransactionNo: integer);
    function GetCurrentInterestBalance(AsOfDate, PawnDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TADOQuery): Currency;
    procedure GetInterestAndNextPaymentInfo(AsOfDate, PawnDate, LastPaymentDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TADOQuery;
                                                out InterestBalanceAsOf: Currency; out InterestOwedToday: Currency;
                                                out NextPaymentDate: TDateTime; out InterestDueAtNext: Currency);
    function GetPawnPaymentUserMessageAboutBalancesAndDueDate: string;
    procedure GetPawnPaymentBalancesAndDueDate(out InterestBalanceAsOf: Currency; out InterestOwedToday: Currency; out NextPaymentDate: TDateTime; out InterestDueAtNext: Currency);
    function GetNextTicketNo(TicketKey: string): integer;
    function GetTotalPaid: Currency;
    procedure RecalcLayawayPBalance;
    procedure ReactivateLayway(TransactionNo: integer);
    procedure LaywayClosePayoffBalance(TransactionNo: integer; AddBalancePayment: boolean);
    function GetItemStatus(qryInvItems: TDataSet): string;
  end;

var
  DM: TDM;

implementation

Uses PawnGlobal, uPawnProIniPrinters, SearchClient, Nvv.FB5.DBA;

{$R *.DFM}

procedure TDM.RefreshStoreQry;
begin
  qryStore.Close;
  qryStore.Open;
end;

function TDM.GetBarcode(Key: integer): string;
begin
  Result := Format('%.6d', [Key]);
end;

function TDM.GetNextTicketNo(TicketKey: string): integer;
begin
  qryNextTicketNo.Close;
  qryNextTicketNo.Parameters.ParamByName('KeyName').Value := TicketKey;
  qryNextTicketNo.Open;

  Result := qryNextTicketNoLastKey.AsInteger + 1;

  qryNextTicketNo.Close;
end;

function TDM.GetNextKey(TableName: string): integer;
begin
  fn_GetNextKey.Params.ParamByName('TABLENAME').Value := TableName;
  fn_GetNextKey.ExecProc;
  Result := fn_GetNextKey.Params.ParamByName('NEXTTABLEKEY').Value;
end;

function ExistsFieldInTable(const TableName, FieldName: string): boolean;
begin
  Result := false;

  if (trim(TableName) = '') or (trim(FieldName) = '') then
    exit;

  try
    OpenSQLStatement('SELECT TOP 1 ' + FieldName + ' FROM ' + TableName);
    Result := true;
  except
  end;
end;

function ExistsIndexOnTable(const TableName, IndexName: string): boolean;
begin
  Result := false;

  if (trim(TableName) = '') or (trim(IndexName) = '') then
    exit;

  try
    OpenSQLStatement('SELECT 1 FROM SYS.SYSINDEX WHERE index_name = ' + QuotedStr(IndexName) +
                     ' AND table_id IN (SELECT table_id FROM SYS.SYSTABLE WHERE table_name = ' + QuotedStr(TableName) + ')');
    Result := true;
  except
  end;
end;

function SqlStr(const S: string): string;
begin
  Result := '''' + StringReplace(S, '''', '''''', [rfReplaceAll]) + '''';
end;

function TDM.RoutineExists(const Conn: TADOConnection;
  const Schema, Name, RoutineType: string): Boolean;
var
  Q: TADOQuery;
begin
  Q := TADOQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.ParamCheck := False;
    Q.SQL.Text :=
      'SELECT 1 ' + sLineBreak +
      'FROM sys.sysprocedure p ' + sLineBreak +
      'WHERE p.proc_name = ' + SqlStr(Name) + sLineBreak +
      '  AND user_name(p.creator) = ' + SqlStr(Schema);
    Q.Open;
    Result := not Q.IsEmpty;
  finally
    Q.Free;
  end;

end;


procedure TDM.EnsureLatePayObjects(const Conn: TADOConnection);
const
  SCHEMA_NAME = 'DBA';
  FN_NAME     = 'fn_TranWithLatePayment';
  SP_NAME     = 'Rep_CustomerWithLatePayments';
var
  RA: Integer;
  FN_SQL, SP_SQL: string;
begin
  FN_SQL :=
    'CREATE FUNCTION "DBA"."fn_TranWithLatePayment"( @TransactionNo integer, @Mons integer = 1 ) ' + sLineBreak +
    'RETURNS bit AS BEGIN ' + sLineBreak +
    '  DECLARE @R integer ' + sLineBreak +
    '  DECLARE @PawnDate date, @LastPayDay date, @CmpDate date ' + sLineBreak +
    '  SELECT @PawnDate = TranDate FROM Transactions WHERE TransactionNo = @TransactionNo ' + sLineBreak +
    '  SELECT @LastPayDay = max(PayDate) FROM Payments WHERE TransactionNo = @TransactionNo ' + sLineBreak +
    '  IF @LastPayDay IS NULL ' + sLineBreak +
    '    SET @CmpDate = @PawnDate ' + sLineBreak +
    '  ELSE SET @CmpDate = @LastPayDay ' + sLineBreak +
    '  IF abs(datediff(month, getdate(), @CmpDate)) > @Mons  SET @R = 1 ELSE SET @R = 0 ' + sLineBreak +
    '  RETURN @R ' + sLineBreak +
    'END';

  SP_SQL :=
    'CREATE OR REPLACE PROCEDURE "DBA"."Rep_CustomerWithLatePayments"( @Mons integer = 1 ) AS BEGIN ' + sLineBreak +
    '  CREATE TABLE #PawnTran( Custno integer NULL, TransactionNo integer NULL, LatePayment integer NULL ) ' + sLineBreak +
    '  INSERT INTO #PawnTran( Custno, TransactionNo, LatePayment ) ' + sLineBreak +
    '    SELECT T1.Custno, T2.TransactionNo, "DBA".fn_TranWithLatePayment(T2.TransactionNo, @Mons) ' + sLineBreak +
    '    FROM Customer AS T1 JOIN Transactions AS T2 ON T1.Custno = T2.CustNo ' + sLineBreak +
    '    WHERE T2.TranType = ''P'' AND T2.TranStatus = ''A'' ' + sLineBreak +
    '  SELECT TOP 1000 T1.TransactionNo, T3.TranTicketNo, CAST(T3.TranDate AS DateTime) AS TranDate, ' + sLineBreak +
    '         LatePayment, T2.Custno, T2.CustLast, T2.CustFirst, T2.CustMid, ' + sLineBreak +
    '         T2.CustPhCell, T2.CustPhHome, T2.CustPhBussiness, T3.TranPawnAmount ' + sLineBreak +
    '    FROM #PawnTran AS T1 ' + sLineBreak +
    '    JOIN Customer AS T2 ON T1.Custno = T2.Custno ' + sLineBreak +
    '    JOIN Transactions AS T3 ON T1.TransactionNo = T3.TransactionNo ' + sLineBreak +
    '    WHERE LatePayment = 1 ' + sLineBreak +
    '    ORDER BY T2.CustFirst ASC, T2.CustLast ASC, T2.Custno ASC ' + sLineBreak +
    '  DROP TABLE #PawnTran ' + sLineBreak +
    'END';

  // If you�re okay replacing definitions, you can skip existence checks entirely:
  // Conn.Execute(FN_SQL, RA, []);
  // Conn.Execute(SP_SQL, RA, []);

  if not RoutineExists(Conn, SCHEMA_NAME, FN_NAME, 'FUNCTION') then
    Conn.Execute(FN_SQL, RA, []);
  if not RoutineExists(Conn, SCHEMA_NAME, SP_NAME, 'PROCEDURE') then
    Conn.Execute(SP_SQL, RA, []);
end;

procedure TDM.CheckForMissingDBChanges;
begin
  if UpperCase(ParamStr(1)) = 'UPDB' then
    begin
      if not ExistsFieldInTable('Store', 'PawnDateCalculationBase') then
        ExecSQLStatement('ALTER TABLE Store ADD "PawnDateCalculationBase" char(1) NULL DEFAULT ''D''');

      if not ExistsFieldInTable('Store', 'SalesTaxPerc') then
        ExecSQLStatement('ALTER TABLE Store ADD "SalesTaxPerc" double NULL DEFAULT 7');

      //Unit weight
      if not ExistsFieldInTable('Store', 'DefaultWeightMeasureUnit') then
        ExecSQLStatement('ALTER TABLE Store ADD "DefaultWeightMeasureUnit" char(1) NULL ');

      // Update DefaultWeightMeasureUnit with 'P' if it's NULL
      if OpenSQLStatement('SELECT COUNT(*) FROM Store WHERE DefaultWeightMeasureUnit IS NULL OR DefaultWeightMeasureUnit = ''''') > 0 then
        ExecSQLStatement('UPDATE Store SET DefaultWeightMeasureUnit = ''P'' WHERE DefaultWeightMeasureUnit IS NULL OR DefaultWeightMeasureUnit = ''''');

      // Default Pawn Interest Rate
      if not ExistsFieldInTable('Store', 'DefaultPawnInterestRate') then
        ExecSQLStatement('ALTER TABLE Store ADD "DefaultPawnInterestRate" double NULL ');

      // Update DefaultPawnInterestRate with 10 if it's NULL
      if OpenSQLStatement('SELECT COUNT(*) FROM Store WHERE DefaultPawnInterestRate IS NULL') > 0 then
        ExecSQLStatement('UPDATE Store SET DefaultPawnInterestRate = 10 WHERE DefaultPawnInterestRate IS NULL');

      if not ExistsFieldInTable('InventoryItems', 'WeightUnit') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "WeightUnit" char(1) NULL ');

      if not ExistsFieldInTable('Stones', 'StoneWeightUnit') then
        ExecSQLStatement('ALTER TABLE Stones ADD "StoneWeightUnit" char(1) NULL ');

      EnsureLatePayObjects(ConnDB);
///
     if OpenSQLStatement('SELECT COUNT(*) FROM ItemStatus WHERE Status = ''C''') = 0 then
       ExecSQLStatement('INSERT INTO ItemStatus (Status, StatusDesc) VALUES(''C'', ''Close'');');

     if OpenSQLStatement('SELECT COUNT(*) FROM TransactionTypes WHERE TranType = ''L''') = 0 then
       ExecSQLStatement('INSERT INTO TransactionTypes (TranType, TranTypeDesc) VALUES(''L'', ''Layaway'');');

    if OpenSQLStatement('SELECT COUNT(*) FROM TableKeys WHERE TableName = ''LayawayTicketNo''') = 0 then
       ExecSQLStatement('INSERT INTO TableKeys (TableName, LastKey) VALUES(''LayawayTicketNo'', 0);');

    if OpenSQLStatement('SELECT COUNT(*) FROM ItemStatus WHERE Status = ''L''') = 0 then
       ExecSQLStatement('INSERT INTO ItemStatus (Status, StatusDesc) VALUES(''L'', ''Layaway'');');

     if not ExistsFieldInTable('Transactions', 'TranCloseReason') then
       ExecSQLStatement('ALTER TABLE Transactions ADD TranCloseReason SMALLINT DEFAULT 0 NOT NULL; ' +
                        'COMMENT ON COLUMN Transactions.TranCloseReason IS ''0-Open 1-Void 2-Redeemed 3-Defaulted 4-Mix Defaulted/Redeemed''');

      if not ExistsFieldInTable('Transactions', 'TranSalesTax') then
        ExecSQLStatement('ALTER TABLE Transactions ADD "TranSalesTax" double NULL');

      if not ExistsFieldInTable('InventoryItems', 'PawnedDate') then
      begin
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "PawnedDate" Date NULL ');
        ExecSQLStatement('UPDATE InventoryItems SET PawnedDate = cast(Created as Date) ' +
                         'WHERE TransactionNo in (SELECT TransactionNo FROM Transactions WHERE TranType = ''P'') ')
      end;

      if not ExistsFieldInTable('InventoryItems', 'PurchaseDate') then
      begin
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "PurchaseDate" Date NULL ');
        ExecSQLStatement('UPDATE InventoryItems SET PurchaseDate= cast(Created as Date) ' +
                         'WHERE TransactionNo in (SELECT TransactionNo FROM Transactions WHERE TranType = ''U'') ')
      end;

      if not ExistsFieldInTable('InventoryItems', 'RedeemedDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "RedeemedDate" Date NULL ');

      if not ExistsFieldInTable('InventoryItems', 'DefaultedDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "DefaultedDate" Date NULL ');

      if not ExistsFieldInTable('InventoryItems', 'MeltedDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "MeltedDate" Date NULL ');

      if not ExistsFieldInTable('InventoryItems', 'ForSaleDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "ForSaleDate" Date NULL ');

      if not ExistsFieldInTable('InventoryItems', 'SoldDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "SoldDate" Date NULL ');

      if not ExistsFieldInTable('InventoryItems', 'LayawayDate') then
        ExecSQLStatement('ALTER TABLE InventoryItems ADD "LayawayDate" Date NULL ');

      // Add BackupImagesPath to BackupSettings if it doesn't exist
      if not ExistsFieldInTable('BackupSettings', 'BackupImagesPath') then
        ExecSQLStatement('ALTER TABLE BackupSettings ADD "BackupImagesPath" varchar(255) NULL ');

      // Create ImagesDataBackup table if it doesn't exist
      if not ExistsFieldInTable('ImagesDataBackup', 'ID') then
      begin
        ExecSQLStatement('CREATE TABLE "DBA"."ImagesDataBackup" ( ' +
                         '"ID" bigint NOT NULL, ' +
                         '"ImagesDataNo" integer NOT NULL, ' +
                         'PRIMARY KEY CLUSTERED ("ID" ASC) )');
        ExecSQLStatement('CREATE UNIQUE INDEX "idx_ImagesDataNo" ON "DBA"."ImagesDataBackup" ( "ImagesDataNo" )');
      end;

      // Create covering index on InventoryItems if it doesn't exist
      if not ExistsIndexOnTable('InventoryItems', 'idx_InvItemStatus_Covering') then
        ExecSQLStatement('CREATE INDEX "idx_InvItemStatus_Covering" ON "DBA"."InventoryItems" ' +
                         '( "InvItemStatus" ASC, "JType" ASC, "JStyle" ASC, "JMetal" ASC, ' +
                         '"InvItemNo", "InvItemBarcode", "InvCatNo", "InvItemCount", "Note", ' +
                         '"SizeLength", "Weight", "KT", "Created", "UnitCost", "UnitPrice" )');

      // Audit table for inventory status/date changes
      if not ExistsFieldInTable('InventoryItemStatusLog', 'LogId') then
      begin
        ExecSQLStatement('CREATE TABLE "DBA"."InventoryItemStatusLog" ( ' +
                         '"LogId" bigint NOT NULL DEFAULT autoincrement, ' +
                         '"InvItemNo" integer NOT NULL, ' +
                         '"OldStatus" char(1) NULL, "NewStatus" char(1) NOT NULL, ' +
                         '"OldPawnedDate" date NULL, "NewPawnedDate" date NULL, ' +
                         '"OldPurchaseDate" date NULL, "NewPurchaseDate" date NULL, ' +
                         '"OldRedeemedDate" date NULL, "NewRedeemedDate" date NULL, ' +
                         '"OldDefaultedDate" date NULL, "NewDefaultedDate" date NULL, ' +
                         '"OldMeltedDate" date NULL, "NewMeltedDate" date NULL, ' +
                         '"OldForSaleDate" date NULL, "NewForSaleDate" date NULL, ' +
                         '"OldSoldDate" date NULL, "NewSoldDate" date NULL, ' +
                         '"OldLayawayDate" date NULL, "NewLayawayDate" date NULL, ' +
                         '"ChangedBy" varchar(50) NULL, ' +
                         '"ChangedAt" "datetime" NOT NULL DEFAULT current timestamp, ' +
                         'PRIMARY KEY ("LogId" ASC) )');
        ExecSQLStatement('CREATE INDEX "idx_InvStatusLog_Item" ON "DBA"."InventoryItemStatusLog" ( "InvItemNo", "ChangedAt" DESC )');
      end
      else if not ExistsIndexOnTable('InventoryItemStatusLog', 'idx_InvStatusLog_Item') then
        ExecSQLStatement('CREATE INDEX "idx_InvStatusLog_Item" ON "DBA"."InventoryItemStatusLog" ( "InvItemNo", "ChangedAt" DESC )');

      // Trigger to log status/date changes on InventoryItems
      if OpenSQLStatement('SELECT COUNT(*) FROM sys.systrigger WHERE trigger_name = ''trg_InvItems_StatusLog''') = 0 then
        ExecSQLStatement('CREATE TRIGGER "DBA"."trg_InvItems_StatusLog" ' +
                         'AFTER UPDATE OF InvItemStatus, PawnedDate, PurchaseDate, RedeemedDate, ' +
                         '                DefaultedDate, MeltedDate, ForSaleDate, SoldDate, LayawayDate ' +
                         'ON "DBA"."InventoryItems" ' +
                         'REFERENCING OLD AS oldrow NEW AS newrow ' +
                         'FOR EACH ROW ' +
                         'BEGIN ' +
                         '  IF oldrow.InvItemStatus IS DISTINCT FROM newrow.InvItemStatus ' +
                         '     OR oldrow.PawnedDate    IS DISTINCT FROM newrow.PawnedDate ' +
                         '     OR oldrow.PurchaseDate  IS DISTINCT FROM newrow.PurchaseDate ' +
                         '     OR oldrow.RedeemedDate  IS DISTINCT FROM newrow.RedeemedDate ' +
                         '     OR oldrow.DefaultedDate IS DISTINCT FROM newrow.DefaultedDate ' +
                         '     OR oldrow.MeltedDate    IS DISTINCT FROM newrow.MeltedDate ' +
                         '     OR oldrow.ForSaleDate   IS DISTINCT FROM newrow.ForSaleDate ' +
                         '     OR oldrow.SoldDate      IS DISTINCT FROM newrow.SoldDate ' +
                         '     OR oldrow.LayawayDate   IS DISTINCT FROM newrow.LayawayDate ' +
                         '  THEN ' +
                         '    INSERT INTO "DBA"."InventoryItemStatusLog" ( ' +
                         '      InvItemNo, OldStatus, NewStatus, ' +
                         '      OldPawnedDate,    NewPawnedDate, ' +
                         '      OldPurchaseDate,  NewPurchaseDate, ' +
                         '      OldRedeemedDate,  NewRedeemedDate, ' +
                         '      OldDefaultedDate, NewDefaultedDate, ' +
                         '      OldMeltedDate,    NewMeltedDate, ' +
                         '      OldForSaleDate,   NewForSaleDate, ' +
                         '      OldSoldDate,      NewSoldDate, ' +
                         '      OldLayawayDate,   NewLayawayDate, ' +
                         '      ChangedBy ' +
                         '    ) ' +
                         '    VALUES ( ' +
                         '      newrow.InvItemNo, oldrow.InvItemStatus, newrow.InvItemStatus, ' +
                         '      oldrow.PawnedDate,    newrow.PawnedDate, ' +
                         '      oldrow.PurchaseDate,  newrow.PurchaseDate, ' +
                         '      oldrow.RedeemedDate,  newrow.RedeemedDate, ' +
                         '      oldrow.DefaultedDate, newrow.DefaultedDate, ' +
                         '      oldrow.MeltedDate,    newrow.MeltedDate, ' +
                         '      oldrow.ForSaleDate,   newrow.ForSaleDate, ' +
                         '      oldrow.SoldDate,      newrow.SoldDate, ' +
                         '      oldrow.LayawayDate,   newrow.LayawayDate, ' +
                         '      USER ' +
                         '    ); ' +
                         '  END IF; ' +
                         'END');

      // Create GoldPriceHistory table if it doesn't exist
      if not ExistsFieldInTable('GoldPriceHistory', 'PriceID') then
      begin
        ExecSQLStatement('CREATE TABLE "DBA"."GoldPriceHistory" (' +
                         '"PriceID" integer NOT NULL DEFAULT autoincrement,' +
                         '"PricePerOunce" numeric(10, 2) NOT NULL,' +
                         '"Currency" varchar(3) NOT NULL DEFAULT ''USD'',' +
                         '"FetchDateTime" "datetime" NOT NULL DEFAULT current timestamp,' +
                         '"Source" varchar(50) NOT NULL DEFAULT ''CryptoCompare'',' +
                         '"APIResponse" long varchar NULL,' +
                         'PRIMARY KEY ("PriceID" ASC))');

        // Create index on GoldPriceHistory
        ExecSQLStatement('CREATE INDEX "idx_GoldPrice_FetchDateTime" ON "DBA"."GoldPriceHistory" ( "FetchDateTime" DESC )');
      end;

      // Create stored procedure for gold price if it doesn't exist
      if not RoutineExists(ConnDB, 'DBA', 'spi_GoldPrice', 'PROCEDURE') then
        ExecSQLStatement('CREATE PROCEDURE "DBA"."spi_GoldPrice"( @PricePerOunce numeric(10,2),@Currency varchar(3) ) ' +
                         'as ' +
                         'begin ' +
                         'declare @LastGPrice numeric(10,2) ' +
                         'select top 1 @LastGPrice = PricePerOunce from GoldPriceHistory order by PriceID desc ' +
                         'set @LastGPrice = isnull(@LastGPrice,0) ' +
                         'if @LastGPrice <> @PricePerOunce ' +
                         'insert into GoldPriceHistory( PricePerOunce,Currency,FetchDateTime,Source ) values( @PricePerOunce,@Currency,current timestamp,''CryptoCompare'' ) ' +
                         'select LastGPrice=@LastGPrice ' +
                         'end');

    end;
end;

function TDM.GetWeightUnitAbbr(WeightUnit: string): string;
begin
  if WeightUnit = WeightUnitPennyweight then
    Result := 'dwt'
  else if WeightUnit = WeightUnitGram then
    Result := 'g'
  else
    Result := '';

end;

procedure TDM.GetWeightUnits(cln: TClientDataSet);
begin
  cln.Data := clnWeigthUnits.Data;
end;

procedure TDM.PopulateWeightUnits;
begin
  clnWeigthUnits.Close;
  clnWeigthUnits.CreateDataSet;

  clnWeigthUnits.Append;
  clnWeigthUnits.FieldByName('WeigthUnitValue').AsString := WeightUnitPennyweight;
  clnWeigthUnits.FieldByName('WeightUnit').AsString := 'Pennyweight';
  clnWeigthUnits.Post;

  clnWeigthUnits.Append;
  clnWeigthUnits.FieldByName('WeigthUnitValue').AsString := WeightUnitGram;
  clnWeigthUnits.FieldByName('WeightUnit').AsString := 'Grams';
  clnWeigthUnits.Post;

end;

function TDM.GetConnectionStr: string;
var
  IniFile: TIniFile;
  PWD, UID, DBN, ENG, HOST: string;
begin

  RegIniFile.Path := LocalIniFile;

  IniFile := TIniFile.Create(GlobalIniFile);
  try
    PWD := 'KAKITA';
    UID := 'dba';
    DBN := IniFile.ReadString(IniSecConn, 'dbn', '');
    ENG := IniFile.ReadString(IniSecConn, 'eng', '');
    HOST := IniFile.ReadString(IniSecConn, 'host', '');
//    Driver := IniFile.ReadString(IniSecConn, 'driver', '');
  finally
   IniFile.Free;
  end;

  Result := Format('Provider=SAOLEDB.12;Password=%s;Persist Security Info=True;User ID=%s;Initial Catalog=%s;Extended Properties="CommLinks=SharedMemory,TCPIP{HOST=%s};ServerName=%s"',
                    [PWD, UID, DBN, HOST, ENG]);
end;

// Reads [CONNECTION_FB] from the global PawnPro.ini and configures the given
// TFDConnection with the same params used for ConnFB. Lets background tasks
// build a thread-local connection without duplicating the INI-read logic.
// Does NOT open the connection — caller decides when.
procedure TDM.ConfigureFBConnectionFor(AConn: TFDConnection);
var
  IniFile: TIniFile;
  Server, Database, User, Password, CharSet: string;
  Port: Integer;
const
  IniSecConnFB = 'CONNECTION_FB';
begin
  IniFile := TIniFile.Create(GlobalIniFile);
  try
    Server   := IniFile.ReadString (IniSecConnFB, 'host',     'localhost');
    Database := IniFile.ReadString (IniSecConnFB, 'database', '');
    User     := IniFile.ReadString (IniSecConnFB, 'user',     'sysdba');
    Password := IniFile.ReadString (IniSecConnFB, 'password', 'masterkey');
    Port     := IniFile.ReadInteger(IniSecConnFB, 'port',     3050);
    CharSet  := IniFile.ReadString (IniSecConnFB, 'charset',  'UTF8');
  finally
    IniFile.Free;
  end;

  AConn.Connected := False;
  AConn.Params.Clear;
  AConn.DriverName := 'FB';
  AConn.Params.Values['Server']       := Server;
  AConn.Params.Values['Database']     := Database;
  AConn.Params.Values['User_Name']    := User;
  AConn.Params.Values['Password']     := Password;
  AConn.Params.Values['Protocol']     := 'TCPIP';
  AConn.Params.Values['Port']         := IntToStr(Port);
  AConn.Params.Values['CharacterSet'] := CharSet;
  AConn.LoginPrompt := False;
end;

// Convenience wrapper that targets the data module's own ConnFB. Used at
// app startup; the parameterized version is used by background tasks.
procedure TDM.ConfigureFBConnection;
begin
  ConfigureFBConnectionFor(ConnFB);
end;

// Probe: configure, open, run trivial query, close. Returns True on success;
// on failure ErrorMsg holds "[ExceptionClass] message" so the caller can show
// it directly. Throwaway test for Phase 1.1.
function TDM.TestFBConnection(out ErrorMsg: string): Boolean;
var
  q: TFDQuery;
begin
  ErrorMsg := '';
  try
    ConfigureFBConnection;
    ConnFB.Connected := True;
    try
      q := TFDQuery.Create(nil);
      try
        q.Connection := ConnFB;
        q.SQL.Text := 'SELECT 1 AS X FROM RDB$DATABASE';
        q.Open;
        Result := q.Fields[0].AsInteger = 1;
      finally
        q.Free;
      end;
    finally
      ConnFB.Connected := False;
    end;
  except
    on E: Exception do
    begin
      ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
      Result := False;
    end;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  FlagValue: string;
  fbErr: string;
begin
  SaveCustQry := DM.qryCustomers.SQL.Text;
  SaveConnectionStr := GetConnectionStr;

  RegIniFile.Path := LocalIniFile;

  { Read IsLocalDatabase flag from INI file, create with default 'Y' if not exists }
  FlagValue := ReadIniFile(IniSecDatabase, IniKeyIsLocalDatabase);
  if FlagValue = '' then
  begin
    WriteIniFile(IniSecDatabase, IniKeyIsLocalDatabase, 'Y');
    FlagValue := 'Y';
  end;
  IsLocalDatabase := FlagValue <> 'N';

//  WriteTextFile(AppPath + 'ConnStr2.txt', ConnStr);

//  ShowMessage(ConnStr);

  ConnDB.Connected := false;
  ConnDB.ConnectionString := SaveConnectionStr;
  ConnDB.Connected := true;

  // Phase 1.2 — open ConnFB persistently in parallel with ADO ConnDB. Both
  // connections live for the lifetime of the data module.
  ConfigureFBConnection;
  try
    ConnFB.Connected := True;
  except
    on E: Exception do
    begin
      ShowMessage('FB5 connection: FAILED' + sLineBreak + sLineBreak +
                  'Database: ' + ConnFB.Params.Values['Database'] + sLineBreak +
                  'Server:   ' + ConnFB.Params.Values['Server'] + sLineBreak +
                  'Port:     ' + ConnFB.Params.Values['Port'] + sLineBreak + sLineBreak +
                  'Error: [' + E.ClassName + '] ' + E.Message);
      raise;
    end;
  end;

  // Phase 1.2 probe — exercise the new helper. Removed before Phase 2.
  try
    fbErr := IntToStr(Integer(OpenSQLStatementFB('SELECT COUNT(*) FROM CUSTOMER')));
    ShowMessage('FB OK. CUSTOMER count via OpenSQLStatementFB = ' + fbErr);
  except
    on E: Exception do
      ShowMessage('FB helper test FAILED: [' + E.ClassName + '] ' + E.Message);
  end;

  CheckForMissingDBChanges;

  QryStates.Open;
  QryStates.Last;
  QryStates.First;

  clnItemStatus.Open;
  qryItemStatus.Close;

  RefreshStoreQry;

  InterestCalcMethod := qryStoreInterestCalcMethod.AsInteger;
  PawnDatesCalcMethod := qryStorePawnDateCalculationBase.AsString;
  if (PawnDatesCalcMethod <> PawnDateCalcByDays) and (PawnDatesCalcMethod <> PawnDateCalcByMonth) then
    PawnDatesCalcMethod := PawnDateCalcByDays;

  DefaultWeightMeasureUnit := qryStoreDefaultWeightMeasureUnit.AsString;

  PopulateWeightUnits;

  LoadPrinterSettingsFromIni(GlobalIniFile, AppPrinterSettings);
(*  Using ODBC driver
  ConnStr := Format('Provider=MSDASQL.1;Persist Security Info=True;Extended Properties="driver=%s;pwd=%s;uid=%s;dbn=%s;eng=%s;CommLinks=SharedMemory,TCPIP{HOST=%s}"',
                    [Driver, PWD, UID, DBN, ENG, HOST]);
*)

end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  // Close FB connection cleanly. Mirrors implicit ADO close.
  if ConnFB.Connected then
    ConnFB.Connected := False;
end;

procedure TDM.qryStoreCalcFields(DataSet: TDataSet);
begin
  qryStorecCity.AsString := Copy(qryStoreStoreCityStZIP.AsString, 1, pos(',', qryStoreStoreCityStZIP.AsString) - 1);
  qryStorecState.AsString := Copy(qryStoreStoreCityStZIP.AsString, pos(',', qryStoreStoreCityStZIP.AsString)+ 2, 2);
  qryStorecZIp.AsString := Copy(qryStoreStoreCityStZIP.AsString, pos(',', qryStoreStoreCityStZIP.AsString)+ 5, 255);
end;

procedure TDM.qryPaymentsAfterPost(DataSet: TDataSet);
begin
  SendMessageToRefreshPaymentDueDateText;
end;

procedure TDM.qryPaymentsCalcFields(DataSet: TDataSet);
begin
  qryPaymentscComment.AsString := Copy(qryPaymentsPayComment.AsString, 1, 255);
  qryPaymentscPeriodNo.AsInteger := GetPawnPeriod(qryTransactionsTRAN_DATE.AsDateTime, qryPaymentsPayDate.AsDateTime);
end;

procedure TDM.qryPaymentsNewRecord(DataSet: TDataSet);
begin
  qryPaymentsPayDate.AsDateTime := Date;
//  qryPaymentsPaymentNo.AsInteger := GetNextKey('Payments');
  qryPaymentsTransactionNo.AsInteger := qryTransactionsTRANSACTION_NO.AsInteger;
end;

function TDM.CalcNextInt(PrincipalBalance: Currency; InterestPerc: Currency; Months: integer): Currency;
begin
  if Months = 0 then
    Inc(Months);

  Result := PrincipalBalance * InterestPerc * (Months);
end;

function TDM.LastPaymentForTransaction(TransactionNo: integer): TDateTime;
begin
  qryLastPayment.Close;
  qryLastPayment.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
  qryLastPayment.Open;

  Result := qryLastPaymentLastPaymentDate.AsDateTime;

  qryLastPayment.Close;
end;

function TDM.CalcPawnDefaultDate(TransactionDate: TDateTime; PawnDefaultMonths: integer): TDateTime;
begin
  if UpperCase(PawnDatesCalcMethod) = PawnDateCalcByMonth then
    Result := IncMonth(TransactionDate, PawnDefaultMonths)
  else
    Result := IncDay(TransactionDate, PawnDefaultMonths * 30);

end;

function TDM.GetPawnMaturityDate(TransactionDate: TDateTime): TDateTime;
begin
  Result := CalcPawnDefaultDate(TransactionDate, qryStoreDefaultMaturityMonths.AsInteger);
end;

function TDM.GetCurrentInterestBalance(AsOfDate, PawnDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TADOQuery): Currency;
var
  DueMonths, PeriodIndex: Integer;
  TotalAccrued, TotalInterestPaid: Currency;
  MonthlyRate: Double;
  PeriodStart: TDateTime;

  CurrentPrincipal: Currency;
  PayDt: TDateTime;
begin
  // Normalize to date-only
  AsOfDate := Trunc(AsOfDate);
  PawnDate := Trunc(PawnDate);

  // If asking before the pawn exists, nothing is due
  if AsOfDate < PawnDate then
    Exit(0);

  // FRONT-LOADED RULE:
  //  - 1 month interest is due immediately at PawnDate
  //  - plus one extra month for each month anniversary passed
  //
  // Example:
  //   PawnDate = 10/06
  //   AsOf    = 10/25 -> MonthsBetween = 0 -> DueMonths = 1  (first month)
  //   AsOf    = 11/10 -> MonthsBetween = 1 -> DueMonths = 2  (first + second)
  DueMonths := 1 + MonthsBetween(PawnDate, AsOfDate);
  if DueMonths < 1 then
    DueMonths := 1;

  MonthlyRate := InterestRate / 100.0;

  TotalAccrued := 0;
  TotalInterestPaid := 0;

  // --- 1) ACCRUED (DUE) INTEREST: period-based, with changing principal ---
  if (DueMonths > 0) and (MonthlyRate > 0) and (PawnAmount > 0) then
  begin
    CurrentPrincipal := PawnAmount;

    // Payments must be sorted by PayDate ascending
    if Assigned(qryPayments) and qryPayments.Active then
      qryPayments.First;

    for PeriodIndex := 0 to DueMonths - 1 do
    begin
      PeriodStart := IncMonth(PawnDate, PeriodIndex);

      // Apply principal changes from payments BEFORE this period start.
      // Rule: principal changes inside a period affect NEXT periods only.
      while Assigned(qryPayments) and (not qryPayments.Eof) do
      begin
        PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);

        if PayDt < PeriodStart then
        begin
          // PrincBalance is the principal AFTER that payment.
          CurrentPrincipal := qryPayments.FieldByName('PrincBalance').AsCurrency;
          qryPayments.Next;
        end
        else
          Break;  // this payment belongs to this or a future period
      end;

      if CurrentPrincipal < 0 then
        CurrentPrincipal := 0;

      // Interest due for this full month:
      TotalAccrued := TotalAccrued + (CurrentPrincipal * MonthlyRate);
    end;
  end;

  // --- 2) TOTAL INTEREST PAID up to AsOfDate ---
  if Assigned(qryPayments) and qryPayments.Active then
  begin
    qryPayments.First;
    while not qryPayments.Eof do
    begin
      PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);
      if PayDt <= AsOfDate then
        TotalInterestPaid := TotalInterestPaid +
          qryPayments.FieldByName('PayInterest').AsCurrency
      else
        Break;  // assuming ordered by PayDate ASC
      qryPayments.Next;
    end;
  end;

  // --- 3) FINAL RESULT ---
  //   > 0 => interest still owed
  //   < 0 => interest overpaid (prepaid)
  Result := TotalAccrued - TotalInterestPaid;
end;

procedure TDM.GetInterestAndNextPaymentInfo(
  AsOfDate, PawnDate, LastPaymentDate: TDateTime;
  PawnAmount, InterestRate: Currency; qryPayments: TADOQuery;
  out InterestBalanceAsOf: Currency;
  out InterestOwedToday: Currency;
  out NextPaymentDate: TDateTime;
  out InterestDueAtNext: Currency);
var
  MonthlyRate: Double;
  TotalInterestPaid: Currency;
//  PaidMonths: Integer;
  CoveredInterest: Currency;
  ResidualPrepaid: Currency;
  PeriodIndex: Integer;
  PeriodStart: TDateTime;
  PayDt: TDateTime;
  PrincipalSim: Currency;
  PrincipalCurrent: Currency;
  PrincipalNext: Currency;
  MonthInterestCurrent: Currency;
  MonthInterestNext: Currency;
  PawnYear, PawnMonth, PawnDay: Word;
  ElapsedMonths: Integer;
begin
  // Normalize dates (date-only)
  AsOfDate := Trunc(AsOfDate);
  PawnDate := Trunc(PawnDate);
  // LastPaymentDate is currently not needed in this version, kept for signature compatibility

  // 1) Interest balance as of AsOfDate (>0 owed, <0 prepaid, 0 = exactly current)
  InterestBalanceAsOf := GetCurrentInterestBalance(
    AsOfDate, PawnDate, PawnAmount, InterestRate, qryPayments
  );

  MonthlyRate := InterestRate / 100.0;

  // Quick exit if no interest or no principal
  if (MonthlyRate <= 0) or (PawnAmount <= 0) then
  begin
    InterestOwedToday  := 0;
    NextPaymentDate    := 0;
    InterestDueAtNext  := 0;
    Exit;
  end;

  // 2) Total interest PAID up to AsOfDate
  TotalInterestPaid := 0;
  if Assigned(qryPayments) and qryPayments.Active then
  begin
    qryPayments.First;
    while not qryPayments.Eof do
    begin
      PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);
      if PayDt <= AsOfDate then
        TotalInterestPaid := TotalInterestPaid +
          qryPayments.FieldByName('PayInterest').AsCurrency
      else
        Break;
      qryPayments.Next;
    end;
  end;

  // 3) Determine how many FULL months of interest are covered by TotalInterestPaid
  //    using the same period-based principal logic as GetCurrentInterestBalance.
//  PaidMonths      := 0;
  CoveredInterest := 0;
  PrincipalSim    := PawnAmount;

  if (TotalInterestPaid > 0) and Assigned(qryPayments) and qryPayments.Active then
  begin
    qryPayments.First;
    PeriodIndex := 0;

    while CoveredInterest + 0.000001 < TotalInterestPaid do
    begin
      PeriodStart := IncMonth(PawnDate, PeriodIndex);

      // Apply principal changes from payments BEFORE this period start.
      while not qryPayments.Eof do
      begin
        PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);
        if PayDt < PeriodStart then
        begin
          PrincipalSim := qryPayments.FieldByName('PrincBalance').AsCurrency;
          qryPayments.Next;
        end
        else
          Break;
      end;

      if PrincipalSim <= 0 then
        Break;

      MonthInterestCurrent := PrincipalSim * MonthlyRate;

      // If the paid interest fully covers this month, mark it as paid
      if CoveredInterest + MonthInterestCurrent <= TotalInterestPaid + 0.000001 then
      begin
        CoveredInterest := CoveredInterest + MonthInterestCurrent;
//        Inc(PaidMonths);
        Inc(PeriodIndex);
      end
      else
        Break; // partial coverage -> next payment (prepayment) applies to this month
    end;
  end
  else
  begin
    // No interest paid at all => PaidMonths = 0
//    PaidMonths      := 0;
    CoveredInterest := 0;
  end;

  // Residual prepaid interest beyond full months
  ResidualPrepaid := TotalInterestPaid - CoveredInterest;
  if ResidualPrepaid < 0 then
    ResidualPrepaid := 0;

  // 4) Determine current period and next anchor based on AsOfDate
  //    - ElapsedMonths: number of full month steps from PawnDate to AsOfDate
  //    - Current period starts at PawnDate + ElapsedMonths
  //    - Next payment date (next interest anchor) is PawnDate + (ElapsedMonths + 1)
  ElapsedMonths := MonthsBetween(PawnDate, AsOfDate);
  DecodeDate(PawnDate, PawnYear, PawnMonth, PawnDay);

  // Start of the current interest period
  PeriodStart := IncMonth(PawnDate, ElapsedMonths);
  // Due date / next anchor after AsOfDate
  NextPaymentDate := IncMonth(PawnDate, ElapsedMonths + 1);

  // 5) Principal at start of CURRENT period (for "current month" interest)
  PrincipalCurrent := PawnAmount;
  if Assigned(qryPayments) and qryPayments.Active then
  begin
    qryPayments.First;
    while not qryPayments.Eof do
    begin
      PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);
      if PayDt < PeriodStart then
      begin
        PrincipalCurrent := qryPayments.FieldByName('PrincBalance').AsCurrency;
        qryPayments.Next;
      end
      else
        Break;
    end;
  end;
  if PrincipalCurrent < 0 then
    PrincipalCurrent := 0;

  MonthInterestCurrent := PrincipalCurrent * MonthlyRate;

  // 6) Principal at start of NEXT period (for next month's interest chunk)
  PrincipalNext := PawnAmount;
  if Assigned(qryPayments) and qryPayments.Active then
  begin
    qryPayments.First;
    // Start of NEXT period = NextPaymentDate
    while not qryPayments.Eof do
    begin
      PayDt := Trunc(qryPayments.FieldByName('PayDate').AsDateTime);
      if PayDt < NextPaymentDate then
      begin
        PrincipalNext := qryPayments.FieldByName('PrincBalance').AsCurrency;
        qryPayments.Next;
      end
      else
        Break;
    end;
  end;
  if PrincipalNext < 0 then
    PrincipalNext := 0;

  MonthInterestNext := PrincipalNext * MonthlyRate;

  // 7) Interest due at NEXT anchor:
  //    - Base is next month's simple interest
  //    - Minus any residual prepaid interest not yet "consumed" by full months
  InterestDueAtNext := MonthInterestNext - ResidualPrepaid;
  if InterestDueAtNext < 0 then
    InterestDueAtNext := 0;

  // 8) Interest Owed Today (past-due only):
  //    - Total interest required to redeem today = InterestBalanceAsOf
  //    - Current period's interest = MonthInterestCurrent
  //    - Past-due interest = max(0, total - current-period chunk)
  InterestOwedToday := InterestBalanceAsOf - MonthInterestCurrent;
  if InterestOwedToday < 0 then
    InterestOwedToday := 0;
end;

procedure TDM.GetPawnPaymentBalancesAndDueDate(out InterestBalanceAsOf: Currency;
                                               out InterestOwedToday: Currency;
                                               out NextPaymentDate: TDateTime;
                                               out InterestDueAtNext: Currency);
var
  AsOfDate: TDateTime;
  LastPayDate: TDateTime;
begin
  LastPayDate := LastPaymentForTransaction(qryTransactionsTRANSACTION_NO.AsInteger);

  if Date > LastPayDate then
    AsOfDate := Date
  else
    AsOfDate := LastPayDate;

    if Assigned(qryPayments) and qryPayments.Active then
      begin
        qryPawnPay.Clone(qryPayments);
        qryPawnPay.Sort := 'PayDate ASC';
      end;

    GetInterestAndNextPaymentInfo(AsOfDate,
                                     DM.qryTransactionsTRAN_DATE.AsDateTime,
                                     LastPayDate,
                                     DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency,
                                     DM.qryTransactionsTRAN_INTEREST.AsCurrency,
                                     qryPawnPay,
                                     InterestBalanceAsOf, //out
                                     InterestOwedToday,   //out
                                     NextPaymentDate,     //out
                                     InterestDueAtNext);  //out

    if (InterestOwedToday = 0) and (InterestDueAtNext = 0) then
      Abort; // already paid all (forgot to change Pawn Status

end;

function TDM.GetPawnPaymentUserMessageAboutBalancesAndDueDate: string;
var
//  AsOfDate: TDateTime;
//  LastPayDate: TDateTime;
  outInterestBalanceAsOf: Currency;
  outInterestOwedToday: Currency;
  outNextPaymentDate: TDatetime;
  outInterestDueAtNext: Currency;
begin
  Result := '';
  if (qryTransactionsTRAN_STATUS.AsString = TranStatus_Active) and (qryTransactionsTRAN_TYPE.AsString = TranPawn) then
    begin
      GetPawnPaymentBalancesAndDueDate(outInterestBalanceAsOf,
                                       outInterestOwedToday,
                                       outNextPaymentDate,
                                       outInterestDueAtNext);
//      LastPayDate := LastPaymentForTransaction(qryTransactionsTRANSACTION_NO.AsInteger);
//
//      if Date > LastPayDate then
//        AsOfDate := Date
//      else
//        AsOfDate := LastPayDate;
//
////      MonthSinceLastPayment := MonthsBetween(AsOfDate, LastPayDate);
//
//      if Assigned(qryPayments) and qryPayments.Active then
//        begin
//          qryPawnPay.Clone(qryPayments);
//          qryPawnPay.Sort := 'PayDate ASC';
//        end;
//
//      GetInterestAndNextPaymentInfo(AsOfDate,
//                                       DM.qryTransactionsTRAN_DATE.AsDateTime,
//                                       LastPayDate,
//                                       DM.qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency,
//                                       DM.qryTransactionsTRAN_INTEREST.AsCurrency,
//                                       qryPawnPay,
//                                       outInterestBalanceAsOf,
//                                       outInterestOwedToday,
//                                       outNextPaymentDate,
//                                       outInterestDueAtNext);
//
//      if (outInterestOwedToday = 0) and (outInterestDueAtNext = 0) then
//        exit; // already paid all (forgot to change Pawn Status

     Result := Format('Interest Owed Today:<b> %m </b>. Interest Required to Redeem Today:<b> %m </b>. On<b> %s </b>, another<b> %m </b>will be added.',
                          [ outInterestOwedToday,   // Interest Owed Today
                            outInterestBalanceAsOf,  // Interest Required to Redeem Today
                            FormatDateTime('mm/dd/yyyy', outNextPaymentDate),
                            outInterestDueAtNext    // Next period interest
                          ]);

(*
Result := Format(
  'Interest Owed Today: %m. Interest Required to Redeem Today: %m. On %s, another %m will be added.',
  [
    outInterestOwedToday,                         // e.g. 240
    outInterestBalanceAsOf,                       // e.g. 300
    FormatDateTime('mm/dd/yyyy', outNextPaymentDate),
    outInterestDueAtNext                          // e.g. 60
  ]
);
*)
    end;


// Interest Owed Today: $40.00. Interest Required to Redeem Today: $80.00. Next Interest Due: $40.00 on 12/16/2025
end;

procedure TDM.SendMessageToRefreshPaymentDueDateText;
begin
  PostMessage(frmClients.Handle, sx_RefreshPaymentDueDateMesg, 0, 0);
end;

procedure TDM.qryTransactionsAfterScroll(DataSet: TDataSet);
begin
  SendMessageToRefreshPaymentDueDateText;
end;

procedure TDM.qryTransactionsCalcFields(DataSet: TDataSet);
var
  DefaultMonthsToRedeem: integer;
  MaturityMonths: integer;
//  IntPerc: Currency;
  InterestAtDefaultDate: Currency;
  OneMonthInterest: Currency;
  CurrentIntBalanceMsg: string;
begin
  DefaultMonthsToRedeem := qryStorePawnDefaultMonths.AsInteger; //2;  // Store table ->  PawnDefaultMonths
  MaturityMonths        := qryStoreDefaultMaturityMonths.AsInteger;   // DefaultMaturityMonths
  CurrentIntBalanceMsg := '';

  if DefaultMonthsToRedeem < MaturityMonths then
    DefaultMonthsToRedeem := MaturityMonths;

  OneMonthInterest := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency * (qryTransactionsTRAN_INTEREST.AsFloat / 100);
  qryTransactionscComment.AsString := Copy(qryTransactionsTRAN_COMMENT.AsString, 1, 255);

  qryTransactionscTranTotalInterestAtMaturity.AsCurrency := OneMonthInterest * MaturityMonths;
  qryTransactionscTranTotalAmountAtMaturity.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency + qryTransactionscTranTotalInterestAtMaturity.AsCurrency;

  InterestAtDefaultDate := (DefaultMonthsToRedeem * OneMonthInterest);
  qryTransactionscTranInsAmount1Month.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency *
                                                   (1 * qryTransactionsTRAN_INTEREST.AsFloat) / 100;
  qryTransactionscTotalPay1Month.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency + OneMonthInterest;
  qryTransactionscAnnualPercRate.AsFloat := qryTransactionsTRAN_INTEREST.AsFloat * 12;
  qryTransactionscPawnDefaultDate.AsDateTime := CalcPawnDefaultDate(qryTransactionsTRAN_DATE.AsDateTime, DefaultMonthsToRedeem);
  qryTransactionscTAmountRedeemDefaultDate.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency + InterestAtDefaultDate;

  if qryTransactionsTRAN_SALES_TAX.AsCurrency > 0 then
    qryTransactionscTotalSalesAmount.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency + qryTransactionsTRAN_SALES_TAX.AsCurrency
  else
    qryTransactionscTotalSalesAmount.AsCurrency := qryTransactionsTRAN_PAWN_AMOUNT.AsCurrency;

  SendMessageToRefreshPaymentDueDateText;
//  qryTransactionscPawnNextMinPayment.AsString := GetPawnPaymentUserMessageAboutBalancesAndDueDate;
end;

function TDM.GetPawnPeriod(const PawnDate, CheckDate: TDateTime): Integer;
var
  PawnD, CheckD : TDateTime;
  Period        : Integer;
  NextStartDate : TDateTime;
begin
  // Normalize to pure dates (ignore time part)
  PawnD  := Trunc(PawnDate);
  CheckD := Trunc(CheckDate);

  // If the check date is before the pawn date, there is no valid period
  if CheckD < PawnD then
  begin
    Result := 0; // or 1, depending on your business rule
    Exit;
  end;

  // Start at period 1
  Period := 1;
  // First "next period start" is PawnDate + 1 month
  NextStartDate := IncMonth(PawnD, 1);

  // While the payment date is on or after the next period start,
  // move to the next period.
  while CheckD >= NextStartDate do
  begin
    Inc(Period);
    NextStartDate := IncMonth(NextStartDate, 1);
  end;

  Result := Period;
end;

procedure TDM.qryTransactionsNewRecord(DataSet: TDataSet);
var
  IntRate: double;
begin
  if qryStoreDefaultPawnInterestRate.AsFloat > 0 then
    IntRate := qryStoreDefaultPawnInterestRate.AsFloat
  else
    IntRate := 10;

  // TRANSACTION_NO is FB IDENTITY - assigned on Post via UpdateOptions.AutoIncFields
  qryTransactionsTRAN_DATE.AsDateTime := Date;
  qryTransactionsTRAN_MATURITY.AsDateTime := GetPawnMaturityDate(qryTransactionsTRAN_DATE.AsDateTime);
  qryTransactionsCUST_NO.AsInteger := qryCustomersCustNo.AsInteger;
  qryTransactionsTRAN_INTEREST.AsFloat := IntRate;
  qryTransactionsTRAN_TYPE.AsString := 'P';
  qryTransactionsTRAN_STATUS.AsString := 'A';
  qryTransactionsPRINC_BALANCE.AsFloat := 0;
  qryTransactionsINTEREST_BALANCE.AsFloat := 0;
end;

procedure TDM.qryTransactionsTranDateChange(Sender: TField);
begin
  if ReCalcMaturity then
    qryTransactionsTRAN_MATURITY.AsDateTime := GetPawnMaturityDate(qryTransactionsTRAN_DATE.AsDateTime);

end;

procedure TDM.qryCustomersNewRecord(DataSet: TDataSet);
begin
  qryCustomersCustCity.AsString := qryStorecCity.AsString;
  qryCustomersCustState.AsString := qryStorecState.AsString;
  qryCustomersCustZip.AsString := qryStorecZIp.AsString;
end;

procedure TDM.CalcInterest(Amount: currency; var IntRate, IntAmount: extended);
var
  modAmount: Integer;
  rAmount: Currency;
begin
  if IntRate <= 0 then
    IntRate := 10;

  case InterestCalcMethod of
  1: //Standard Method 10% min $5.00
    begin
      if Amount < 50.0 then
        begin
          IntAmount := 5.0;
          //Calc effective Interest rate
          IntRate := (IntAmount / Amount) * 100.0;
          exit;
        end;
//      IntRate := 10;
      IntAmount := Amount * IntRate / 100.0;
    end;
  2: //Kendale Method min $5.00. Interest 10% rounding to upper multiple of $5.00
     //Ex:  $50 -> $5   $60 -> $10   $70 -> $10   $100 -> $10  $110 -> $15
    begin
      if Amount < 50.0 then  //Min $50.00
        begin
          IntAmount := 5.0;
          //Calc effective Interest rate
          IntRate := (IntAmount / Amount) * 100.0;
          exit;
        end;
      modAmount := trunc(Amount) mod 50;
      if modAmount > 0 then
        begin
          rAmount := (trunc(Amount) - modAmount) + 50;
          IntAmount := rAmount * 0.10;
          //Calc effective Interest rate
          IntRate := (IntAmount / Amount) * 100.0; 
        end
      else  //Multiple of $50 standard 10%
        begin
 //         IntRate := 10.0;
          IntAmount := Amount * IntRate / 100.0;
        end;

    end;
  end;
end;

procedure TDM.clnSalesTranCalcFields(DataSet: TDataSet);
begin
  clnSalesTrancComment.AsString := clnSalesTranTranComment.AsString;
end;

procedure TDM.clnSalesTranNewRecord(DataSet: TDataSet);
begin
  clnSalesTranTransactionNo.AsInteger := DM.GetNextKey('Transactions');
  clnSalesTranTranTicketNo.AsInteger := DM.GetNextKey('SaleTicketNo');
  clnSalesTranTranDate.AsDateTime := Now;
//  qryTransactionsTRAN_MATURITY.AsDateTime := IncMonth(Date, 1);
  clnSalesTranCustNo.AsInteger := 0;
  clnSalesTranTranType.AsString := 'S';
  clnSalesTranTranStatus.AsString := 'A'
end;

procedure TDM.qryCustomersAfterScroll(DataSet: TDataSet);
begin
  qryTransactions.Close;
  qryTransactions.Params.ParamByName('CUST_NO').AsInteger := qryCustomersCustno.AsInteger;
  qryTransactions.Open;
end;

procedure TDM.qryCustomersBeforePost(DataSet: TDataSet);
begin
  if qryCustomersCustno.AsInteger = 0 then
    qryCustomersCustno.AsInteger := GetNextKey('Customer');
end;

procedure TDM.qryCustomersCalcFields(DataSet: TDataSet);
begin
  qryCustomerscCustPhHome.AsString := FormatPhoneUSA(qryCustomersCustPhHome.AsString);
  qryCustomersCCustPhBussiness.AsString := FormatPhoneUSA(qryCustomersCustPhBussiness.AsString);
  qryCustomersCCustPhBeep.AsString := FormatPhoneUSA(qryCustomersCustPhBeep.AsString);
  qryCustomerscCustPhCell.AsString := FormatPhoneUSA(qryCustomersCustPhCell.AsString);
  if trim(qryCustomersCustFlDrvLic.AsString) <> '' then
    qryCustomerscCustFlDrvLic.AsString := FormatFLDriverLic(trim(qryCustomersCustFlDrvLic.AsString));

  if qryCustomersCustDOB.AsDateTime > 0 then
    qryCustomerscCustAge.AsInteger := YearsBetween(Date, qryCustomersCustDOB.AsDateTime)
  else
    qryCustomerscCustAge.AsInteger := 0;
end;

procedure TDM.qryCustomersCustFlDrvLicGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatFLDriverLic(Sender.AsString);
end;

procedure TDM.LogBackupWithConnection(AConn: TFDConnection; const BckLocation: string);
var
  Q: TFDQuery;
begin
  if AConn = nil then
    raise EArgumentNilException.Create('TDM.LogBackupWithConnection: AConn is nil');

  if not AConn.Connected then
    AConn.Connected := True;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text := 'INSERT INTO BACKUP_HISTORY (BCK_DATE, BCK_PATH) VALUES (CURRENT_TIMESTAMP, :BCK_PATH)';
    Q.ParamByName('BCK_PATH').AsString := BckLocation;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TDM.SaveImageToFile(ImagesDataNo: integer; FileName: string);
begin
  qryImage.Close;
  qryImage.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryImage.Open;
  qryImageImageData.SaveToFile(FileName);
  qryImage.Close;
end;

procedure TDM.ExportImageToPath(ImagesDataNo: integer; DestPath: string);
var
  LookupQuery: TADOQuery;
  ImageDate: TDateTime;
  SrcPath: string;
begin
  if ImageStorageMode = 'FILE' then
  begin
    LookupQuery := TADOQuery.Create(nil);
    try
      LookupQuery.Connection := ConnDB;
      LookupQuery.SQL.Text := 'SELECT Created FROM ImagesData WHERE ImagesDataNo = :ImagesDataNo';
      LookupQuery.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;
      LookupQuery.Open;
      if LookupQuery.Eof or LookupQuery.FieldByName('Created').IsNull then
        ImageDate := 0
      else
        ImageDate := LookupQuery.FieldByName('Created').AsDateTime;
    finally
      LookupQuery.Free;
    end;

    SrcPath := GetImageFilePath(ImagesDataNo, ImageDate);
    if FileExists(SrcPath) then
      CopyFile(PChar(SrcPath), PChar(DestPath), False)
    else
      raise Exception.CreateFmt('Image file not found: %s', [SrcPath]);
  end
  else
    SaveImageToFile(ImagesDataNo, DestPath);
end;


procedure TDM.FillPawnStatusCombobox(cb: TRzComboBox; StatusToSelect: String);
var
  i: Integer;
  iStatus: integer;
begin
  clnItemStatus.First;

  iStatus := -1;
  cb.Clear;
  i := 0;
  while not clnItemStatus.Eof do
    begin
      cb.Items.Add(clnItemStatusStatusDesc.AsString);
      if StatusToSelect = clnItemStatusStatus.AsString then
        iStatus := i;

      inc(i);

      clnItemStatus.Next;
    end;

  cb.ItemIndex := iStatus;
end;

procedure TDM.UpdatePawnStatusBaseOnItems(TransactionNo: integer);
var
  PawnStatus: integer;
  NeedUpdate: boolean;
  CloseReason: smallint;
  TranStatus: string;
begin
  NeedUpdate := false;
  PawnStatus := GetPawnStatusFromItems(TransactionNo);
  CloseReason := 0;
  case PawnStatus of
  0: // Pawned Active
    begin
      if qryTransactionsTRAN_STATUS.AsString <> 'A' then
        begin
          CloseReason := 0;
          TranStatus := 'A';
          NeedUpdate := true;
        end;
    end;
  2: // Pawn Redeemed
    begin
      if (qryTransactionsTRAN_STATUS.AsString = 'A') or (qryTransactionsTRAN_CLOSE_REASON.AsInteger <> 2) then
        begin
          CloseReason := 2;
          TranStatus := 'I';
          NeedUpdate := true;
        end;
    end;
  3: // Pawn Defaulted
    begin
      if (qryTransactionsTRAN_STATUS.AsString = 'A') or (qryTransactionsTRAN_CLOSE_REASON.AsInteger <> 3) then
        begin
          CloseReason := 3;
          TranStatus := 'I';
          NeedUpdate := true;
        end;
    end;
  4: // Pawn Items Status mix Redeemed and or  Defaulted
    begin
      if (qryTransactionsTRAN_STATUS.AsString = 'A') or (qryTransactionsTRAN_CLOSE_REASON.AsInteger <> 4) then
        begin
          CloseReason := 4;
          TranStatus := 'I';
          NeedUpdate := true;
        end;
    end;

  end;


  if NeedUpdate then
    begin
      qryUpdPawnStatus.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
      qryUpdPawnStatus.Parameters.ParamByName('TranCloseReason').Value := CloseReason;
      qryUpdPawnStatus.Parameters.ParamByName('TranStatus').Value := TranStatus;
      qryUpdPawnStatus.ExecSQL;
    end;

end;

procedure TDM.UpdatePawnItemStatus(InvItemNo: integer; const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
var
  sDefaultedDate, sRedeemedDate, sMeltedDate, sForSaleDate: string;
  sSQL: string;
begin
  sRedeemedDate := 'Null';
  sDefaultedDate := 'Null';
  sMeltedDate := 'Null';
  sForSaleDate := 'Null';

  if not VarIsNull(RedeemedDate) then
    sRedeemedDate := AsaDateToStr(RedeemedDate);

  if not VarIsNull(DefaultedDate) then
    sDefaultedDate := AsaDateToStr(DefaultedDate);

  if not VarIsNull(MeltedDate) then
    sMeltedDate := AsaDateToStr(MeltedDate);

  if not VarIsNull(ForSaleDate) then
    sForSaleDate := AsaDateToStr(ForSaleDate);

  sSQL := Format('UPDATE InventoryItems SET RedeemedDate = %s, DefaultedDate = %s, MeltedDate = %s, ForSaleDate = %s ' +
                 ' WHERE InvItemNo = %d ',
                [sRedeemedDate, sDefaultedDate, sMeltedDate, sForSaleDate, InvItemNo]);

  ConnDB.Execute(sSQL);

end;

procedure TDM.UpdatePawnItemStatusAndStage(TransactionNo: integer; CloseReason: smallint; PawnDefaultedItemAction: integer);
var
  sDefaultedDate, sRedeemedDate, sMeltedDate, sForSaleDate: string;
  sSQL: string;
begin
  sRedeemedDate := 'Null';
  sDefaultedDate := 'Null';
  sMeltedDate := 'Null';
  sForSaleDate := 'Null';

  if CloseReason = PawnCloseReasonRedeemed then
    sRedeemedDate := AsaDateToStr(Date);

  if CloseReason = PawnCloseReasonDefaulted then
    sDefaultedDate := AsaDateToStr(Date);

  //Item Actions

  if PawnDefaultedItemAction > 0 then
    begin
      if PawnDefaultedItemAction = PawnDefaultedItemMelted then
        sMeltedDate := AsaDateToStr(Date);

     if PawnDefaultedItemAction = PawnDefaultedItemForSale then
        sForSaleDate := AsaDateToStr(Date);
    end;

    sSQL := Format('UPDATE InventoryItems SET RedeemedDate = %s, DefaultedDate = %s, MeltedDate = %s, ForSaleDate = %s ' +
                   ' WHERE TransactionNo = %d and InvItemStatus = ''P'' and RedeemedDate is null and DefaultedDate is NULL ',
                  [sRedeemedDate, sDefaultedDate, sMeltedDate, sForSaleDate, TransactionNo]);

    ConnDB.Execute(sSQL);

end;

procedure TDM.SetPawnAndItemsStatus(TransactionNo: integer; CloseReason: smallint; TranStatus: string; PawnDefaultedItemAction: integer);
begin
  try
    ConnDB.BeginTrans;

    qryUpdPawnStatus.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
    qryUpdPawnStatus.Parameters.ParamByName('TranCloseReason').Value := CloseReason;
    qryUpdPawnStatus.Parameters.ParamByName('TranStatus').Value := TranStatus;
    qryUpdPawnStatus.ExecSQL;

    UpdatePawnItemStatusAndStage(TransactionNo, CloseReason, PawnDefaultedItemAction);

    ConnDB.CommitTrans;
  except
    on E: Exception do
    begin
      if ConnDB.InTransaction then
        ConnDB.RollbackTrans;

      raise Exception.Create('Error updating pawn status: ' + E.Message);
    end;
  end;
end;

procedure TDM.PutPawnBackToActive(TransactionNo: integer);
var
  sSQLItemsStatus: string;
  sTransactionNo: string;
begin
  sTransactionNo := IntToStr(TransactionNo);
  sSQLItemsStatus := 'UPDATE InventoryItems SET RedeemedDate = null, DefaultedDate = null, MeltedDate = null, ForSaleDate = null ' + sLineBreak +
                     'WHERE TransactionNo = ' + sTransactionNo + ' and InvItemStatus = ''P'' and SoldDate is null';

  try
    ConnDB.BeginTrans;

    ConnDB.Execute('update Transactions set TranStatus = ''A'', TranCloseReason=0 where TransactionNo = ' + sTransactionNo);

    ConnDB.Execute(sSQLItemsStatus);

    ConnDB.CommitTrans;
  except
    on E: Exception do
    begin
      if ConnDB.InTransaction then
        ConnDB.RollbackTrans;

      raise Exception.Create('Error updating pawn status: ' + E.Message);
    end;
  end;


end;

procedure TDM.ReactivateLayway(TransactionNo: integer);
var
  sSQLItemsStatus: string;
  sTransactionNo: string;
begin
  sTransactionNo := IntToStr(TransactionNo);

  try
    ConnDB.BeginTrans;

    qryTransactions.Edit;
    qryTransactionsTRAN_STATUS.AsString := TranStatus_Active;
    qryTransactionsPRINC_BALANCE.AsCurrency := 0;
    qryTransactions.Post;

    sSQLItemsStatus := 'UPDATE InventoryItems SET SoldDate=null ' + sLineBreak +
                       'WHERE TransactionNo = ' + sTransactionNo + ' and InvItemStatus = ''L'' ';

    ConnDB.Execute(sSQLItemsStatus);

    ConnDB.CommitTrans;
  except
    on E: Exception do
    begin
      if ConnDB.InTransaction then
        ConnDB.RollbackTrans;

      raise Exception.Create('Error updating Layaway status: ' + E.Message);
    end;
  end;

end;

procedure TDM.LaywayClosePayoffBalance(TransactionNo: integer; AddBalancePayment: boolean);
var
  TotalPaid: Currency;
  sSQLItemsStatus: string;
  sTransactionNo: string;
begin
  sTransactionNo := IntToStr(TransactionNo);
  if AddBalancePayment then
    TotalPaid := GetTotalPaid
  else
    TotalPaid := 0;

  try
    ConnDB.BeginTrans;

    //////////// Payment /////////////
    if AddBalancePayment then
    begin
      qryPayments.Append;

      if TotalPaid <= qryTransactionscTotalSalesAmount.AsCurrency  then
        qryPaymentsPayAmount.AsCurrency := qryTransactionscTotalSalesAmount.AsCurrency - TotalPaid
      else
        raise Exception.Create('Total payments are greater than Total Transaction Amount');

      qryPaymentsPayPrincipal.AsCurrency := qryPaymentsPayAmount.AsCurrency;
      qryPaymentsPrincBalance.AsCurrency := 0;
      qryPaymentsInsterestBalance.AsCurrency := 0;
      qryPayments.Post;
    end;
    /////////////End Payment///////////////

    qryTransactions.Edit;
    qryTransactionsTRAN_STATUS.AsString := TranStatus_Inactive;
    qryTransactionsPRINC_BALANCE.AsCurrency := 0;
    qryTransactions.Post;

    sSQLItemsStatus := 'UPDATE InventoryItems SET SoldDate=current timestamp ' + sLineBreak +
                       'WHERE TransactionNo = ' + sTransactionNo + ' and InvItemStatus = ''L'' and LayawayDate is not NULL AND SoldDate is null';

    ConnDB.Execute(sSQLItemsStatus);

    ConnDB.CommitTrans;
  except
    on E: Exception do
    begin
      if ConnDB.InTransaction then
        ConnDB.RollbackTrans;

      raise Exception.Create('Error updating Layaway status: ' + E.Message);
    end;
  end;
end;

procedure TDM.RefreshADOQry(Qry: TADOQuery);
var
  SavePos: integer;
begin
  if Qry.RecNo > 0 then
    begin
      SavePos := Qry.RecNo;

      Qry.DisableControls;
      try
        Qry.Close;
        Qry.Open;
        Qry.RecNo := SavePos;
      finally
        Qry.EnableControls;
      end;
    end;
end;

procedure TDM.RefreshFBQry(Qry: TFDQuery);
var
  SavePos: integer;
begin
  if Qry.RecNo > 0 then
    begin
      SavePos := Qry.RecNo;

      Qry.DisableControls;
      try
        Qry.Close;
        Qry.Open;
        Qry.RecNo := SavePos;
      finally
        Qry.EnableControls;
      end;
    end;
end;

function TDM.GetPawnStatusFromItems(TransactionNo: integer): integer;
begin
  Result := -1;
  qryGetPawnStatusFromItems.Close;
  qryGetPawnStatusFromItems.Parameters.ParamByName('TransactionNo').Value := TransactionNo;
  qryGetPawnStatusFromItems.Open;

  if qryGetPawnStatusFromItemsItemCount.AsInteger > 0 then
    Result := qryGetPawnStatusFromItemsPawnStatusCode.AsInteger;

  qryGetPawnStatusFromItems.Close;
end;

function TDM.GetTotalPaid: Currency;
begin
  qryTotalPaid.Close;
  qryTotalPaid.Parameters.ParamByName('TransactionNo').Value := qryTransactionsTRANSACTION_NO.AsInteger;
  qryTotalPaid.Open;

  Result := qryTotalPaidTotalPaid.AsCurrency;

  qryTotalPaid.Close;
end;

procedure TDM.RecalcLayawayPBalance;
var
  TotalPaid, PricBalance: Currency;
begin
  TotalPaid := GetTotalPaid;
  PricBalance := DM.qryTransactionscTotalSalesAmount.AsCurrency - TotalPaid;

  DM.qryTransactions.Edit;
  DM.qryTransactionsPRINC_BALANCE.AsFloat := PricBalance;
  DM.qryTransactions.Post;
end;

function TDM.GetItemStatus(qryInvItems: TDataSet): string;
begin
  if qryInvItems.FieldByName('InvItemNo').IsNull then
    exit;

  if qryInvItems.FieldByName('InvItemStatus').AsString = TranPawn then
    begin
      Result := 'Pawned';
    end
  else if qryInvItems.FieldByName('InvItemStatus').AsString = TranPurchase then
    begin
      Result := 'Purchase';
      if not qryInvItems.FieldByName('MeltedDate').IsNull then
        Result := 'Melted'
      else if not qryInvItems.FieldByName('ForSaleDate').IsNull then
        Result := 'For Sale';
    end
  else if qryInvItems.FieldByName('InvItemStatus').AsString = TranLayaway then
    begin
      Result := 'Layaway';
      if not qryInvItems.FieldByName('SoldDate').IsNull then
        Result := 'Sold / Close';
    end
  else if qryInvItems.FieldByName('InvItemStatus').AsString = TranForSale then
    begin
      Result := 'For Sale';
    end;
end;

function TDM.GetImageFilePath(ImagesDataNo: integer; ImageDate: TDateTime): string;
var
  YearMonth: string;
begin
  { Generate path structure: ImagesStoragePath\YYYYMM\ImagesDataNo.jpg }
  YearMonth := FormatDateTime('yyyymm', ImageDate);
  Result := IncludeTrailingPathDelimiter(ImagesStoragePath) + YearMonth + PathDelim + IntToStr(ImagesDataNo) + '.jpg';
end;

procedure TDM.SaveImageToDatabase(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
begin
  qryItemImages.Close;
  qryItemImages.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryItemImages.Open;

  qryItemImages.Edit;
  qryItemImagesImageData.LoadFromStream(ImageData);
  qryItemImages.Post;
end;

procedure TDM.GetImageFromDatabase(ImagesDataNo: integer; ImageComponent: TImage);
var
  BlobStream: TStream;
begin
  qryImage.Close;
  qryImage.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryImage.Open;
  
  if not qryImage.Eof then
  begin
    BlobStream := qryImage.CreateBlobStream(qryImageImageData, bmRead);
    try
      ImageComponent.Picture.LoadFromStream(BlobStream);
    finally
      BlobStream.Free;
    end;
  end;
  qryImage.Close;
end;

procedure TDM.GetImageFromFile(ImagesDataNo: integer; ImageComponent: TImage);
var
  FilePath: string;
  SelectQuery: TADOQuery;
  ImageDate: TDateTime;
begin
  SelectQuery := TADOQuery.Create(nil);
  try
    SelectQuery.Connection := ConnDB;

    SelectQuery.SQL.Text :=
      'SELECT Created ' +
      'FROM ImagesData ' +
      'WHERE ImagesDataNo = :ImagesDataNo';

    // ADO: use parameter name WITHOUT the colon
    SelectQuery.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    SelectQuery.Open;

    if not SelectQuery.Eof then
    begin
      // Guard against NULL Created
      if SelectQuery.FieldByName('Created').IsNull then
        ImageDate := 0
      else
        ImageDate := SelectQuery.FieldByName('Created').AsDateTime;

      FilePath := GetImageFilePath(ImagesDataNo, ImageDate);

      if FileExists(FilePath) then
        ImageComponent.Picture.LoadFromFile(FilePath)
      else
        ImageComponent.Picture.Assign(nil);  // Clear image if file not found
    end;
  finally
    SelectQuery.Free;
  end;
end;

procedure TDM.SaveImageToFile_Method(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
var
  FilePath: string;
  FileStream: TFileStream;
  YearMonthFolder: string;
begin
  FilePath := GetImageFilePath(ImagesDataNo, ImageDate);
  YearMonthFolder := ExtractFileDir(FilePath);
  
  { Create directory if it doesn't exist }
  if not DirectoryExists(YearMonthFolder) then
    ForceDirectories(YearMonthFolder);
  
  { Save image to file }
  FileStream := TFileStream.Create(FilePath, fmCreate or fmShareExclusive);
  try
    ImageData.Position := 0;
    FileStream.CopyFrom(ImageData, ImageData.Size);
  finally
    FileStream.Free;
  end;
end;

procedure TDM.SaveImageToFile_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
var
  DestPath: string;
  DestDir: string;
  InStream: TFileStream;
  OutStream: TFileStream;
begin
  DestPath := GetImageFilePath(ImagesDataNo, ImageDate);
  DestDir := ExtractFileDir(DestPath);

  { Create destination directory if it doesn't exist }
  if not DirectoryExists(DestDir) then
    ForceDirectories(DestDir);

  { Copy the source file into our managed storage }
  InStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    OutStream := TFileStream.Create(DestPath, fmCreate or fmShareExclusive);
    try
      OutStream.CopyFrom(InStream, InStream.Size);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure TDM.DeleteImageFromDatabase(ImagesDataNo: Integer);
var
  DeleteQuery: TADOQuery;
begin
  DeleteQuery := TADOQuery.Create(nil);
  try
    DeleteQuery.Connection := ConnDB;
    DeleteQuery.SQL.Text := 'DELETE FROM ImagesData WHERE ImagesDataNo = :ImagesDataNo';

    // ADO: use parameter name WITHOUT the colon
    DeleteQuery.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    DeleteQuery.ExecSQL;
  finally
    DeleteQuery.Free;
  end;
end;

procedure TDM.DeleteImageFromFile(ImagesDataNo: Integer);
var
  FilePath: string;
  SelectQuery: TADOQuery;
  ImageDate: TDateTime;
begin
  SelectQuery := TADOQuery.Create(nil);
  try
    SelectQuery.Connection := ConnDB;
    SelectQuery.SQL.Text := 'SELECT Created FROM ImagesData WHERE ImagesDataNo = :ImagesDataNo';

    // ADO: use parameter name WITHOUT the colon
    SelectQuery.Parameters.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    SelectQuery.Open;

    if not SelectQuery.Eof then
    begin
      // Guard against NULL Created
      if SelectQuery.FieldByName('Created').IsNull then
        ImageDate := 0
      else
        ImageDate := SelectQuery.FieldByName('Created').AsDateTime;

      FilePath := GetImageFilePath(ImagesDataNo, ImageDate);

      if FileExists(FilePath) then
        DeleteFile(FilePath);
    end;
  finally
    SelectQuery.Free;
  end;
end;

procedure TDM.SaveImageToDatabase_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SaveImageToDatabase(ImagesDataNo, FileStream, ImageDate);
  finally
    FileStream.Free;
  end;
end;

function TDM.BackupDatabaseToFileWithConnection(AConn: TFDConnection; BackupPath: string): string;
const
  KeepLastNBackups = 7;
begin
  if AConn = nil then
    raise EArgumentNilException.Create('TDM.BackupDatabaseToFileWithConnection: AConn is nil');

  Result := TFB5DBA.BackupDatabase(AConn, BackupPath, 'PawnPro', KeepLastNBackups);
end;

// Synchronous; safe to call from a worker thread. Creates its own TFDConnection
// so it does not share state with TDM.ConnFB. Reports phase transitions through
// AOnPhase (callback runs on whatever thread RunBackup was invoked on - the
// caller is responsible for marshalling to the UI thread if needed).
procedure TDM.RunBackup(const ABackupPath, AImageTargetPath: string;
  ADoImageBackup: Boolean; out AResult: TBackupResult;
  AOnPhase: TBackupPhaseProc = nil);

  procedure NotifyPhase(Phase: TBackupPhase);
  begin
    if Assigned(AOnPhase) then
      AOnPhase(Phase);
  end;

var
  Conn: TFDConnection;
begin
  AResult := Default(TBackupResult);

  NotifyPhase(bpStarting);
  Conn := TFDConnection.Create(nil);
  try
    try
      ConfigureFBConnectionFor(Conn);

      NotifyPhase(bpDatabase);
      AResult.WrittenFile := BackupDatabaseToFileWithConnection(Conn, ABackupPath);

      if ADoImageBackup then
      begin
        NotifyPhase(bpImages);
        Conn.Connected := True;
        BackupImagesToFolderWithConnection(Conn, ImagesStoragePath, AImageTargetPath,
          AResult.CopiedCount, AResult.SkippedCount, AResult.ImageError);
      end;

      NotifyPhase(bpLogging);
      try
        LogBackupWithConnection(Conn, AResult.WrittenFile);
      except
        on E: Exception do
          AResult.LogError := E.Message;
      end;
    except
      on E: Exception do
        AResult.BackupError := E.Message;
    end;
  finally
    Conn.Free;
    NotifyPhase(bpDone);
  end;
end;

function TDM.ShouldBackupImages: Boolean;
var
  LastBackupStr: string;
  LastBackupDate: TDateTime;
  DaysSinceBackup: Integer;
  Today: TDateTime;
begin
  Result := False;
  Today := Date;
  
  // Read last backup date from INI (stored in same directory as EXE)
  // Format is ISO 8601: YYYY-MM-DD (locale-independent)
  LastBackupStr := ReadIniFile(IniSecImageBackup, IniKeyImageBackupLastBackupDate);
  
  // If never backed up before, do it now
  if Trim(LastBackupStr) = '' then
  begin
    Result := True;
    Exit;
  end;
  
  // Parse the last backup date from ISO format (YYYY-MM-DD)
  try
    LastBackupDate := EncodeDate(
      StrToInt(Copy(LastBackupStr, 1, 4)),    // Year
      StrToInt(Copy(LastBackupStr, 6, 2)),    // Month
      StrToInt(Copy(LastBackupStr, 9, 2))     // Day
    );
  except
    // If date is invalid, treat as never backed up
    Result := True;
    Exit;
  end;
  
  // Calculate days since last backup
  DaysSinceBackup := Trunc(Today - LastBackupDate);
  
  // Backup if more than 7 days ago
  if DaysSinceBackup > 7 then
  begin
    Result := True;
    Exit;
  end;
  
  // Backup on Tuesday (DayOfWeek: 1=Sunday, 2=Monday, 3=Tuesday...)
  // But only if not already done today
  if (DayOfWeek(Today) = 3) and (DaysSinceBackup > 0) then
  begin
    Result := True;
    Exit;
  end;
end;

procedure TDM.BackupImagesToFolderWithConnection(AConn: TFDConnection; const SourceFolder, TargetFolder: string; out CopiedCount, SkippedCount: integer; out ErrorMessage: string);
var
  CheckQuery, InsertQuery, ExistsQuery, MissingQuery: TFDQuery;
  SourceRoot, TargetRoot: string;

  function ExtractImagesDataNo(const FileName: string): integer;
  var
    BaseName, Digits: string;
    I: integer;
  begin
    BaseName := ChangeFileExt(ExtractFileName(FileName), '');
    Digits := '';
    for I := 1 to Length(BaseName) do
    begin
      if CharInSet(BaseName[I], ['0'..'9']) then
        Digits := Digits + BaseName[I]
      else
        Break;
    end;

    if Digits = '' then
      Result := -1
    else
      Result := StrToIntDef(Digits, -1);
  end;

  function AlreadyBackedUp(const ImagesDataNo: integer): boolean;
  begin
    CheckQuery.Close;
    CheckQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := ImagesDataNo;
    CheckQuery.Open;
    Result := not CheckQuery.Eof;
  end;

  function ExistsInImagesData(const ImagesDataNo: integer): boolean;
  begin
    ExistsQuery.Close;
    ExistsQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := ImagesDataNo;
    ExistsQuery.Open;
    Result := not ExistsQuery.Eof;
  end;

  procedure MarkBackedUp(const ImagesDataNo: integer);
  begin
    InsertQuery.Params.ParamByName('ID').AsInteger := ImagesDataNo;
    InsertQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := ImagesDataNo;
    InsertQuery.ExecSQL;
  end;

  procedure ProcessFolder(const CurrentSource: string);
  var
    SR: TSearchRec;
    CurrentPath, FullSource, RelativePath, DestinationDir, DestinationFile: string;
    ImagesDataNo: integer;
  begin
    CurrentPath := IncludeTrailingPathDelimiter(CurrentSource);

    if FindFirst(CurrentPath + '*.*', faAnyFile, SR) = 0 then
    try
      repeat
        if (SR.Name = '.') or (SR.Name = '..') then
          Continue;

        if (SR.Attr and faDirectory) = faDirectory then
          ProcessFolder(CurrentPath + SR.Name)
        else
        begin
          FullSource := CurrentPath + SR.Name;
          ImagesDataNo := ExtractImagesDataNo(SR.Name);

          if ImagesDataNo = -1 then
          begin
            Inc(SkippedCount);
            Continue;
          end;

          try
            if not ExistsInImagesData(ImagesDataNo) then
            begin
              Inc(SkippedCount);
              Continue;
            end;

            if AlreadyBackedUp(ImagesDataNo) then
            begin
              Inc(SkippedCount);
              Continue;
            end;

            RelativePath := Copy(FullSource, Length(SourceRoot) + 1, MaxInt);
            DestinationFile := TargetRoot + RelativePath;
            DestinationDir := ExtractFilePath(DestinationFile);

            if not DirectoryExists(DestinationDir) then
              ForceDirectories(DestinationDir);

            if not CopyFile(PChar(FullSource), PChar(DestinationFile), False) then
              raise Exception.CreateFmt('Copy failed (%s)', [SysErrorMessage(GetLastError)]);

            MarkBackedUp(ImagesDataNo);
            Inc(CopiedCount);
          except
            on E: Exception do
            begin
              ErrorMessage := ErrorMessage + Format('%s - %s'#13#10, [FullSource, E.Message]);
            end;
          end;
        end;
      until FindNext(SR) <> 0;
    finally
      FindClose(SR);
    end;
  end;

  function BuildImagePathForRoot(const RootPath: string; ImagesDataNo: integer; ImageDate: TDateTime): string;
  var
    YearMonth: string;
  begin
    YearMonth := FormatDateTime('yyyymm', ImageDate);
    Result := IncludeTrailingPathDelimiter(RootPath) + YearMonth + PathDelim + IntToStr(ImagesDataNo) + '.jpg';
  end;

  procedure ProcessMissingFromDatabase;
  var
    ImagesDataNo: integer;
    ImageDate: TDateTime;
    FullSource, RelativePath, DestinationDir, DestinationFile: string;
  begin
    MissingQuery.Close;
    MissingQuery.Open;

    while not MissingQuery.Eof do
    begin
      ImagesDataNo := MissingQuery.FieldByName('IMAGES_DATA_NO').AsInteger;

      if MissingQuery.FieldByName('CREATED').IsNull then
      begin
        Inc(SkippedCount);
        ErrorMessage := ErrorMessage + Format('IMAGES_DATA_NO %d has NULL CREATED date'#13#10, [ImagesDataNo]);
        MissingQuery.Next;
        Continue;
      end;

      ImageDate := MissingQuery.FieldByName('CREATED').AsDateTime;
      FullSource := BuildImagePathForRoot(SourceRoot, ImagesDataNo, ImageDate);

      if not FileExists(FullSource) then
      begin
        Inc(SkippedCount);
        ErrorMessage := ErrorMessage + Format('%s - source file not found'#13#10, [FullSource]);
        MissingQuery.Next;
        Continue;
      end;

      try
        RelativePath := Copy(FullSource, Length(SourceRoot) + 1, MaxInt);
        DestinationFile := TargetRoot + RelativePath;
        DestinationDir := ExtractFilePath(DestinationFile);

        if not DirectoryExists(DestinationDir) then
          ForceDirectories(DestinationDir);

        if not CopyFile(PChar(FullSource), PChar(DestinationFile), False) then
          raise Exception.CreateFmt('Copy failed (%s)', [SysErrorMessage(GetLastError)]);

        MarkBackedUp(ImagesDataNo);
        Inc(CopiedCount);
      except
        on E: Exception do
          ErrorMessage := ErrorMessage + Format('%s - %s'#13#10, [FullSource, E.Message]);
      end;

      MissingQuery.Next;
    end;
  end;

begin
  CopiedCount := 0;
  SkippedCount := 0;
  ErrorMessage := '';

  // Remove backup rows for images that no longer exist in IMAGES_DATA.
  AConn.ExecSQL('DELETE FROM IMAGES_DATA_BACKUP WHERE IMAGES_DATA_NO NOT IN (SELECT IMAGES_DATA_NO FROM IMAGES_DATA)');

  if not DirectoryExists(SourceFolder) then
    raise Exception.Create('Source folder does not exist: ' + SourceFolder);

  SourceRoot := IncludeTrailingPathDelimiter(SourceFolder);
  TargetRoot := IncludeTrailingPathDelimiter(TargetFolder);

  CheckQuery := TFDQuery.Create(nil);
  InsertQuery := TFDQuery.Create(nil);
  ExistsQuery := TFDQuery.Create(nil);
  MissingQuery := TFDQuery.Create(nil);
  try
    CheckQuery.Connection := AConn;
    InsertQuery.Connection := AConn;
    ExistsQuery.Connection := AConn;
    MissingQuery.Connection := AConn;

    CheckQuery.SQL.Text := 'SELECT IMAGES_DATA_NO FROM IMAGES_DATA_BACKUP WHERE IMAGES_DATA_NO = :IMAGES_DATA_NO';
    InsertQuery.SQL.Text := 'INSERT INTO IMAGES_DATA_BACKUP (ID, IMAGES_DATA_NO) VALUES (:ID, :IMAGES_DATA_NO)';
    ExistsQuery.SQL.Text := 'SELECT IMAGES_DATA_NO FROM IMAGES_DATA WHERE IMAGES_DATA_NO = :IMAGES_DATA_NO';
    MissingQuery.SQL.Text := 'SELECT IMAGES_DATA_NO, CREATED FROM IMAGES_DATA WHERE IMAGES_DATA_NO NOT IN (SELECT IMAGES_DATA_NO FROM IMAGES_DATA_BACKUP)';

    // If weekly backup is not due, run the missing-only backup process
    if not ShouldBackupImages then
    begin
      ProcessMissingFromDatabase;
      Exit;
    end;

    ProcessFolder(SourceRoot);
    
    // Only save the backup date if we actually copied files successfully
    if (CopiedCount > 0) and (ErrorMessage = '') then
      WriteLastImageBackupDate;
  finally
    CheckQuery.Free;
    InsertQuery.Free;
    ExistsQuery.Free;
    MissingQuery.Free;
  end;
end;

procedure TDM.ExportAllImagesToFolder(var ExportCount: integer; var ErrorMessage: string; ProgressLabel: TLabel = nil);
var
  ExportQuery: TADOQuery;
  FilePath, Directory: string;
  ImageStream: TStream;
  FileStream: TFileStream;
  ImagesDataNo: integer;
  ImageDate: TDateTime;
  TotalImages: integer;
begin
  ExportCount := 0;
  ErrorMessage := '';
  
  if ImagesStoragePath = '' then
  begin
    ErrorMessage := 'ImagesStoragePath is not configured.';
    Exit;
  end;

  // Create root directory if it doesn't exist
  if not DirectoryExists(ImagesStoragePath) then
  begin
    try
      ForceDirectories(ImagesStoragePath);
    except
      on E: Exception do
      begin
        ErrorMessage := 'Failed to create root directory: ' + E.Message;
        Exit;
      end;
    end;
  end;

  ExportQuery := TADOQuery.Create(nil);
  try
    ExportQuery.Connection := ConnDB;
    ExportQuery.SQL.Text := 'SELECT ImagesDataNo, ImageData, Created FROM ImagesData ORDER BY ImagesDataNo';
    ExportQuery.Open;
    
    // Get total count for progress display
    TotalImages := ExportQuery.RecordCount;
    if ProgressLabel <> nil then
      ProgressLabel.Caption := 'Starting export of ' + IntToStr(TotalImages) + ' images...';

    ImagesDataNo := 0;
    while not ExportQuery.Eof do
    begin
      try
        ImagesDataNo := ExportQuery.FieldByName('ImagesDataNo').AsInteger;
        ImageDate := ExportQuery.FieldByName('Created').AsDateTime;
        
        // Update progress label
        if ProgressLabel <> nil then
        begin
          ProgressLabel.Caption := Format('Exporting image %d of %d...', [ExportQuery.RecNo, TotalImages]);
          Application.ProcessMessages;
        end;
        
        // Get the file path for this image
        FilePath := GetImageFilePath(ImagesDataNo, ImageDate);
        Directory := ExtractFilePath(FilePath);
        
        // Create directory structure if needed
        if not DirectoryExists(Directory) then
          ForceDirectories(Directory);
        
        // Export the BLOB to file
        ImageStream := ExportQuery.CreateBlobStream(ExportQuery.FieldByName('ImageData'), bmRead);
        try
          FileStream := TFileStream.Create(FilePath, fmCreate);
          try
            FileStream.CopyFrom(ImageStream, ImageStream.Size);
            Inc(ExportCount);
          finally
            FileStream.Free;
          end;
        finally
          ImageStream.Free;
        end;
      except
        on E: Exception do
        begin
          ErrorMessage := ErrorMessage + Format('Error exporting image %d: %s'#13#10, [ImagesDataNo, E.Message]);
        end;
      end;
      
      ExportQuery.Next;
    end;
    
    if ProgressLabel <> nil then
    begin
      ProgressLabel.Caption := Format('Export complete! %d images exported.', [ExportCount]);
      Application.ProcessMessages;
    end;
  finally
    ExportQuery.Free;
  end;
end;

end.
