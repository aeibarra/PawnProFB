unit PawnDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles,
  Db, DBClient, Provider, Variants, Vcl.ImgList, DateUtils, System.UITypes, Vcl.StdCtrls,
  RzCommon, System.ImageList, RzCmboBx, Vcl.VirtualImageList, Vcl.ExtCtrls,
  Vcl.BaseImageCollection, Vcl.ImageCollection, SVGIconImageCollection,
  SVGIconVirtualImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, System.IOUtils;

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

  // One item of a sale, as the sale screens hand it to TDM.CompleteSale. Cost,
  // quantity and asking price are read from the item itself when saving.
  TSaleLine = record
    InvItemNo:   integer;
    Description: string;      // as shown on the sale (kept for the ticket)
    SalePrice:   Currency;    // pre-tax, before the whole-sale discount
  end;

  TDM = class(TDataModule)
    DSCustomers: TDataSource;
    DSStates: TDataSource;
    DSTransactions: TDataSource;
    DSPayments: TDataSource;
    DSStore: TDataSource;
    RegIniFile: TRzRegIniFile;
    ImageListBtn: TImageList;
    qryImage: TFDQuery;
    qryImageImagesDataNo: TIntegerField;
    qryImageImageDesc: TWideStringField;
    qryImageImageData: TBlobField;
    qryImageUploadFileName: TWideStringField;
    clnWeigthUnits: TClientDataSet;
    clnWeigthUnitsWeigthUnitValue: TWideStringField;
    clnWeigthUnitsWeightUnit: TWideStringField;
    qryUpdPawnStatus: TFDQuery;
    qryGetPawnStatusFromItems: TFDQuery;
    qryGetPawnStatusFromItemsPawnStatusCode: TSmallintField;
    qryGetPawnStatusFromItemsItemCount: TLargeintField;
    vilMain: TSVGIconVirtualImageList;
    svgMain: TSVGIconImageCollection;
    vilMain24: TSVGIconVirtualImageList;
    qryPawnPay: TFDMemTable;
    qryTotalPaid: TFDQuery;
    qryTotalPaidTotalPaid: TFloatField;
    qryItemImages: TFDQuery;
    qryItemImagesImagesDataNo: TIntegerField;
    qryItemImagesImageData: TBlobField;
    ConnFB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    qryDummyFB: TFDQuery;
    qryBackupSetings: TFDQuery;
    qryBackupSetingsBACKUP_PATH: TWideStringField;
    qryBackupSetingsAUTO_BACKUP_WHEN_CLOSE_APP: TBooleanField;
    qryBackupSetingsBACKUP_IMAGES_PATH: TWideStringField;
    qryTransactions: TFDQuery;
    qryTransactionsTRANSACTION_NO: TIntegerField;
    qryTransactionsCUST_NO: TIntegerField;
    qryTransactionsTRAN_DATE: TDateField;
    qryTransactionsTRAN_TICKET_NO: TWideStringField;
    qryTransactionsTRAN_COMMENT: TWideMemoField;
    qryTransactionsTRAN_MATURITY: TDateField;
    qryTransactionsTRAN_TYPE: TWideStringField;
    qryTransactionsTRAN_STATUS: TWideStringField;
    qryTransactionsTRAN_VOID_DATE: TSQLTimeStampField;
    qryTransactionsTRAN_PAWN_AMOUNT: TFloatField;
    qryTransactionsTRAN_INTEREST: TFloatField;
    qryTransactionsPRINC_BALANCE: TFloatField;
    qryTransactionsINTEREST_BALANCE: TFloatField;
    qryTransactionsTRAN_TIME: TTimeField;
    qryTransactionsTRAN_CLOSE_REASON: TSmallintField;
    qryTransactionsTRAN_SALES_TAX: TFloatField;
    qryTransactionscComment: TWideStringField;
    qryTransactionscTranInsAmount1Month: TCurrencyField;
    qryTransactionscTotalPay1Month: TCurrencyField;
    qryTransactionscPawnDefaultDate: TDateTimeField;
    qryTransactionscTAmountRedeemDefaultDate: TCurrencyField;
    qryTransactionscAnnualPercRate: TFloatField;
    qryTransactionscPawnNextMinPayment: TWideStringField;
    qryTransactionscTranTotalInterestAtMaturity: TCurrencyField;
    qryTransactionscTranTotalAmountAtMaturity: TCurrencyField;
    qryTransactionscTotalSalesAmount: TCurrencyField;
    qryStore: TFDQuery;
    qryStoreSTORE_NO: TWideStringField;
    qryStoreSTORE_NAME: TWideStringField;
    qryStoreSTORE_ADDR: TWideStringField;
    qryStoreSTORE_CITY_ST_ZIP: TWideStringField;
    qryStoreSTORE_PHONE: TWideStringField;
    qryStoreSTORE_POLICE_ID: TWideStringField;
    qryStoreSTORE_ADJ_TOP_MARG: TIntegerField;
    qryStoreSTORE_NUMBER: TWideStringField;
    qryStoreSTORE_ADJ_DETAIL_HEIGHT: TIntegerField;
    qryStoreSTORE_ADJ_FOOTER_HEIGHT: TIntegerField;
    qryStoreINTEREST_CALC_METHOD: TIntegerField;
    qryStorePOLICE_REPORT_TO_PRINT: TIntegerField;
    qryStorePOLICE_REPORT_LASER_COPIES: TIntegerField;
    qryStoreDEFAULT_MATURITY_MONTHS: TIntegerField;
    qryStorePAWN_DEFAULT_MONTHS: TIntegerField;
    qryStoreLEADS_STORE_ID: TWideStringField;
    qryStoreLEADS_ONLINE_FTP_ADDRESS: TWideStringField;
    qryStoreLEADS_ONLINE_USER_NAME: TWideStringField;
    qryStoreLEADS_ONLINE_PASSWORD: TWideStringField;
    qryStoreFTP_PASSIVE: TBooleanField;
    qryStoreLEADS_ONLINE_API_USER: TWideStringField;
    qryStoreLEADS_ONLINE_API_PASSWORD: TWideStringField;
    qryStoreLEADS_ONLINE_EXPORT_METHOD: TWideStringField;
    qryStoreLEADS_ONLINE_USE_SANDBOX: TBooleanField;
    qryStoreLEADS_ONLINE_SKIP_CSV_SENT: TBooleanField;
    qryStorePAWN_DATE_CALCULATION_BASE: TWideStringField;
    qryStoreDEFAULT_WEIGHT_MEASURE_UNIT: TWideStringField;
    qryStoreSALES_TAX_PERC: TFloatField;
    qryStoreDEFAULT_PAWN_INTERESTRATE: TFloatField;
    qryStorecCity: TWideStringField;
    qryStorecState: TWideStringField;
    qryStorecZIp: TWideStringField;
    qryStates: TFDQuery;
    qryStatesSTATE_ABBR: TWideStringField;
    qryStatesSTATE_NAME: TWideStringField;
    qryCustomers: TFDQuery;
    qryCustomersCUST_NO: TIntegerField;
    qryCustomersCUST_FIRST: TWideStringField;
    qryCustomersCUST_MID: TWideStringField;
    qryCustomersCUST_LAST: TWideStringField;
    qryCustomersCUST_DOB: TDateField;
    qryCustomersCUST_GENDER: TWideStringField;
    qryCustomersCUST_RACE: TWideStringField;
    qryCustomersCUST_HAIR: TWideStringField;
    qryCustomersCUST_EYES: TWideStringField;
    qryCustomersCUST_MARK: TWideStringField;
    qryCustomersCUST_WEIGHT: TFloatField;
    qryCustomersCUST_HEIGHT: TWideStringField;
    qryCustomersCUST_ADDR: TWideStringField;
    qryCustomersCUST_APT: TWideStringField;
    qryCustomersCUST_CITY: TWideStringField;
    qryCustomersCUST_STATE: TWideStringField;
    qryCustomersCUST_ZIP: TWideStringField;
    qryCustomersCUST_PLACE_EMPLY: TWideStringField;
    qryCustomersCUST_FL_DRV_LIC: TWideStringField;
    qryCustomersCUST_ID: TWideStringField;
    qryCustomersCUST_ID_TYPE: TWideStringField;
    qryCustomersCUST_ID_AGENCY_STATE: TWideStringField;
    qryCustomersCUST_PH_HOME: TWideStringField;
    qryCustomersCUST_PH_BUSINESS: TWideStringField;
    qryCustomersCUST_PH_BEEP: TWideStringField;
    qryCustomersCUST_PH_CELL: TWideStringField;
    qryCustomersCUST_COMMENT: TWideMemoField;
    qryCustomersCCustPhHome: TWideStringField;
    qryCustomersCCustPhBussiness: TWideStringField;
    qryCustomersCCustPhBeep: TWideStringField;
    qryCustomerscCustPhCell: TWideStringField;
    qryCustomerscCustFlDrvLic: TWideStringField;
    qryCustomerscCustAge: TIntegerField;
    qryCustomerscHasPics: TWideStringField;
    qryCustomersHAS_CUST_PICS: TBooleanField;
    qryPayments: TFDQuery;
    qryLastPayment: TFDQuery;
    qryLastPaymentLASTPAYMENTDATE: TDateField;
    qryPaymentscComment: TWideStringField;
    qryPaymentscPeriodNo: TIntegerField;
    qryPaymentsPAYMENT_NO: TIntegerField;
    qryPaymentsTRANSACTION_NO: TIntegerField;
    qryPaymentsPAY_DATE: TDateField;
    qryPaymentsPAY_AMOUNT: TFloatField;
    qryPaymentsPAY_COMMENT: TWideMemoField;
    qryPaymentsPAY_METHOD: TSmallintField;
    qryPaymentsPAY_INTEREST: TFloatField;
    qryPaymentsPAY_PRINCIPAL: TFloatField;
    qryPaymentsPRINC_BALANCE: TFloatField;
    qryPaymentsINTEREST_BALANCE: TFloatField;
    clnItemStatus: TFDMemTable;
    qryItemStatus: TFDQuery;
    clnJGenders: TFDMemTable;
    clnJMetals: TFDMemTable;
    clnJStoneColors: TFDMemTable;
    clnJStoneShapes: TFDMemTable;
    clnJStyles: TFDMemTable;
    clnJTypes: TFDMemTable;
    clnJGendersJ_GENDER: TWideStringField;
    clnJGendersJ_GENDER_DESC: TWideStringField;
    clnJMetalsJ_METAL: TWideStringField;
    clnJMetalsJ_METAL_DESC: TWideStringField;
    clnJStoneColorsJ_STONE_COLOR: TWideStringField;
    clnJStoneColorsJ_STONE_DESC: TWideStringField;
    clnJStoneShapesJ_SHAPE: TWideStringField;
    clnJStoneShapesJ_SHAPE_DESC: TWideStringField;
    clnJStylesJ_STYLE: TWideStringField;
    clnJStylesJ_STYLE_DESC: TWideStringField;
    clnJTypesJ_TYPE: TWideStringField;
    clnJTypesJ_TYPE_DESC: TWideStringField;
    clnStoneTypes: TFDMemTable;
    clnStoneTypesSTONE_TYPE: TWideStringField;
    clnInventoryCategories: TFDMemTable;
    clnInventoryCategoriesINV_CAT_NO: TIntegerField;
    clnInventoryCategoriesINV_CATEGORY: TWideStringField;
    clnInventoryBrands: TFDMemTable;
    clnInventoryBrandsINV_ITEM_BRAND: TWideStringField;
    qryCalcUnitCostFromWeight: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    vilMain20: TSVGIconVirtualImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qryStoreCalcFields(DataSet: TDataSet);
    procedure qryPaymentsCalcFields(DataSet: TDataSet);
    procedure qryPaymentsNewRecord(DataSet: TDataSet);
    procedure qryTransactionsCalcFields(DataSet: TDataSet);
    procedure qryTransactionsNewRecord(DataSet: TDataSet);
    procedure qryCustomersNewRecord(DataSet: TDataSet);
    procedure qryCustomersAfterScroll(DataSet: TDataSet);
    procedure qryCustomersCalcFields(DataSet: TDataSet);
    procedure qryTransactionsTranDateChange(Sender: TField);
    procedure qryCustomersCustFlDrvLicGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryPaymentsAfterPost(DataSet: TDataSet);
    procedure qryTransactionsAfterScroll(DataSet: TDataSet);
  private
    FPendingFBPasswordForIni: string;
    FDeleteLegacyFBPasswordFromIni: Boolean;
    procedure CheckForMissingDBChanges;
    procedure PopulateWeightUnits;
    procedure LoadLookupMemTables;
    procedure LoadLookupMemTable(AMemTable: TFDMemTable; const ASQL: string);
    function GetFBPasswordFromIni(const PasswordEnc, LegacyPassword: string; AllowPrompt: Boolean): string;
    procedure SavePendingFBPasswordToIni;
    procedure UpdatePawnItemStatusAndStage(TransactionNo: integer; CloseReason: smallint; PawnDefaultedItemAction: integer);
    function GetPawnPeriod(const PawnDate, CheckDate: TDateTime): Integer;
    procedure SendMessageToRefreshPaymentDueDateText;
    function OpenAppState(const StateKey: string): TFDQuery;
    procedure SaveAppState(const StateKey: string; const TextValue: Variant;
      const IntValue: Variant; const CurrencyValue: Variant; const DateValue: Variant);
  public
    SaveCustQry: string;
    ReCalcMaturity: boolean;
    function RoutineExists(const Conn: TFDConnection; const Name, RoutineType: string): Boolean;
    procedure BindFBClientLibrary;
    procedure ConfigureFBConnection;
    procedure ConfigureFBConnectionFor(AConn: TFDConnection);
    function TestFBConnection(out ErrorMsg: string): Boolean;
    procedure RefreshStoreQry;
    function GetAppStateText(const StateKey, DefaultValue: string): string;
    function GetAppStateInt(const StateKey: string; DefaultValue: Integer): Integer;
    function GetAppStateCurrency(const StateKey: string; DefaultValue: Currency): Currency;
    function GetAppStateDate(const StateKey: string; DefaultValue: TDateTime): TDateTime;
    procedure SetAppStateText(const StateKey, Value: string);
    procedure SetAppStateInt(const StateKey: string; Value: Integer);
    procedure SetAppStateCurrency(const StateKey: string; Value: Currency);
    procedure SetAppStateDate(const StateKey: string; Value: TDateTime);
    function GetBarcode(Key: integer): string;
    procedure CalcInterest(Amount: currency; var IntRate, IntAmount: extended);
    function LastPaymentForTransaction(TransactionNo: integer): TDateTime;
    function CalcNextInt(PrincipalBalance: Currency; InterestPerc: Currency; Months: integer): Currency;
    procedure LogBackupWithConnection(AConn: TFDConnection; const BckLocation: string);
    function BackupDatabaseToFileWithConnection(AConn: TFDConnection; BackupPath: string): string;
    function ShouldBackupImages: Boolean;
    procedure BackupImagesToFolderWithConnection(AConn: TFDConnection; const SourceFolder, TargetFolder: string; out CopiedCount, SkippedCount: integer; out ErrorMessage: string);
    procedure ExportAllImagesToFolder(var ExportCount: integer; var ErrorMessage: string; ProgressLabel: TLabel = nil);
    procedure RunBackup(const ABackupPath, AImageTargetPath: string; ADoImageBackup: Boolean; out AResult: TBackupResult; AOnPhase: TBackupPhaseProc = nil);
    procedure SaveImageToFile(ImagesDataNo: integer; FileName: string);
    procedure ExportImageToPath(ImagesDataNo: integer; DestPath: string);
    function GetImageFilePath(ImagesDataNo: integer; ImageDate: TDateTime): string;
    procedure SaveImageToDatabase(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
    procedure GetImageFromDatabase(ImagesDataNo: integer; ImageComponent: TImage);
    procedure GetImageFromFile(ImagesDataNo: integer; ImageComponent: TImage);
    /// Original bytes, for transmitting rather than displaying -- see
    /// TGetImageBytesProc in PawnGlobal. Both return nil when absent.
    function GetImageBytesFromDatabase(ImagesDataNo: integer): TBytes;
    function GetImageBytesFromFile(ImagesDataNo: integer): TBytes;
    procedure SaveImageToFile_Method(ImagesDataNo: integer; ImageData: TStream; ImageDate: TDateTime);
    procedure SaveImageToFile_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
    procedure SaveImageToDatabase_FromPath(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime);
    procedure DeleteImageFromDatabase(ImagesDataNo: integer);
    procedure DeleteImageFromFile(ImagesDataNo: integer);
    function CalcPawnDefaultDate(TransactionDate: TDateTime; PawnDefaultMonths: integer): TDateTime;
    function GetPawnMaturityDate(TransactionDate: TDateTime): TDateTime;
    procedure GetWeightUnits(cln: TClientDataSet);
    procedure CopyMemTableData(Source: TDataSet; Target: TFDMemTable);
    procedure GetJGenders(MemTable: TFDMemTable);
    procedure GetJMetals(MemTable: TFDMemTable);
    procedure GetJStoneColors(MemTable: TFDMemTable);
    procedure GetJStoneShapes(MemTable: TFDMemTable);
    procedure GetJStyles(MemTable: TFDMemTable);
    procedure GetJTypes(MemTable: TFDMemTable);
    procedure AddStoneType(const AStoneType: string);
    procedure AddInventoryBrand(const ABrand: string);
    procedure RefreshInventoryCategories;
    procedure RefreshLookupMemTables;
    function GetWeightUnitAbbr(WeightUnit: string): string;
    procedure FillPawnStatusCombobox(cb: TRzComboBox; StatusToSelect: String);
    procedure SetPawnAndItemsStatus(TransactionNo: integer; CloseReason: smallint; TranStatus: string; PawnDefaultedItemAction: integer);
    procedure PutPawnBackToActive(TransactionNo: integer);
    procedure GetPurchaseItemsState(TransactionNo: integer; out Unclassified, Classified, Locked: integer);
    procedure SetPurchaseItemsStatus(TransactionNo: integer; PurchaseItemAction: integer);
    procedure PutPurchaseBackToOriginal(TransactionNo: integer);
    function SetPurchaseItemStatus(InvItemNo: integer; PurchaseItemAction: integer): boolean;
    function CompleteSale(const Lines: TArray<TSaleLine>; SaleDate: TDateTime;
                          DiscountIsPercent: boolean; DiscountValue, TaxPerc: Currency): integer;
    procedure VoidSale(SaleNo: integer; const Reason: string);
    function FindSaleOfItem(InvItemNo: integer; out SaleNo, TicketNo, LineCount: integer;
                            out Total: Currency): boolean;
    function GetSoldItemsInfo(TransactionNo, InvItemNo: integer; out SoldCount: integer;
                              out SaleNos: TArray<integer>): string;
    procedure DeleteWithLog(const SaleNos: TArray<integer>; const Reason: string; const DeleteProc: TProc);
    // Receive Stock (supplier purchases, schema v15)
    function FindOrAddSupplier(const AName: string): integer;
    function SaveStockReceipt(ReceiptNo, SupplierNo: integer; ReceivedDate: TDateTime;
                              const InvoiceNo: string; const InvoiceDate, InvoiceTotal, PayTypeNo: Variant;
                              const Notes: string): integer;
    procedure SaveStockReceiptLine(ReceiptNo, InvItemNo: integer);
    procedure CopyStockReceiptItem(ReceiptNo, SourceItemNo, Copies: integer);
    procedure GetCopyGroupSize(ReceiptNo, InvItemNo: integer; out Group, Size, UnsoldOthers: integer);
    function ApplyItemToCopyGroup(ReceiptNo, SourceItemNo: integer): integer;
    function StockReceiptItemIsSold(InvItemNo: integer): boolean;
    procedure RemoveStockReceiptItem(InvItemNo: integer; const Reason: string);
    procedure VoidStockReceipt(ReceiptNo: integer; const Reason: string);
    function UnsellItem(InvItemNo: integer): boolean;
    procedure RefreshFBQry(Qry: TFDQuery); overload;
    procedure RefreshFBQry(Qry: TFDQuery; const DSKey: Variant; const DSKeyField: string); overload;
    procedure UpdatePawnItemStatus(InvItemNo: integer; const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
    function GetPawnStatusFromItems(TransactionNo: integer): integer;
    procedure UpdatePawnStatusBaseOnItems(TransactionNo: integer);
    function GetCurrentInterestBalance(AsOfDate, PawnDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TDataSet): Currency;
    procedure GetInterestAndNextPaymentInfo(AsOfDate, PawnDate, LastPaymentDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TDataSet;
                                                out InterestBalanceAsOf: Currency; out InterestOwedToday: Currency;
                                                out NextPaymentDate: TDateTime; out InterestDueAtNext: Currency);
    function GetPawnPaymentUserMessageAboutBalancesAndDueDate: string;
    procedure GetPawnPaymentBalancesAndDueDate(out InterestBalanceAsOf: Currency; out InterestOwedToday: Currency; out NextPaymentDate: TDateTime; out InterestDueAtNext: Currency);
    function GetNextTicketNo(TicketKey: string): integer;
    function GetTotalPaid: Currency;
    procedure RecalcLayawayPBalance;
    procedure ReactivateLayway(TransactionNo: integer);
    procedure CancelLayaway(TransactionNo: integer);
    procedure LaywayClosePayoffBalance(TransactionNo: integer; AddBalancePayment: boolean);
    procedure UpdateLastTicketNo(TicketKey: string; TicketNo: integer);
    procedure CalcUnitCostFromWeight(TransactionNo: integer);
    function GetItemStatus(qryInvItems: TDataSet): string;
  end;

var
  DM: TDM;

implementation

Uses PawnGlobal, uPrinting, uPawnIniDefaults, DPAPIUtils, SearchClient, Nvv.FB5.DBA,
  SealedBox, Nvv.Crypto.FileEnvelope, uDBMigrations, uImageMaintenanceGate;

{$R *.DFM}

const
  { How long an image backup waits for the image gate before giving up. Covers a
    weekly audit standing down (fast) or a camera capture finishing (seconds). }
  ImageGateWaitMs = 10000;

// 32-byte Curve25519 vendor PUBLIC key (VENDOR_PUBLIC_KEY). Backups are sealed
// to it; only the vendor's offline secret key can decrypt. Public -> harmless
// if extracted from the EXE.
{$I SetupVendorPublicKey.inc}

// The embedded vendor public key as TBytes, for EncryptFileToVendor.
function GetVendorPublicKey: TBytes;
begin
  SetLength(Result, Length(VENDOR_PUBLIC_KEY));
  Move(VENDOR_PUBLIC_KEY[0], Result[0], Length(VENDOR_PUBLIC_KEY));
end;

// Backup encryption is ON unless the ini explicitly turns it off. Missing or
// empty value = ON (secure by default).
function BackupEncryptionEnabled: Boolean;
var
  V: string;
begin
  V := UpperCase(Trim(ReadIniFile(IniSecBackup, IniKeyEncryptBackups)));
  Result := (V <> '0') and (V <> 'N') and (V <> 'NO') and
            (V <> 'FALSE') and (V <> 'OFF');
end;

// Best-effort overwrite-then-delete of a plaintext backup, to shrink the
// window where cleartext PII sits on disk after we've made the encrypted copy.
procedure SecureDeleteFile(const FileName: string);
var
  FS: TFileStream;
  Zeros: TBytes;
  Remaining, ThisWrite: Int64;
begin
  try
    if FileExists(FileName) then
    begin
      FS := TFileStream.Create(FileName, fmOpenReadWrite or fmShareExclusive);
      try
        SetLength(Zeros, 64 * 1024);
        FillChar(Zeros[0], Length(Zeros), 0);
        Remaining := FS.Size;
        FS.Position := 0;
        while Remaining > 0 do
        begin
          ThisWrite := Remaining;
          if ThisWrite > Length(Zeros) then
            ThisWrite := Length(Zeros);
          FS.WriteBuffer(Zeros[0], ThisWrite);
          Dec(Remaining, ThisWrite);
        end;
      finally
        FS.Free;
      end;
    end;
  except
    // Overwrite is best-effort; still attempt the delete below.
  end;
  System.SysUtils.DeleteFile(FileName);
end;

procedure TDM.RefreshStoreQry;
begin
  qryStore.Close;
  qryStore.Open;
end;

function TDM.OpenAppState(const StateKey: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := ConnFB;
    Result.SQL.Text := 'SELECT * FROM SPS_APP_STATE(:P_STATE_KEY)';
    Result.Params.ParamByName('P_STATE_KEY').AsString := StateKey;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

procedure TDM.SaveAppState(const StateKey: string; const TextValue: Variant;
  const IntValue: Variant; const CurrencyValue: Variant; const DateValue: Variant);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConnFB;
    Qry.SQL.Text :=
      'EXECUTE PROCEDURE SPU_APP_STATE(' +
      ':P_STATE_KEY, :P_VALUE_TEXT, :P_VALUE_INT, :P_VALUE_CURRENCY, :P_VALUE_DATE)';
    Qry.Params.ParamByName('P_STATE_KEY').AsString := StateKey;
    Qry.Params.ParamByName('P_VALUE_TEXT').Value := TextValue;
    Qry.Params.ParamByName('P_VALUE_INT').Value := IntValue;
    Qry.Params.ParamByName('P_VALUE_CURRENCY').Value := CurrencyValue;
    Qry.Params.ParamByName('P_VALUE_DATE').Value := DateValue;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TDM.GetAppStateText(const StateKey, DefaultValue: string): string;
var
  Qry: TFDQuery;
begin
  Result := DefaultValue;
  Qry := OpenAppState(StateKey);
  try
    if not Qry.Eof and not Qry.FieldByName('VALUE_TEXT').IsNull then
      Result := Qry.FieldByName('VALUE_TEXT').AsString;
  finally
    Qry.Free;
  end;
end;

function TDM.GetAppStateInt(const StateKey: string; DefaultValue: Integer): Integer;
var
  Qry: TFDQuery;
begin
  Result := DefaultValue;
  Qry := OpenAppState(StateKey);
  try
    if not Qry.Eof and not Qry.FieldByName('VALUE_INT').IsNull then
      Result := Qry.FieldByName('VALUE_INT').AsInteger;
  finally
    Qry.Free;
  end;
end;

function TDM.GetAppStateCurrency(const StateKey: string; DefaultValue: Currency): Currency;
var
  Qry: TFDQuery;
begin
  Result := DefaultValue;
  Qry := OpenAppState(StateKey);
  try
    if not Qry.Eof and not Qry.FieldByName('VALUE_CURRENCY').IsNull then
      Result := Qry.FieldByName('VALUE_CURRENCY').AsCurrency;
  finally
    Qry.Free;
  end;
end;

function TDM.GetAppStateDate(const StateKey: string; DefaultValue: TDateTime): TDateTime;
var
  Qry: TFDQuery;
begin
  Result := DefaultValue;
  Qry := OpenAppState(StateKey);
  try
    if not Qry.Eof and not Qry.FieldByName('VALUE_DATE').IsNull then
      Result := Qry.FieldByName('VALUE_DATE').AsDateTime;
  finally
    Qry.Free;
  end;
end;

procedure TDM.SetAppStateText(const StateKey, Value: string);
begin
  SaveAppState(StateKey, Value, Null, Null, Null);
end;

procedure TDM.SetAppStateInt(const StateKey: string; Value: Integer);
begin
  SaveAppState(StateKey, Null, Value, Null, Null);
end;

procedure TDM.SetAppStateCurrency(const StateKey: string; Value: Currency);
begin
  SaveAppState(StateKey, Null, Null, Value, Null);
end;

procedure TDM.SetAppStateDate(const StateKey: string; Value: TDateTime);
begin
  SaveAppState(StateKey, Null, Null, Null, Value);
end;

function TDM.GetBarcode(Key: integer): string;
begin
  Result := Format('%.6d', [Key]);
end;

function TDM.GetNextTicketNo(TicketKey: string): integer;
begin
  if not SameText(TicketKey, PawnTicketNo) and
     not SameText(TicketKey, LayawayTicketNo) then
    raise Exception.CreateFmt('Unsupported TABLE_KEYS ticket name: %s', [TicketKey]);

  Result := OpenSQLStatementFB(Format(
    'SELECT LAST_KEY FROM TABLE_KEYS WHERE TABLE_NAME = %s',
    [QuotedStr(TicketKey)])) + 1;
end;

procedure TDM.UpdateLastTicketNo(TicketKey: string; TicketNo: integer);
begin
  if not SameText(TicketKey, PawnTicketNo) and
     not SameText(TicketKey, LayawayTicketNo) then
    raise Exception.CreateFmt('Unsupported TABLE_KEYS ticket name: %s', [TicketKey]);

  ConnFB.ExecSQL(
    'UPDATE TABLE_KEYS SET LAST_KEY = :LAST_KEY WHERE TABLE_NAME = :TABLE_NAME',
    [TicketNo, TicketKey]);
end;

procedure TDM.CalcUnitCostFromWeight(TransactionNo: integer);
begin
  qryCalcUnitCostFromWeight.Params.ParamByName('TRANSACTION_NO').AsInteger := TransactionNo;
  qryCalcUnitCostFromWeight.ExecSQL;
end;

function ExistsFieldInTable(const TableName, FieldName: string): boolean;
begin
  Result := false;

  if (trim(TableName) = '') or (trim(FieldName) = '') then
    exit;

  try
    Result := OpenSQLStatementFB(
      'SELECT COUNT(*) ' +
      'FROM RDB$RELATION_FIELDS ' +
      'WHERE RDB$RELATION_NAME = ' + QuotedStr(UpperCase(TableName)) +
      '  AND RDB$FIELD_NAME = ' + QuotedStr(UpperCase(FieldName))) > 0;
  except
  end;
end;

function ExistsIndexOnTable(const TableName, IndexName: string): boolean;
begin
  Result := false;

  if (trim(TableName) = '') or (trim(IndexName) = '') then
    exit;

  try
    Result := OpenSQLStatementFB(
      'SELECT COUNT(*) ' +
      'FROM RDB$INDICES ' +
      'WHERE RDB$RELATION_NAME = ' + QuotedStr(UpperCase(TableName)) +
      '  AND RDB$INDEX_NAME = ' + QuotedStr(UpperCase(IndexName))) > 0;
  except
  end;
end;

function TDM.RoutineExists(const Conn: TFDConnection;
  const Name, RoutineType: string): Boolean;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT 1 ' + sLineBreak +
      'FROM RDB$PROCEDURES p ' + sLineBreak +
      'WHERE p.RDB$PROCEDURE_NAME = :ROUTINE_NAME ' + sLineBreak +
      '  AND :ROUTINE_TYPE = ''PROCEDURE'' ' + sLineBreak +
      'UNION ALL ' + sLineBreak +
      'SELECT 1 ' + sLineBreak +
      'FROM RDB$FUNCTIONS f ' + sLineBreak +
      'WHERE f.RDB$FUNCTION_NAME = :ROUTINE_NAME ' + sLineBreak +
      '  AND :ROUTINE_TYPE = ''FUNCTION''';
    Q.ParamByName('ROUTINE_NAME').AsString := UpperCase(Name);
    Q.ParamByName('ROUTINE_TYPE').AsString := UpperCase(RoutineType);
    Q.Open;
    Result := not Q.IsEmpty;
  finally
    Q.Free;
  end;

end;

procedure TDM.CheckForMissingDBChanges;
begin
  // Only the machine holding the database applies migrations. Every workstation
  // reaches this code at startup, and while the steps are idempotent they are
  // not concurrency-safe: two PCs starting together can both pass the same
  // "if not ColumnExists" guard and issue the same DDL, which Firebird rejects
  // with a metadata lock error. A failed migration is fatal, so that would stop
  // tills from opening -- at a multi-station store, on the first morning after
  // an update, which is the worst possible moment.
  if not IsLocalDatabase then
  begin
    // Skipping the migration is not the same as ignoring the version. Running
    // new code against an old schema fails later, deeper, and far less legibly
    // than saying so here.
    if not DatabaseIsCurrent(ConnFB) then
    begin
      ShowMessage('PawnPro cannot start: this store''s database is not up to date.' + sLineBreak + sLineBreak +
                  'The computer that holds the database has to run PawnPro first so it can ' +
                  'apply the update.' + sLineBreak + sLineBreak +
                  'Start PawnPro on that computer, wait for it to finish loading, ' +
                  'then start PawnPro here again.');
      Application.Terminate;
      Halt(0);
    end;
    Exit;
  end;

  // Apply any pending schema migrations for already-deployed stores. Fatal on
  // failure: never let the app run against a half-migrated database.
  try
    EnsureDatabaseCurrent(ConnFB);
  except
    on E: Exception do
    begin
      ShowMessage('Database update FAILED — the application cannot start.' + sLineBreak + sLineBreak +
                  'The database schema could not be brought up to date.' + sLineBreak +
                  'Error: [' + E.ClassName + '] ' + E.Message);
      raise;
    end;
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

// Generic in-memory copy. Source is any TDataSet (TFDMemTable, TFDQuery, ...);
// Target is a TFDMemTable. If Target has persistent fields, structure is
// preserved (just rows replaced); if not, structure is copied from source.
procedure TDM.CopyMemTableData(Source: TDataSet; Target: TFDMemTable);
begin
  if not Assigned(Source) or not Assigned(Target) then
    Exit;

  Target.DisableControls;
  try
    Target.Close;
    if Target.FieldCount > 0 then
    begin
      Target.CreateDataSet;
      Target.CopyDataSet(Source, [coRestart, coAppend]);
    end
    else
      Target.CopyDataSet(Source, [coStructure, coRestart, coAppend]);
  finally
    Target.EnableControls;
  end;
end;

procedure TDM.GetJGenders(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJGenders, MemTable);
end;

procedure TDM.GetJMetals(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJMetals, MemTable);
end;

procedure TDM.GetJStoneColors(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJStoneColors, MemTable);
end;

procedure TDM.GetJStoneShapes(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJStoneShapes, MemTable);
end;

procedure TDM.GetJStyles(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJStyles, MemTable);
end;

procedure TDM.GetJTypes(MemTable: TFDMemTable);
begin
  CopyMemTableData(clnJTypes, MemTable);
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

procedure TDM.LoadLookupMemTable(AMemTable: TFDMemTable; const ASQL: string);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConnFB;
    Qry.SQL.Text := ASQL;
    Qry.Open;
    CopyMemTableData(Qry, AMemTable);
  finally
    Qry.Free;
  end;
end;

procedure TDM.LoadLookupMemTables;
begin
  LoadLookupMemTable(clnJGenders,
    'SELECT J_GENDER, J_GENDER_DESC FROM J_GENDERS ORDER BY J_GENDER_DESC');

  LoadLookupMemTable(clnJMetals,
    'SELECT J_METAL, J_METAL_DESC FROM J_METALS ORDER BY J_METAL_DESC');

  LoadLookupMemTable(clnJStoneColors,
    'SELECT J_STONE_COLOR, J_STONE_DESC FROM J_STONE_COLORS ORDER BY J_STONE_DESC');

  LoadLookupMemTable(clnJStoneShapes,
    'SELECT J_SHAPE, J_SHAPE_DESC FROM J_STONE_SHAPES ORDER BY J_SHAPE_DESC');

  LoadLookupMemTable(clnJStyles,
    'SELECT J_STYLE, J_STYLE_DESC FROM J_STYLES ORDER BY J_STYLE_DESC');

  LoadLookupMemTable(clnJTypes,
    'SELECT J_TYPE, J_TYPE_DESC FROM J_TYPES ORDER BY J_TYPE_DESC');

  LoadLookupMemTable(clnStoneTypes,
    'SELECT DISTINCT TRIM(STONE_TYPE) AS STONE_TYPE FROM STONES ' +
    'WHERE TRIM(STONE_TYPE) <> '''' ORDER BY STONE_TYPE');

  RefreshInventoryCategories;

  LoadLookupMemTable(clnInventoryBrands,
    'SELECT DISTINCT TRIM(INV_ITEM_BRAND) AS INV_ITEM_BRAND FROM INVENTORY_ITEMS ' +
    'WHERE CHAR_LENGTH(TRIM(INV_ITEM_BRAND)) >= 3 ' +
    'AND TRIM(INV_ITEM_BRAND) NOT SIMILAR TO ''[[:DIGIT:]]+'' ' +
    'ORDER BY INV_ITEM_BRAND');
end;

procedure TDM.AddStoneType(const AStoneType: string);
var
  StoneType: string;
begin
  StoneType := Trim(AStoneType);
  if (StoneType = '') or
     clnStoneTypes.Locate('STONE_TYPE', StoneType, [loCaseInsensitive]) then
    Exit;

  clnStoneTypes.Append;
  clnStoneTypesSTONE_TYPE.AsString := StoneType;
  clnStoneTypes.Post;
end;

function IsValidInventoryBrand(const ABrand: string): Boolean;
var
  I: Integer;
begin
  Result := Length(ABrand) >= 3;
  if not Result then
    Exit;

  Result := False;
  for I := 1 to Length(ABrand) do
    if not CharInSet(ABrand[I], ['0'..'9']) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TDM.AddInventoryBrand(const ABrand: string);
var
  Brand: string;
begin
  Brand := Trim(ABrand);
  if not IsValidInventoryBrand(Brand) or
     clnInventoryBrands.Locate('INV_ITEM_BRAND', Brand, [loCaseInsensitive]) then
    Exit;

  clnInventoryBrands.Append;
  clnInventoryBrandsINV_ITEM_BRAND.AsString := Brand;
  clnInventoryBrands.Post;
end;

procedure TDM.RefreshInventoryCategories;
begin
  LoadLookupMemTable(clnInventoryCategories,
    'SELECT INV_CAT_NO, INV_CATEGORY FROM INV_CATEGORIES ORDER BY INV_CATEGORY');
end;

procedure TDM.RefreshLookupMemTables;
begin
  LoadLookupMemTables;
end;

function PromptForDatabasePassword(out Password: string): Boolean;
var
  Frm: TForm;
  Lbl: TLabel;
  Edt: TEdit;
  BtnOK, BtnCancel: TButton;
begin
  Password := '';

  Frm := TForm.Create(nil);
  try
    Frm.BorderStyle := bsDialog;
    Frm.Caption := 'PawnPro Database Password';
    Frm.ClientWidth := 420;
    Frm.ClientHeight := 135;
    Frm.Position := poScreenCenter;
    Frm.Font.Name := 'Segoe UI';
    Frm.Font.Size := 9;

    Lbl := TLabel.Create(Frm);
    Lbl.Parent := Frm;
    Lbl.AutoSize := False;
    Lbl.WordWrap := True;
    Lbl.Caption :=
      'Enter the Firebird database password. PawnPro will encrypt it in ' +
      'PawnPro.ini for this workstation.';
    Lbl.SetBounds(16, 16, Frm.ClientWidth - 32, 34);

    Edt := TEdit.Create(Frm);
    Edt.Parent := Frm;
    Edt.Left := 16;
    Edt.Top := 58;
    Edt.Width := Frm.ClientWidth - 32;
    Edt.PasswordChar := '*';

    BtnOK := TButton.Create(Frm);
    BtnOK.Parent := Frm;
    BtnOK.Caption := 'OK';
    BtnOK.ModalResult := mrOk;
    BtnOK.Default := True;
    BtnOK.Left := Frm.ClientWidth - 176;
    BtnOK.Top := 96;
    BtnOK.Width := 75;

    BtnCancel := TButton.Create(Frm);
    BtnCancel.Parent := Frm;
    BtnCancel.Caption := 'Cancel';
    BtnCancel.ModalResult := mrCancel;
    BtnCancel.Cancel := True;
    BtnCancel.Left := Frm.ClientWidth - 91;
    BtnCancel.Top := 96;
    BtnCancel.Width := 75;

    Frm.ActiveControl := Edt;
    Result := Frm.ShowModal = mrOk;
    if Result then
      Password := Edt.Text;
  finally
    Frm.Free;
  end;
end;

function TDM.GetFBPasswordFromIni(const PasswordEnc, LegacyPassword: string; AllowPrompt: Boolean): string;
begin
  Result := '';

  if PasswordEnc <> '' then
    begin
      try
        Result := DPAPIUnprotect(PasswordEnc);
        FDeleteLegacyFBPasswordFromIni := LegacyPassword <> '';
        Exit;
      except
        on E: Exception do
        begin
          if not AllowPrompt then
            raise;

          MessageDlg(
            'PawnPro could not decrypt the database password saved in PawnPro.ini.' +
            sLineBreak + sLineBreak +
            'This usually happens when the INI file was copied from another workstation.' +
            sLineBreak +
            'Please enter the Firebird database password so it can be encrypted for this workstation.',
            mtInformation, [mbOK], 0);
        end;
      end;
    end
  else if LegacyPassword <> '' then
    begin
      Result := LegacyPassword;
      FDeleteLegacyFBPasswordFromIni := True;
    end
  else if AllowPrompt then
    begin
      if not PromptForDatabasePassword(Result) then
      begin
        Application.Terminate;
        Halt(0);
        Abort;
      end;
    end
  else
    raise Exception.Create('PawnPro.ini is missing [CONNECTION_FB] password_enc.');

  if Result = '' then
  begin
    if not AllowPrompt then
      raise Exception.Create('Database password is required to start PawnPro.');

    if not PromptForDatabasePassword(Result) then
    begin
      Application.Terminate;
      Halt(0);
      Abort;
    end;
  end;

  FPendingFBPasswordForIni := Result;
end;

procedure TDM.SavePendingFBPasswordToIni;
var
  IniFile: TIniFile;
begin
  if (FPendingFBPasswordForIni = '') and not FDeleteLegacyFBPasswordFromIni then
    Exit;

  IniFile := TIniFile.Create(GlobalIniFile);
  try
    if FPendingFBPasswordForIni <> '' then
      IniFile.WriteString(IniSecConnFB, IniKeyPasswordEnc, DPAPIProtect(FPendingFBPasswordForIni));
    if IniFile.ValueExists(IniSecConnFB, IniKeyPassword) then
      IniFile.DeleteKey(IniSecConnFB, IniKeyPassword);
  finally
    IniFile.Free;
    FPendingFBPasswordForIni := '';
    FDeleteLegacyFBPasswordFromIni := False;
  end;
end;

// Reads [CONNECTION_FB] from the global PawnPro.ini and configures the given
// TFDConnection with the same params used for ConnFB. Lets background tasks
// build a thread-local connection without duplicating the INI-read logic.
// Does NOT open the connection — caller decides when.
procedure TDM.ConfigureFBConnectionFor(AConn: TFDConnection);
var
  IniFile: TIniFile;
  Server, Database, User, Password, PasswordEnc, CharSet: string;
  Port: Integer;
begin
  IniFile := TIniFile.Create(GlobalIniFile);
  try
    // Default 127.0.0.1, not 'localhost' -- avoids getaddrinfo(localhost) name
    // resolution, which failed intermittently at a store (WSANO_DATA).
    Server      := IniFile.ReadString (IniSecConnFB, IniKeyConnFBHost,     '127.0.0.1');
    Database    := IniFile.ReadString (IniSecConnFB, IniKeyConnFBDatabase, '');
    User        := IniFile.ReadString (IniSecConnFB, IniKeyConnFBUser,     'sysdba');
    PasswordEnc := IniFile.ReadString (IniSecConnFB, IniKeyPasswordEnc,    '');
    Password    := IniFile.ReadString (IniSecConnFB, IniKeyPassword,       '');
    Port        := IniFile.ReadInteger(IniSecConnFB, IniKeyConnFBPort,     3050);
    CharSet     := IniFile.ReadString (IniSecConnFB, IniKeyConnFBCharset,  'UTF8');
  finally
    IniFile.Free;
  end;

  Password := GetFBPasswordFromIni(PasswordEnc, Password, AConn = ConnFB);

  // NOTE: FDPhysFBDriverLink1.VendorLib is deliberately NOT set here. This
  // routine is called from background threads (the backup worker via RunBackup,
  // and the gold-price worker), and writing a shared VCL component's property
  // from a worker is a data race on main-thread-owned state -- the same class of
  // bug that the image audit was carrying. It is a set-once value, so it is
  // applied on the main thread in BindFBClientLibrary during DataModuleCreate,
  // before any worker can exist. Everything below only touches AConn, which the
  // caller owns.

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

// Points FireDAC's FB driver at the fbclient.dll shipped beside the EXE rather
// than whatever happens to be on PATH. Main thread only, set-once: call it
// during DataModuleCreate before any background worker can exist. Kept out of
// ConfigureFBConnectionFor precisely because that routine IS called from
// workers -- see the note there.
procedure TDM.BindFBClientLibrary;
begin
  FDPhysFBDriverLink1.VendorLib := ExtractFilePath(ParamStr(0)) + 'fbclient.dll';
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
        if Result then
          SavePendingFBPasswordToIni;
      finally
        q.Free;
      end;
    finally
      ConnFB.Connected := False;
    end;
  except
    on E: EAbort do
    begin
      Application.Terminate;
      raise;
    end;
    on E: Exception do
    begin
      ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
      Result := False;
    end;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  // First, on the main thread, before anything can spawn a worker: bind the FB
  // driver to our own fbclient.dll. Background workers configure their own
  // connections later and must never write this shared component property.
  BindFBClientLibrary;

  SaveCustQry := DM.qryCustomers.SQL.Text;

  RegIniFile.Path := LocalIniFile;

  // Make sure every INI key the app expects exists with a safe default. Must
  // run before any other INI read so first-run installs don't fall back to
  // per-call defaults that never get written to disk.
  EnsureIniDefaults(GlobalIniFile);

  // First run: if the local-database flag has never been written, detect it
  // from the configured FB host and persist the answer so admins can override
  // later. A non-local DB disables the backup option (no backup drive attached).
  if Trim(ReadIniFile(IniSecDatabase, IniKeyIsLocalDatabase)) = '' then
    if DetectDatabaseIsLocal then
      WriteIniFile(IniSecDatabase, IniKeyIsLocalDatabase, 'Y')
    else
      WriteIniFile(IniSecDatabase, IniKeyIsLocalDatabase, 'N');

  IsLocalDatabase := ReadIniFile(IniSecDatabase, IniKeyIsLocalDatabase) <> 'N';

  // Open ConnFB persistently for the lifetime of the data module.
  ConfigureFBConnection;
  try
    ConnFB.Connected := True;
    SavePendingFBPasswordToIni;
  except
    on E: EAbort do
    begin
      Application.Terminate;
      raise;
    end;
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

  CheckForMissingDBChanges;

  // Record which build is running this store. Written every startup (single
  // upsert) so support can answer "what version is this store on?" from the DB
  // instead of guessing. Never let version bookkeeping block startup.
  try
    SetAppStateText(AppStateKeyAppVersion, GetBuildStamp);
  except
  end;

  QryStates.Open;
  QryStates.Last;
  QryStates.First;

  // Briefcase pattern: load ITEM_STATUS into the in-memory clnItemStatus once
  // at startup so combobox population doesn't hit the DB every time.
  qryItemStatus.Open;
  clnItemStatus.CopyDataSet(qryItemStatus, [coStructure, coRestart, coAppend]);
  qryItemStatus.Close;

  LoadLookupMemTables;

  RefreshStoreQry;

  InterestCalcMethod := qryStoreINTEREST_CALC_METHOD.AsInteger;
  PawnDatesCalcMethod := qryStorePAWN_DATE_CALCULATION_BASE.AsString;
  if (PawnDatesCalcMethod <> PawnDateCalcByDays) and (PawnDatesCalcMethod <> PawnDateCalcByMonth) then
    PawnDatesCalcMethod := PawnDateCalcByDays;

  // Fall back to Pennyweight when the STORE row is missing the value (legacy
  // databases pre-dating the column, or a fresh store that hasn't filled it
  // through the app's settings screen yet).
  if qryStoreDEFAULT_WEIGHT_MEASURE_UNIT.IsNull or
     (Trim(qryStoreDEFAULT_WEIGHT_MEASURE_UNIT.AsString) = '') then
    DefaultWeightMeasureUnit := WeightUnitPennyweight
  else
    DefaultWeightMeasureUnit := qryStoreDEFAULT_WEIGHT_MEASURE_UNIT.AsString;

  PopulateWeightUnits;

  ReloadPrinterSettings;
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
  qryStorecCity.AsString := Copy(qryStoreSTORE_CITY_ST_ZIP.AsString, 1, pos(',', qryStoreSTORE_CITY_ST_ZIP.AsString) - 1);
  qryStorecState.AsString := Copy(qryStoreSTORE_CITY_ST_ZIP.AsString, pos(',', qryStoreSTORE_CITY_ST_ZIP.AsString)+ 2, 2);
  qryStorecZIp.AsString := Copy(qryStoreSTORE_CITY_ST_ZIP.AsString, pos(',', qryStoreSTORE_CITY_ST_ZIP.AsString)+ 5, 255);
end;

procedure TDM.qryPaymentsAfterPost(DataSet: TDataSet);
begin
  SendMessageToRefreshPaymentDueDateText;
end;

procedure TDM.qryPaymentsCalcFields(DataSet: TDataSet);
begin
  qryPaymentscComment.AsString := Copy(qryPaymentsPAY_COMMENT.AsString, 1, 255);
  qryPaymentscPeriodNo.AsInteger := GetPawnPeriod(qryTransactionsTRAN_DATE.AsDateTime, qryPaymentsPAY_DATE.AsDateTime);
end;

procedure TDM.qryPaymentsNewRecord(DataSet: TDataSet);
begin
  qryPaymentsPAY_DATE.AsDateTime := Date;
  // PAYMENT_NO is FB IDENTITY - assigned on Post via UpdateOptions.AutoIncFields.
  // TRANSACTION_NO is bound from the master via DataSource = DSTransactions.
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
  qryLastPayment.Params.ParamByName('TRANSACTION_NO').AsInteger := TransactionNo;
  qryLastPayment.Open;

  Result := qryLastPaymentLASTPAYMENTDATE.AsDateTime;

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
  Result := CalcPawnDefaultDate(TransactionDate, qryStoreDEFAULT_MATURITY_MONTHS.AsInteger);
end;

function TDM.GetCurrentInterestBalance(AsOfDate, PawnDate: TDateTime; PawnAmount, InterestRate: Currency; qryPayments: TDataSet): Currency;
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
        PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);

        if PayDt < PeriodStart then
        begin
          // PrincBalance is the principal AFTER that payment.
          CurrentPrincipal := qryPayments.FieldByName('PRINC_BALANCE').AsCurrency;
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
      PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);
      if PayDt <= AsOfDate then
        TotalInterestPaid := TotalInterestPaid +
          qryPayments.FieldByName('PAY_INTEREST').AsCurrency
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
  PawnAmount, InterestRate: Currency; qryPayments: TDataSet;
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
      PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);
      if PayDt <= AsOfDate then
        TotalInterestPaid := TotalInterestPaid +
          qryPayments.FieldByName('PAY_INTEREST').AsCurrency
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
        PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);
        if PayDt < PeriodStart then
        begin
          PrincipalSim := qryPayments.FieldByName('PRINC_BALANCE').AsCurrency;
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
      PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);
      if PayDt < PeriodStart then
      begin
        PrincipalCurrent := qryPayments.FieldByName('PRINC_BALANCE').AsCurrency;
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
      PayDt := Trunc(qryPayments.FieldByName('PAY_DATE').AsDateTime);
      if PayDt < NextPaymentDate then
      begin
        PrincipalNext := qryPayments.FieldByName('PRINC_BALANCE').AsCurrency;
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
        qryPawnPay.CopyDataSet(qryPayments, [coStructure, coRestart, coAppend]);
        qryPawnPay.IndexFieldNames := 'PAY_DATE';
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
  if Assigned(frmClients) and
     not (csDestroying in frmClients.ComponentState) and
     frmClients.HandleAllocated then
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
  DefaultMonthsToRedeem := qryStorePAWN_DEFAULT_MONTHS.AsInteger; //2;  // Store table ->  PawnDefaultMonths
  MaturityMonths        := qryStoreDEFAULT_MATURITY_MONTHS.AsInteger;   // DefaultMaturityMonths
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
  if qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat > 0 then
    IntRate := qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat
  else
    IntRate := 10;

  // TRANSACTION_NO is FB IDENTITY - assigned on Post via UpdateOptions.AutoIncFields
  qryTransactionsTRAN_DATE.AsDateTime := Date;
  qryTransactionsTRAN_MATURITY.AsDateTime := GetPawnMaturityDate(qryTransactionsTRAN_DATE.AsDateTime);
  qryTransactionsCUST_NO.AsInteger := qryCustomersCUST_NO.AsInteger;
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
  qryCustomersCUST_CITY.AsString := qryStorecCity.AsString;
  qryCustomersCUST_STATE.AsString := qryStorecState.AsString;
  qryCustomersCUST_ZIP.AsString := qryStorecZIp.AsString;
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

procedure TDM.qryCustomersAfterScroll(DataSet: TDataSet);
begin
  qryTransactions.Close;
  qryTransactions.Params.ParamByName('CUST_NO').AsInteger := qryCustomersCUST_NO.AsInteger;
  qryTransactions.Open;
end;

procedure TDM.qryCustomersCalcFields(DataSet: TDataSet);
begin
  qryCustomerscCustPhHome.AsString := FormatPhoneUSA(qryCustomersCUST_PH_HOME.AsString);
  qryCustomersCCustPhBussiness.AsString := FormatPhoneUSA(qryCustomersCUST_PH_BUSINESS.AsString);
  qryCustomersCCustPhBeep.AsString := FormatPhoneUSA(qryCustomersCUST_PH_BEEP.AsString);
  qryCustomerscCustPhCell.AsString := FormatPhoneUSA(qryCustomersCUST_PH_CELL.AsString);
  if trim(qryCustomersCUST_FL_DRV_LIC.AsString) <> '' then
    qryCustomerscCustFlDrvLic.AsString := FormatFLDriverLic(trim(qryCustomersCUST_FL_DRV_LIC.AsString));

  if qryCustomersCUST_DOB.AsDateTime > 0 then
    qryCustomerscCustAge.AsInteger := YearsBetween(Date, qryCustomersCUST_DOB.AsDateTime)
  else
    qryCustomerscCustAge.AsInteger := 0;

  if qryCustomersHAS_CUST_PICS.AsBoolean then
    qryCustomerscHasPics.AsString := 'X'
  else
    qryCustomerscHasPics.AsString := '';
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
  qryImage.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryImage.Open;
  qryImageImageData.SaveToFile(FileName);
  qryImage.Close;
end;

procedure TDM.ExportImageToPath(ImagesDataNo: integer; DestPath: string);
var
  LookupQuery: TFDQuery;
  ImageDate: TDateTime;
  SrcPath: string;
begin
  if ImageStorageMode = 'FILE' then
  begin
    LookupQuery := TFDQuery.Create(nil);
    try
      LookupQuery.Connection := ConnFB;
      LookupQuery.SQL.Text := 'SELECT CREATED FROM IMAGES_DATA WHERE IMAGES_DATA_NO = :ImagesDataNo';
      LookupQuery.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
      LookupQuery.Open;
      if LookupQuery.Eof or LookupQuery.FieldByName('CREATED').IsNull then
        ImageDate := 0
      else
        ImageDate := LookupQuery.FieldByName('CREATED').AsDateTime;
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
      cb.Items.Add(clnItemStatus.FieldByName('STATUS_DESC').AsString);
      if StatusToSelect = clnItemStatus.FieldByName('STATUS').AsString then
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
      qryUpdPawnStatus.Params.ParamByName('TransactionNo').Value := TransactionNo;
      qryUpdPawnStatus.Params.ParamByName('TranCloseReason').Value := CloseReason;
      qryUpdPawnStatus.Params.ParamByName('TranStatus').Value := TranStatus;
      qryUpdPawnStatus.ExecSQL;
    end;

end;

{ Status char of a PAWN item from its default-action dates: For Sale 'S',
  Scrap 'C', otherwise still 'P' (open, redeemed, or defaulted with no action). }
function PawnItemStatusChar(const MeltedDate, ForSaleDate: variant): string;
begin
  if not VarIsNull(ForSaleDate) then
    Result := 'S'
  else if not VarIsNull(MeltedDate) then
    Result := 'C'
  else
    Result := 'P';
end;

procedure TDM.UpdatePawnItemStatus(InvItemNo: integer; const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
begin
  // Never touches a sold item, or one in a state the pawn flow does not own.
  ConnFB.ExecSQL(
    'UPDATE INVENTORY_ITEMS ' +
    'SET INV_ITEM_STATUS = :INV_ITEM_STATUS, ' +
    '    REDEEMED_DATE = :REDEEMED_DATE, ' +
    '    DEFAULTED_DATE = :DEFAULTED_DATE, ' +
    '    MELTED_DATE = :MELTED_DATE, ' +
    '    FORSALE_DATE = :FORSALE_DATE ' +
    'WHERE INV_ITEM_NO = :INV_ITEM_NO ' +
    '  AND SOLD_DATE IS NULL ' +
    '  AND INV_ITEM_STATUS IN (''P'', ''S'', ''C'')',
    [PawnItemStatusChar(MeltedDate, ForSaleDate), RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate, InvItemNo]);
end;

procedure TDM.UpdatePawnItemStatusAndStage(TransactionNo: integer; CloseReason: smallint; PawnDefaultedItemAction: integer);
var
  DefaultedDate, RedeemedDate, MeltedDate, ForSaleDate: Variant;
begin
  RedeemedDate := Null;
  DefaultedDate := Null;
  MeltedDate := Null;
  ForSaleDate := Null;

  if CloseReason = PawnCloseReasonRedeemed then
    RedeemedDate := Date;

  if CloseReason = PawnCloseReasonDefaulted then
    DefaultedDate := Date;

  //Item Actions

  if PawnDefaultedItemAction > 0 then
    begin
      if PawnDefaultedItemAction = PawnDefaultedItemMelted then
        MeltedDate := Date;

     if PawnDefaultedItemAction = PawnDefaultedItemForSale then
        ForSaleDate := Date;
    end;

  // The status char follows the default action, so a defaulted item set For
  // Sale / Scrap is real For Sale / Scrap stock (Inventory filter, Sell screen,
  // reports read the char). Redeemed or defaulted-with-no-action stay 'P'.
  ConnFB.ExecSQL(
    'UPDATE INVENTORY_ITEMS ' +
    'SET INV_ITEM_STATUS = :INV_ITEM_STATUS, ' +
    '    REDEEMED_DATE = :REDEEMED_DATE, ' +
    '    DEFAULTED_DATE = :DEFAULTED_DATE, ' +
    '    MELTED_DATE = :MELTED_DATE, ' +
    '    FORSALE_DATE = :FORSALE_DATE ' +
    'WHERE TRANSACTION_NO = :TRANSACTION_NO ' +
    '  AND INV_ITEM_STATUS = ''P'' ' +
    '  AND REDEEMED_DATE IS NULL ' +
    '  AND DEFAULTED_DATE IS NULL',
    [PawnItemStatusChar(MeltedDate, ForSaleDate), RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate, TransactionNo]);
end;

procedure TDM.SetPawnAndItemsStatus(TransactionNo: integer; CloseReason: smallint; TranStatus: string; PawnDefaultedItemAction: integer);
var
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    qryUpdPawnStatus.Params.ParamByName('TransactionNo').Value := TransactionNo;
    qryUpdPawnStatus.Params.ParamByName('TranCloseReason').Value := CloseReason;
    qryUpdPawnStatus.Params.ParamByName('TranStatus').Value := TranStatus;
    qryUpdPawnStatus.ExecSQL;

    UpdatePawnItemStatusAndStage(TransactionNo, CloseReason, PawnDefaultedItemAction);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error updating pawn status: ' + E.Message);
    end;
  end;
end;

procedure TDM.PutPawnBackToActive(TransactionNo: integer);
var
  sSQLItemsStatus: string;
  sTransactionNo: string;
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  sTransactionNo := IntToStr(TransactionNo);

  // Defaulted items may now be 'S' (For Sale) or 'C' (Scrap); bring those back
  // to 'P' as well. A pawn with an item already sold cannot be reactivated --
  // reverting the rest would leave the pawn half-open.
  if ConnFB.ExecSQLScalar('SELECT COUNT(*) FROM INVENTORY_ITEMS WHERE TRANSACTION_NO = :TRANSACTION_NO' +
                          ' AND (SOLD_DATE IS NOT NULL OR INV_ITEM_STATUS = ''D'')', [TransactionNo]) > 0 then
    raise Exception.Create('This pawn has items that were already sold. It cannot be reactivated.');

  sSQLItemsStatus := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''P'', REDEEMED_DATE = null, DEFAULTED_DATE = null, MELTED_DATE = null, FORSALE_DATE = null ' + sLineBreak +
                     'WHERE TRANSACTION_NO = ' + sTransactionNo + ' and INV_ITEM_STATUS IN (''P'', ''S'', ''C'') and SOLD_DATE is null';

  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    ConnFB.ExecSQL('update TRANSACTIONS set TRAN_STATUS = ''A'', TRAN_CLOSE_REASON=0 where TRANSACTION_NO = ' + sTransactionNo);

    ConnFB.ExecSQL(sSQLItemsStatus);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error updating pawn status: ' + E.Message);
    end;
  end;


end;

{ Purchase item status -- the purchase counterpart of the Pawn change-status flow.

  A purchase item is created INV_ITEM_STATUS='S' with no FORSALE_DATE and no
  MELTED_DATE ("unclassified": bought, the store has not said what it is for).
  The store then classifies the whole purchase once:
    For Sale -> 'S' + FORSALE_DATE
    Scrap    -> 'C' + MELTED_DATE
  PutPurchaseBackToOriginal undoes that. The purchase TRANSACTION is never
  touched: unlike a pawn it has nothing to close, so it stays Active.

  "Locked" = sold, on layaway, or any other state this flow does not own. Locked
  items are never changed, and a purchase holding one cannot be reverted. }
const
  PurchaseItemUnclassifiedSQL =
    'INV_ITEM_STATUS = ''S'' AND FORSALE_DATE IS NULL AND MELTED_DATE IS NULL AND SOLD_DATE IS NULL';
  PurchaseItemLockedSQL =
    '(SOLD_DATE IS NOT NULL OR COALESCE(INV_ITEM_STATUS, '''') NOT IN (''S'', ''C''))';

procedure TDM.GetPurchaseItemsState(TransactionNo: integer; out Unclassified, Classified, Locked: integer);
var
  Q: TFDQuery;
begin
  Unclassified := 0;
  Classified := 0;
  Locked := 0;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := ConnFB;
    Q.SQL.Text :=
      'SELECT ' +
      '  COALESCE(SUM(CASE WHEN ' + PurchaseItemLockedSQL + ' THEN 1 ELSE 0 END), 0) AS N_LOCKED, ' +
      '  COALESCE(SUM(CASE WHEN ' + PurchaseItemUnclassifiedSQL + ' THEN 1 ELSE 0 END), 0) AS N_UNCLASSIFIED, ' +
      '  COUNT(*) AS N_ALL ' +
      'FROM INVENTORY_ITEMS WHERE TRANSACTION_NO = :TRANSACTION_NO';
    Q.ParamByName('TRANSACTION_NO').AsInteger := TransactionNo;
    Q.Open;

    Locked := Q.FieldByName('N_LOCKED').AsInteger;
    Unclassified := Q.FieldByName('N_UNCLASSIFIED').AsInteger;
    Classified := Q.FieldByName('N_ALL').AsInteger - Locked - Unclassified;
  finally
    Q.Free;
  end;
end;

procedure TDM.SetPurchaseItemsStatus(TransactionNo: integer; PurchaseItemAction: integer);
var
  sSQL: string;
  StartedFBTrans: Boolean;
begin
  if PurchaseItemAction = PawnDefaultedItemForSale then
    sSQL := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', FORSALE_DATE = CURRENT_DATE, MELTED_DATE = NULL '
  else if PurchaseItemAction = PawnDefaultedItemMelted then
    sSQL := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''C'', MELTED_DATE = CURRENT_DATE, FORSALE_DATE = NULL '
  else
    raise Exception.Create('SetPurchaseItemsStatus: unknown item action ' + IntToStr(PurchaseItemAction));

  // Only unclassified items: this is what makes the action one-time per purchase.
  sSQL := sSQL + 'WHERE TRANSACTION_NO = :TRANSACTION_NO AND ' + PurchaseItemUnclassifiedSQL;

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    ConnFB.ExecSQL(sSQL, [TransactionNo]);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error updating purchase items status: ' + E.Message);
    end;
  end;
end;

procedure TDM.PutPurchaseBackToOriginal(TransactionNo: integer);
var
  Unclassified, Classified, Locked: integer;
  StartedFBTrans: Boolean;
begin
  GetPurchaseItemsState(TransactionNo, Unclassified, Classified, Locked);
  if Locked > 0 then
    raise Exception.Create('This purchase has items that were already sold or put on layaway. ' +
                           'Its items cannot be put back to their original status.');

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    ConnFB.ExecSQL(
      'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', FORSALE_DATE = NULL, MELTED_DATE = NULL ' +
      'WHERE TRANSACTION_NO = :TRANSACTION_NO AND NOT ' + PurchaseItemLockedSQL,
      [TransactionNo]);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error reactivating purchase: ' + E.Message);
    end;
  end;
end;

{ Single-item version of SetPurchaseItemsStatus / PutPurchaseBackToOriginal,
  used by the Items grid right-click menu on a purchase. Writes the same status
  char and dates as the purchase-wide button, so both stay consistent. Unlike
  the button it may re-classify an already classified item (For Sale <-> Scrap),
  but never a locked one (sold / layaway). Returns False when the item was
  locked and nothing was changed. }
function TDM.SetPurchaseItemStatus(InvItemNo: integer; PurchaseItemAction: integer): boolean;
var
  sSQL: string;
begin
  case PurchaseItemAction of
    PawnDefaultedItemForSale:
      sSQL := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', FORSALE_DATE = CURRENT_DATE, MELTED_DATE = NULL ';
    PawnDefaultedItemMelted:
      sSQL := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''C'', MELTED_DATE = CURRENT_DATE, FORSALE_DATE = NULL ';
    PurchaseItemUndecided:
      sSQL := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', FORSALE_DATE = NULL, MELTED_DATE = NULL ';
  else
    raise Exception.Create('SetPurchaseItemStatus: unknown item action ' + IntToStr(PurchaseItemAction));
  end;

  sSQL := sSQL + 'WHERE INV_ITEM_NO = :INV_ITEM_NO AND NOT ' + PurchaseItemLockedSQL;

  // Single statement: autocommit is enough, no explicit FB transaction needed.
  Result := ConnFB.ExecSQL(sSQL, [InvItemNo]) > 0;
end;

{ Saves one sale -- from the Inventory sale drawer or the Sell Items screen --
  as a numbered ticket: a SALES row holding the money as it was on the day, one
  SALE_LINES row per item, and each item 'S' -> 'D' with SOLD_DATE (the
  INVENTORY_ITEM_STATUS_LOG trigger records that). UNIT_PRICE is left alone:
  the line keeps both the asking price and what the item sold for.

  The whole-sale discount is split across the lines in proportion to their
  sale price, in whole cents (largest remainder), so the line nets add up to
  exactly subtotal - discount and no line goes below zero.

  All or nothing, in one FB transaction: if any item is no longer For Sale
  (another PC sold it meanwhile) nothing is saved and the message names it.
  The ticket counter is bumped inside the same transaction, so a failed sale
  never uses up a ticket number. Returns the sale ticket number. }
function TDM.CompleteSale(const Lines: TArray<TSaleLine>; SaleDate: TDateTime;
  DiscountIsPercent: boolean; DiscountValue, TaxPerc: Currency): integer;
var
  i, Best, SaleNo: integer;
  Subtotal, Discount, Tax, Total, Share: Currency;
  SubCents, DiscCents, PriceCents, LeftCents: Int64;
  ShareCents, Remainders: TArray<Int64>;
  DiscType, DiscValue: Variant;
  StartedFBTrans: Boolean;
  Barcode, Step: string;
begin
  if Length(Lines) = 0 then
    raise Exception.Create('There are no items in this sale.');

  Subtotal := 0;
  for i := 0 to High(Lines) do
    begin
      if Lines[i].SalePrice <= 0 then
        raise Exception.Create('Every item in the sale needs a sale price.');
      Subtotal := Subtotal + Lines[i].SalePrice;
    end;

  Discount := CalcSaleDiscount(Subtotal, DiscountIsPercent, DiscountValue);
  CalcTaxAndTotal(Subtotal - Discount, TaxPerc, Tax, Total);

  // Discount shares in cents: floor of the proportional share, then the cents
  // left over go one each to the lines with the largest remainders.
  SubCents := Round(Subtotal * 100);
  DiscCents := Round(Discount * 100);
  SetLength(ShareCents, Length(Lines));
  SetLength(Remainders, Length(Lines));
  LeftCents := DiscCents;
  for i := 0 to High(Lines) do
    begin
      PriceCents := Round(Lines[i].SalePrice * 100);
      ShareCents[i] := (DiscCents * PriceCents) div SubCents;
      Remainders[i] := (DiscCents * PriceCents) mod SubCents;
      Dec(LeftCents, ShareCents[i]);
    end;
  while LeftCents > 0 do
    begin
      Best := 0;
      for i := 1 to High(Lines) do
        if Remainders[i] > Remainders[Best] then
          Best := i;
      Inc(ShareCents[Best]);
      Remainders[Best] := -1;
      Dec(LeftCents);
    end;

  if Discount > 0 then
    begin
      if DiscountIsPercent then
        DiscType := SaleDiscount_Percent
      else
        DiscType := SaleDiscount_Amount;
      DiscValue := DiscountValue;
    end
  else
    begin
      DiscType := Null;
      DiscValue := Null;
    end;

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    for i := 0 to High(Lines) do
      if ConnFB.ExecSQL(
           'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''D'', SOLD_DATE = :SOLD_DATE ' +
           'WHERE INV_ITEM_NO = :INV_ITEM_NO AND INV_ITEM_STATUS = ''S'' AND SOLD_DATE IS NULL',
           [DateOf(SaleDate), Lines[i].InvItemNo]) = 0 then
        begin
          Barcode := VarToStr(ConnFB.ExecSQLScalar(
            'SELECT INV_ITEM_BARCODE FROM INVENTORY_ITEMS WHERE INV_ITEM_NO = :INV_ITEM_NO', [Lines[i].InvItemNo]));
          raise Exception.CreateFmt('Item %s is no longer For Sale. Nothing was sold.', [Barcode]);
        end;

    // Next sale ticket number: the counter plus a random 1..SaleTicketMaxStep,
    // so the gap between two receipts says nothing about how many sales
    // happened in between (the store's volume). Still increasing, and still
    // inside the sale's transaction: a failed sale gives its number back.
    // The UPDATE locks the counter row until commit, so two PCs completing a
    // sale at the same moment cannot share a number (UQ_SALES_TICKET_NO backs
    // that up). A missing counter row is recreated past the last ticket saved.
    Step := Format('(1 + CAST(FLOOR(RAND() * %d) AS INTEGER))', [SaleTicketMaxStep]);
    if ConnFB.ExecSQL('UPDATE TABLE_KEYS SET LAST_KEY = LAST_KEY + ' + Step +
                      ' WHERE TABLE_NAME = :TABLE_NAME', [SaleTicketNo]) = 0 then
      ConnFB.ExecSQL('INSERT INTO TABLE_KEYS (TABLE_NAME, LAST_KEY) ' +
                     'SELECT CAST(:TABLE_NAME AS VARCHAR(15)), ' +
                     Format('MAXVALUE(COALESCE(MAX(SALE_TICKET_NO), 0), %d) + ', [SaleTicketStartAfter]) + Step +
                     ' FROM SALES', [SaleTicketNo]);
    Result := ConnFB.ExecSQLScalar('SELECT LAST_KEY FROM TABLE_KEYS WHERE TABLE_NAME = :TABLE_NAME',
                                   [SaleTicketNo]);

    // Pay type 1 = Cash (PAYMENT_TYPES); the only way to pay until card
    // payments are added.
    ConnFB.ExecSQL(
      'INSERT INTO SALES (SALE_TICKET_NO, SALE_DATE, SUBTOTAL, DISCOUNT_TYPE, DISCOUNT_VALUE, ' +
      '  DISCOUNT_AMOUNT, TAX_PERC, TAX_AMOUNT, TOTAL, PAY_TYPE_NO, SALE_STATUS) ' +
      'VALUES (:SALE_TICKET_NO, :SALE_DATE, :SUBTOTAL, :DISCOUNT_TYPE, :DISCOUNT_VALUE, ' +
      '  :DISCOUNT_AMOUNT, :TAX_PERC, :TAX_AMOUNT, :TOTAL, 1, :SALE_STATUS)',
      [Result, DateOf(SaleDate), Subtotal, DiscType, DiscValue,
       Discount, TaxPerc, Tax, Total, SaleStatus_Completed],
      [ftInteger, ftDate, ftCurrency, ftWideString, ftCurrency,
       ftCurrency, ftCurrency, ftCurrency, ftCurrency, ftWideString]);

    SaleNo := ConnFB.ExecSQLScalar('SELECT SALE_NO FROM SALES WHERE SALE_TICKET_NO = :SALE_TICKET_NO', [Result]);

    // Quantity, cost and asking price come from the item as it is now.
    for i := 0 to High(Lines) do
      begin
        Share := ShareCents[i] / 100;
        ConnFB.ExecSQL(
          'INSERT INTO SALE_LINES (SALE_NO, INV_ITEM_NO, ITEM_COUNT, DESCRIPTION, UNIT_COST, ' +
          '  LIST_PRICE, SALE_PRICE, DISCOUNT_SHARE, NET_PRICE) ' +
          'SELECT CAST(:SALE_NO AS INTEGER), ii.INV_ITEM_NO, ii.INV_ITEM_COUNT, ' +
          '  CAST(:DESCRIPTION AS VARCHAR(120)), ii.UNIT_COST, ii.UNIT_PRICE, ' +
          '  CAST(:SALE_PRICE AS DECIMAL(18,2)), CAST(:DISCOUNT_SHARE AS DECIMAL(18,2)), ' +
          '  CAST(:NET_PRICE AS DECIMAL(18,2)) ' +
          'FROM INVENTORY_ITEMS ii WHERE ii.INV_ITEM_NO = :INV_ITEM_NO',
          [SaleNo, Copy(Lines[i].Description, 1, 120), Lines[i].SalePrice, Share,
           Lines[i].SalePrice - Share, Lines[i].InvItemNo],
          [ftInteger, ftWideString, ftCurrency, ftCurrency, ftCurrency, ftInteger]);
      end;

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Rollback;
    raise;
  end;
end;

{ Voids a whole sale ticket: its items go back to For Sale (SOLD_DATE cleared)
  and the ticket stays in SALES marked Voided -- never deleted -- so ticket
  numbers have no holes and the history shows what happened. All or nothing:
  refused when the ticket is already voided, or when any of its items is no
  longer Sold the way this sale left it. }
procedure TDM.VoidSale(SaleNo: integer; const Reason: string);
var
  LineCount, Restored: integer;
  VoidReason: Variant;
  StartedFBTrans: Boolean;
begin
  if Trim(Reason) = '' then
    VoidReason := Null
  else
    VoidReason := Copy(Trim(Reason), 1, 120);

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    if ConnFB.ExecSQL(
         'UPDATE SALES SET SALE_STATUS = :VOIDED, VOID_DATE = CURRENT_TIMESTAMP, VOID_REASON = :VOID_REASON ' +
         'WHERE SALE_NO = :SALE_NO AND SALE_STATUS = :COMPLETED',
         [SaleStatus_Voided, VoidReason, SaleNo, SaleStatus_Completed],
         [ftWideString, ftWideString, ftInteger, ftWideString]) = 0 then
      raise Exception.Create('This sale was already voided.');

    // Lines whose item no longer exists (deleted together with this void, see
    // TDM.DeleteWithLog) have nothing to put back, so they are not expected.
    LineCount := ConnFB.ExecSQLScalar(
      'SELECT COUNT(*) FROM SALE_LINES l WHERE l.SALE_NO = :SALE_NO ' +
      '  AND EXISTS (SELECT 1 FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO)', [SaleNo]);
    Restored := ConnFB.ExecSQL(
      'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', SOLD_DATE = NULL ' +
      'WHERE INV_ITEM_NO IN (SELECT INV_ITEM_NO FROM SALE_LINES WHERE SALE_NO = :SALE_NO) ' +
      '  AND INV_ITEM_STATUS = ''D'' AND LAYAWAY_DATE IS NULL',
      [SaleNo]);
    if Restored <> LineCount then
      raise Exception.Create('Some items of this sale are no longer Sold. The sale was not voided.');

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Rollback;
    raise;
  end;
end;

{ The completed sale ticket an item was sold on. False when there is none:
  the item was sold before sale tickets existed, or through a layaway. }
function TDM.FindSaleOfItem(InvItemNo: integer; out SaleNo, TicketNo, LineCount: integer;
  out Total: Currency): boolean;
var
  Qry: TFDQuery;
begin
  SaleNo := 0;
  TicketNo := 0;
  LineCount := 0;
  Total := 0;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConnFB;
    Qry.SQL.Text :=
      'SELECT s.SALE_NO, s.SALE_TICKET_NO, s.TOTAL, ' +
      '       (SELECT COUNT(*) FROM SALE_LINES l2 WHERE l2.SALE_NO = s.SALE_NO) AS LINE_COUNT ' +
      'FROM SALE_LINES l JOIN SALES s ON s.SALE_NO = l.SALE_NO ' +
      'WHERE l.INV_ITEM_NO = :INV_ITEM_NO AND s.SALE_STATUS = :COMPLETED ' +
      'ORDER BY s.SALE_NO DESC ROWS 1';
    Qry.ParamByName('INV_ITEM_NO').AsInteger := InvItemNo;
    Qry.ParamByName('COMPLETED').AsString := SaleStatus_Completed;
    Qry.Open;
    Result := not Qry.IsEmpty;
    if Result then
      begin
        SaleNo := Qry.FieldByName('SALE_NO').AsInteger;
        TicketNo := Qry.FieldByName('SALE_TICKET_NO').AsInteger;
        LineCount := Qry.FieldByName('LINE_COUNT').AsInteger;
        Total := Qry.FieldByName('TOTAL').AsCurrency;
      end;
  finally
    Qry.Free;
  end;
end;

{ Before deleting an item (InvItemNo > 0) or a whole transaction
  (InvItemNo = 0): how many of its items are sold (SOLD_DATE set, or status
  'D'), and the COMPLETED sale tickets holding them. Returns those tickets as
  text ('4012, 4031'), '' when none; SaleNos are what TDM.DeleteWithLog voids.
  Voided tickets need nothing: they stay in history as they are. }
function TDM.GetSoldItemsInfo(TransactionNo, InvItemNo: integer; out SoldCount: integer;
  out SaleNos: TArray<integer>): string;
var
  Qry: TFDQuery;
  Scope: string;
begin
  Result := '';
  SaleNos := nil;
  if InvItemNo > 0 then
    Scope := 'ii.INV_ITEM_NO = ' + IntToStr(InvItemNo)
  else
    Scope := 'ii.TRANSACTION_NO = ' + IntToStr(TransactionNo);

  SoldCount := ConnFB.ExecSQLScalar(
    'SELECT COUNT(*) FROM INVENTORY_ITEMS ii WHERE ' + Scope +
    ' AND (ii.SOLD_DATE IS NOT NULL OR ii.INV_ITEM_STATUS = ''D'')');

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConnFB;
    Qry.SQL.Text :=
      'SELECT DISTINCT s.SALE_NO, s.SALE_TICKET_NO ' +
      'FROM SALE_LINES l ' +
      'JOIN SALES s ON s.SALE_NO = l.SALE_NO ' +
      'JOIN INVENTORY_ITEMS ii ON ii.INV_ITEM_NO = l.INV_ITEM_NO ' +
      'WHERE ' + Scope + ' AND s.SALE_STATUS = :COMPLETED ' +
      'ORDER BY s.SALE_TICKET_NO';
    Qry.ParamByName('COMPLETED').AsString := SaleStatus_Completed;
    Qry.Open;
    while not Qry.Eof do
      begin
        SaleNos := SaleNos + [Qry.Fields[0].AsInteger];
        if Result <> '' then
          Result := Result + ', ';
        Result := Result + Qry.Fields[1].AsString;
        Qry.Next;
      end;
  finally
    Qry.Free;
  end;
end;

{ Deletes an item or a transaction (DeleteProc does the actual delete) and
  voids the completed sale tickets of its sold items, all in one database
  transaction: everything happens, or nothing does.

  The log is written by the database (BEFORE DELETE triggers into
  INVENTORY_ITEMS_DELETED / TRANSACTIONS_DELETED, schema v13); Reason reaches
  them through the transaction's context. The delete runs BEFORE the voids,
  so the copy shows a sold item as Sold; VoidSale then puts the ticket's
  remaining items back to For Sale and skips the deleted one. }
procedure TDM.DeleteWithLog(const SaleNos: TArray<integer>; const Reason: string; const DeleteProc: TProc);
var
  SaleNo: integer;
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    if Trim(Reason) <> '' then
      ConnFB.ExecSQLScalar(
        'SELECT RDB$SET_CONTEXT(''USER_TRANSACTION'', ''PAWNPRO_DELETE_REASON'', ' +
        'CAST(:REASON AS VARCHAR(200))) FROM RDB$DATABASE',
        [Copy(Trim(Reason), 1, 200)], [ftWideString]);

    DeleteProc();

    for SaleNo in SaleNos do
      VoidSale(SaleNo, Copy('Item deleted: ' + Trim(Reason), 1, 120));

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Rollback;
    raise;
  end;
end;

{ ---- Receive Stock (supplier purchases, schema v15) ----------------------- }

{ The supplier with this name, added when it is new -- the supplier box works
  like the brand box: type a name, or pick one typed before. Names are unique
  ignoring case and accents (UQ_SUPPLIERS_NAME on the UNICODE_CI_AI collation),
  so 'miami gold' finds 'Miami Gold'. Two PCs adding the same new name at once:
  the second insert fails on the unique key and simply re-reads the first's.
  Using a hidden (inactive) supplier makes it active again. }
function TDM.FindOrAddSupplier(const AName: string): integer;
var
  Name: string;
  V: Variant;
begin
  Name := Copy(Trim(AName), 1, 80);
  if Name = '' then
    raise Exception.Create('Please enter the supplier.');

  V := ConnFB.ExecSQLScalar('SELECT SUPPLIER_NO FROM SUPPLIERS WHERE SUPPLIER_NAME = :N', [Name], [ftWideString]);
  if VarIsNull(V) or VarIsEmpty(V) then
    try
      V := ConnFB.ExecSQLScalar(
        'INSERT INTO SUPPLIERS (SUPPLIER_NAME) VALUES (:N) RETURNING SUPPLIER_NO', [Name], [ftWideString]);
    except
      V := ConnFB.ExecSQLScalar('SELECT SUPPLIER_NO FROM SUPPLIERS WHERE SUPPLIER_NAME = :N', [Name], [ftWideString]);
      if VarIsNull(V) or VarIsEmpty(V) then
        raise;
    end;
  Result := V;
  ConnFB.ExecSQL('UPDATE SUPPLIERS SET ACTIVE = TRUE WHERE SUPPLIER_NO = :S AND ACTIVE = FALSE', [Result]);
end;

{ Inserts the receipt header (ReceiptNo = 0) or updates it; returns its number.
  InvoiceDate, InvoiceTotal and PayTypeNo may be Null. Changing the received
  date also moves the PURCHASE_DATE / FORSALE_DATE of its items still For Sale,
  so the item dates keep matching the receipt. }
function TDM.SaveStockReceipt(ReceiptNo, SupplierNo: integer; ReceivedDate: TDateTime;
  const InvoiceNo: string; const InvoiceDate, InvoiceTotal, PayTypeNo: Variant;
  const Notes: string): integer;
var
  InvNo, Nts: Variant;
begin
  if Trim(InvoiceNo) = '' then InvNo := Null else InvNo := Copy(Trim(InvoiceNo), 1, 40);
  if Trim(Notes) = '' then Nts := Null else Nts := Copy(Trim(Notes), 1, 500);

  if ReceiptNo = 0 then
    Result := ConnFB.ExecSQLScalar(
      'INSERT INTO STOCK_RECEIPTS (SUPPLIER_NO, RECEIVED_DATE, INVOICE_NO, INVOICE_DATE, ' +
      '  INVOICE_TOTAL, PAY_TYPE_NO, NOTES) ' +
      'VALUES (:S, :RD, :INV, :ID, :TOT, :PT, :NOTES) RETURNING STOCK_RECEIPT_NO',
      [SupplierNo, DateOf(ReceivedDate), InvNo, InvoiceDate, InvoiceTotal, PayTypeNo, Nts],
      [ftInteger, ftDate, ftWideString, ftDate, ftCurrency, ftInteger, ftWideString])
  else
    begin
      ConnFB.ExecSQL(
        'UPDATE STOCK_RECEIPTS SET SUPPLIER_NO = :S, RECEIVED_DATE = :RD, INVOICE_NO = :INV, ' +
        '  INVOICE_DATE = :ID, INVOICE_TOTAL = :TOT, PAY_TYPE_NO = :PT, NOTES = :NOTES ' +
        'WHERE STOCK_RECEIPT_NO = :R',
        [SupplierNo, DateOf(ReceivedDate), InvNo, InvoiceDate, InvoiceTotal, PayTypeNo, Nts, ReceiptNo],
        [ftInteger, ftDate, ftWideString, ftDate, ftCurrency, ftInteger, ftWideString, ftInteger]);
      ConnFB.ExecSQL(
        'UPDATE INVENTORY_ITEMS i SET i.PURCHASE_DATE = :RD, i.FORSALE_DATE = :RD2 ' +
        'WHERE i.INV_ITEM_STATUS = ''S'' AND i.SOLD_DATE IS NULL AND i.TRANSACTION_NO IS NULL ' +
        '  AND i.INV_ITEM_NO IN (SELECT l.INV_ITEM_NO FROM STOCK_RECEIPT_LINES l WHERE l.STOCK_RECEIPT_NO = :R)',
        [DateOf(ReceivedDate), DateOf(ReceivedDate), ReceiptNo], [ftDate, ftDate, ftInteger]);
      Result := ReceiptNo;
    end;
end;

{ The receipt's line for an item, added or brought in line with the item:
  while the stock is being received, an edit of the item is a correction of
  what came in, so the line follows it. }
procedure TDM.SaveStockReceiptLine(ReceiptNo, InvItemNo: integer);
begin
  if ConnFB.ExecSQL(
       'UPDATE STOCK_RECEIPT_LINES l SET ' +
       '  l.DESCRIPTION = (SELECT LEFT(i.DESCRIPTION, 120) FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO), ' +
       '  l.UNIT_COST = (SELECT i.UNIT_COST FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO), ' +
       '  l.UNIT_PRICE = (SELECT i.UNIT_PRICE FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO) ' +
       'WHERE l.STOCK_RECEIPT_NO = :R AND l.INV_ITEM_NO = :I', [ReceiptNo, InvItemNo]) = 0 then
    ConnFB.ExecSQL(
      'INSERT INTO STOCK_RECEIPT_LINES (STOCK_RECEIPT_NO, INV_ITEM_NO, DESCRIPTION, UNIT_COST, UNIT_PRICE) ' +
      'SELECT CAST(:R AS INTEGER), i.INV_ITEM_NO, LEFT(i.DESCRIPTION, 120), i.UNIT_COST, i.UNIT_PRICE ' +
      'FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = :I', [ReceiptNo, InvItemNo]);
end;

{ "Copies": Copies more items exactly like SourceItemNo (stones included),
  each with its own number and barcode and its own receipt line, all in one
  copy group with the original. One database
  transaction: all copies or none. A plain loop, not an EXECUTE BLOCK: FireDAC
  would take the block's own :variables for its parameters. }
procedure TDM.CopyStockReceiptItem(ReceiptNo, SourceItemNo, Copies: integer);
var
  k, NewNo, Group: integer;
  StartedFBTrans: Boolean;
begin
  if Copies <= 0 then
    exit;

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    // The original and its copies share the receipt's next group number, so
    // an edit can later be applied to all of them (ApplyItemToCopyGroup).
    Group := ConnFB.ExecSQLScalar(
      'SELECT COALESCE(MAX(COPY_GROUP), 0) + 1 FROM STOCK_RECEIPT_LINES WHERE STOCK_RECEIPT_NO = :R', [ReceiptNo]);
    ConnFB.ExecSQL('UPDATE STOCK_RECEIPT_LINES SET COPY_GROUP = :G WHERE STOCK_RECEIPT_NO = :R AND INV_ITEM_NO = :I',
                   [Group, ReceiptNo, SourceItemNo]);

    for k := 1 to Copies do
      begin
        NewNo := ConnFB.ExecSQLScalar(
          'INSERT INTO INVENTORY_ITEMS (INV_CAT_NO, J_TYPE, J_STYLE, J_METAL, INV_ITEM_COUNT, NOTE, ' +
          '  SIZE_LENGTH, WEIGHT, KT, UNIT_COST, UNIT_PRICE, INV_ITEM_STATUS, TRANSACTION_NO, ' +
          '  INV_ITEM_BRAND, SERIAL_NUMBER, OWNER_APP_NUMBER, MODEL_NUMBER, GENDER, DESCRIPTION, ' +
          '  WEIGHT_UNIT, PURCHASE_DATE, FORSALE_DATE) ' +
          'SELECT INV_CAT_NO, J_TYPE, J_STYLE, J_METAL, INV_ITEM_COUNT, NOTE, ' +
          '  SIZE_LENGTH, WEIGHT, KT, UNIT_COST, UNIT_PRICE, INV_ITEM_STATUS, TRANSACTION_NO, ' +
          '  INV_ITEM_BRAND, SERIAL_NUMBER, OWNER_APP_NUMBER, MODEL_NUMBER, GENDER, DESCRIPTION, ' +
          '  WEIGHT_UNIT, PURCHASE_DATE, FORSALE_DATE ' +
          'FROM INVENTORY_ITEMS WHERE INV_ITEM_NO = :SRC ' +
          'RETURNING INV_ITEM_NO', [SourceItemNo]);

        ConnFB.ExecSQL('UPDATE INVENTORY_ITEMS SET INV_ITEM_BARCODE = :B WHERE INV_ITEM_NO = :I',
                       [GetBarcode(NewNo), NewNo], [ftWideString, ftInteger]);
        ConnFB.ExecSQL(
          'INSERT INTO STONES (INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT) ' +
          'SELECT CAST(:NEW_NO AS INTEGER), STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT ' +
          'FROM STONES WHERE INV_ITEM_NO = :SRC', [NewNo, SourceItemNo]);
        SaveStockReceiptLine(ReceiptNo, NewNo);
        ConnFB.ExecSQL('UPDATE STOCK_RECEIPT_LINES SET COPY_GROUP = :G WHERE STOCK_RECEIPT_NO = :R AND INV_ITEM_NO = :I',
                       [Group, ReceiptNo, NewNo]);
      end;

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Rollback;
    raise;
  end;
end;

{ The copy group of an item on a receipt (0 when it is a single piece), how
  many pieces of the group are still there, and how many of the OTHER pieces
  are still unsold -- the ones an "apply to the group" edit would change. }
procedure TDM.GetCopyGroupSize(ReceiptNo, InvItemNo: integer; out Group, Size, UnsoldOthers: integer);
var
  V: Variant;
begin
  Group := 0;
  Size := 0;
  UnsoldOthers := 0;
  V := ConnFB.ExecSQLScalar(
    'SELECT COPY_GROUP FROM STOCK_RECEIPT_LINES WHERE STOCK_RECEIPT_NO = :R AND INV_ITEM_NO = :I',
    [ReceiptNo, InvItemNo]);
  if VarIsNull(V) or VarIsEmpty(V) then
    exit;
  Group := V;
  Size := ConnFB.ExecSQLScalar(
    'SELECT COUNT(*) FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
    'WHERE l.STOCK_RECEIPT_NO = :R AND l.COPY_GROUP = :G', [ReceiptNo, Group]);
  UnsoldOthers := ConnFB.ExecSQLScalar(
    'SELECT COUNT(*) FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
    'WHERE l.STOCK_RECEIPT_NO = :R AND l.COPY_GROUP = :G AND l.INV_ITEM_NO <> :I ' +
    '  AND i.INV_ITEM_STATUS = ''S'' AND i.SOLD_DATE IS NULL', [ReceiptNo, Group, InvItemNo]);
end;

{ An edit of one piece of a copy group, applied to the group's other UNSOLD
  pieces: the same details and stones. Each piece keeps its own barcode,
  status, dates and serial number (by nature one per piece). Sold / layaway
  pieces are never touched. One database transaction. Returns how many pieces
  were changed. }
function TDM.ApplyItemToCopyGroup(ReceiptNo, SourceItemNo: integer): integer;
var
  Group, Size, Unsold: integer;
  StartedFBTrans: Boolean;
const
  OthersSQL =
    'SELECT l.INV_ITEM_NO FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS o ON o.INV_ITEM_NO = l.INV_ITEM_NO ' +
    'WHERE l.STOCK_RECEIPT_NO = :R AND l.COPY_GROUP = :G AND l.INV_ITEM_NO <> :SRC ' +
    '  AND o.INV_ITEM_STATUS = ''S'' AND o.SOLD_DATE IS NULL';
begin
  Result := 0;
  GetCopyGroupSize(ReceiptNo, SourceItemNo, Group, Size, Unsold);
  if (Group = 0) or (Unsold = 0) then
    exit;

  StartedFBTrans := False;
  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    Result := ConnFB.ExecSQL(
      'UPDATE INVENTORY_ITEMS o SET ' +
      '  o.INV_CAT_NO = (SELECT s.INV_CAT_NO FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.J_TYPE = (SELECT s.J_TYPE FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.J_STYLE = (SELECT s.J_STYLE FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.J_METAL = (SELECT s.J_METAL FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.GENDER = (SELECT s.GENDER FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.DESCRIPTION = (SELECT s.DESCRIPTION FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.NOTE = (SELECT s.NOTE FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.SIZE_LENGTH = (SELECT s.SIZE_LENGTH FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.WEIGHT = (SELECT s.WEIGHT FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.WEIGHT_UNIT = (SELECT s.WEIGHT_UNIT FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.KT = (SELECT s.KT FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.UNIT_COST = (SELECT s.UNIT_COST FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.UNIT_PRICE = (SELECT s.UNIT_PRICE FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.INV_ITEM_BRAND = (SELECT s.INV_ITEM_BRAND FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.MODEL_NUMBER = (SELECT s.MODEL_NUMBER FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC), ' +
      '  o.OWNER_APP_NUMBER = (SELECT s.OWNER_APP_NUMBER FROM INVENTORY_ITEMS s WHERE s.INV_ITEM_NO = :SRC) ' +
      'WHERE o.INV_ITEM_NO IN (' + OthersSQL + ')',
      [SourceItemNo, ReceiptNo, Group]);

    // Stones: the group's other unsold pieces get exactly the edited piece's stones.
    ConnFB.ExecSQL('DELETE FROM STONES WHERE INV_ITEM_NO IN (' + OthersSQL + ')',
                   [ReceiptNo, Group, SourceItemNo]);
    ConnFB.ExecSQL(
      'INSERT INTO STONES (INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, STONE_COLOR, CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT) ' +
      'SELECT x.INV_ITEM_NO, s.STONE_NUMBER, s.STONE_SHAPE, s.STONE_COLOR, s.CT, s.WT, s.STONE_TYPE, s.STONE_WEIGHT_UNIT ' +
      'FROM STONES s, (' + OthersSQL + ') x WHERE s.INV_ITEM_NO = :SRC2',
      [ReceiptNo, Group, SourceItemNo, SourceItemNo]);

    // The group's lines follow, as SaveStockReceiptLine does for one item.
    ConnFB.ExecSQL(
      'UPDATE STOCK_RECEIPT_LINES l SET ' +
      '  l.DESCRIPTION = (SELECT LEFT(i.DESCRIPTION, 120) FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO), ' +
      '  l.UNIT_COST = (SELECT i.UNIT_COST FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO), ' +
      '  l.UNIT_PRICE = (SELECT i.UNIT_PRICE FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO) ' +
      'WHERE l.STOCK_RECEIPT_NO = :R AND l.COPY_GROUP = :G ' +
      '  AND EXISTS (SELECT 1 FROM INVENTORY_ITEMS i WHERE i.INV_ITEM_NO = l.INV_ITEM_NO ' +
      '              AND i.INV_ITEM_STATUS = ''S'' AND i.SOLD_DATE IS NULL)',
      [ReceiptNo, Group]);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Rollback;
    raise;
  end;
end;

{ Sold, or on layaway: the item has left the stock and stays out of this
  receipt's edits (it is deleted, if ever, from the Items / client screens). }
function TDM.StockReceiptItemIsSold(InvItemNo: integer): boolean;
begin
  Result := ConnFB.ExecSQLScalar(
    'SELECT COUNT(*) FROM INVENTORY_ITEMS WHERE INV_ITEM_NO = :I ' +
    '  AND (SOLD_DATE IS NOT NULL OR INV_ITEM_STATUS IN (''D'', ''L''))', [InvItemNo]) > 0;
end;

{ Takes an unsold item off a receipt: the item is deleted (logged by the v14
  trigger, with the receipt number); its receipt line stays as the record of
  what came in. }
procedure TDM.RemoveStockReceiptItem(InvItemNo: integer; const Reason: string);
begin
  if StockReceiptItemIsSold(InvItemNo) then
    raise Exception.Create('This item is sold or on layaway, so it is no longer only on this receipt.');
  DeleteWithLog(nil, Reason,
    procedure
    begin
      ConnFB.ExecSQL('DELETE FROM IMAGES_DATA WHERE IMAG_REF_TO_ROW_NO = :I', [InvItemNo]);
      ConnFB.ExecSQL('DELETE FROM INVENTORY_ITEMS WHERE INV_ITEM_NO = :I', [InvItemNo]);
    end);
end;

{ Voids a receipt entered by mistake: its items are deleted (logged, with the
  reason) and the receipt stays, marked 'V'. Refused while any of its items is
  sold or on layaway -- those left the stock and cannot be un-received. }
procedure TDM.VoidStockReceipt(ReceiptNo: integer; const Reason: string);
begin
  if ConnFB.ExecSQLScalar(
       'SELECT COUNT(*) FROM STOCK_RECEIPT_LINES l JOIN INVENTORY_ITEMS i ON i.INV_ITEM_NO = l.INV_ITEM_NO ' +
       'WHERE l.STOCK_RECEIPT_NO = :R AND (i.SOLD_DATE IS NOT NULL OR i.INV_ITEM_STATUS IN (''D'', ''L''))',
       [ReceiptNo]) > 0 then
    raise Exception.Create('Some items of this receipt are sold or on layaway. The receipt was not voided.');

  DeleteWithLog(nil, Copy('Receipt voided: ' + Trim(Reason), 1, 200),
    procedure
    begin
      ConnFB.ExecSQL(
        'DELETE FROM IMAGES_DATA WHERE IMAG_REF_TO_ROW_NO IN ' +
        '  (SELECT INV_ITEM_NO FROM STOCK_RECEIPT_LINES WHERE STOCK_RECEIPT_NO = :R)', [ReceiptNo]);
      ConnFB.ExecSQL(
        'DELETE FROM INVENTORY_ITEMS WHERE INV_ITEM_NO IN ' +
        '  (SELECT INV_ITEM_NO FROM STOCK_RECEIPT_LINES WHERE STOCK_RECEIPT_NO = :R)', [ReceiptNo]);
      if ConnFB.ExecSQL(
           'UPDATE STOCK_RECEIPTS SET RECEIPT_STATUS = ''V'', VOID_DATE = CURRENT_TIMESTAMP, ' +
           '  VOID_REASON = :REASON WHERE STOCK_RECEIPT_NO = :R AND RECEIPT_STATUS = ''A''',
           [Copy(Trim(Reason), 1, 120), ReceiptNo], [ftWideString, ftInteger]) = 0 then
        raise Exception.Create('This receipt was already voided.');
    end);
end;

{ Undo the sale of an item that has no sale ticket (sold before tickets
  existed): back to For Sale, SOLD_DATE cleared. A layaway payoff also sets
  SOLD_DATE but belongs to Reactivate Layaway, so it is not touched here.
  Items sold on a ticket are put back by TDM.VoidSale. False if nothing changed. }
function TDM.UnsellItem(InvItemNo: integer): boolean;
begin
  Result := ConnFB.ExecSQL(
    'UPDATE INVENTORY_ITEMS ii SET ii.INV_ITEM_STATUS = ''S'', ii.SOLD_DATE = NULL ' +
    'WHERE ii.INV_ITEM_NO = :INV_ITEM_NO AND ii.INV_ITEM_STATUS = ''D'' AND ii.LAYAWAY_DATE IS NULL ' +
    '  AND NOT EXISTS (SELECT 1 FROM SALE_LINES l JOIN SALES s ON s.SALE_NO = l.SALE_NO ' +
    '                  WHERE l.INV_ITEM_NO = ii.INV_ITEM_NO AND s.SALE_STATUS = ''C'')',
    [InvItemNo]) > 0;
end;

procedure TDM.ReactivateLayway(TransactionNo: integer);
var
  PricBalance, TotalPaid: Currency;
  sSQLItemsStatus: string;
  sTransactionNo: string;
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  sTransactionNo := IntToStr(TransactionNo);
  TotalPaid := GetTotalPaid;
  PricBalance := qryTransactionscTotalSalesAmount.AsCurrency - TotalPaid;

  if qryTransactionsTRAN_CLOSE_REASON.AsInteger = LayawayCloseReasonCanceledReturned then
    raise Exception.Create('Canceled layaways cannot be re-opened. Create a new layaway instead.');

  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    qryTransactions.Edit;
    qryTransactionsTRAN_STATUS.AsString := TranStatus_Active;
    qryTransactionsTRAN_CLOSE_REASON.AsInteger := 0;
    qryTransactionsPRINC_BALANCE.AsCurrency := PricBalance;
    qryTransactions.Post;

    sSQLItemsStatus := 'UPDATE INVENTORY_ITEMS SET SOLD_DATE=null ' + sLineBreak +
                       'WHERE TRANSACTION_NO = ' + sTransactionNo + ' and INV_ITEM_STATUS = ''L'' ';

    ConnFB.ExecSQL(sSQLItemsStatus);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error updating Layaway status: ' + E.Message);
    end;
  end;

end;

procedure TDM.CancelLayaway(TransactionNo: integer);
var
  sSQLItemsStatus: string;
  sTransactionNo: string;
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  sTransactionNo := IntToStr(TransactionNo);

  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    qryTransactions.Edit;
    qryTransactionsTRAN_STATUS.AsString := TranStatus_Inactive;
    qryTransactionsTRAN_CLOSE_REASON.AsInteger := LayawayCloseReasonCanceledReturned;
    qryTransactionsPRINC_BALANCE.AsCurrency := 0;
    qryTransactions.Post;

    sSQLItemsStatus := 'UPDATE INVENTORY_ITEMS SET INV_ITEM_STATUS = ''S'', LAYAWAY_DATE = null, SOLD_DATE = null, FORSALE_DATE = current_date ' + sLineBreak +
                       'WHERE TRANSACTION_NO = ' + sTransactionNo + ' and INV_ITEM_STATUS = ''L'' ';

    ConnFB.ExecSQL(sSQLItemsStatus);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error canceling Layaway: ' + E.Message);
    end;
  end;
end;

procedure TDM.LaywayClosePayoffBalance(TransactionNo: integer; AddBalancePayment: boolean);
var
  TotalPaid: Currency;
  sSQLItemsStatus: string;
  sTransactionNo: string;
  StartedFBTrans: Boolean;
begin
  StartedFBTrans := False;
  sTransactionNo := IntToStr(TransactionNo);
  if AddBalancePayment then
    TotalPaid := GetTotalPaid
  else
    TotalPaid := 0;

  try
    if not ConnFB.InTransaction then
    begin
      ConnFB.StartTransaction;
      StartedFBTrans := True;
    end;

    //////////// Payment /////////////
    if AddBalancePayment then
    begin
      qryPayments.Append;

      if TotalPaid <= qryTransactionscTotalSalesAmount.AsCurrency  then
        qryPaymentsPAY_AMOUNT.AsCurrency := qryTransactionscTotalSalesAmount.AsCurrency - TotalPaid
      else
        raise Exception.Create('Total payments are greater than Total Transaction Amount');

      qryPaymentsPAY_PRINCIPAL.AsCurrency := qryPaymentsPAY_AMOUNT.AsCurrency;
      qryPaymentsPRINC_BALANCE.AsCurrency := 0;
      qryPaymentsINTEREST_BALANCE.AsCurrency := 0;
      qryPayments.Post;
    end;
    /////////////End Payment///////////////

    qryTransactions.Edit;
    qryTransactionsTRAN_STATUS.AsString := TranStatus_Inactive;
    qryTransactionsTRAN_CLOSE_REASON.AsInteger := LayawayCloseReasonClosedReleased;
    qryTransactionsPRINC_BALANCE.AsCurrency := 0;
    qryTransactions.Post;

    sSQLItemsStatus := 'UPDATE INVENTORY_ITEMS SET SOLD_DATE=current_timestamp ' + sLineBreak +
                       'WHERE TRANSACTION_NO = ' + sTransactionNo + ' and INV_ITEM_STATUS = ''L'' and LAYAWAY_DATE is not NULL AND SOLD_DATE is null';

    ConnFB.ExecSQL(sSQLItemsStatus);

    if StartedFBTrans and ConnFB.InTransaction then
      ConnFB.Commit;
  except
    on E: Exception do
    begin
      if StartedFBTrans and ConnFB.InTransaction then
        ConnFB.Rollback;

      raise Exception.Create('Error updating Layaway status: ' + E.Message);
    end;
  end;
end;

procedure TDM.RefreshFBQry(Qry: TFDQuery);
begin
  RefreshFBQry(Qry, Unassigned, '');
end;

procedure TDM.RefreshFBQry(Qry: TFDQuery; const DSKey: Variant; const DSKeyField: string);
var
  SavePos: integer;
  HasKey: boolean;
  FoundKey: boolean;
begin
  if Qry.RecNo > 0 then
    begin
      SavePos := Qry.RecNo;
      HasKey := (Trim(DSKeyField) <> '') and not VarIsEmpty(DSKey) and
        not VarIsNull(DSKey) and (VarToStr(DSKey) <> '');
      FoundKey := False;

      Qry.DisableControls;
      try
        Qry.Close;
        Qry.Open;

        if HasKey and Assigned(Qry.FindField(DSKeyField)) then
          FoundKey := Qry.Locate(DSKeyField, DSKey, []);

        if not FoundKey then
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
  qryGetPawnStatusFromItems.Params.ParamByName('TransactionNo').Value := TransactionNo;
  qryGetPawnStatusFromItems.Open;

  if qryGetPawnStatusFromItemsItemCount.AsInteger > 0 then
    Result := qryGetPawnStatusFromItemsPawnStatusCode.AsInteger;

  qryGetPawnStatusFromItems.Close;
end;

function TDM.GetTotalPaid: Currency;
begin
  qryTotalPaid.Close;
  qryTotalPaid.Params.ParamByName('TransactionNo').Value := qryTransactionsTRANSACTION_NO.AsInteger;
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
// Derive the item's current lifecycle status from the authoritative *_DATE
// columns, NOT from INV_ITEM_STATUS. INV_ITEM_STATUS is an unreliable legacy
// char -- e.g. purchases pumped from the old ASA database carry 'P', which made
// this routine label purchase items as "Pawned". The date columns are written by
// the workflow and are the source of truth, so check them most-advanced first.
begin
  Result := '';

  if qryInvItems.FieldByName('InvItemNo').IsNull then
    Exit;

  if not qryInvItems.FieldByName('SoldDate').IsNull then
  begin
    // A sold layaway keeps its "closed" wording; anything else is simply Sold.
    if not qryInvItems.FieldByName('LayawayDate').IsNull then
      Result := 'Sold / Close'
    else
      Result := PawnItemStatus_Sold;
  end
  else if not qryInvItems.FieldByName('MeltedDate').IsNull then
    Result := PawnItemStatus_Melted
  else if not qryInvItems.FieldByName('RedeemedDate').IsNull then
    Result := PawnItemStatus_Redeemed
  else if not qryInvItems.FieldByName('ForSaleDate').IsNull then
    Result := PawnItemStatus_ForSale
  else if not qryInvItems.FieldByName('DefaultedDate').IsNull then
    Result := PawnItemStatus_Defaulted
  else if not qryInvItems.FieldByName('PurchaseDate').IsNull then
    Result := 'Purchase'
  else if not qryInvItems.FieldByName('LayawayDate').IsNull then
    Result := PawnItemStatus_Layaway
  else if not qryInvItems.FieldByName('PawnedDate').IsNull then
    Result := PawnItemStatus_Pawned;
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
  qryItemImages.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
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
  qryImage.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
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

function TDM.GetImageBytesFromDatabase(ImagesDataNo: integer): TBytes;
var
  BlobStream: TStream;
begin
  Result := nil;
  qryImage.Close;
  qryImage.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
  qryImage.Open;
  try
    if qryImage.Eof or qryImageImageData.IsNull then
      Exit;

    BlobStream := qryImage.CreateBlobStream(qryImageImageData, bmRead);
    try
      SetLength(Result, BlobStream.Size);
      if Length(Result) > 0 then
        BlobStream.ReadBuffer(Result[0], Length(Result));
    finally
      BlobStream.Free;
    end;
  finally
    qryImage.Close;
  end;
end;

function TDM.GetImageBytesFromFile(ImagesDataNo: integer): TBytes;
var
  SelectQuery: TFDQuery;
  FilePath: string;
  ImageDate: TDateTime;
begin
  Result := nil;
  SelectQuery := TFDQuery.Create(nil);
  try
    SelectQuery.Connection := ConnFB;
    SelectQuery.SQL.Text :=
      'SELECT CREATED ' +
      'FROM IMAGES_DATA ' +
      'WHERE IMAGES_DATA_NO = :ImagesDataNo';
    SelectQuery.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;
    SelectQuery.Open;

    if SelectQuery.Eof then
      Exit;

    // The path is derived from CREATED (yyyymm folder), so a NULL date has to
    // resolve the same way GetImageFromFile resolves it or the two would look
    // in different folders for the same image.
    if SelectQuery.FieldByName('CREATED').IsNull then
      ImageDate := 0
    else
      ImageDate := SelectQuery.FieldByName('CREATED').AsDateTime;

    FilePath := GetImageFilePath(ImagesDataNo, ImageDate);
    if FileExists(FilePath) then
      Result := TFile.ReadAllBytes(FilePath);
  finally
    SelectQuery.Free;
  end;
end;

procedure TDM.GetImageFromFile(ImagesDataNo: integer; ImageComponent: TImage);
var
  FilePath: string;
  SelectQuery: TFDQuery;
  ImageDate: TDateTime;
begin
  SelectQuery := TFDQuery.Create(nil);
  try
    SelectQuery.Connection := ConnFB;

    SelectQuery.SQL.Text :=
      'SELECT CREATED ' +
      'FROM IMAGES_DATA ' +
      'WHERE IMAGES_DATA_NO = :ImagesDataNo';

    SelectQuery.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    SelectQuery.Open;

    if not SelectQuery.Eof then
    begin
      // Guard against NULL Created
      if SelectQuery.FieldByName('CREATED').IsNull then
        ImageDate := 0
      else
        ImageDate := SelectQuery.FieldByName('CREATED').AsDateTime;

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
  DeleteQuery: TFDQuery;
begin
  DeleteQuery := TFDQuery.Create(nil);
  try
    DeleteQuery.Connection := ConnFB;
    DeleteQuery.SQL.Text := 'DELETE FROM IMAGES_DATA WHERE IMAGES_DATA_NO = :ImagesDataNo';

    DeleteQuery.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    DeleteQuery.ExecSQL;
  finally
    DeleteQuery.Free;
  end;
end;

procedure TDM.DeleteImageFromFile(ImagesDataNo: Integer);
var
  FilePath: string;
  SelectQuery: TFDQuery;
  ImageDate: TDateTime;
begin
  SelectQuery := TFDQuery.Create(nil);
  try
    SelectQuery.Connection := ConnFB;
    SelectQuery.SQL.Text := 'SELECT CREATED FROM IMAGES_DATA WHERE IMAGES_DATA_NO = :ImagesDataNo';

    SelectQuery.Params.ParamByName('ImagesDataNo').Value := ImagesDataNo;

    SelectQuery.Open;

    if not SelectQuery.Eof then
    begin
      // Guard against NULL Created
      if SelectQuery.FieldByName('CREATED').IsNull then
        ImageDate := 0
      else
        ImageDate := SelectQuery.FieldByName('CREATED').AsDateTime;

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
  EncFile: string;
begin
  AResult := Default(TBackupResult);

  NotifyPhase(bpStarting);
  Conn := TFDConnection.Create(nil);
  try
    try
      ConfigureFBConnectionFor(Conn);

      NotifyPhase(bpDatabase);
      AResult.WrittenFile := BackupDatabaseToFileWithConnection(Conn, ABackupPath);

      // Encrypt the plaintext .fbk at rest, sealed to the vendor public key.
      // The store never handles a key; only the vendor's offline secret key
      // can decrypt (see Tools\PawnProDecrypt). Can be disabled per-site via
      // [BACKUP] EncryptBackups=0.
      if BackupEncryptionEnabled then
      begin
        EncFile := AResult.WrittenFile + '.enc';
        EncryptFileToVendor(AResult.WrittenFile, EncFile, GetVendorPublicKey);
        SecureDeleteFile(AResult.WrittenFile);
        AResult.WrittenFile := EncFile;
        // Retain the 7 most recent encrypted backups (matches the plaintext
        // retention TFB5DBA.BackupDatabase applies to *.fbk).
        TFB5DBA.PruneOldBackups(ABackupPath, 'PawnPro_*.fbk.enc', 7);
      end;

      if ADoImageBackup then
      begin
        NotifyPhase(bpImages);
        // Waits rather than failing: a backup preempts the weekly audit, which
        // stands down within a slice or two. Only a camera capture in progress
        // can still refuse us, and that is measured in seconds.
        if not TryBeginImageMaintenance(imoBackup, ImageGateWaitMs) then
          AResult.ImageError :=
            'A picture is being taken right now. Try the image backup again in a moment.'
        else
          try
            Conn.Connected := True;
            BackupImagesToFolderWithConnection(Conn, ImagesStoragePath, AImageTargetPath,
              AResult.CopiedCount, AResult.SkippedCount, AResult.ImageError);
          finally
            EndImageMaintenance(imoBackup);
          end;
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
  ExportQuery: TFDQuery;
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

  ExportQuery := TFDQuery.Create(nil);
  try
    ExportQuery.Connection := ConnFB;
    ExportQuery.SQL.Text := 'SELECT IMAGES_DATA_NO, IMAGE_DATA, CREATED FROM IMAGES_DATA ORDER BY IMAGES_DATA_NO';
    ExportQuery.Open;
    
    // Get total count for progress display
    TotalImages := ExportQuery.RecordCount;
    if ProgressLabel <> nil then
      ProgressLabel.Caption := 'Starting export of ' + IntToStr(TotalImages) + ' images...';

    ImagesDataNo := 0;
    while not ExportQuery.Eof do
    begin
      try
        ImagesDataNo := ExportQuery.FieldByName('IMAGES_DATA_NO').AsInteger;
        ImageDate := ExportQuery.FieldByName('CREATED').AsDateTime;
        
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
        ImageStream := ExportQuery.CreateBlobStream(ExportQuery.FieldByName('IMAGE_DATA'), bmRead);
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
