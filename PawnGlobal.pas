unit PawnGlobal;

interface


Uses Windows, SysUtils, System.Classes, Forms, Controls, IniFiles, Dialogs, ActiveX, ComObj,
     Winapi.WinSpool, Vcl.Printers, Math,
     Db, dbctrls, Graphics, buttons, stdctrls, extctrls, DBGrids, System.Generics.Collections,
     Grids, Types, Variants, Vcl.FileCtrl, Nvv.IO.CSV.Delphi.NvvCSVClasses,
     System.SyncObjs;

type
  TDBInfo = record
    Alias, DBFile, LogName: string;
    ConnCount, PageSize: integer;
  end;

  TCloseReasonRec = record
    Code: Integer;
    Description: string;
  end;

  TPawnStatusColor = record
    Status: string;
    BG: TColor;
    FG: TColor;
  end;

  { Image Storage Procedure Types }
  TGetImageProc = procedure(ImagesDataNo: integer; ImageComponent: TImage) of object;
  /// Returns the image's ORIGINAL bytes, exactly as stored. Needed wherever an
  /// image is transmitted rather than displayed: loading into a TImage and
  /// saving it back re-encodes it, producing a different (usually much larger)
  /// file. For evidence going to law enforcement the bytes must be the ones the
  /// camera produced. Returns nil when the image is missing.
  TGetImageBytesProc = function(ImagesDataNo: integer): TBytes of object;
  TSaveImageProc = procedure(ImagesDataNo: integer; FileName: string; ImageDate: TDateTime) of object;
  TDeleteImageProc = procedure(ImagesDataNo: integer) of object;


const
  TranPawn = 'P';
  TranPurchase = 'U';
  TranLayaway = 'L';
  TranForSale = 'S';

  TranStatus_Active   ='A';
  TranStatus_Inactive ='I';

  PawnItemStatus_Pawned    = 'Pawned';
  PawnItemStatus_Redeemed  = 'Redeemed';
  PawnItemStatus_Defaulted = 'Defaulted';
  PawnItemStatus_ForSale   = 'For Sale';
  PawnItemStatus_Melted    = 'Melted';
  PawnItemStatus_Sold      = 'Sold';
  PawnItemStatus_Layaway   = 'Layaway';

  PawnTicketNo = 'PawnTicketNo';
  LayawayTicketNo = 'LayawayTicketNo';

  PawnCloseReasons: array[0..4] of TCloseReasonRec = (
    (Code: 0; Description: 'Open'),
    (Code: 1; Description: 'Void'),
    (Code: 2; Description: 'Redeemed'),
    (Code: 3; Description: 'Defaulted'),
    (Code: 4; Description: 'Mix Defaulted/Redeemed')
  );

  PawnStatusColors: array[0..5] of TPawnStatusColor = (
    (Status: PawnItemStatus_Pawned;     BG: clWhite;   FG: clBlack),  // White
    (Status: PawnItemStatus_Redeemed;   BG: $00F1FAF0; FG: clBlack),  // light green
    (Status: PawnItemStatus_Defaulted;  BG: $00ECECFB; FG: clBlack),  // light red
    (Status: PawnItemStatus_ForSale;    BG: $00E6F9FF; FG: clBlack),  // Light Yellow
    (Status: PawnItemStatus_Melted;     BG: $00F2F2F2; FG: clBlack),  // Light gray
    (Status: PawnItemStatus_Sold;       BG: $00FFE8F3; FG: clBlack)   // Light purple
  );

  EnableColor: array [false..true] of TColor = (clBtnFace, clWindow);
  PrnPreview: array [false..true] of string = ('Printer', 'Screen');
  YesNo: array [false..true] of String = ('N', 'Y');

  IniFileName = 'PawnPro.ini';
  IniKeyBarcode = 'BARCODE';

  IniKeyRepPolPrn = 'POLICEREP';
  IniKeyRepPolPrnBin = 'POLICEREPBIN';

  IniKeyPayReceiptPrn = 'PAYRECEIPTPRN';
  IniKeyPayReceiptPrnBin = 'PAYRECEIPTPRNBIN';

  IniSecLeadsOnline     = 'LEADS_ONLINE';
  IniKeyLeadsOnlinePath = 'CSVPath';

  IniSecImageBackup = 'IMAGE_BACKUP';
  IniKeyImageBackupLastBackupDate = 'LastBackupDate';
  IniKeyImageBackupLastAuditDate = 'LastAuditDate';
  IniKeyImageBackupLastAuditWeek = 'LastAuditWeek';

  IniSecBackup = 'BACKUP';
  // Encrypt the .fbk at rest to the vendor public key. Default (missing/empty)
  // = ON. Disable only with an explicit off value ('0','N','NO','FALSE','OFF').
  IniKeyEncryptBackups = 'EncryptBackups';

  IniSecSettings = 'SETTINGS';
  IniKeyShowGoldPrice = 'SHOWGOLDPRICE';

  IniSecGoldPrice = 'GOLD_PRICE';
  IniKeyGoldPriceUrl = 'Url';
  IniKeyGoldPriceKarats = 'Karats';   // e.g. 10,14,18 - blank hides the karat line
  IniKeyGoldPriceWeightUnit = 'WeightUnit';   // G or P - blank follows the store's default

  IniSecImageStorage = 'IMAGE_STORAGE';
  IniKeyStorageMode = 'StorageMode';
  IniKeyImageDirectory = 'ImageDirectory';
  ImageStorageMode_Database = 'DATABASE';
  ImageStorageMode_File = 'FILE';

  { IMAGES_TYPES.IMAGE_TYPE seed values (see PawnPro_FB5_SeedReferenceData.sql).
    Images are stored in IMAGES_DATA keyed by (IMAGE_TYPE_NO, IMAG_REF_TO_ROW_NO):
    Customer ID pics reference CUST_NO, item pics reference INV_ITEM_NO. }
  ImageType_CustomerID  = 1;
  ImageType_ItemPicture = 2;

  AppStateKeyImageSharedPath = 'IMAGE_SHARED_PATH';

  // Current DB schema version, tracked in APP_STATE.VALUE_INT. Read/written by
  // the startup migration runner (uDBMigrations). See CURRENT_DB_VERSION there.
  AppStateKeyDbSchemaVersion = 'DB_SCHEMA_VERSION';

  // Build identity of the EXE that last connected, written every startup so
  // "what version is this store running?" is a DB lookup, not a guess. Value
  // is GetBuildStamp: file version + git branch/hash + compile date.
  AppStateKeyAppVersion = 'APP_VERSION';

  IniSecDatabase = 'DATABASE';
  IniKeyIsLocalDatabase = 'IsLocalDatabase';

  // [CONNECTION_FB] keys. The section name itself is still inline in
  // PawnDM.ConfigureFBConnectionFor; this constant exists because both the
  // main app and PawnProSetup.exe need to refer to it.
  IniSecConnFB        = 'CONNECTION_FB';
  IniKeyConnFBHost     = 'host';
  IniKeyConnFBDatabase = 'database';
  IniKeyConnFBUser     = 'user';
  IniKeyPassword       = 'password';      // legacy cleartext
  IniKeyPasswordEnc    = 'password_enc';  // DPAPI Base64 blob (preferred)
  IniKeyConnFBPort     = 'port';
  IniKeyConnFBCharset  = 'charset';

  PawnDateCalcByDays  = 'D';
  PawnDateCalcByMonth = 'M';

  LastMinorAge = 17;

  WeightUnitPennyweight ='P';
  WeightUnitGram        ='G';

  GramsPerTroyOunce     = 31.1034768;
  GramsPerPennyweight   = 1.55517384;   // 1 dwt = 1/20 troy oz

  TranStatusActive      = 'A';
  TranStatusInactive    = 'I';

  //0-Open 1-Void 2-Redeemed 3-Defaulted 4-Mix Defaulted/Redeemed
  PawnCloseReasonVoid                     = 1;
  PawnCloseReasonRedeemed                 = 2;
  PawnCloseReasonDefaulted                = 3;
  PawnCloseReasonItemsMixRedeemDefaulted  = 4;
  LayawayCloseReasonClosedReleased        = 5;
  LayawayCloseReasonCanceledReturned      = 6;

  PawnDefaultedItemMelted = 1;
  PawnDefaultedItemForSale = 2;

  // STORE.LEADS_ONLINE_EXPORT_METHOD -- whether this store reports to
  // LeadsOnline at all, and if so over which channel. Not every store is a
  // LeadsOnline customer, so 'N' is the default for a new store and the whole
  // LeadsOnline export UI stays hidden until someone opts in.
  //
  // The column is nullable, so treat NULL/blank/anything unrecognised as 'N':
  // an unconfigured store must not appear to be reporting to law enforcement.
  // Stores migrated by uDBMigrations Step6 were explicitly backfilled to 'C',
  // so the ones already exporting by CSV keep working untouched.
  LeadsExportMethodNone = 'N';
  LeadsExportMethodCsv  = 'C';
  LeadsExportMethodSoap = 'S';


