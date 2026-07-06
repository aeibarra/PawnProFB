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
    qryCalcUnitCostFromWeight: TFDQuery;
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
    function GetFBPasswordFromIni(const PasswordEnc, LegacyPassword: string;
      AllowPrompt: Boolean): string;
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
    procedure StartImageBackupAuditIfDue;
    procedure ExportAllImagesToFolder(var ExportCount: integer; var ErrorMessage: string; ProgressLabel: TLabel = nil);
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
    procedure RefreshLookupMemTables;
    function GetWeightUnitAbbr(WeightUnit: string): string;
    procedure FillPawnStatusCombobox(cb: TRzComboBox; StatusToSelect: String);
    procedure SetPawnAndItemsStatus(TransactionNo: integer; CloseReason: smallint; TranStatus: string; PawnDefaultedItemAction: integer);
    procedure PutPawnBackToActive(TransactionNo: integer);
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

Uses PawnGlobal, uPawnProIniPrinters, uPawnIniDefaults, DPAPIUtils, SearchClient, Nvv.FB5.DBA,
  SealedBox, Nvv.Crypto.FileEnvelope, IdHashSHA;

{$R *.DFM}

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

function SHA256OfStream(AStream: TStream): string;
var
  Hasher: TIdHashSHA256;
begin
  Hasher := TIdHashSHA256.Create;
  try
    AStream.Position := 0;
    Result := Hasher.HashStreamAsHex(AStream);
  finally
    Hasher.Free;
  end;
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

function TDM.GetFBPasswordFromIni(const PasswordEnc, LegacyPassword: string;
  AllowPrompt: Boolean): string;
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
    Server      := IniFile.ReadString (IniSecConnFB, IniKeyConnFBHost,     'localhost');
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

  FDPhysFBDriverLink1.VendorLib := ExtractFilePath(ParamStr(0)) + 'fbclient.dll';

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

procedure TDM.UpdatePawnItemStatus(InvItemNo: integer; const RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate: variant);
begin
  ConnFB.ExecSQL(
    'UPDATE INVENTORY_ITEMS ' +
    'SET REDEEMED_DATE = :REDEEMED_DATE, ' +
    '    DEFAULTED_DATE = :DEFAULTED_DATE, ' +
    '    MELTED_DATE = :MELTED_DATE, ' +
    '    FORSALE_DATE = :FORSALE_DATE ' +
    'WHERE INV_ITEM_NO = :INV_ITEM_NO',
    [RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate, InvItemNo]);
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

  ConnFB.ExecSQL(
    'UPDATE INVENTORY_ITEMS ' +
    'SET REDEEMED_DATE = :REDEEMED_DATE, ' +
    '    DEFAULTED_DATE = :DEFAULTED_DATE, ' +
    '    MELTED_DATE = :MELTED_DATE, ' +
    '    FORSALE_DATE = :FORSALE_DATE ' +
    'WHERE TRANSACTION_NO = :TRANSACTION_NO ' +
    '  AND INV_ITEM_STATUS = ''P'' ' +
    '  AND REDEEMED_DATE IS NULL ' +
    '  AND DEFAULTED_DATE IS NULL',
    [RedeemedDate, DefaultedDate, MeltedDate, ForSaleDate, TransactionNo]);
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
  sSQLItemsStatus := 'UPDATE INVENTORY_ITEMS SET REDEEMED_DATE = null, DEFAULTED_DATE = null, MELTED_DATE = null, FORSALE_DATE = null ' + sLineBreak +
                     'WHERE TRANSACTION_NO = ' + sTransactionNo + ' and INV_ITEM_STATUS = ''P'' and SOLD_DATE is null';

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

procedure TDM.StartImageBackupAuditIfDue;
const
  AuditDelayMs = 15000;
  AuditThrottleMs = 100;
var
  AuditWeekStr, CurrentAuditWeek: string;
  BackupImagesPath, SourceRoot, TargetRoot: string;
  DayNo, WeekYear, WeekNo: Word;
  SettingsQuery: TFDQuery;
  AuditThread: TThread;

  function ReadBackupImagesPath: string;
  begin
    Result := '';
    SettingsQuery := TFDQuery.Create(nil);
    try
      SettingsQuery.Connection := ConnFB;
      SettingsQuery.SQL.Text := 'SELECT BACKUP_IMAGES_PATH FROM BACKUP_SETTINGS';
      SettingsQuery.Open;
      if not SettingsQuery.Eof then
        Result := Trim(SettingsQuery.FieldByName('BACKUP_IMAGES_PATH').AsString);
    finally
      SettingsQuery.Free;
    end;
  end;

