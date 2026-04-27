unit PumpAsaFb50Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  System.UITypes, FireDAC.Stan.Param,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, FireDAC.DApt;

type
  TfrmPumpAsaFb50Main = class(TForm)
    btnClose: TButton;
    btnGo: TButton;
    lblCurrentProcess: TLabel;
    MemoErrors: TMemo;
    pnConnections: TPanel;
    edAsaServerIP: TEdit;
    edAsaDBName: TEdit;
    lblAsaServer: TLabel;
    lblAsaDBName: TLabel;
    lblAsaUser: TLabel;
    edAsaUser: TEdit;
    edAsaPassword: TEdit;
    Label2: TLabel;
    edFBServer: TEdit;
    edFBDBName: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edFBUser: TEdit;
    edFBPassword: TEdit;
    Label5: TLabel;
    ConnectionFB: TFDConnection;
    edFBPort: TEdit;
    Label6: TLabel;
    edFBCharSet: TEdit;
    Label7: TLabel;
    ConnDB: TADOConnection;
    btnTestAsa: TButton;
    btnTestFb: TButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormCreate(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnTestAsaClick(Sender: TObject);
    procedure btnTestFbClick(Sender: TObject);
  private
    FNotNullCols: TStringList;  // lazy-init; holds "TABLE.COLUMN" for every FB NOT NULL column
    procedure ConfigureFBDatabaseConnection;
    procedure GetADOConnectionStr;
    procedure LogLine(const S: string);
    procedure LoadFbNotNullMetadata;
    procedure ApplyNullCoercion(AQuery: TFDQuery; const ATable: string);
    procedure WipeFirebirdDatabase;
    procedure PumpTwoColLookup(const SrcTable, SrcCol1, SrcCol2,
                               DstTable, DstCol1, DstCol2: string);
    procedure PumpTable(const ALabel, DstTable, SrcSQL, DstSQL: string;
                        const MapRow: TProc<TADOQuery, TFDQuery>);
    procedure PumpStates;
    procedure PumpJTypes;
    procedure PumpJMetals;
    procedure PumpJStyles;
    procedure PumpJGenders;
    procedure PumpJStoneShapes;
    procedure PumpJStoneColors;
    procedure PumpItemStatus;
    procedure PumpTransactionTypes;
    procedure PumpStore;
    procedure PumpStations;
    procedure PumpSEQTable;
    procedure PumpBackupSettings;
    procedure PumpExportFormat;
    procedure PumpPaymentTypes;
    procedure PumpImagesTypes;
    procedure PumpInvCategories;
    procedure PumpTableKeys;
    procedure PumpCustomer;
    procedure PumpTransactions;
    procedure PumpInventoryItems;
    procedure PumpStones;
    procedure PumpSalesItems;
    procedure PumpPayments;
    procedure PumpImagesData;
    procedure PumpImagesDataBackup;
    procedure PumpInventoryItemStatusLog;
    procedure PumpBackupHistory;
    procedure PumpExportFileLog;
    procedure PumpExportLogFileDetail;
    procedure PumpGoldPriceHistory;
    procedure PostPumpReseed;
  public
    { Public declarations }
  end;

var
  frmPumpAsaFb50Main: TfrmPumpAsaFb50Main;

implementation

{$R *.dfm}

procedure TfrmPumpAsaFb50Main.GetADOConnectionStr;
var
  PWD, UID, DBN, ENG, HOST, CnnStr: string;
begin
  PWD  := Trim(edAsaPassword.Text);
  UID  := Trim(edAsaUser.Text);
  DBN  := Trim(edAsaDBName.Text);
  ENG  := Trim(edAsaDBName.Text);      // ASA engine name; defaults to DB name unless user sets otherwise
  HOST := Trim(edAsaServerIP.Text);

  CnnStr := Format('Provider=SAOLEDB.12;Password=%s;Persist Security Info=True;User ID=%s;Initial Catalog=%s;Extended Properties="CommLinks=SharedMemory,TCPIP{HOST=%s};ServerName=%s"',
                    [PWD, UID, DBN, HOST, ENG]);

  ConnDB.Connected := False;
  ConnDB.ConnectionString := CnnStr;
end;

procedure TfrmPumpAsaFb50Main.ConfigureFBDatabaseConnection;
var
  Server, DatabasePath, User, Password, CharacterSet: string;
  Port: Integer;
begin
  Server       := Trim(edFBServer.Text);
  DatabasePath := Trim(edFBDBName.Text);
  User         := Trim(edFBUser.Text);
  Password     := Trim(edFBPassword.Text);
  Port         := StrToIntDef(Trim(edFBPort.Text), 3050);
  CharacterSet := Trim(edFBCharSet.Text);

  ConnectionFB.Connected := False;
  ConnectionFB.Params.Clear;
  ConnectionFB.DriverName := 'FB';
  ConnectionFB.Params.Values['Server']       := Server;
  ConnectionFB.Params.Values['Database']     := DatabasePath;
  ConnectionFB.Params.Values['User_Name']    := User;
  ConnectionFB.Params.Values['Password']     := Password;
  ConnectionFB.Params.Values['Protocol']     := 'TCPIP';
  ConnectionFB.Params.Values['Port']         := IntToStr(Port);
  ConnectionFB.Params.Values['CharacterSet'] := CharacterSet;
  ConnectionFB.LoginPrompt := False;
end;

procedure TfrmPumpAsaFb50Main.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPumpAsaFb50Main.btnGoClick(Sender: TObject);
var
  fbPath: string;
begin
  MemoErrors.Lines.Clear;

  GetADOConnectionStr;
  ConfigureFBDatabaseConnection;

  fbPath := ConnectionFB.Params.Values['Database'];
  if MessageDlg(
       Format('This will ERASE all data in the Firebird database at:' + sLineBreak +
              '  %s' + sLineBreak + sLineBreak + 'Continue?', [fbPath]),
       mtWarning, [mbYes, mbNo], 0) <> mrYes then
  begin
    LogLine('Pump cancelled by user.');
    Exit;
  end;

  try
    ConnDB.Connected := True;
    try
      ConnectionFB.Connected := True;
      try
        LoadFbNotNullMetadata;
        WipeFirebirdDatabase;
        PumpStates;
        PumpJTypes;
        PumpJMetals;
        PumpJStyles;
        PumpJGenders;
        PumpJStoneShapes;
        PumpJStoneColors;
        PumpItemStatus;
        PumpTransactionTypes;
        PumpStore;
        PumpStations;
        PumpSEQTable;
        PumpBackupSettings;
        PumpExportFormat;
        PumpPaymentTypes;
        PumpImagesTypes;
        PumpInvCategories;
        PumpTableKeys;
        PumpCustomer;
        PumpTransactions;
        PumpInventoryItems;
        PumpStones;
        PumpSalesItems;
        PumpPayments;
        PumpImagesData;
        PumpImagesDataBackup;
        PumpInventoryItemStatusLog;
        PumpBackupHistory;
        PumpExportFileLog;
        PumpExportLogFileDetail;
        PumpGoldPriceHistory;
        PostPumpReseed;
        lblCurrentProcess.Caption := '';
        LogLine('Pump complete.');
      finally
        ConnectionFB.Connected := False;
      end;
    finally
      ConnDB.Connected := False;
    end;
  except
    on E: Exception do
    begin
      lblCurrentProcess.Caption := '';
      LogLine(Format('  PUMP FAILED: [%s] %s', [E.ClassName, E.Message]));
    end;
  end;
end;

procedure TfrmPumpAsaFb50Main.WipeFirebirdDatabase;
const
  // Reverse-FK delete order — children before parents. See PUMP_APP_PLAN.md §5a.
  WIPE_ORDER: array[0..30] of string = (
    'PAYMENTS', 'STONES', 'SALES_ITEMS', 'INVENTORY_ITEM_STATUS_LOG',
    'IMAGES_DATA_BACKUP', 'IMAGES_DATA', 'INVENTORY_ITEMS', 'TRANSACTIONS',
    'CUSTOMER', 'EXPORT_LOG_FILE_DETAIL', 'EXPORT_FILE_LOG',
    'GOLD_PRICE_HISTORY', 'BACKUP_HISTORY', 'TABLE_KEYS',
    'INV_CATEGORIES', 'IMAGES_TYPES', 'PAYMENT_TYPES', 'TRANSACTION_TYPES',
    'ITEM_STATUS', 'J_STONE_COLORS', 'J_STONE_SHAPES', 'J_GENDERS',
    'J_STYLES', 'J_METALS', 'J_TYPES', 'EXPORT_FORMAT',
    'BACKUP_SETTINGS', 'SEQ_TABLE', 'STATIONS', 'STORE', 'STATES'
  );
var
  i, TotalDeleted: Integer;
begin
  lblCurrentProcess.Caption := 'Wiping Firebird DB...';
  LogLine('Wiping Firebird database (all 31 tables, one transaction)...');
  TotalDeleted := 0;

  ConnectionFB.StartTransaction;
  try
    for i := Low(WIPE_ORDER) to High(WIPE_ORDER) do
      Inc(TotalDeleted, ConnectionFB.ExecSQL('DELETE FROM ' + WIPE_ORDER[i]));
    ConnectionFB.Commit;
  except
    ConnectionFB.Rollback;
    raise;
  end;

  LogLine(Format('  OK. Wiped %d rows across %d tables.',
                 [TotalDeleted, Length(WIPE_ORDER)]));
end;

procedure TfrmPumpAsaFb50Main.PumpTwoColLookup(
  const SrcTable, SrcCol1, SrcCol2, DstTable, DstCol1, DstCol2: string);
var
  src: TADOQuery;
  dst: TFDQuery;
  n: Integer;
begin
  lblCurrentProcess.Caption := Format('Pumping %s...', [DstTable]);
  LogLine(Format('Pumping %s -> %s...', [SrcTable, DstTable]));
  n := 0;

  src := TADOQuery.Create(nil);
  dst := TFDQuery.Create(nil);
  try
    src.Connection := ConnDB;
    src.SQL.Text := Format('SELECT %s, %s FROM %s', [SrcCol1, SrcCol2, SrcTable]);
    src.Open;

    dst.Connection := ConnectionFB;
    // Use target column names as param names so ApplyNullCoercion can map
    // each param back to its FB NOT NULL metadata entry.
    dst.SQL.Text := Format('INSERT INTO %s (%s, %s) VALUES (:%s, :%s)',
                           [DstTable, DstCol1, DstCol2, DstCol1, DstCol2]);
    dst.Prepare;

    ConnectionFB.StartTransaction;
    try
      while not src.Eof do
      begin
        dst.ParamByName(DstCol1).Value := src.FieldByName(SrcCol1).Value;
        dst.ParamByName(DstCol2).Value := src.FieldByName(SrcCol2).Value;
        ApplyNullCoercion(dst, DstTable);
        dst.ExecSQL;
        Inc(n);
        src.Next;
      end;
      ConnectionFB.Commit;
    except
      ConnectionFB.Rollback;
      raise;
    end;

    LogLine(Format('  OK. %d rows pumped.', [n]));
  finally
    dst.Free;
    src.Free;
  end;
end;

procedure TfrmPumpAsaFb50Main.PumpJTypes;
begin
  PumpTwoColLookup('JTypes',  'JType',  'JTypeDesc',
                   'J_TYPES', 'J_TYPE', 'J_TYPE_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpJMetals;
begin
  PumpTwoColLookup('JMetals',  'JMetal',  'JMetalDesc',
                   'J_METALS', 'J_METAL', 'J_METAL_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpJStyles;
begin
  PumpTwoColLookup('JStyles',  'JStyle',  'JStyleDesc',
                   'J_STYLES', 'J_STYLE', 'J_STYLE_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpJGenders;
begin
  PumpTwoColLookup('JGenders',  'JGender',  'JGenderDesc',
                   'J_GENDERS', 'J_GENDER', 'J_GENDER_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpJStoneShapes;
begin
  PumpTwoColLookup('JStoneShapes',   'JShape',  'JShapeDesc',
                   'J_STONE_SHAPES', 'J_SHAPE', 'J_SHAPE_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpJStoneColors;
begin
  // NOTE: src description column is JStoneDesc (not JStoneColorDesc) in both schemas.
  PumpTwoColLookup('JStoneColors',   'JStoneColor',   'JStoneDesc',
                   'J_STONE_COLORS', 'J_STONE_COLOR', 'J_STONE_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpItemStatus;
begin
  PumpTwoColLookup('ItemStatus',  'Status', 'StatusDesc',
                   'ITEM_STATUS', 'STATUS', 'STATUS_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpTransactionTypes;
begin
  PumpTwoColLookup('TransactionTypes',  'TranType',  'TranTypeDesc',
                   'TRANSACTION_TYPES', 'TRAN_TYPE', 'TRAN_TYPE_DESC');
end;

procedure TfrmPumpAsaFb50Main.PumpTable(const ALabel, DstTable, SrcSQL, DstSQL: string;
                                        const MapRow: TProc<TADOQuery, TFDQuery>);
var
  src: TADOQuery;
  dst: TFDQuery;
  n: Integer;
begin
  lblCurrentProcess.Caption := Format('Pumping %s...', [ALabel]);
  LogLine(Format('Pumping %s...', [ALabel]));
  n := 0;

  src := TADOQuery.Create(nil);
  dst := TFDQuery.Create(nil);
  try
    src.Connection := ConnDB;
    src.SQL.Text := SrcSQL;
    src.Open;

    dst.Connection := ConnectionFB;
    dst.SQL.Text := DstSQL;
    dst.Prepare;

    ConnectionFB.StartTransaction;
    try
      while not src.Eof do
      begin
        MapRow(src, dst);
        ApplyNullCoercion(dst, DstTable);
        dst.ExecSQL;
        Inc(n);
        src.Next;
      end;
      ConnectionFB.Commit;
    except
      ConnectionFB.Rollback;
      raise;
    end;

    LogLine(Format('  OK. %d rows pumped.', [n]));
  finally
    dst.Free;
    src.Free;
  end;
end;

procedure TfrmPumpAsaFb50Main.PumpStore;
begin
  PumpTable('Store -> STORE', 'STORE',
    'SELECT StoreNo, StoreName, StoreAddr, StoreCityStZIP, StorePhone, ' +
    '  StorePoliceID, StoreAdjTopMarg, StoreNumber, StoreAdjDetailHeight, ' +
    '  StoreAdjFooterHeight, InterestCalcMethod, PoliceReportToPrint, ' +
    '  PoliceReportLaserCopies, DefaultMaturityMonths, PawnDefaultMonths, ' +
    '  LeadsStoreId, LeadsOnlineFTPAddress, LeadsOnlineUserName, ' +
    '  LeadsOnlinePassword, FTPpassive, PawnDateCalculationBase, ' +
    '  DefaultWeightMeasureUnit, SalesTaxPerc, DefaultPawnInterestRate ' +
    'FROM Store',
    'INSERT INTO STORE (STORE_NO, STORE_NAME, STORE_ADDR, STORE_CITY_ST_ZIP, ' +
    '  STORE_PHONE, STORE_POLICE_ID, STORE_ADJ_TOP_MARG, STORE_NUMBER, ' +
    '  STORE_ADJ_DETAIL_HEIGHT, STORE_ADJ_FOOTER_HEIGHT, INTEREST_CALC_METHOD, ' +
    '  POLICE_REPORT_TO_PRINT, POLICE_REPORT_LASER_COPIES, ' +
    '  DEFAULT_MATURITY_MONTHS, PAWN_DEFAULT_MONTHS, LEADS_STORE_ID, ' +
    '  LEADS_ONLINE_FTP_ADDRESS, LEADS_ONLINE_USER_NAME, LEADS_ONLINE_PASSWORD, ' +
    '  FTP_PASSIVE, PAWN_DATE_CALCULATION_BASE, DEFAULT_WEIGHT_MEASURE_UNIT, ' +
    '  SALES_TAX_PERC, DEFAULT_PAWN_INTERESTRATE) ' +
    'VALUES (:STORE_NO, :STORE_NAME, :STORE_ADDR, :STORE_CITY_ST_ZIP, ' +
    '  :STORE_PHONE, :STORE_POLICE_ID, :STORE_ADJ_TOP_MARG, :STORE_NUMBER, ' +
    '  :STORE_ADJ_DETAIL_HEIGHT, :STORE_ADJ_FOOTER_HEIGHT, :INTEREST_CALC_METHOD, ' +
    '  :POLICE_REPORT_TO_PRINT, :POLICE_REPORT_LASER_COPIES, ' +
    '  :DEFAULT_MATURITY_MONTHS, :PAWN_DEFAULT_MONTHS, :LEADS_STORE_ID, ' +
    '  :LEADS_ONLINE_FTP_ADDRESS, :LEADS_ONLINE_USER_NAME, :LEADS_ONLINE_PASSWORD, ' +
    '  :FTP_PASSIVE, :PAWN_DATE_CALCULATION_BASE, :DEFAULT_WEIGHT_MEASURE_UNIT, ' +
    '  :SALES_TAX_PERC, :DEFAULT_PAWN_INTERESTRATE)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('STORE_NO').Value                   := src.FieldByName('StoreNo').Value;
      dst.ParamByName('STORE_NAME').Value                 := src.FieldByName('StoreName').Value;
      dst.ParamByName('STORE_ADDR').Value                 := src.FieldByName('StoreAddr').Value;
      dst.ParamByName('STORE_CITY_ST_ZIP').Value          := src.FieldByName('StoreCityStZIP').Value;
      dst.ParamByName('STORE_PHONE').Value                := src.FieldByName('StorePhone').Value;
      dst.ParamByName('STORE_POLICE_ID').Value            := src.FieldByName('StorePoliceID').Value;
      dst.ParamByName('STORE_ADJ_TOP_MARG').Value         := src.FieldByName('StoreAdjTopMarg').Value;
      dst.ParamByName('STORE_NUMBER').Value               := src.FieldByName('StoreNumber').Value;
      dst.ParamByName('STORE_ADJ_DETAIL_HEIGHT').Value    := src.FieldByName('StoreAdjDetailHeight').Value;
      dst.ParamByName('STORE_ADJ_FOOTER_HEIGHT').Value    := src.FieldByName('StoreAdjFooterHeight').Value;
      dst.ParamByName('INTEREST_CALC_METHOD').Value       := src.FieldByName('InterestCalcMethod').Value;
      dst.ParamByName('POLICE_REPORT_TO_PRINT').Value     := src.FieldByName('PoliceReportToPrint').Value;
      dst.ParamByName('POLICE_REPORT_LASER_COPIES').Value := src.FieldByName('PoliceReportLaserCopies').Value;
      dst.ParamByName('DEFAULT_MATURITY_MONTHS').Value    := src.FieldByName('DefaultMaturityMonths').Value;
      dst.ParamByName('PAWN_DEFAULT_MONTHS').Value        := src.FieldByName('PawnDefaultMonths').Value;
      dst.ParamByName('LEADS_STORE_ID').Value             := src.FieldByName('LeadsStoreId').Value;
      dst.ParamByName('LEADS_ONLINE_FTP_ADDRESS').Value   := src.FieldByName('LeadsOnlineFTPAddress').Value;
      dst.ParamByName('LEADS_ONLINE_USER_NAME').Value     := src.FieldByName('LeadsOnlineUserName').Value;
      dst.ParamByName('LEADS_ONLINE_PASSWORD').Value      := src.FieldByName('LeadsOnlinePassword').Value;
      // FB FTP_PASSIVE is BOOLEAN; ASA FTPpassive is bit -> ADO returns True/False via .Value.
      dst.ParamByName('FTP_PASSIVE').Value                := src.FieldByName('FTPpassive').Value;
      dst.ParamByName('PAWN_DATE_CALCULATION_BASE').Value := src.FieldByName('PawnDateCalculationBase').Value;
      dst.ParamByName('DEFAULT_WEIGHT_MEASURE_UNIT').Value:= src.FieldByName('DefaultWeightMeasureUnit').Value;
      dst.ParamByName('SALES_TAX_PERC').Value             := src.FieldByName('SalesTaxPerc').Value;
      dst.ParamByName('DEFAULT_PAWN_INTERESTRATE').Value  := src.FieldByName('DefaultPawnInterestRate').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpStations;
begin
  PumpTable('Stations -> STATIONS', 'STATIONS',
    'SELECT StationNo, StationGUID, StationName, StationConnected, ' +
    '  Created, ConnStart, ConnThru ' +
    'FROM Stations',
    'INSERT INTO STATIONS (STATION_NO, STATION_GUID, STATION_NAME, ' +
    '  STATION_CONNECTED, CREATED, CONN_START, CONN_THRU) ' +
    'VALUES (:STATION_NO, :STATION_GUID, :STATION_NAME, ' +
    '  :STATION_CONNECTED, :CREATED, :CONN_START, :CONN_THRU)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('STATION_NO').Value        := src.FieldByName('StationNo').Value;
      dst.ParamByName('STATION_GUID').Value      := src.FieldByName('StationGUID').Value;
      dst.ParamByName('STATION_NAME').Value      := src.FieldByName('StationName').Value;
      dst.ParamByName('STATION_CONNECTED').Value := src.FieldByName('StationConnected').Value;
      dst.ParamByName('CREATED').Value           := src.FieldByName('Created').Value;
      dst.ParamByName('CONN_START').Value        := src.FieldByName('ConnStart').Value;
      dst.ParamByName('CONN_THRU').Value         := src.FieldByName('ConnThru').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpSEQTable;
begin
  PumpTable('SEQTable -> SEQ_TABLE', 'SEQ_TABLE',
    'SELECT StationSEQ FROM SEQTable',
    'INSERT INTO SEQ_TABLE (STATION_SEQ) VALUES (:STATION_SEQ)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('STATION_SEQ').Value := src.FieldByName('StationSEQ').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpBackupSettings;
begin
  PumpTable('BackupSettings -> BACKUP_SETTINGS', 'BACKUP_SETTINGS',
    'SELECT BackupPath, AutoBackupWhenCloseApp, BackupImagesPath FROM BackupSettings',
    'INSERT INTO BACKUP_SETTINGS (BACKUP_PATH, AUTO_BACKUP_WHEN_CLOSE_APP, ' +
    '  BACKUP_IMAGES_PATH) ' +
    'VALUES (:BACKUP_PATH, :AUTO_BACKUP_WHEN_CLOSE_APP, :BACKUP_IMAGES_PATH)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('BACKUP_PATH').Value                := src.FieldByName('BackupPath').Value;
      // FB AUTO_BACKUP_WHEN_CLOSE_APP is BOOLEAN; ASA is bit.
      dst.ParamByName('AUTO_BACKUP_WHEN_CLOSE_APP').Value := src.FieldByName('AutoBackupWhenCloseApp').Value;
      dst.ParamByName('BACKUP_IMAGES_PATH').Value         := src.FieldByName('BackupImagesPath').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpExportFormat;
begin
  PumpTable('ExportFormat -> EXPORT_FORMAT', 'EXPORT_FORMAT',
    'SELECT ID, DataFieldName, DataFieldType, DataFieldMaxSize, ' +
    '  DataFieldCaption, DataFieldDesc ' +
    'FROM ExportFormat',
    'INSERT INTO EXPORT_FORMAT (ID, DATA_FIELD_NAME, DATA_FIELD_TYPE, ' +
    '  DATA_FIELD_MAX_SIZE, DATA_FIELD_CAPTION, DATA_FIELD_DESC) ' +
    'VALUES (:ID, :DATA_FIELD_NAME, :DATA_FIELD_TYPE, ' +
    '  :DATA_FIELD_MAX_SIZE, :DATA_FIELD_CAPTION, :DATA_FIELD_DESC)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('ID').Value                  := src.FieldByName('ID').Value;
      dst.ParamByName('DATA_FIELD_NAME').Value     := src.FieldByName('DataFieldName').Value;
      dst.ParamByName('DATA_FIELD_TYPE').Value     := src.FieldByName('DataFieldType').Value;
      dst.ParamByName('DATA_FIELD_MAX_SIZE').Value := src.FieldByName('DataFieldMaxSize').Value;
      dst.ParamByName('DATA_FIELD_CAPTION').Value  := src.FieldByName('DataFieldCaption').Value;
      dst.ParamByName('DATA_FIELD_DESC').Value     := src.FieldByName('DataFieldDesc').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpPaymentTypes;
begin
  PumpTable('PaymentTypes -> PAYMENT_TYPES', 'PAYMENT_TYPES',
    'SELECT PayTypeNo, PaymentType, PaymentMask, IsCreditCard FROM PaymentTypes',
    'INSERT INTO PAYMENT_TYPES (PAY_TYPE_NO, PAYMENT_TYPE, PAYMENT_MASK, ' +
    '  IS_CREDIT_CARD) ' +
    'VALUES (:PAY_TYPE_NO, :PAYMENT_TYPE, :PAYMENT_MASK, :IS_CREDIT_CARD)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('PAY_TYPE_NO').Value    := src.FieldByName('PayTypeNo').Value;
      dst.ParamByName('PAYMENT_TYPE').Value   := src.FieldByName('PaymentType').Value;
      dst.ParamByName('PAYMENT_MASK').Value   := src.FieldByName('PaymentMask').Value;
      dst.ParamByName('IS_CREDIT_CARD').Value := src.FieldByName('IsCreditCard').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpImagesTypes;
begin
  PumpTable('ImagesTypes -> IMAGES_TYPES', 'IMAGES_TYPES',
    'SELECT ImageTypeNo, ImageType, ImageTypeDesc FROM ImagesTypes',
    'INSERT INTO IMAGES_TYPES (IMAGE_TYPE_NO, IMAGE_TYPE, IMAGE_TYPE_DESC) ' +
    'VALUES (:IMAGE_TYPE_NO, :IMAGE_TYPE, :IMAGE_TYPE_DESC)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('IMAGE_TYPE_NO').Value   := src.FieldByName('ImageTypeNo').Value;
      dst.ParamByName('IMAGE_TYPE').Value      := src.FieldByName('ImageType').Value;
      dst.ParamByName('IMAGE_TYPE_DESC').Value := src.FieldByName('ImageTypeDesc').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpInvCategories;
begin
  PumpTable('InvCategories -> INV_CATEGORIES', 'INV_CATEGORIES',
    'SELECT InvCatNo, InvCategory FROM InvCategories',
    'INSERT INTO INV_CATEGORIES (INV_CAT_NO, INV_CATEGORY) ' +
    'VALUES (:INV_CAT_NO, :INV_CATEGORY)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('INV_CAT_NO').Value   := src.FieldByName('InvCatNo').Value;
      dst.ParamByName('INV_CATEGORY').Value := src.FieldByName('InvCategory').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpTableKeys;
begin
  PumpTable('TableKeys -> TABLE_KEYS', 'TABLE_KEYS',
    'SELECT TableName, LastKey FROM TableKeys',
    'INSERT INTO TABLE_KEYS (TABLE_NAME, LAST_KEY) VALUES (:TABLE_NAME, :LAST_KEY)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('TABLE_NAME').Value := src.FieldByName('TableName').Value;
      dst.ParamByName('LAST_KEY').Value   := src.FieldByName('LastKey').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpCustomer;
begin
  // Deprecated in FB (see PUMP_APP_PLAN.md §9.4): CustTicketNo, StationID, StationSEQ.
  // ASA typo CustPhBussiness -> FB CUST_PH_BUSINESS (single 's').
  // CustComment: ASA long varchar -> FB BLOB SUB_TYPE 1 (text). .Value passes through.
  PumpTable('Customer -> CUSTOMER', 'CUSTOMER',
    'SELECT Custno, CustFirst, CustMid, CustLast, CustDOB, CustGender, ' +
    '  CustRace, CustHair, CustEyes, CustMark, CustWeight, CustHeight, ' +
    '  CustAddr, CustApt, CustCity, CustState, CustZip, ' +
    '  CustPlaceEmply, CustFlDrvLic, ' +
    '  CustID, CustIDType, CustIDAgencyState, ' +
    '  CustPhHome, CustPhBussiness, CustPhBeep, CustPhCell, ' +
    '  CustComment ' +
    'FROM Customer',
    'INSERT INTO CUSTOMER (CUST_NO, CUST_FIRST, CUST_MID, CUST_LAST, CUST_DOB, ' +
    '  CUST_GENDER, CUST_RACE, CUST_HAIR, CUST_EYES, CUST_MARK, ' +
    '  CUST_WEIGHT, CUST_HEIGHT, CUST_ADDR, CUST_APT, CUST_CITY, ' +
    '  CUST_STATE, CUST_ZIP, CUST_PLACE_EMPLY, CUST_FL_DRV_LIC, ' +
    '  CUST_ID, CUST_ID_TYPE, CUST_ID_AGENCY_STATE, ' +
    '  CUST_PH_HOME, CUST_PH_BUSINESS, CUST_PH_BEEP, CUST_PH_CELL, ' +
    '  CUST_COMMENT) ' +
    'VALUES (:CUST_NO, :CUST_FIRST, :CUST_MID, :CUST_LAST, :CUST_DOB, ' +
    '  :CUST_GENDER, :CUST_RACE, :CUST_HAIR, :CUST_EYES, :CUST_MARK, ' +
    '  :CUST_WEIGHT, :CUST_HEIGHT, :CUST_ADDR, :CUST_APT, :CUST_CITY, ' +
    '  :CUST_STATE, :CUST_ZIP, :CUST_PLACE_EMPLY, :CUST_FL_DRV_LIC, ' +
    '  :CUST_ID, :CUST_ID_TYPE, :CUST_ID_AGENCY_STATE, ' +
    '  :CUST_PH_HOME, :CUST_PH_BUSINESS, :CUST_PH_BEEP, :CUST_PH_CELL, ' +
    '  :CUST_COMMENT)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('CUST_NO').Value              := src.FieldByName('Custno').Value;
      dst.ParamByName('CUST_FIRST').Value           := src.FieldByName('CustFirst').Value;
      dst.ParamByName('CUST_MID').Value             := src.FieldByName('CustMid').Value;
      dst.ParamByName('CUST_LAST').Value            := src.FieldByName('CustLast').Value;
      dst.ParamByName('CUST_DOB').Value             := src.FieldByName('CustDOB').Value;
      dst.ParamByName('CUST_GENDER').Value          := src.FieldByName('CustGender').Value;
      dst.ParamByName('CUST_RACE').Value            := src.FieldByName('CustRace').Value;
      dst.ParamByName('CUST_HAIR').Value            := src.FieldByName('CustHair').Value;
      dst.ParamByName('CUST_EYES').Value            := src.FieldByName('CustEyes').Value;
      dst.ParamByName('CUST_MARK').Value            := src.FieldByName('CustMark').Value;
      dst.ParamByName('CUST_WEIGHT').Value          := src.FieldByName('CustWeight').Value;
      dst.ParamByName('CUST_HEIGHT').Value          := src.FieldByName('CustHeight').Value;
      dst.ParamByName('CUST_ADDR').Value            := src.FieldByName('CustAddr').Value;
      dst.ParamByName('CUST_APT').Value             := src.FieldByName('CustApt').Value;
      dst.ParamByName('CUST_CITY').Value            := src.FieldByName('CustCity').Value;
      dst.ParamByName('CUST_STATE').Value           := src.FieldByName('CustState').Value;
      dst.ParamByName('CUST_ZIP').Value             := src.FieldByName('CustZip').Value;
      dst.ParamByName('CUST_PLACE_EMPLY').Value     := src.FieldByName('CustPlaceEmply').Value;
      dst.ParamByName('CUST_FL_DRV_LIC').Value      := src.FieldByName('CustFlDrvLic').Value;
      dst.ParamByName('CUST_ID').Value              := src.FieldByName('CustID').Value;
      dst.ParamByName('CUST_ID_TYPE').Value         := src.FieldByName('CustIDType').Value;
      dst.ParamByName('CUST_ID_AGENCY_STATE').Value := src.FieldByName('CustIDAgencyState').Value;
      dst.ParamByName('CUST_PH_HOME').Value         := src.FieldByName('CustPhHome').Value;
      dst.ParamByName('CUST_PH_BUSINESS').Value     := src.FieldByName('CustPhBussiness').Value;
      dst.ParamByName('CUST_PH_BEEP').Value         := src.FieldByName('CustPhBeep').Value;
      dst.ParamByName('CUST_PH_CELL').Value         := src.FieldByName('CustPhCell').Value;
      dst.ParamByName('CUST_COMMENT').Value         := src.FieldByName('CustComment').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpTransactions;
begin
  // ASA TranDate is TIMESTAMP; FB TRAN_DATE is DATE. Explicit CAST in the SELECT
  // makes the narrowing obvious (rather than relying on implicit ADO->FireDAC coercion).
  // ASA typo InsterestBalance -> FB INTEREST_BALANCE.
  // TranComment: ASA long varchar -> FB BLOB SUB_TYPE 1 (text).
  PumpTable('Transactions -> TRANSACTIONS', 'TRANSACTIONS',
    'SELECT TransactionNo, CustNo, CAST(TranDate AS DATE) AS TranDate, ' +
    '  TranTicketNo, TranComment, TranMaturity, TranType, TranStatus, ' +
    '  TranVoidDate, TranPawnAmount, TranInterest, PrincBalance, ' +
    '  InsterestBalance, TranTime, TranCloseReason, TranSalesTax ' +
    'FROM Transactions',
    'INSERT INTO TRANSACTIONS (TRANSACTION_NO, CUST_NO, TRAN_DATE, ' +
    '  TRAN_TICKET_NO, TRAN_COMMENT, TRAN_MATURITY, TRAN_TYPE, TRAN_STATUS, ' +
    '  TRAN_VOID_DATE, TRAN_PAWN_AMOUNT, TRAN_INTEREST, PRINC_BALANCE, ' +
    '  INTEREST_BALANCE, TRAN_TIME, TRAN_CLOSE_REASON, TRAN_SALES_TAX) ' +
    'VALUES (:TRANSACTION_NO, :CUST_NO, :TRAN_DATE, ' +
    '  :TRAN_TICKET_NO, :TRAN_COMMENT, :TRAN_MATURITY, :TRAN_TYPE, :TRAN_STATUS, ' +
    '  :TRAN_VOID_DATE, :TRAN_PAWN_AMOUNT, :TRAN_INTEREST, :PRINC_BALANCE, ' +
    '  :INTEREST_BALANCE, :TRAN_TIME, :TRAN_CLOSE_REASON, :TRAN_SALES_TAX)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('TRANSACTION_NO').Value    := src.FieldByName('TransactionNo').Value;
      dst.ParamByName('CUST_NO').Value           := src.FieldByName('CustNo').Value;
      dst.ParamByName('TRAN_DATE').Value         := src.FieldByName('TranDate').Value;
      dst.ParamByName('TRAN_TICKET_NO').Value    := src.FieldByName('TranTicketNo').Value;
      dst.ParamByName('TRAN_COMMENT').Value      := src.FieldByName('TranComment').Value;
      dst.ParamByName('TRAN_MATURITY').Value     := src.FieldByName('TranMaturity').Value;
      dst.ParamByName('TRAN_TYPE').Value         := src.FieldByName('TranType').Value;
      dst.ParamByName('TRAN_STATUS').Value       := src.FieldByName('TranStatus').Value;
      dst.ParamByName('TRAN_VOID_DATE').Value    := src.FieldByName('TranVoidDate').Value;
      dst.ParamByName('TRAN_PAWN_AMOUNT').Value  := src.FieldByName('TranPawnAmount').Value;
      dst.ParamByName('TRAN_INTEREST').Value     := src.FieldByName('TranInterest').Value;
      dst.ParamByName('PRINC_BALANCE').Value     := src.FieldByName('PrincBalance').Value;
      dst.ParamByName('INTEREST_BALANCE').Value  := src.FieldByName('InsterestBalance').Value;
      dst.ParamByName('TRAN_TIME').Value         := src.FieldByName('TranTime').Value;
      dst.ParamByName('TRAN_CLOSE_REASON').Value := src.FieldByName('TranCloseReason').Value;
      dst.ParamByName('TRAN_SALES_TAX').Value    := src.FieldByName('TranSalesTax').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpInventoryItems;
begin
  // ASA UnitCost/UnitPrice are money -> FB DECIMAL(18,2). .Value handles it.
  // ASA Description varchar(40) -> FB VARCHAR(120) (widened, no action needed).
  // Column order matches ASA source, not FB table declaration order.
  PumpTable('InventoryItems -> INVENTORY_ITEMS', 'INVENTORY_ITEMS',
    'SELECT InvItemNo, InvItemBarcode, InvCatNo, JType, JStyle, JMetal, ' +
    '  InvItemCount, Note, SizeLength, Weight, KT, Created, UnitCost, ' +
    '  UnitPrice, InvItemStatus, TransactionNo, InvOriginalItemNo, ' +
    '  InvItemBrand, OwnerAppNumber, ModelNumber, SerialNumber, Gender, ' +
    '  Description, WeightUnit, PawnedDate, PurchaseDate, RedeemedDate, ' +
    '  DefaultedDate, MeltedDate, ForSaleDate, SoldDate, LayawayDate ' +
    'FROM InventoryItems',
    'INSERT INTO INVENTORY_ITEMS (INV_ITEM_NO, INV_ITEM_BARCODE, INV_CAT_NO, ' +
    '  J_TYPE, J_STYLE, J_METAL, INV_ITEM_COUNT, NOTE, SIZE_LENGTH, WEIGHT, ' +
    '  KT, CREATED, UNIT_COST, UNIT_PRICE, INV_ITEM_STATUS, TRANSACTION_NO, ' +
    '  INV_ORIGINAL_ITEM_NO, INV_ITEM_BRAND, OWNER_APP_NUMBER, MODEL_NUMBER, ' +
    '  SERIAL_NUMBER, GENDER, DESCRIPTION, WEIGHT_UNIT, PAWNED_DATE, ' +
    '  PURCHASE_DATE, REDEEMED_DATE, DEFAULTED_DATE, MELTED_DATE, ' +
    '  FORSALE_DATE, SOLD_DATE, LAYAWAY_DATE) ' +
    'VALUES (:INV_ITEM_NO, :INV_ITEM_BARCODE, :INV_CAT_NO, ' +
    '  :J_TYPE, :J_STYLE, :J_METAL, :INV_ITEM_COUNT, :NOTE, :SIZE_LENGTH, :WEIGHT, ' +
    '  :KT, :CREATED, :UNIT_COST, :UNIT_PRICE, :INV_ITEM_STATUS, :TRANSACTION_NO, ' +
    '  :INV_ORIGINAL_ITEM_NO, :INV_ITEM_BRAND, :OWNER_APP_NUMBER, :MODEL_NUMBER, ' +
    '  :SERIAL_NUMBER, :GENDER, :DESCRIPTION, :WEIGHT_UNIT, :PAWNED_DATE, ' +
    '  :PURCHASE_DATE, :REDEEMED_DATE, :DEFAULTED_DATE, :MELTED_DATE, ' +
    '  :FORSALE_DATE, :SOLD_DATE, :LAYAWAY_DATE)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('INV_ITEM_NO').Value          := src.FieldByName('InvItemNo').Value;
      dst.ParamByName('INV_ITEM_BARCODE').Value     := src.FieldByName('InvItemBarcode').Value;
      dst.ParamByName('INV_CAT_NO').Value           := src.FieldByName('InvCatNo').Value;
      dst.ParamByName('J_TYPE').Value               := src.FieldByName('JType').Value;
      dst.ParamByName('J_STYLE').Value              := src.FieldByName('JStyle').Value;
      dst.ParamByName('J_METAL').Value              := src.FieldByName('JMetal').Value;
      dst.ParamByName('INV_ITEM_COUNT').Value       := src.FieldByName('InvItemCount').Value;
      dst.ParamByName('NOTE').Value                 := src.FieldByName('Note').Value;
      dst.ParamByName('SIZE_LENGTH').Value          := src.FieldByName('SizeLength').Value;
      dst.ParamByName('WEIGHT').Value               := src.FieldByName('Weight').Value;
      dst.ParamByName('KT').Value                   := src.FieldByName('KT').Value;
      dst.ParamByName('CREATED').Value              := src.FieldByName('Created').Value;
      dst.ParamByName('UNIT_COST').Value            := src.FieldByName('UnitCost').Value;
      dst.ParamByName('UNIT_PRICE').Value           := src.FieldByName('UnitPrice').Value;
      dst.ParamByName('INV_ITEM_STATUS').Value      := src.FieldByName('InvItemStatus').Value;
      dst.ParamByName('TRANSACTION_NO').Value       := src.FieldByName('TransactionNo').Value;
      dst.ParamByName('INV_ORIGINAL_ITEM_NO').Value := src.FieldByName('InvOriginalItemNo').Value;
      dst.ParamByName('INV_ITEM_BRAND').Value       := src.FieldByName('InvItemBrand').Value;
      dst.ParamByName('OWNER_APP_NUMBER').Value     := src.FieldByName('OwnerAppNumber').Value;
      dst.ParamByName('MODEL_NUMBER').Value         := src.FieldByName('ModelNumber').Value;
      dst.ParamByName('SERIAL_NUMBER').Value        := src.FieldByName('SerialNumber').Value;
      dst.ParamByName('GENDER').Value               := src.FieldByName('Gender').Value;
      dst.ParamByName('DESCRIPTION').Value          := src.FieldByName('Description').Value;
      dst.ParamByName('WEIGHT_UNIT').Value          := src.FieldByName('WeightUnit').Value;
      dst.ParamByName('PAWNED_DATE').Value          := src.FieldByName('PawnedDate').Value;
      dst.ParamByName('PURCHASE_DATE').Value        := src.FieldByName('PurchaseDate').Value;
      dst.ParamByName('REDEEMED_DATE').Value        := src.FieldByName('RedeemedDate').Value;
      dst.ParamByName('DEFAULTED_DATE').Value       := src.FieldByName('DefaultedDate').Value;
      dst.ParamByName('MELTED_DATE').Value          := src.FieldByName('MeltedDate').Value;
      dst.ParamByName('FORSALE_DATE').Value         := src.FieldByName('ForSaleDate').Value;
      dst.ParamByName('SOLD_DATE').Value            := src.FieldByName('SoldDate').Value;
      dst.ParamByName('LAYAWAY_DATE').Value         := src.FieldByName('LayawayDate').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpStones;
begin
  PumpTable('Stones -> STONES', 'STONES',
    'SELECT StoneNo, InvItemNo, StoneNumber, StoneShape, StoneColor, ' +
    '  CT, WT, StoneType, StoneWeightUnit ' +
    'FROM Stones',
    'INSERT INTO STONES (STONE_NO, INV_ITEM_NO, STONE_NUMBER, STONE_SHAPE, ' +
    '  STONE_COLOR, CT, WT, STONE_TYPE, STONE_WEIGHT_UNIT) ' +
    'VALUES (:STONE_NO, :INV_ITEM_NO, :STONE_NUMBER, :STONE_SHAPE, ' +
    '  :STONE_COLOR, :CT, :WT, :STONE_TYPE, :STONE_WEIGHT_UNIT)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('STONE_NO').Value          := src.FieldByName('StoneNo').Value;
      dst.ParamByName('INV_ITEM_NO').Value       := src.FieldByName('InvItemNo').Value;
      dst.ParamByName('STONE_NUMBER').Value      := src.FieldByName('StoneNumber').Value;
      dst.ParamByName('STONE_SHAPE').Value       := src.FieldByName('StoneShape').Value;
      dst.ParamByName('STONE_COLOR').Value       := src.FieldByName('StoneColor').Value;
      dst.ParamByName('CT').Value                := src.FieldByName('CT').Value;
      dst.ParamByName('WT').Value                := src.FieldByName('WT').Value;
      dst.ParamByName('STONE_TYPE').Value        := src.FieldByName('StoneType').Value;
      dst.ParamByName('STONE_WEIGHT_UNIT').Value := src.FieldByName('StoneWeightUnit').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpSalesItems;
begin
  PumpTable('SalesItems -> SALES_ITEMS', 'SALES_ITEMS',
    'SELECT SalesItemNo, InvItemNo, SalesItemDesc, CatNo, JType, JStyle, ' +
    '  JMetal, JShape, JStoneColor, SalesItemCount, Amount ' +
    'FROM SalesItems',
    'INSERT INTO SALES_ITEMS (SALES_ITEM_NO, INV_ITEM_NO, SALES_ITEM_DESC, ' +
    '  CAT_NO, J_TYPE, J_STYLE, J_METAL, J_SHAPE, J_STONE_COLOR, ' +
    '  SALES_ITEM_COUNT, AMOUNT) ' +
    'VALUES (:SALES_ITEM_NO, :INV_ITEM_NO, :SALES_ITEM_DESC, ' +
    '  :CAT_NO, :J_TYPE, :J_STYLE, :J_METAL, :J_SHAPE, :J_STONE_COLOR, ' +
    '  :SALES_ITEM_COUNT, :AMOUNT)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('SALES_ITEM_NO').Value    := src.FieldByName('SalesItemNo').Value;
      dst.ParamByName('INV_ITEM_NO').Value      := src.FieldByName('InvItemNo').Value;
      dst.ParamByName('SALES_ITEM_DESC').Value  := src.FieldByName('SalesItemDesc').Value;
      dst.ParamByName('CAT_NO').Value           := src.FieldByName('CatNo').Value;
      dst.ParamByName('J_TYPE').Value           := src.FieldByName('JType').Value;
      dst.ParamByName('J_STYLE').Value          := src.FieldByName('JStyle').Value;
      dst.ParamByName('J_METAL').Value          := src.FieldByName('JMetal').Value;
      dst.ParamByName('J_SHAPE').Value          := src.FieldByName('JShape').Value;
      dst.ParamByName('J_STONE_COLOR').Value    := src.FieldByName('JStoneColor').Value;
      dst.ParamByName('SALES_ITEM_COUNT').Value := src.FieldByName('SalesItemCount').Value;
      dst.ParamByName('AMOUNT').Value           := src.FieldByName('Amount').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpPayments;
begin
  // ASA typo InsterestBalance -> FB INTEREST_BALANCE.
  // PayComment: ASA long varchar -> FB BLOB SUB_TYPE 1 (text).
  PumpTable('Payments -> PAYMENTS', 'PAYMENTS',
    'SELECT PaymentNo, TransactionNo, PayDate, PayAmount, PayComment, ' +
    '  PayMethod, PayInterest, PayPrincipal, PrincBalance, InsterestBalance ' +
    'FROM Payments',
    'INSERT INTO PAYMENTS (PAYMENT_NO, TRANSACTION_NO, PAY_DATE, PAY_AMOUNT, ' +
    '  PAY_COMMENT, PAY_METHOD, PAY_INTEREST, PAY_PRINCIPAL, PRINC_BALANCE, ' +
    '  INTEREST_BALANCE) ' +
    'VALUES (:PAYMENT_NO, :TRANSACTION_NO, :PAY_DATE, :PAY_AMOUNT, ' +
    '  :PAY_COMMENT, :PAY_METHOD, :PAY_INTEREST, :PAY_PRINCIPAL, :PRINC_BALANCE, ' +
    '  :INTEREST_BALANCE)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('PAYMENT_NO').Value       := src.FieldByName('PaymentNo').Value;
      dst.ParamByName('TRANSACTION_NO').Value   := src.FieldByName('TransactionNo').Value;
      dst.ParamByName('PAY_DATE').Value         := src.FieldByName('PayDate').Value;
      dst.ParamByName('PAY_AMOUNT').Value       := src.FieldByName('PayAmount').Value;
      dst.ParamByName('PAY_COMMENT').Value      := src.FieldByName('PayComment').Value;
      dst.ParamByName('PAY_METHOD').Value       := src.FieldByName('PayMethod').Value;
      dst.ParamByName('PAY_INTEREST').Value     := src.FieldByName('PayInterest').Value;
      dst.ParamByName('PAY_PRINCIPAL').Value    := src.FieldByName('PayPrincipal').Value;
      dst.ParamByName('PRINC_BALANCE').Value    := src.FieldByName('PrincBalance').Value;
      dst.ParamByName('INTEREST_BALANCE').Value := src.FieldByName('InsterestBalance').Value;
    end);
end;

// Chunked/keyset-paginated because stores that use DATABASE image mode can
// have many multi-MB blobs; loading the whole result set client-side (ADO
// default clUseClient) risks OOM. Batches of 20 rows keep peak memory bounded
// at roughly 20 * max-image-size while still committing in one FB transaction.
procedure TfrmPumpAsaFb50Main.PumpImagesData;
const
  BATCH_SIZE = 20;
var
  src: TADOQuery;
  dst: TFDQuery;
  n, BatchCount: Integer;
  LastID: Integer;
begin
  lblCurrentProcess.Caption := 'Pumping IMAGES_DATA...';
  LogLine(Format('Pumping ImagesData -> IMAGES_DATA (batches of %d)...', [BATCH_SIZE]));
  n := 0;
  LastID := 0;

  src := TADOQuery.Create(nil);
  dst := TFDQuery.Create(nil);
  try
    src.Connection := ConnDB;

    dst.Connection := ConnectionFB;
    dst.SQL.Text :=
      'INSERT INTO IMAGES_DATA (IMAGES_DATA_NO, IMAGE_TYPE_NO, IMAG_REF_TO_ROW_NO, ' +
      '  IMAGE_DESC, IMAGE_DATA, CREATED, UPLOAD_TIME, UPLOAD_FILE_NAME) ' +
      'VALUES (:IMAGES_DATA_NO, :IMAGE_TYPE_NO, :IMAG_REF_TO_ROW_NO, ' +
      '  :IMAGE_DESC, :IMAGE_DATA, :CREATED, :UPLOAD_TIME, :UPLOAD_FILE_NAME)';
    dst.Prepare;

    ConnectionFB.StartTransaction;
    try
      repeat
        src.Close;
        src.SQL.Text := Format(
          'SELECT TOP %d ImagesDataNo, ImageTypeNo, ImagRefToRowNo, ImageDesc, ' +
          '  ImageData, Created, UploadTime, UploadFileName ' +
          'FROM ImagesData WHERE ImagesDataNo > %d ORDER BY ImagesDataNo',
          [BATCH_SIZE, LastID]);
        src.Open;

        BatchCount := 0;
        while not src.Eof do
        begin
          dst.ParamByName('IMAGES_DATA_NO').Value     := src.FieldByName('ImagesDataNo').Value;
          dst.ParamByName('IMAGE_TYPE_NO').Value      := src.FieldByName('ImageTypeNo').Value;
          dst.ParamByName('IMAG_REF_TO_ROW_NO').Value := src.FieldByName('ImagRefToRowNo').Value;
          dst.ParamByName('IMAGE_DESC').Value         := src.FieldByName('ImageDesc').Value;
          dst.ParamByName('IMAGE_DATA').Value         := src.FieldByName('ImageData').Value;
          dst.ParamByName('CREATED').Value            := src.FieldByName('Created').Value;
          dst.ParamByName('UPLOAD_TIME').Value        := src.FieldByName('UploadTime').Value;
          dst.ParamByName('UPLOAD_FILE_NAME').Value   := src.FieldByName('UploadFileName').Value;
          ApplyNullCoercion(dst, 'IMAGES_DATA');
          dst.ExecSQL;

          LastID := src.FieldByName('ImagesDataNo').AsInteger;
          Inc(n);
          Inc(BatchCount);
          src.Next;
        end;
      until BatchCount < BATCH_SIZE;  // last batch returned fewer than BATCH_SIZE = done

      ConnectionFB.Commit;
    except
      ConnectionFB.Rollback;
      raise;
    end;

    LogLine(Format('  OK. %d rows pumped.', [n]));
  finally
    dst.Free;
    src.Free;
  end;
end;

procedure TfrmPumpAsaFb50Main.PumpImagesDataBackup;
begin
  // ASA ID is bigint, FB ID is INTEGER — narrower. Fine for realistic values.
  PumpTable('ImagesDataBackup -> IMAGES_DATA_BACKUP', 'IMAGES_DATA_BACKUP',
    'SELECT ID, ImagesDataNo FROM ImagesDataBackup',
    'INSERT INTO IMAGES_DATA_BACKUP (ID, IMAGES_DATA_NO) VALUES (:ID, :IMAGES_DATA_NO)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('ID').Value             := src.FieldByName('ID').Value;
      dst.ParamByName('IMAGES_DATA_NO').Value := src.FieldByName('ImagesDataNo').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpInventoryItemStatusLog;
begin
  PumpTable('InventoryItemStatusLog -> INVENTORY_ITEM_STATUS_LOG', 'INVENTORY_ITEM_STATUS_LOG',
    'SELECT LogId, InvItemNo, OldStatus, NewStatus, ' +
    '  OldPawnedDate, NewPawnedDate, OldPurchaseDate, NewPurchaseDate, ' +
    '  OldRedeemedDate, NewRedeemedDate, OldDefaultedDate, NewDefaultedDate, ' +
    '  OldMeltedDate, NewMeltedDate, OldForSaleDate, NewForSaleDate, ' +
    '  OldSoldDate, NewSoldDate, OldLayawayDate, NewLayawayDate, ' +
    '  ChangedBy, ChangedAt ' +
    'FROM InventoryItemStatusLog',
    'INSERT INTO INVENTORY_ITEM_STATUS_LOG (LOG_ID, INV_ITEM_NO, OLD_STATUS, NEW_STATUS, ' +
    '  OLD_PAWNED_DATE, NEW_PAWNED_DATE, OLD_PURCHASE_DATE, NEW_PURCHASE_DATE, ' +
    '  OLD_REDEEMED_DATE, NEW_REDEEMED_DATE, OLD_DEFAULTED_DATE, NEW_DEFAULTED_DATE, ' +
    '  OLD_MELTED_DATE, NEW_MELTED_DATE, OLD_FORSALE_DATE, NEW_FORSALE_DATE, ' +
    '  OLD_SOLD_DATE, NEW_SOLD_DATE, OLD_LAYAWAY_DATE, NEW_LAYAWAY_DATE, ' +
    '  CHANGED_BY, CHANGED_AT) ' +
    'VALUES (:LOG_ID, :INV_ITEM_NO, :OLD_STATUS, :NEW_STATUS, ' +
    '  :OLD_PAWNED_DATE, :NEW_PAWNED_DATE, :OLD_PURCHASE_DATE, :NEW_PURCHASE_DATE, ' +
    '  :OLD_REDEEMED_DATE, :NEW_REDEEMED_DATE, :OLD_DEFAULTED_DATE, :NEW_DEFAULTED_DATE, ' +
    '  :OLD_MELTED_DATE, :NEW_MELTED_DATE, :OLD_FORSALE_DATE, :NEW_FORSALE_DATE, ' +
    '  :OLD_SOLD_DATE, :NEW_SOLD_DATE, :OLD_LAYAWAY_DATE, :NEW_LAYAWAY_DATE, ' +
    '  :CHANGED_BY, :CHANGED_AT)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('LOG_ID').Value             := src.FieldByName('LogId').Value;
      dst.ParamByName('INV_ITEM_NO').Value        := src.FieldByName('InvItemNo').Value;
      dst.ParamByName('OLD_STATUS').Value         := src.FieldByName('OldStatus').Value;
      dst.ParamByName('NEW_STATUS').Value         := src.FieldByName('NewStatus').Value;
      dst.ParamByName('OLD_PAWNED_DATE').Value    := src.FieldByName('OldPawnedDate').Value;
      dst.ParamByName('NEW_PAWNED_DATE').Value    := src.FieldByName('NewPawnedDate').Value;
      dst.ParamByName('OLD_PURCHASE_DATE').Value  := src.FieldByName('OldPurchaseDate').Value;
      dst.ParamByName('NEW_PURCHASE_DATE').Value  := src.FieldByName('NewPurchaseDate').Value;
      dst.ParamByName('OLD_REDEEMED_DATE').Value  := src.FieldByName('OldRedeemedDate').Value;
      dst.ParamByName('NEW_REDEEMED_DATE').Value  := src.FieldByName('NewRedeemedDate').Value;
      dst.ParamByName('OLD_DEFAULTED_DATE').Value := src.FieldByName('OldDefaultedDate').Value;
      dst.ParamByName('NEW_DEFAULTED_DATE').Value := src.FieldByName('NewDefaultedDate').Value;
      dst.ParamByName('OLD_MELTED_DATE').Value    := src.FieldByName('OldMeltedDate').Value;
      dst.ParamByName('NEW_MELTED_DATE').Value    := src.FieldByName('NewMeltedDate').Value;
      dst.ParamByName('OLD_FORSALE_DATE').Value   := src.FieldByName('OldForSaleDate').Value;
      dst.ParamByName('NEW_FORSALE_DATE').Value   := src.FieldByName('NewForSaleDate').Value;
      dst.ParamByName('OLD_SOLD_DATE').Value      := src.FieldByName('OldSoldDate').Value;
      dst.ParamByName('NEW_SOLD_DATE').Value      := src.FieldByName('NewSoldDate').Value;
      dst.ParamByName('OLD_LAYAWAY_DATE').Value   := src.FieldByName('OldLayawayDate').Value;
      dst.ParamByName('NEW_LAYAWAY_DATE').Value   := src.FieldByName('NewLayawayDate').Value;
      dst.ParamByName('CHANGED_BY').Value         := src.FieldByName('ChangedBy').Value;
      dst.ParamByName('CHANGED_AT').Value         := src.FieldByName('ChangedAt').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpBackupHistory;
begin
  PumpTable('BackupHistory -> BACKUP_HISTORY', 'BACKUP_HISTORY',
    'SELECT BckId, BckDate, BckPath FROM BackupHistory',
    'INSERT INTO BACKUP_HISTORY (BCK_ID, BCK_DATE, BCK_PATH) ' +
    'VALUES (:BCK_ID, :BCK_DATE, :BCK_PATH)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('BCK_ID').Value   := src.FieldByName('BckId').Value;
      dst.ParamByName('BCK_DATE').Value := src.FieldByName('BckDate').Value;
      dst.ParamByName('BCK_PATH').Value := src.FieldByName('BckPath').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpExportFileLog;
begin
  PumpTable('ExportFileLog -> EXPORT_FILE_LOG', 'EXPORT_FILE_LOG',
    'SELECT ExportLogID, ExportDate, FileName, ItemCount FROM ExportFileLog',
    'INSERT INTO EXPORT_FILE_LOG (EXPORT_LOG_ID, EXPORT_DATE, FILE_NAME, ITEM_COUNT) ' +
    'VALUES (:EXPORT_LOG_ID, :EXPORT_DATE, :FILE_NAME, :ITEM_COUNT)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('EXPORT_LOG_ID').Value := src.FieldByName('ExportLogID').Value;
      dst.ParamByName('EXPORT_DATE').Value   := src.FieldByName('ExportDate').Value;
      dst.ParamByName('FILE_NAME').Value     := src.FieldByName('FileName').Value;
      dst.ParamByName('ITEM_COUNT').Value    := src.FieldByName('ItemCount').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpExportLogFileDetail;
begin
  // ASA ExportLine long varchar -> FB EXPORT_LINE BLOB SUB_TYPE 1 (text blob).
  PumpTable('ExportLogFileDetail -> EXPORT_LOG_FILE_DETAIL', 'EXPORT_LOG_FILE_DETAIL',
    'SELECT ID, ExportLogID, TransactionNo, ExportLine, InvItemNo, ItemSeq ' +
    'FROM ExportLogFileDetail',
    'INSERT INTO EXPORT_LOG_FILE_DETAIL (ID, EXPORT_LOG_ID, TRANSACTION_NO, ' +
    '  EXPORT_LINE, INV_ITEM_NO, ITEM_SEQ) ' +
    'VALUES (:ID, :EXPORT_LOG_ID, :TRANSACTION_NO, ' +
    '  :EXPORT_LINE, :INV_ITEM_NO, :ITEM_SEQ)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('ID').Value             := src.FieldByName('ID').Value;
      dst.ParamByName('EXPORT_LOG_ID').Value  := src.FieldByName('ExportLogID').Value;
      dst.ParamByName('TRANSACTION_NO').Value := src.FieldByName('TransactionNo').Value;
      dst.ParamByName('EXPORT_LINE').Value    := src.FieldByName('ExportLine').Value;
      dst.ParamByName('INV_ITEM_NO').Value    := src.FieldByName('InvItemNo').Value;
      dst.ParamByName('ITEM_SEQ').Value       := src.FieldByName('ItemSeq').Value;
    end);
end;

procedure TfrmPumpAsaFb50Main.PumpGoldPriceHistory;
begin
  // FB column is FETCHDATETIME (one word, no underscore).
  // ASA APIResponse long varchar -> FB API_RESPONSE BLOB SUB_TYPE 1 (text blob).
  PumpTable('GoldPriceHistory -> GOLD_PRICE_HISTORY', 'GOLD_PRICE_HISTORY',
    'SELECT PriceID, PricePerOunce, Currency, FetchDateTime, Source, APIResponse ' +
    'FROM GoldPriceHistory',
    'INSERT INTO GOLD_PRICE_HISTORY (PRICE_ID, PRICE_PER_OUNCE, CURRENCY, ' +
    '  FETCHDATETIME, SOURCE, API_RESPONSE) ' +
    'VALUES (:PRICE_ID, :PRICE_PER_OUNCE, :CURRENCY, ' +
    '  :FETCHDATETIME, :SOURCE, :API_RESPONSE)',
    procedure(src: TADOQuery; dst: TFDQuery)
    begin
      dst.ParamByName('PRICE_ID').Value        := src.FieldByName('PriceID').Value;
      dst.ParamByName('PRICE_PER_OUNCE').Value := src.FieldByName('PricePerOunce').Value;
      dst.ParamByName('CURRENCY').Value        := src.FieldByName('Currency').Value;
      dst.ParamByName('FETCHDATETIME').Value   := src.FieldByName('FetchDateTime').Value;
      dst.ParamByName('SOURCE').Value          := src.FieldByName('Source').Value;
      dst.ParamByName('API_RESPONSE').Value    := src.FieldByName('APIResponse').Value;
    end);
end;

// Post-pump housekeeping (plan §7):
//   1. For each IDENTITY table, restart the sequence at MAX(pk)+1. GENERATED BY
//      DEFAULT does not advance the sequence on explicit-value inserts, so
//      post-pump the sequences are still at 1 and would collide on first
//      app-issued insert.
//   2. For each app-managed key tracked in TABLE_KEYS (Transactions,
//      InventoryItems), ensure LAST_KEY >= MAX(pk). Normally the pumped
//      TABLE_KEYS row already carries the right value; this is belt-and-braces.
procedure TfrmPumpAsaFb50Main.PostPumpReseed;
const
  IDENTITY_TBL: array[0..13] of string = (
    'CUSTOMER',                  'PAYMENTS',
    'STATIONS',                  'INV_CATEGORIES',
    'SALES_ITEMS',               'STONES',
    'BACKUP_HISTORY',            'EXPORT_FORMAT',
    'EXPORT_FILE_LOG',           'EXPORT_LOG_FILE_DETAIL',
    'IMAGES_TYPES',              'IMAGES_DATA',
    'INVENTORY_ITEM_STATUS_LOG', 'GOLD_PRICE_HISTORY'
  );
  IDENTITY_COL: array[0..13] of string = (
    'CUST_NO',                   'PAYMENT_NO',
    'STATION_NO',                'INV_CAT_NO',
    'SALES_ITEM_NO',             'STONE_NO',
    'BCK_ID',                    'ID',
    'EXPORT_LOG_ID',             'ID',
    'IMAGE_TYPE_NO',             'IMAGES_DATA_NO',
    'LOG_ID',                    'PRICE_ID'
  );

  // TABLE_KEYS rows (ASA casing in TableName) -> FB target for MAX lookup.
  KEY_TBL_NAME:  array[0..1] of string = ('Transactions',    'InventoryItems');
  KEY_FB_TABLE:  array[0..1] of string = ('TRANSACTIONS',    'INVENTORY_ITEMS');
  KEY_FB_COL:    array[0..1] of string = ('TRANSACTION_NO',  'INV_ITEM_NO');

var
  q: TFDQuery;
  i, maxVal, currentKey: Integer;
begin
  lblCurrentProcess.Caption := 'Reseeding sequences...';
  LogLine('Reseeding identity sequences and TABLE_KEYS...');

  q := TFDQuery.Create(nil);
  try
    q.Connection := ConnectionFB;

    // --- 1. Identity RESTART WITH MAX+1 ---
    for i := Low(IDENTITY_TBL) to High(IDENTITY_TBL) do
    begin
      q.Close;
      q.SQL.Text := Format('SELECT COALESCE(MAX(%s), 0) FROM %s',
                           [IDENTITY_COL[i], IDENTITY_TBL[i]]);
      q.Open;
      maxVal := q.Fields[0].AsInteger;

      ConnectionFB.ExecSQL(Format('ALTER TABLE %s ALTER COLUMN %s RESTART WITH %d',
                                  [IDENTITY_TBL[i], IDENTITY_COL[i], maxVal + 1]));
    end;
    LogLine(Format('  Identity sequences reseeded on %d tables.', [Length(IDENTITY_TBL)]));

    // --- 2. TABLE_KEYS reconciliation for app-managed PKs ---
    for i := Low(KEY_TBL_NAME) to High(KEY_TBL_NAME) do
    begin
      q.Close;
      q.SQL.Text := Format('SELECT COALESCE(MAX(%s), 0) FROM %s',
                           [KEY_FB_COL[i], KEY_FB_TABLE[i]]);
      q.Open;
      maxVal := q.Fields[0].AsInteger;

      q.Close;
      q.SQL.Text := 'SELECT LAST_KEY FROM TABLE_KEYS WHERE TABLE_NAME = :N';
      q.ParamByName('N').AsString := KEY_TBL_NAME[i];
      q.Open;
      if q.Eof then
      begin
        LogLine(Format('  TABLE_KEYS[%s] row missing — skipped.', [KEY_TBL_NAME[i]]));
        Continue;
      end;
      currentKey := q.Fields[0].AsInteger;

      if currentKey < maxVal then
      begin
        ConnectionFB.ExecSQL(
          Format('UPDATE TABLE_KEYS SET LAST_KEY = %d WHERE TABLE_NAME = ''%s''',
                 [maxVal, KEY_TBL_NAME[i]]));
        LogLine(Format('  TABLE_KEYS[%s] bumped %d -> %d.',
                       [KEY_TBL_NAME[i], currentKey, maxVal]));
      end
      else
        LogLine(Format('  TABLE_KEYS[%s] OK (%d >= max %d).',
                       [KEY_TBL_NAME[i], currentKey, maxVal]));
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmPumpAsaFb50Main.PumpStates;
var
  src: TADOQuery;
  dst: TFDQuery;
  n: Integer;
begin
  lblCurrentProcess.Caption := 'Pumping STATES...';
  LogLine('Pumping States -> STATES...');
  n := 0;

  src := TADOQuery.Create(nil);
  dst := TFDQuery.Create(nil);
  try
    src.Connection := ConnDB;
    src.SQL.Text := 'SELECT State_Abbr, State_Name FROM States';
    src.Open;

    dst.Connection := ConnectionFB;
    dst.SQL.Text := 'INSERT INTO STATES (STATE_ABBR, STATE_NAME) VALUES (:STATE_ABBR, :STATE_NAME)';
    dst.Prepare;

    ConnectionFB.StartTransaction;
    try
      while not src.Eof do
      begin
        // TField.Value -> Variant preserves NULLs through to TFDParam.Value.
        // For blob columns, use .LoadFromStream / .AsBlob instead (future tables).
        dst.ParamByName('STATE_ABBR').Value := src.FieldByName('State_Abbr').Value;
        dst.ParamByName('STATE_NAME').Value := src.FieldByName('State_Name').Value;
        ApplyNullCoercion(dst, 'STATES');
        dst.ExecSQL;
        Inc(n);
        src.Next;
      end;
      ConnectionFB.Commit;
    except
      ConnectionFB.Rollback;
      raise;
    end;

    LogLine(Format('  OK. %d rows pumped.', [n]));
  finally
    dst.Free;
    src.Free;
  end;
end;

procedure TfrmPumpAsaFb50Main.LogLine(const S: string);
begin
  MemoErrors.Lines.Add(Format('[%s] %s', [FormatDateTime('hh:nn:ss', Now), S]));
end;

// Reads FB system catalog once per pump run and caches every column declared
// NOT NULL as an uppercase "TABLE.COLUMN" key. The ApplyNullCoercion helper
// below uses it to decide whether a NULL-valued parameter needs to be coerced.
procedure TfrmPumpAsaFb50Main.LoadFbNotNullMetadata;
var
  q: TFDQuery;
begin
  if FNotNullCols = nil then
  begin
    FNotNullCols := TStringList.Create;
    FNotNullCols.CaseSensitive := False;
    FNotNullCols.Sorted := True;
    FNotNullCols.Duplicates := dupIgnore;
  end;
  FNotNullCols.Clear;

  q := TFDQuery.Create(nil);
  try
    q.Connection := ConnectionFB;
    q.SQL.Text :=
      'SELECT TRIM(RDB$RELATION_NAME) || ''.'' || TRIM(RDB$FIELD_NAME) AS KEY ' +
      'FROM RDB$RELATION_FIELDS ' +
      'WHERE RDB$SYSTEM_FLAG = 0 AND RDB$NULL_FLAG = 1';
    q.Open;
    while not q.Eof do
    begin
      FNotNullCols.Add(q.FieldByName('KEY').AsString);
      q.Next;
    end;
  finally
    q.Free;
  end;
  LogLine(Format('Loaded %d NOT NULL column(s) from FB metadata.',
                 [FNotNullCols.Count]));
end;

// For any param on AQuery that is currently NULL and whose target column
// (ATable.ParamName) is NOT NULL in FB, substitute 0 (numeric) or ' ' (string).
// Dates/times/booleans/binary-blobs left as NULL — if any of those hit a
// NOT NULL target, the ExecSQL will surface a clear FB error for us to address.
procedure TfrmPumpAsaFb50Main.ApplyNullCoercion(AQuery: TFDQuery;
                                                const ATable: string);
var
  i: Integer;
  P: TFDParam;
  key, tableUpper: string;
begin
  if (FNotNullCols = nil) or (FNotNullCols.Count = 0) then
    Exit;
  tableUpper := UpperCase(ATable);
  for i := 0 to AQuery.Params.Count - 1 do
  begin
    P := AQuery.Params[i];
    if not P.IsNull then
      Continue;

    key := tableUpper + '.' + UpperCase(P.Name);
    if FNotNullCols.IndexOf(key) < 0 then
      Continue;  // target allows NULL — leave it

    case P.DataType of
      ftSmallint, ftInteger, ftLargeint, ftWord, ftAutoInc,
      ftByte, ftShortint, ftLongWord,
      ftBCD, ftFMTBcd, ftFloat, ftCurrency, ftSingle, ftExtended:
        P.Value := 0;
      ftString, ftWideString, ftFixedChar, ftFixedWideChar,
      ftMemo, ftWideMemo, ftFmtMemo:
        P.Value := ' ';
    end;
  end;
end;

procedure TfrmPumpAsaFb50Main.btnTestAsaClick(Sender: TObject);
var
  qry: TADOQuery;
  n: Integer;
begin
  LogLine('Testing ASA connection...');
  try
//    GetADOConnectionStr;
    ConnDB.Connected := True;
    try
      qry := TADOQuery.Create(nil);
      try
        qry.Connection := ConnDB;
        qry.SQL.Text := 'SELECT COUNT(*) FROM Customer';
        qry.Open;
        n := qry.Fields[0].AsInteger;
        LogLine(Format('  OK. ASA reachable. Customer rows: %d', [n]));
      finally
        qry.Free;
      end;
    finally
      ConnDB.Connected := False;
    end;
  except
    on E: Exception do
      LogLine(Format('  FAILED: [%s] %s', [E.ClassName, E.Message]));
  end;
end;

procedure TfrmPumpAsaFb50Main.btnTestFbClick(Sender: TObject);
var
  qry: TFDQuery;
  n: Integer;
begin
  LogLine('Testing Firebird connection...');
  try
    ConfigureFBDatabaseConnection;
    ConnectionFB.Connected := True;
    try
      qry := TFDQuery.Create(nil);
      try
        qry.Connection := ConnectionFB;
        qry.SQL.Text := 'SELECT COUNT(*) FROM CUSTOMER';
        qry.Open;
        n := qry.Fields[0].AsInteger;
        LogLine(Format('  OK. Firebird reachable. CUSTOMER rows: %d', [n]));
      finally
        qry.Free;
      end;
    finally
      ConnectionFB.Connected := False;
    end;
  except
    on E: Exception do
      LogLine(Format('  FAILED: [%s] %s', [E.ClassName, E.Message]));
  end;
end;

procedure TfrmPumpAsaFb50Main.FormCreate(Sender: TObject);
begin
  lblCurrentProcess.Caption := '';

  GetADOConnectionStr;
  ConfigureFBDatabaseConnection;
end;

end.