var
  AppPath: string;
  GlobalIniFile, LocalIniFile: string;
  DatabaseFileName: string;
  InterestCalcMethod: integer;
  PawnDatesCalcMethod: string;
  DefaultWeightMeasureUnit: string;
  ImageStorageMode: string;          // DATABASE or FILE
  ImagesStoragePath: string;          // Path for file-based storage
  IsLocalDatabase: boolean;           // True if DB is on same machine, False if remote
  AppShuttingDown: boolean;           // Set once the main form is closing for real.
                                      // Background workers must check this before
                                      // touching any VCL control: the main thread has
                                      // left its message loop by then, so the form and
                                      // its controls may already be gone.
  GetImageProc: TGetImageProc;        // Procedure pointer for getting images
  GetImageBytesProc: TGetImageBytesProc; // ...and for getting them un-re-encoded
  SaveImageProc: TSaveImageProc;      // Procedure pointer for saving images
  DeleteImageProc: TDeleteImageProc;  // Procedure pointer for deleting images

function WindowsDirectory: string;

/// The store's LeadsOnline channel, normalised to one of the three
/// LeadsExportMethod* constants -- never NULL, blank or unrecognised.
function LeadsOnlineMethod(const AStoredValue: string): string;
/// True when this store reports to LeadsOnline over either channel.
function UsesLeadsOnline(const AStoredValue: string): Boolean;

//function AddBackSlash(Path: string): string;
function ReadIniFile(Section, Key: string): string;
procedure WriteIniFile(Section, Key, Value: string);
procedure WriteLastImageBackupDate;
function DetectDatabaseIsLocal: Boolean;

//function CreateTempView(SQLStatement: string): string;
//Procedure ExecSQLStatement(SQLStatement: string);
function OpenSQLStatementFB(SQLStatement: string): variant;
function ExecSQLStatementFB(SQLStatement: string): integer; //Return how many rows were affected

function GetMACAddress:String;
function GetUniqueID: string;

function GuidToDBString(Guid: TGUID): string;

function FloridaLic(xLast, xFirst, xmid: string; xdob: TDateTime; gender: string): string;

function AddDoubleBackSlash(S: string): string;

procedure EnableDisableContr(Container: TWinControl; Enable: boolean);

procedure GridCheckBox(DBGrid: TDBGrid; const Rect: TRect; Column: TColumn;
                       DataCol: Integer; State: TGridDrawState; Checked: boolean);

function GetSaveSettingsName(FormName: string): string;

function ConvertTo2Dec(F: extended): extended;
function GetTransactionStr(TranType: string): string;
function GetFullName(FName, MName, LName: string): string;
function GetFullNameLastFirst(FName, MName, LName: string): string;

//procedure ParseFL_DL(RawData: string; var DrvLicInfo: TDriverLicenseInfo);

procedure WriteTextFile(FileName: string; Line: string);

function FormatPhoneUSA(Ph: string): string;
function FormatFLDriverLic(FL_DRV_LIC: string): string;
function MaskCustomerID(const IDType, IDNumber: string): string;
function GetRecNo(RecNo: integer): integer;
function SelectExportFolder(var FDir: string): boolean;
function CombinePhones(const Separator: string; const PhonesArray: array of string): string;
procedure ConfigureUSDateFormat;

procedure ReadCSVString_GetOneFieldData(HeaderPresent: boolean; const ACSVString: string; FieldNo: integer; var FldData: string);
procedure ReadCSVString(HeaderPresent: boolean; const ACSVString: string; var OneFldNamePerLine, OneFldPerLine: string);