begin
  if ImageStorageMode <> ImageStorageMode_File then
    Exit;

  if (Trim(ImagesStoragePath) = '') or not DirectoryExists(ImagesStoragePath) then
    Exit;

  DayNo := DayOfWeek(Date);
  if (DayNo <> 3) and (DayNo <> 4) then
    Exit;

  WeekNo := WeekOfTheYear(Date, WeekYear);
  CurrentAuditWeek := Format('%.4d-%.2d', [WeekYear, WeekNo]);
  AuditWeekStr := ReadIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditWeek);
  if SameText(Trim(AuditWeekStr), CurrentAuditWeek) then
    Exit;

  BackupImagesPath := ReadBackupImagesPath;
  if (BackupImagesPath = '') or not DirectoryExists(BackupImagesPath) then
    Exit;

  SourceRoot := IncludeTrailingPathDelimiter(ImagesStoragePath);
  TargetRoot := IncludeTrailingPathDelimiter(BackupImagesPath);

  AuditThread := TThread.CreateAnonymousThread(
    procedure
    var
      Conn: TFDConnection;
      ImageQuery, MarkQuery: TFDQuery;
      ImagesDataNo: integer;
      ImageDate: TDateTime;
      SourcePath, BackupPath: string;
      SourceStream, BackupStream: TFileStream;
      SourceBytes, BackupBytes: Int64;
      SourceHash, BackupHash: string;

      function BuildImagePathForRoot(const RootPath: string; AImagesDataNo: integer; AImageDate: TDateTime): string;
      begin
        Result := IncludeTrailingPathDelimiter(RootPath) +
                  FormatDateTime('yyyymm', AImageDate) + PathDelim +
                  IntToStr(AImagesDataNo) + '.jpg';
      end;

      procedure MarkForBackup;
      begin
        try
          MarkQuery.Params.ParamByName('IMAGES_DATA_NO').AsInteger := ImagesDataNo;
          MarkQuery.ExecSQL;
        except
          { Background audit is best-effort. Normal backup still handles new images. }
        end;
      end;

      function FileSizeOf(const FileName: string): Int64;
      var
        FS: TFileStream;
      begin
        FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
        try
          Result := FS.Size;
        finally
          FS.Free;
        end;
      end;

    begin
      Sleep(AuditDelayMs);
      Conn := nil;
      ImageQuery := nil;
      MarkQuery := nil;
      try
        Conn := TFDConnection.Create(nil);
        ConfigureFBConnectionFor(Conn);
        Conn.Connected := True;

        ImageQuery := TFDQuery.Create(nil);
        MarkQuery := TFDQuery.Create(nil);
        ImageQuery.Connection := Conn;
        MarkQuery.Connection := Conn;

        ImageQuery.SQL.Text :=
          'SELECT IMAGES_DATA_NO, CREATED ' +
          'FROM IMAGES_DATA ' +
          'WHERE CREATED IS NOT NULL ' +
          'ORDER BY IMAGES_DATA_NO';

        MarkQuery.SQL.Text :=
          'DELETE FROM IMAGES_DATA_BACKUP WHERE IMAGES_DATA_NO = :IMAGES_DATA_NO';

        ImageQuery.Open;
        while not ImageQuery.Eof do
        begin
          ImagesDataNo := ImageQuery.FieldByName('IMAGES_DATA_NO').AsInteger;
          ImageDate := ImageQuery.FieldByName('CREATED').AsDateTime;
          SourcePath := BuildImagePathForRoot(SourceRoot, ImagesDataNo, ImageDate);
          BackupPath := BuildImagePathForRoot(TargetRoot, ImagesDataNo, ImageDate);

          try
            if FileExists(SourcePath) then
            begin
              if not FileExists(BackupPath) then
                MarkForBackup
              else
              begin
                SourceBytes := FileSizeOf(SourcePath);
                BackupBytes := FileSizeOf(BackupPath);

                if SourceBytes <> BackupBytes then
                  MarkForBackup
                else
                begin
                  SourceStream := TFileStream.Create(SourcePath, fmOpenRead or fmShareDenyNone);
                  try
                    BackupStream := TFileStream.Create(BackupPath, fmOpenRead or fmShareDenyNone);
                    try
                      SourceHash := SHA256OfStream(SourceStream);
                      BackupHash := SHA256OfStream(BackupStream);
                    finally
                      BackupStream.Free;
                    end;
                  finally
                    SourceStream.Free;
                  end;

                  if not SameText(SourceHash, BackupHash) then
                    MarkForBackup;
                end;
              end;
            end;
          except
            MarkForBackup;
          end;

          Sleep(AuditThrottleMs);
          ImageQuery.Next;
        end;

        WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditDate, FormatDateTime('yyyy-mm-dd', Date));
        WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastAuditWeek, CurrentAuditWeek);
      finally
        MarkQuery.Free;
        ImageQuery.Free;
        Conn.Free;
      end;
    end);
  AuditThread.FreeOnTerminate := True;
  AuditThread.Priority := tpLowest;
  AuditThread.Start;
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