procedure CenterPopupOnControl(const Host: TWinControl; const Popup: TForm);

function GetPrinterBinNames(const APrinterName: string): TArray<string>;
procedure FillPrinterTrays(ComboBox: TComboBox; const APrinterName: string);

function GetPawnStatusColor(const AStatus: string): TPawnStatusColor;
procedure CalcTaxAndTotal(const Amount: Currency; const TaxPercent: Currency;
                          out Tax: Currency; out TotalAmount: Currency);

// FULL build identity: file version, git branch/hash (from the build-time
// BuildInfo.inc), and compile date. For support, not for customers -- written to
// APP_STATE every startup so a store's running build is a database lookup
// rather than a guess.
function GetBuildStamp: string;

// What the ABOUT BOX shows: version and build date only.
//
// Deliberately not GetBuildStamp. That carries the git branch name, and a store
// owner reading "fix/camera-memory-and-audit-isolation" has just been told the
// software has a camera problem -- by a branch whose own work finished long ago
// and which now carries something else entirely. Branch names describe our work
// to us; they are not a message to a customer. The full stamp still goes to
// APP_STATE every startup, so support loses nothing.
function GetVersionCaption: string;


implementation

Uses PawnDM, Calendar, GLbUtils;

var
  IniAccessLock: TCriticalSection;

// Git branch/hash of this build. Regenerated by GenerateBuildInfo.ps1 as the
// project's pre-build step; the committed copy is the fallback when git is not
// on PATH at build time.
{$I BuildInfo.inc}

function LeadsOnlineMethod(const AStoredValue: string): string;
var
  V: string;
begin
  V := UpperCase(Trim(AStoredValue));
  if (V = LeadsExportMethodCsv) or (V = LeadsExportMethodSoap) then
    Result := V
  else
    // NULL, blank, or something nobody recognises. Defaulting to "not using"
    // is the safe direction: the alternative is a store that looks like it is
    // reporting to law enforcement when nothing is configured.
    Result := LeadsExportMethodNone;
end;

function UsesLeadsOnline(const AStoredValue: string): Boolean;
begin
  Result := LeadsOnlineMethod(AStoredValue) <> LeadsExportMethodNone;
end;

function GetBuildStamp: string;
begin
  Result := Format('v%s  |  %s %s  |  built %s',
    [GetVersionInfo(ParamStr(0), ''), BUILD_GIT_BRANCH, BUILD_GIT_HASH, BUILD_TIMESTAMP]);
end;

function GetVersionCaption: string;
begin
  // Date only, not the timestamp: the minute a build was compiled tells a store
  // nothing, and a stamp that changes several times a day reads like churn.
  Result := Format('Version %s  -  %s',
    [GetVersionInfo(ParamStr(0), ''), Copy(BUILD_TIMESTAMP, 1, 10)]);
end;

function AddDoubleBackSlash(S: string): string;
var
  i: integer;
begin
  if trim(S) = '' then
    exit;
  for i := 1 to length(S) do
    begin
      Result := Result + S[i];
      if S[i] = '\' then
        Result := Result + S[i];
    end;
end;

procedure EnableDisableContr(Container: TWinControl; Enable: boolean);
var
  i: integer;
  S: string;
begin
  S := '';
  for i := 0 to Container.ControlCount - 1 do
    begin
      if Container.Controls[i] is TDBEdit then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              (Container.Controls[i] as TDBEdit).ReadOnly := not Enable;
              (Container.Controls[i] as TDBEdit).Color := EnableColor[Enable];
            end;
        end
      else if Container.Controls[i] is TEdit then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              (Container.Controls[i] as TEdit).Color := EnableColor[Enable];
            end;
        end
      else if Container.Controls[i] is TDBMemo then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              (Container.Controls[i] as TDBMemo).ReadOnly := not Enable;
              (Container.Controls[i] as TDBMemo).Color := EnableColor[Enable];
            end;
        end
      else if Container.Controls[i] is TDBLookupComboBox then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              (Container.Controls[i] as TDBLookupComboBox).ReadOnly := not Enable;
              (Container.Controls[i] as TDBLookupComboBox).Color := EnableColor[Enable];
            end;
        end
      else if Container.Controls[i] is TDBRadioGroup then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              Container.Controls[i].Enabled := Enable;
            end;
        end
      else if Container.Controls[i] is TSpeedButton then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              Container.Controls[i].Enabled := Enable;
            end;
        end
      else if Container.Controls[i] is TGroupBox then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              Container.Controls[i].Enabled := Enable;
            end;
        end
      else if Container.Controls[i] is TPanel then
        begin
          if Container.Controls[i].Tag = 0 then
            begin
              Container.Controls[i].Enabled := Enable;
            end;
        end;
    end;
end;

function ReadIniFile(Section, Key: string): string;
var
  IniFile: TIniFile;
begin
  IniAccessLock.Acquire;
  try
    IniFile := TIniFile.Create(AppPath + IniFileName);
    try
      Result := IniFile.ReadString(Section, Key, '');
    finally
      IniFile.Free;
    end;
  finally
    IniAccessLock.Release;
  end;
end;

procedure WriteIniFile(Section, Key, Value: string);
var
  IniFile: TIniFile;
begin
  IniAccessLock.Acquire;
  try
    IniFile := TIniFile.Create(AppPath + IniFileName);
    try
      IniFile.WriteString(Section, Key, Value);
    finally
      IniFile.Free;
    end;
  finally
    IniAccessLock.Release;
  end;
end;

procedure WriteLastImageBackupDate;
begin
  WriteIniFile(IniSecImageBackup, IniKeyImageBackupLastBackupDate, FormatDateTime('yyyy-mm-dd', Date));
end;

// Heuristic: does the configured Firebird host point at this machine? Used to
// seed [DATABASE] IsLocalDatabase on first run, when the key has never been
// written. A non-local DB means no backup drive is attached, so the backup
// option is disabled. Reads the same [CONNECTION_FB] host that
// ConfigureFBConnectionFor uses.
function DetectDatabaseIsLocal: Boolean;
var
  Host: string;
begin
  Host := LowerCase(Trim(ReadIniFile(IniSecConnFB, IniKeyConnFBHost)));
  Result := (Host = '')          or
            (Host = 'localhost')  or
            (Host = '127.0.0.1')  or
            (Host = '::1')        or
            (Host = '.')          or
            SameText(Host, GetStationName);
end;

{function CreateTempView(SQLStatement: string): string;
var
  Q: TOEQuery;
begin
  Q := TOEQuery.Create(nil);
  Result := 'Vw' + GetUniqueID;
  try
    Q.hDbc := DM.Database;
    Q.SQL.Text := 'CREATE VIEW '+ Result + ' AS ' + SQLStatement;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;
}
function GetMACAddress:String;
type
  TGMac = record
    G: array [1..SizeOf(TGUID) - 6] of byte;
    MAC: array [1..6] of Byte;
  end;
var
  IUD: TGUID;
  ICount: Integer;
begin
  CoCreateGUID(IUD);
  Result := '';
  for iCount := 1 to 6 do
    Result := Result + IntToHex(TGMac(IUD).MAC[iCount], 2);
end;

function CharsOnly(S: string): string;
var
  i: integer;
begin
  S := UpperCase(S);
  Result := '';
  for i := 1 to Length(S) do
    begin
      if CharInSet(S[i], ['0'..'9', 'A'..'Z']) then
        Result := Result + S[i];
    end;
end;

function GetUniqueID: string;
var
  IUD: TGUID;
  GUIDStr: WideString;
  ISize: integer;
begin
  CoCreateGUID(IUD);
  ISize := 50;
  SetLength(GUIDStr, ISize);
  StringFromGUID2(IUD, PWideChar(GUIDStr), ISize);
  Result := CharsOnly(String(GUIDStr));
end;

function GuidToDBString(Guid: TGUID): string;
begin
  Result := GuidToString(Guid);
  Result := Copy(Result, 2, Length(Result) - 2);
end;

function WindowsDirectory: string;
begin
  SetLength(Result, 255);
  GetWindowsDirectory(pchar(Result), 255);
  SetLength(Result, StrLen(pchar(Result)));
  Result := IncludeTrailingPathDelimiter(Result);
end;

function FloridaLic(xLast, xFirst, xmid: string; xdob: TDateTime; gender: string): string;
//http://www.highprogrammer.com/alan/
type
  LetterVal = record
    Letter: Char;
    LVal: Char;
  end;

  LetterNum = record
    Letter: Char;
    LVal: Integer;
  end;

  LetterValTbl = Array [1..18] of LetterVal;

Const
  LetterValList: LetterValTbl = ((Letter: 'b'; LVal: '1'), (Letter: 'c'; LVal: '2'),
                                 (Letter: 'd'; LVal: '3'), (Letter: 'f'; LVal: '1'),
                                 (Letter: 'g'; LVal: '2'), (Letter: 'j'; LVal: '2'),
                                 (Letter: 'k'; LVal: '2'), (Letter: 'l'; LVal: '4'),
                                 (Letter: 'm'; LVal: '5'), (Letter: 'n'; LVal: '5'),
                                 (Letter: 'p'; LVal: '1'), (Letter: 'q'; LVal: '2'),
                                 (Letter: 'r'; LVal: '6'), (Letter: 's'; LVal: '2'),
                                 (Letter: 't'; LVal: '3'), (Letter: 'v'; LVal: '1'),
                                 (Letter: 'x'; LVal: '2'), (Letter: 'z'; LVal: '2'));

 y: Array [1..26] of LetterNum = ( (Letter: 'a'; LVal: 0), (Letter: 'b'; LVal: 60), (Letter: 'c'; LVal: 100), (Letter: 'd'; LVal: 160),
                                   (Letter: 'e'; LVal: 200), (Letter: 'f'; LVal: 240), (Letter: 'g'; LVal: 280), (Letter: 'h'; LVal: 320),
                                   (Letter: 'i'; LVal: 400), (Letter: 'j'; LVal: 420), (Letter: 'k'; LVal: 500), (Letter: 'l'; LVal: 520),
                                   (Letter: 'm'; LVal: 540), (Letter: 'n'; LVal: 620), (Letter: 'o'; LVal: 640), (Letter: 'p'; LVal: 660),
                                   (Letter: 'q'; LVal: 700), (Letter: 'r'; LVal: 720), (Letter: 's'; LVal: 780), (Letter: 't'; LVal: 800),
                                   (Letter: 'u'; LVal: 840), (Letter: 'v'; LVal: 860), (Letter: 'w'; LVal: 880), (Letter: 'x'; LVal: 940),
                                   (Letter: 'y'; LVal: 960), (Letter: 'z'; LVal: 980) );

 ym: Array [1..26] of LetterNum = ( (Letter: 'a'; LVal: 1), (Letter: 'b'; LVal: 2), (Letter: 'c'; LVal: 3), (Letter: 'd'; LVal: 4),
                                   (Letter: 'e'; LVal: 5), (Letter: 'f'; LVal: 6), (Letter: 'g'; LVal: 7), (Letter: 'h'; LVal: 8),
                                   (Letter: 'i'; LVal: 9), (Letter: 'j'; LVal: 10), (Letter: 'k'; LVal: 11), (Letter: 'l'; LVal: 12),
                                   (Letter: 'm'; LVal: 13), (Letter: 'n'; LVal: 14), (Letter: 'o'; LVal: 14), (Letter: 'p'; LVal: 15),
                                   (Letter: 'q'; LVal: 15), (Letter: 'r'; LVal: 16), (Letter: 's'; LVal: 17), (Letter: 't'; LVal: 18),
                                   (Letter: 'u'; LVal: 18), (Letter: 'v'; LVal: 18), (Letter: 'w'; LVal: 19), (Letter: 'x'; LVal: 19),
                                   (Letter: 'y'; LVal: 19), (Letter: 'z'; LVal: 19) );

var
  i, n, v, x: integer;
// y: Array [1..26] of LetterNum;
  Second, SecondNum, Fifth, Sixth, eighth: string;
  Third, fourth, seventh: integer;
  xgender: char;
begin
  xlast := trim(LowerCase(xlast));
  xfirst := trim(LowerCase(xfirst));
  xmid := trim(LowerCase(xmid));

  if trim(gender) = '' then
    exit;

  xgender := UpCase(gender[1]);
  if not ((xlast <> '') and (xfirst <> '') and (CharInSet(xgender, ['M', 'F'])) and (xdob > EncodeDate(1900, 1, 1))) then
    exit;

//  xgender := trim(LowCase(xgender));

  Second := '';
  SecondNum := '';
  v := length(trim(xLast));
  for i := 2 to v do
    begin
      second := xlast[i];
      for n :=1 to 18 do
        begin
          if xLast[i] = LetterValList[n].Letter then
            if n <> 1 then
              begin
                if xLast[i] <> xlast[i-1] then
                  SecondNum := SecondNum + LetterValList[n].LVal;
              end
            else
              SecondNum := SecondNum + LetterValList[n].LVal;
        end;//for
    end;//for

  if length(trim(secondnum)) > 3 then
    SecondNum := Copy(SecondNum, 1, 3);

  Second := SecondNum + StringOfChar('0', 3 - Length(SecondNum));


  // Third := 0;
  if xfirst='albert' then
    third := 20
  else if xfirst='alice' then
    third := 20
  else if  xfirst='ann' then
    third := 40
  else if  xfirst='anna' then
    third := 40
  else if  xfirst='anne' then
    third := 40
  else if  xfirst='annie' then
    third := 40
  else if  xfirst='arthur' then
    third := 40
  else if  xfirst='bernard' then
    third := 80
  else if  xfirst='bette' then
    third := 80
  else if  xfirst='bettie' then
    third := 80
  else if  xfirst='betty' then
    third := 80
  else if  xfirst='carl' then
    third := 120
  else if  xfirst='catherine' then
    third := 120
  else if  xfirst='charles' then
    third := 140
  else if  xfirst='clara' then
    third := 140
  else if  xfirst='donald' then
    third := 180
  else if  xfirst='dorothy' then
    third := 180
  else if  xfirst='dorthy' then
    third := 180
  else if  xfirst='edward' then
    third := 220
  else if  xfirst='elizabeth' then
    third := 220
  else if  xfirst='florence' then
    third := 260
  else if  xfirst='frank' then
    third := 260
  else if  xfirst='george' then
    third := 300
  else if  xfirst='grace' then
    third := 300
  else if  xfirst='harold' then
    third := 340
  else if  xfirst='harriet' then
    third := 340
  else if  xfirst='harry' then
    third := 360
  else if  xfirst='hazel' then
    third := 360
  else if  xfirst='helen' then
    third := 380
  else if  xfirst='henry' then
    third := 380
  else if  xfirst='james' then
    third := 440
  else if  xfirst='jane' then
    third := 440
  else if  xfirst='jayne' then
    third := 440
  else if  xfirst='jean' then
    third := 460
  else if  xfirst='john' then
    third := 460
  else if  xfirst='joan' then
    third := 480
  else if  xfirst='joseph' then
    third := 480
  else if  xfirst='margaret' then
    third := 560
  else if  xfirst='martin' then
    third := 450
  else if  xfirst='marvin' then
    third := 580
  else if  xfirst='mary' then
    third := 580
  else if  xfirst='melvin' then
    third := 600
  else if  xfirst='mildred' then
    third := 600
  else if  xfirst='patricia' then
    third := 680
  else if  xfirst='paul' then
    third := 680
  else if  xfirst='richard' then
    third := 740
  else if  xfirst='ruby' then
    third := 740
  else if  xfirst='robert' then
    third := 760
  else if  xfirst='ruth' then
    third := 760
  else if  xfirst='thelma' then
    third := 820
  else if  xfirst='thomas' then
    third := 820
  else if  xfirst='walter' then
    third := 900
  else if  xfirst='wanda' then
    third := 900
  else if  xfirst='william' then
    third := 920
  else if  xfirst='wilma' then
    third := 920
  else if  xfirst='wilmau' then
    third := 920
  else
   begin
     Third := byte(xFirst[1]); //?
     for i := 1 to 26 do
       if xFirst[1] = y[i].Letter then
         Third := y[i].LVal;
   end;

  fourth :=0;
  if length(trim(xmid)) <> 0 then
   for i:=1 to 26 do
    if xmid[1] = ym[i].Letter then
      fourth := ym[i].LVal;


  Fifth := IntToStr(third+fourth);
  Fifth := StringOfChar('0', 3 - length(Fifth)) + Fifth;

  Sixth := FormatDateTime('yy', xdob);

  X := StrToInt(FormatDateTime('mm', xdob));

  seventh := 0;
  if UpCase(xgender) = 'F' then //Femenine
   begin
     case X of
     1: seventh:=500;
     2: seventh:=540;
     3: seventh:=580;
     4: seventh:=620;
     5: seventh:=660;
     6: seventh:=700;
     7: seventh:=740;
     8: seventh:=780;
     9: seventh:=820;
     10: seventh:=860;
     11: seventh:=900;
     12: seventh:=440//940;
     end; //case
    end  //if
  else
    begin
      case X of
      1: seventh:=0;
      2: seventh:=40;
      3: seventh:=80;
      4: seventh:=120;
      5: seventh:=160;
      6: seventh:=200;
      7: seventh:=240;
      8: seventh:=280;
      9: seventh:=320;
      10: seventh:=360;
      11: seventh:=400;
      12: seventh:=440;
      end; //case
    end; //if

  eighth := IntToStr(StrToInt(FormatDateTime('dd', xdob)) + seventh);
  eighth := StringOfChar('0', 3 - length(eighth)) + eighth;

  Result :=UpCase(xLast[1]) + Second + Fifth + Sixth + Eighth;
end;

// Firebird counterparts. Side-by-side with the ADO versions during the
// migration; call sites switch one at a time. ADO versions deleted in Phase 4.
// Uses TFDQuery.Open(string) / ExecSQL(string) overloads — bundles the SQL
// assignment and the call.
function OpenSQLStatementFB(SQLStatement: string): variant;
begin
  DM.qryDummyFB.Close;
  DM.qryDummyFB.Open(SQLStatement);
  Result := DM.qryDummyFB.Fields[0].Value;
  DM.qryDummyFB.Close;
end;

function ExecSQLStatementFB(SQLStatement: string): integer; //Return how many rows were affected
begin
  Result := DM.qryDummyFB.ExecSQL(SQLStatement);
end;

type
  TGridChild = class(TCustomDBGrid);

procedure GridCheckBox(DBGrid: TDBGrid; const Rect: TRect; Column: TColumn;
                       DataCol: Integer; State: TGridDrawState; Checked: boolean);
var
  CellRect: TRect;
  RowSelected: boolean;
begin
  with TGridChild(DBGrid) do
    begin
      RowSelected := (TDataLink(DataLink).ActiveRecord = (Row-1));
      if RowSelected then //Current Row
       with Canvas do
        begin
          Brush.Color := clGradientActiveCaption;
          Font.Color  := clblack;
          DefaultDrawColumnCell(Rect,DataCol,Column,State);
        end;
    end;
  with (DBGrid) do
    if Column.Index = 0 then
      begin
        CellRect.Top := ((Rect.Bottom - Rect.Top - 11) div 2) + Rect.Top;
        CellRect.Left := ((Rect.Right - Rect.Left - 11) div 2) + Rect.Left;
        CellRect.Bottom := CellRect.Top + 10;
        CellRect.Right := CellRect.Left + 10;

{        if RowSelected then
          Canvas.Pen.Color := clWhite
        else}
         Canvas.Pen.Color := clBlack;

        Canvas.Polyline([
        Point(CellRect.Left, CellRect.Top), Point(CellRect.Right, CellRect.Top),
        Point(CellRect.Right, CellRect.Bottom), Point(CellRect.Left, CellRect.Bottom),
        Point(CellRect.Left, CellRect.Top)]);
        if Checked then
          begin
            Canvas.MoveTo(CellRect.Left + 2, CellRect.Top + 4);
            Canvas.LineTo(CellRect.Left + 2, CellRect.Top + 7);
            Canvas.MoveTo(CellRect.Left + 3, CellRect.Top + 5);
            Canvas.LineTo(CellRect.Left + 3, CellRect.Top + 8);
            Canvas.MoveTo(CellRect.Left + 4, CellRect.Top + 6);
            Canvas.LineTo(CellRect.Left + 4, CellRect.Top + 9);
            Canvas.MoveTo(CellRect.Left + 5, CellRect.Top + 5);
            Canvas.LineTo(CellRect.Left + 5, CellRect.Top + 8);
            Canvas.MoveTo(CellRect.Left + 6, CellRect.Top + 4);
            Canvas.LineTo(CellRect.Left + 6, CellRect.Top + 7);
            Canvas.MoveTo(CellRect.Left + 7, CellRect.Top + 3);
            Canvas.LineTo(CellRect.Left + 7, CellRect.Top + 6);
            Canvas.MoveTo(CellRect.Left + 8, CellRect.Top + 2);
            Canvas.LineTo(CellRect.Left + 8, CellRect.Top + 5);
          end;
      end;
end;

function GetSaveSettingsName(FormName: string): string;
begin
  Result := Application.Title + '.' + FormName;
end;

function ConvertTo2Dec(F: extended): extended;
begin
  Result := StrToFloat(Format('%.2f', [F]));
end;

function GetTransactionStr(TranType: string): string;
begin
  if TranType = TranPawn then
    Result := 'Pawn'
  else if TranType = TranPurchase then
    Result := 'Purchase'
  else
    Result := '';
end;

function GetFullNameLastFirst(FName, MName, LName: string): string;
begin
  Result := trim(trim(trim(LName) + ', ' + FName) + ' ' + MName);
end;

function GetFullName(FName, MName, LName: string): string;
begin
  Result := trim(trim(trim(FName) + ' ' + MName) + ' ' + LName);
end;

//function GetDriverLicZip(S: string): string;
//var
//  StartPos, i: integer;
//begin
//  StartPos := 1;
//  for i := 1 to Length(S) do
//    begin
//      if S[i] <> '0' then
//        begin
//          StartPos := i;
//          break;
//        end;
//    end;
//
//   Result := Copy(S, StartPos, 5) + '-' + Copy(S, StartPos + 5, 4);
//end;



procedure WriteTextFile(FileName: string; Line: string);
var
  F: TextFile;
begin
  AssignFile(F, FileName);
  try
    if FileExists(FileName) then
      Append(F)
    else
      Rewrite(F);

    Writeln(F, Line);
  finally
    CloseFile(F);
  end;
end;

function StripOutInvalid(N: string): string;
var
  i: integer;
begin
  N := trim(N);
  Result := '';
  for i := 1 to length(N) do
    begin
      if CharInSet(N[i], ['0'..'9']) then
        Result := Result + N[i];
    end;
end;

function FormatPhoneUSA(Ph: string): string;
var
  i: integer;
  PhChars: string;
begin
  Ph := StripOutInvalid(Ph);
  Result := '';
  if Ph = '' then
    exit;

  Ph := StringOfChar(' ', 10 - Length(Ph)) + Ph;
  if Length(Ph) > 10 then
    Ph := Copy(Ph, Length(Ph) - 9, Length(Ph));
  for i := 10 Downto 1 do
    begin
      if i = 6 then
        PhChars := Ph[i] + '-'
      else if i = 3 then
        PhChars := Ph[i] + ') '
      else if i = 1 then
        PhChars := '(' + Ph[i]
      else
        PhChars := Ph[i];

      Result := PhChars + Result;
    end;
end;

function FormatFLDriverLic(FL_DRV_LIC: string): string;
begin
  Result := Copy(FL_DRV_LIC, 1, 4) + '-' +
            Copy(FL_DRV_LIC, 5, 3) + '-' +
            Copy(FL_DRV_LIC, 8, 2) + '-' +
            Copy(FL_DRV_LIC, 10, 3) + '-' +
            Copy(FL_DRV_LIC, 13, 1);
end;

function MaskCustomerID(const IDType, IDNumber: string): string;
begin
  if Length(IDNumber) > 4 then
    Result := Format('%s (ending %s)', [IDType, Copy(IDNumber, Length(IDNumber)-3, 4)])
  else
    Result := IDType;
end;

function GetRecNo(RecNo: integer): integer;
begin
  if RecNo <= 0 then
    Result := 1
  else
    Result := RecNo;
end;

procedure ConfigureUSDateFormat;
begin
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'mm/dd/yyyy';
  FormatSettings.LongDateFormat := 'mmmm d, yyyy';
end;

(*
procedure ParseFL_DL(const RawData: string; out FirstName, MiddleName, LastName,
                     Address, State, City, ZipCode, DOB, FLDrvLocNumber, Gender, PersonHeight: string);
var
  P: integer;
begin
  if (Length(RawData) < 150) {and (RawData[1] <> '%')} then
    exit;

  if RawData[1] <> '%' then
    exit;

  p := pos('^', RawData);
  State := UpperCase(Copy(RawData, 2, 2));
  City := UpperCase(Copy(RawData, 4, p - 4));
  Delete(RawData, 1, P);

  P := Pos('$', RawData);
  LastName := Copy(RawData, 1, P - 1);
  LastName := UpperCase(LastName);
  Delete(RawData, 1, P);

  P := Pos('$', RawData);
  FirstName := UpperCase(Copy(RawData, 1, P - 1));
  Delete(RawData, 1, P);

  P := Pos('^', RawData);
  MiddleName := UpperCase(Copy(RawData, 1, P - 1));
  Delete(RawData, 1, P);

  P := Pos('^', RawData);
  if P = 0 then
    P := Pos('?', RawData);

  Address := UpperCase(Copy(RawData, 1, P - 1));

  P := Pos(';', RawData);
  Delete(RawData, 1, P);

  P := Pos('=', RawData);
  FLDrvLocNumber := UpperCase(Copy(LastName, 1, 1) + Copy(RawData, 9, 11) + '0');
  Delete(RawData, 1, P);

  DOB := Copy(RawData, 3, 2) + '/' + Copy(RawData, 11, 2) + '/' + Copy(RawData, 5, 4);

  P := Pos('?#!', RawData);
  if P = 0 then
    P := Pos('?+!', RawData);

  Delete(RawData, 1, P+3);

  RawData := trim(RawData);

  ZipCode := Copy(RawData, 1, 5);
  Delete(RawData, 1, 20);

  RawData := trim(RawData);

  if Copy(RawData, 1, 1) = '1' then
    Gender := 'M'
  else
    Gender := 'F';

  PersonHeight := Copy(RawData, 2, 1) + '.' + Copy(RawData, 3, 2) ;

//  ModalResult := mrOk;

end;   *)

function SelectExportFolder(var FDir: string): boolean;
begin
  Result := false;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
      try
        Title := 'Select Directory';
        Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
        OkButtonLabel := 'Select';
        DefaultFolder := FDir;
        FileName := FDir;
        if Execute then
          begin
            FDir := IncludeTrailingPathDelimiter(FileName);
            Result := true;
          end;
      finally
        Free;
      end
  else
    if SelectDirectory('Select Directory', ExtractFileDrive(FDir), FDir, [sdNewUI, sdNewFolder]) then
      begin
        FDir := IncludeTrailingPathDelimiter(FDir);
        Result := true;
      end;
end;

function CombinePhones(const Separator: string; const PhonesArray: array of string): string;
var
  List: TArray<string>;
  Seen: TStringList;
  Raw, Formatted: string;
begin
  List := [];
  Seen := TStringList.Create;
  try
    Seen.Sorted := True;
    Seen.CaseSensitive := False;   // treat formatted duplicates equally
    Seen.Duplicates := dupIgnore;

    for Raw in PhonesArray do
    begin
      if Trim(Raw) = '' then
        Continue;

      Formatted := FormatPhoneUSA(Raw);  // already cleans/normalizes

      if Formatted = '' then
        Continue;

      if Seen.IndexOf(Formatted) = -1 then
      begin
        Seen.Add(Formatted);
        List := List + [Formatted];
      end;
    end;

    Result := String.Join(Separator, List);
  finally
    Seen.Free;
  end;
end;

procedure ReadCSVString(HeaderPresent: boolean; const ACSVString: string; var OneFldNamePerLine, OneFldPerLine: string);
var
  csvReader: TnvvCSVStringReader;
  i: Integer;
begin
  OneFldPerLine := '';
  OneFldNamePerLine := '';
  //Constructor can have parameter that, if >0 and <>512(default), sets buffer size in chars
  csvReader := TnvvCSVStringReader.Create;
  try
    csvReader.DataString := ACSVString; // Assign string containing CSV data
    // Modify values of other input properties if necessary. For example:
    csvReader.HeaderPresent := HeaderPresent;

    csvReader.Open;

    if (csvReader.HeaderPresent) then
      for i:=0 to csvReader.FieldCount-1 do
        OneFldNamePerLine := OneFldNamePerLine + csvReader.Fields[i].Name + ^M^J;

    while (not csvReader.Eof) do
    begin
      for i:=0 to csvReader.FieldCount-1 do
        OneFldPerLine := OneFldPerLine + csvReader.Fields[i].Value + ^M^J;

      csvReader.Next;
    end;
    csvReader.Close;
  finally
    csvReader.Free;
  end;
end;

procedure ReadCSVString_GetOneFieldData(HeaderPresent: boolean; const ACSVString: string; FieldNo: integer; var FldData: string);
var
  csvReader: TnvvCSVStringReader;
begin
  //Constructor can have parameter that, if >0 and <>512(default), sets buffer size in chars
  csvReader := TnvvCSVStringReader.Create;
  try
    csvReader.DataString := ACSVString; // Assign string containing CSV data
    // Modify values of other input properties if necessary. For example:
    csvReader.HeaderPresent := HeaderPresent;

    csvReader.Open;

    if FieldNo <= csvReader.FieldCount then
      FldData := csvReader.Fields[FieldNo-1].Value;

    csvReader.Close;
  finally
    csvReader.Free;
  end;
end;

function WorkAreaForControl(const C: TWinControl): TRect;
var
  mon: TMonitor;
  pt : TPoint;
begin
  pt  := C.ClientToScreen(Point(0, 0));
  mon := Screen.MonitorFromPoint(pt); // 10.2 has this
  if mon <> nil then
    Result := mon.WorkareaRect
  else
    Result := Screen.WorkAreaRect; // fallback (primary monitor)
end;

procedure CenterPopupOnControl(const Host: TWinControl; const Popup: TForm);
var
  rcClient: TRect;
  ptTopLeft: TPoint;
  L, T: Integer;
  wa: TRect;
begin
  rcClient := Host.ClientRect; // control coords
  ptTopLeft := Host.ClientToScreen(Point(rcClient.Left, rcClient.Top)); // to screen

  // center over the control
  L := ptTopLeft.X + (rcClient.Width  - Popup.Width)  div 2;
  T := ptTopLeft.Y + (rcClient.Height - Popup.Height) div 2;

  // clamp to the monitor work area (WinAPI path)
  wa := WorkAreaForControl(Host);
  if L < wa.Left then L := wa.Left;
  if T < wa.Top  then T := wa.Top;
  if L + Popup.Width  > wa.Right  then L := wa.Right  - Popup.Width;
  if T + Popup.Height > wa.Bottom then T := wa.Bottom - Popup.Height;

  Popup.Position := poDesigned; // use Left/Top you set
  Popup.Left := L;
  Popup.Top  := T;
end;

function GetPrinterBinNames(const APrinterName: string): TArray<string>;
const
  BIN_NAME_LEN = 24; // DC_BINNAMES: fixed 24-char blocks
var
  Device, Port: array[0..255] of Char;
  ProfileBuf: array[0..255] of Char;
  BinCount, I, J, StartIdx, LenProfile: Integer;
  NamesBuf: TArray<Char>;
  OneName: string;
  PrinterIdx: Integer;
  P: PChar;
begin
  Result := [];

  // Validate printer by name
  PrinterIdx := Printer.Printers.IndexOf(APrinterName);
  if PrinterIdx = -1 then
    Exit;

  // Optional: point TPrinter to that printer (not strictly required for DeviceCapabilities)
  Printer.PrinterIndex := PrinterIdx;

  // DeviceCapabilities expects:
  //   pDevice = printer name
  //   pPort   = printer port (LPT1:, Ne00:, USB001, etc.)
  // The port can be obtained from the [Devices] section in WIN.INI:
  //
  //   [Devices]
  //   "Canon Printer"="winspool,Ne00:"

  // Copy printer name to Device
  StrPLCopy(Device, APrinterName, Length(Device));

  // Get "driver,port" string into ProfileBuf
  LenProfile := GetProfileString('Devices', Device, '', ProfileBuf, SizeOf(ProfileBuf));
  if LenProfile = 0 then
    Exit; // no info → bail out

  // ProfileBuf format: 'winspool,Ne00:' → we want 'Ne00:'
  P := StrScan(ProfileBuf, ',');
  if P = nil then
    Exit;
  Inc(P); // move past the comma
  StrPLCopy(Port, P, Length(Port));

  // How many bins does this driver report?
  BinCount := DeviceCapabilities(Device, Port, DC_BINS, nil, nil);
  if BinCount <= 0 then
    Exit;

  // Fetch the bin NAMES (BinCount blocks of 24 chars)
  SetLength(NamesBuf, BinCount * BIN_NAME_LEN);
  if DeviceCapabilities(Device, Port, DC_BINNAMES, PChar(NamesBuf), nil) <> BinCount then
    Exit;

  SetLength(Result, BinCount);
  for I := 0 to BinCount - 1 do
  begin
    StartIdx := I * BIN_NAME_LEN;
    // DC_BINNAMES entries are fixed 24-char blocks and are NOT guaranteed to be
    // null-terminated. Read at most BIN_NAME_LEN chars, stopping at the first #0,
    // so a full-length name can't spill into the next block (or past the buffer
    // on the last bin) and corrupt the tray name.
    OneName := '';
    for J := StartIdx to StartIdx + BIN_NAME_LEN - 1 do
    begin
      if NamesBuf[J] = #0 then
        Break;
      OneName := OneName + NamesBuf[J];
    end;
    Result[I] := Trim(OneName);
  end;
end;

procedure FillPrinterTrays(ComboBox: TComboBox; const APrinterName: string);
var
  TrayNames: TArray<string>;
  TrayName: string;
begin
  ComboBox.Items.BeginUpdate;
  try
    ComboBox.Clear;
    TrayNames := GetPrinterBinNames(APrinterName);
    if Length(TrayNames) = 0 then
      ComboBox.Items.Add('(Default Tray)')
    else
      for TrayName in TrayNames do
        ComboBox.Items.Add(TrayName);
  finally
    ComboBox.Items.EndUpdate;
  end;
  ComboBox.ItemIndex := 0; // select first by default
end;

function GetPawnStatusColor(const AStatus: string): TPawnStatusColor;
var
  I: Integer;
begin
  for I := Low(PawnStatusColors) to High(PawnStatusColors) do
    if SameText(PawnStatusColors[I].Status, AStatus) then
      Exit(PawnStatusColors[I]);

  // Fallback
  Result.Status := AStatus;
  Result.BG := clWindow;
  Result.FG := clWindowText;
end;

procedure CalcTaxAndTotal(const Amount: Currency; const TaxPercent: Currency;
                          out Tax: Currency; out TotalAmount: Currency);
var
  TaxRate: Currency;
begin
  // Convert percent to fraction
  TaxRate := TaxPercent / 100.0;

  // Calculate tax and round to cents
  Tax := RoundTo(Amount * TaxRate, -2);

  // Total must always be Amount + Tax (never round total independently)
  TotalAmount := Amount + Tax;
end;


initialization
  IniAccessLock := TCriticalSection.Create;
  DefaultWeightMeasureUnit := '';
  AppPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  DatabaseFileName := 'PAWN.DB';
  GlobalIniFile := AppPath + IniFileName;
  ExceptionLogPath := AppPath + 'PawnProError.log';
  LocalIniFile := GetLocalUserAppDataFolder + IniFileName;
  ImagesStoragePath := ReadIniFile(IniSecImageStorage, IniKeyImageDirectory);

finalization
  { IniAccessLock is deliberately NOT freed.

    PawnGlobal uses Forms, so it initializes after Forms and therefore finalizes
    BEFORE it -- i.e. before Forms tears down Application and destroys the main
    form. Background workers (the image-backup audit writes the weekly marker on
    completion) can still call ReadIniFile/WriteIniFile in that window, and a
    freed critical section there is an access violation during shutdown: exactly
    the kind of windowless-ghost failure we are chasing. One critical section at
    process exit costs nothing; the OS reclaims it. }

end.
