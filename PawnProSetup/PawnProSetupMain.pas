unit PawnProSetupMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes,
  System.Classes, System.Hash, System.IniFiles, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton, Vcl.ExtCtrls;

type
  TPawnProFileInfo = record
    FileName: string;
    Overwrite: Boolean;
    SubFolder: string;  // relative to the install folder, e.g. 'plugins\'; '' = root
  end;

  // Current multi-workstation state as read back from the server's firebird.conf.
  // smUnknown = no local Firebird server (client PC, or Firebird not installed).
  TStationMode = (smUnknown, smSingle, smMultiple);

  TfrmPawnProSetupMain = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    MemoLog: TMemo;
    lblInstallFolder: TLabel;
    edInstallFolder: TEdit;
    btnBrowseInstallFolder: TRzToolbarButton;
    btnCopyPawnProFiles: TRzButton;
    btnTestConnection: TRzButton;
    btnEnterStoreInfo: TRzButton;
    lblHost: TLabel;
    lblDatabase: TLabel;
    lblPort: TLabel;
    lblCurrentPassword: TLabel;
    lblNewPassword: TLabel;
    edHost: TEdit;
    edPort: TEdit;
    edDatabase: TEdit;
    edCurrentPassword: TEdit;
    edNewPassword: TEdit;
    rgSngleInstallation: TRadioGroup;
    gbStationMng: TGroupBox;
    lblStationsStatus: TLabel;
    btnMultStationsEnableDisable: TButton;
    gbIsDBLocal: TGroupBox;
    rbIsDBLocalYES: TRadioButton;
    rbIsDBLocalNO: TRadioButton;
    lblIsDBLocal: TLabel;
    procedure btnBrowseInstallFolderClick(Sender: TObject);
    procedure btnCopyPawnProFilesClick(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
    procedure btnEnterStoreInfoClick(Sender: TObject);
    procedure btnMultStationsEnableDisableClick(Sender: TObject);
    procedure IsDBLocalSelectionChanged(Sender: TObject);
    procedure edInstallFolderChange(Sender: TObject);
    procedure edDatabaseChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FUpdatingDatabasePath: Boolean;
    FDatabasePathFollowsInstallFolder: Boolean;
    procedure Log(const Msg: string);
    function SourceFolder: string;
    function TargetFolder: string;
    function DefaultDatabasePath: string;
    function IniPath: string;
    function DatabasePath: string;
    function ConnectDatabase: string;
    function ImagesFolder: string;
    procedure CreateImagesFolder;
    function Port: Integer;
    procedure SyncDatabasePathWithInstallFolder;
    function FilesAreSame(const FileName1, FileName2: string): Boolean;
    procedure CopyPawnProFile(const SrcFolder, TargetFolder: string;
      const FileInfo: TPawnProFileInfo);
    procedure CopyPawnProFiles(const SrcFolder, TargetFolder: string);
    procedure CopyFbClientCryptoFiles(const SrcFolder, TargetFolder: string);
    procedure CopyDatabaseFile(const SrcFolder: string);
    procedure CreateDefaultPawnProIni(const TargetFolder: string);
    procedure WriteCommonIniDefaults(Ini: TIniFile);
    procedure WriteEncryptedConnectionIni(const TargetFolder, Password: string);
    function IsSingleWorkstationInstall: Boolean;
    function IsDatabaseLocal: Boolean;
    function IsDBLocalSelected: Boolean;
    function ValidateDBLocalSelected: Boolean;
    procedure UpdateStepButtonsEnabled;
    function FindFirebirdConfPath: string;
    function FindFirebirdDatabasesConfPath: string;
    procedure SetFirebirdDatabaseAlias;
    procedure SetFirebirdRemoteAccess(AllowRemoteAccess: Boolean);
    procedure UpdateFirebirdRemoteAccessFromSelection;
    function GetStationMode: TStationMode;
    procedure RefreshStationStatus;
    procedure FormatIniSectionSpacing(const IniPath: string);
  public
    { Public declarations }
  end;

var
  frmPawnProSetupMain: TfrmPawnProSetupMain;

implementation

{$R *.dfm}

uses PawnProSetupDM, DPAPIUtils;

const
  PAWNPRO_DB_ALIAS = 'PAWNDATA';

  // PAWNDATA.FDB is intentionally NOT here -- it is handled by CopyDatabaseFile,
  // which copies it to the aliased database path (DatabasePath) and only for a
  // local-DB install. A client/workstation must not receive a local copy.

  PAWNPRO_FILES: array[0..2] of TPawnProFileInfo = (
    (FileName: 'fbclient.dll';   Overwrite: True; SubFolder: ''),
    (FileName: 'PawnProFB.exe';  Overwrite: True; SubFolder: ''),
    // libsodium.dll is a load-time dependency of PawnProFB.exe (backup
    // encryption); the app will not start without it next to the EXE.
    (FileName: 'libsodium.dll';  Overwrite: True; SubFolder: '')
  );

  // Firebird wire-encryption client files (folds in CopyFbClientCrypto.bat) so a
  // workstation can satisfy the server's WireCrypt=Required on remote connects.
  // chacha.dll must land in plugins\ next to fbclient.dll; plugins.conf maps the
  // ChaCha64 plugin name to it; firebird.msg gives readable server error text.
  FBCRYPTO_FILES: array[0..2] of TPawnProFileInfo = (
    (FileName: 'chacha.dll';   Overwrite: True; SubFolder: 'plugins\'),
    (FileName: 'plugins.conf'; Overwrite: True; SubFolder: ''),
    (FileName: 'firebird.msg'; Overwrite: True; SubFolder: '')
  );

procedure TfrmPawnProSetupMain.FormCreate(Sender: TObject);
begin
  FDatabasePathFollowsInstallFolder := True;
  SyncDatabasePathWithInstallFolder;
  RefreshStationStatus;
  UpdateStepButtonsEnabled;
end;

procedure TfrmPawnProSetupMain.btnBrowseInstallFolderClick(Sender: TObject);
var
  Dlg: TFileOpenDialog;
begin
  Dlg := TFileOpenDialog.Create(Self);
  try
    Dlg.Title := 'Choose install folder';
    Dlg.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    if Trim(edInstallFolder.Text) <> '' then
      Dlg.DefaultFolder := edInstallFolder.Text;
    if Dlg.Execute then
      edInstallFolder.Text := IncludeTrailingPathDelimiter(Dlg.FileName);
  finally
    Dlg.Free;
  end;

end;

procedure TfrmPawnProSetupMain.edInstallFolderChange(Sender: TObject);
begin
  SyncDatabasePathWithInstallFolder;
end;

procedure TfrmPawnProSetupMain.edDatabaseChange(Sender: TObject);
begin
  if not FUpdatingDatabasePath then
    FDatabasePathFollowsInstallFolder := SameText(Trim(edDatabase.Text), DefaultDatabasePath);
end;

procedure TfrmPawnProSetupMain.Log(const Msg: string);
begin
  MemoLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + Msg);
  Application.ProcessMessages;
end;

function TfrmPawnProSetupMain.SourceFolder: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

function TfrmPawnProSetupMain.TargetFolder: string;
begin
  Result := IncludeTrailingPathDelimiter(Trim(edInstallFolder.Text));
end;

function TfrmPawnProSetupMain.DefaultDatabasePath: string;
begin
  if Trim(edInstallFolder.Text) = '' then
    Result := ''
  else
    Result := TargetFolder + 'PAWNDATA.FDB';
end;

function TfrmPawnProSetupMain.IniPath: string;
begin
  Result := TargetFolder + 'PawnPro.ini';
end;

function TfrmPawnProSetupMain.DatabasePath: string;
begin
  Result := Trim(edDatabase.Text);
  if Result = '' then
    Result := DefaultDatabasePath;
end;

function TfrmPawnProSetupMain.ConnectDatabase: string;
// The database identifier to hand FireDAC for a live connection. On the DB-host
// machine that is the real local .FDB path. On a client/workstation the .FDB is
// remote, so we must connect via the PAWNDATA alias (resolved on the server's
// databases.conf) -- a client-local path would be interpreted server-side and
// fail. This mirrors what the generated PawnPro.ini stores (database=PAWNDATA).
begin
  if IsDatabaseLocal then
    Result := DatabasePath
  else
    Result := PAWNPRO_DB_ALIAS;
end;

function TfrmPawnProSetupMain.ImagesFolder: string;
// Default on-disk image store for a host/local install: <InstallFolder>\PawnImages.
// Seeded into [IMAGE_STORAGE] ImageDirectory so a fresh install has a working
// FILE image path out of the box (the admin can relocate it later in the app).
begin
  Result := TargetFolder + 'PawnImages';
end;

procedure TfrmPawnProSetupMain.CreateImagesFolder;
var
  Folder: string;
begin
  // Only the DB host stores images locally; a client points at the host's shared
  // image path, so it gets no local PawnImages folder.
  if not IsDatabaseLocal then
    Exit;

  Folder := ImagesFolder;
  if DirectoryExists(Folder) then
  begin
    Log('Images folder already exists: ' + Folder);
    Exit;
  end;

  if ForceDirectories(Folder) then
    Log('Created images folder: ' + Folder)
  else
    Log('WARNING: could not create images folder: ' + Folder);
end;

function TfrmPawnProSetupMain.Port: Integer;
begin
  Result := StrToIntDef(Trim(edPort.Text), 3050);
end;

procedure TfrmPawnProSetupMain.SyncDatabasePathWithInstallFolder;
var
  NewDatabasePath: string;
begin
  if not FDatabasePathFollowsInstallFolder then
    Exit;

  NewDatabasePath := DefaultDatabasePath;
  if NewDatabasePath = '' then
    Exit;

  if SameText(Trim(edDatabase.Text), NewDatabasePath) then
    Exit;

  FUpdatingDatabasePath := True;
  try
    edDatabase.Text := NewDatabasePath;
  finally
    FUpdatingDatabasePath := False;
  end;
end;

function TfrmPawnProSetupMain.FilesAreSame(const FileName1, FileName2: string): Boolean;
var
  Hash1, Hash2: string;
begin
  Result := False;

  if not FileExists(FileName1) or not FileExists(FileName2) then
    Exit;

  Hash1 := THashSHA2.GetHashStringFromFile(FileName1);
  Hash2 := THashSHA2.GetHashStringFromFile(FileName2);
  Result := SameText(Hash1, Hash2);
end;

procedure TfrmPawnProSetupMain.CopyPawnProFile(const SrcFolder, TargetFolder: string;
  const FileInfo: TPawnProFileInfo);
var
  SourceFile, TargetFile, FileName, RelName, TargetSubDir: string;
begin
  FileName := FileInfo.FileName;
  RelName := FileInfo.SubFolder + FileName;
  SourceFile := SrcFolder + RelName;
  TargetFile := TargetFolder + RelName;

  if not FileExists(SourceFile) then
    raise Exception.CreateFmt('Source file is missing: %s', [SourceFile]);

  TargetSubDir := ExtractFilePath(TargetFile);
  if (TargetSubDir <> '') and not DirectoryExists(TargetSubDir) then
    if not ForceDirectories(TargetSubDir) then
      raise Exception.CreateFmt('Could not create target folder: %s', [TargetSubDir]);

  if FileExists(TargetFile) then
  begin
    if not FileInfo.Overwrite then
    begin
      Log(RelName + ' already exists. Skipped because overwrite is disabled.');
      Exit;
    end;

    if FilesAreSame(SourceFile, TargetFile) then
    begin
      Log(RelName + ' is already current. Skipped.');
      Exit;
    end;

    Log(RelName + ' is different. Replacing target file.');
  end
  else
    Log(RelName + ' is missing. Copying file.');

  if not CopyFile(PChar(SourceFile), PChar(TargetFile), False) then
    raise Exception.CreateFmt('Copy failed for %s. Windows error: %d',
      [RelName, GetLastError]);

  Log(RelName + ' copied.');
end;

procedure TfrmPawnProSetupMain.CopyPawnProFiles(const SrcFolder, TargetFolder: string);
var
  I: Integer;
begin
  Log('Copying PawnPro files from ' + SrcFolder + ' to ' + TargetFolder);

  for I := Low(PAWNPRO_FILES) to High(PAWNPRO_FILES) do
    CopyPawnProFile(SrcFolder, TargetFolder, PAWNPRO_FILES[I]);

  Log('Finished copying PawnPro files.');
end;

procedure TfrmPawnProSetupMain.CopyFbClientCryptoFiles(const SrcFolder, TargetFolder: string);
var
  I: Integer;
begin
  Log('Copying Firebird wire-encryption client files (ChaCha)...');

  for I := Low(FBCRYPTO_FILES) to High(FBCRYPTO_FILES) do
    CopyPawnProFile(SrcFolder, TargetFolder, FBCRYPTO_FILES[I]);

  Log('Finished copying Firebird wire-encryption client files.');
end;

procedure TfrmPawnProSetupMain.CopyDatabaseFile(const SrcFolder: string);
// Copies the seed PAWNDATA.FDB to the aliased database path (DatabasePath), not
// the install folder, so the file actually lives where the alias/connection
// points. Skipped for non-local installs -- a client uses the server's DB.
var
  SourceFile, TargetFile, TargetDir: string;
begin
  if not IsDatabaseLocal then
  begin
    Log('Database is not local to this machine. Skipping PAWNDATA.FDB copy.');
    Exit;
  end;

  SourceFile := SrcFolder + 'PAWNDATA.FDB';
  TargetFile := DatabasePath;

  if not FileExists(SourceFile) then
    raise Exception.CreateFmt('Source file is missing: %s', [SourceFile]);

  TargetDir := ExtractFilePath(TargetFile);
  if (TargetDir <> '') and not DirectoryExists(TargetDir) then
    if not ForceDirectories(TargetDir) then
      raise Exception.CreateFmt('Could not create database folder: %s', [TargetDir]);

  if FileExists(TargetFile) then
  begin
    Log('Database already exists at ' + TargetFile + '. Skipped (will not overwrite).');
    Exit;
  end;

  // bFailIfExists = True: never clobber an existing database.
  if not CopyFile(PChar(SourceFile), PChar(TargetFile), True) then
    raise Exception.CreateFmt('Database copy failed for %s. Windows error: %d',
      [TargetFile, GetLastError]);

  Log('Database copied to ' + TargetFile);
end;

procedure EnsureIniKey(Ini: TIniFile; const Section, Key, Value: string);
begin
  if not Ini.ValueExists(Section, Key) then
    Ini.WriteString(Section, Key, Value);
end;

procedure TfrmPawnProSetupMain.WriteCommonIniDefaults(Ini: TIniFile);
var
  IsLocalValue: string;
begin
  if IsDatabaseLocal then
    IsLocalValue := 'Y'
  else
    IsLocalValue := 'N';

  EnsureIniKey(Ini, 'PRINTERS', 'POLICEREP', '');
  EnsureIniKey(Ini, 'PRINTERS', 'POLICEREPBIN', '');
  EnsureIniKey(Ini, 'PRINTERS', 'PAYRECEIPTPRN', '');
  EnsureIniKey(Ini, 'PRINTERS', 'PAYRECEIPTPRNBIN', '');
  EnsureIniKey(Ini, 'PRINTERS', 'UsePaymentReceiptPrinter', 'N');
  EnsureIniKey(Ini, 'PRINTERS', 'UseEnvelopeLabelPrinter', 'N');
  EnsureIniKey(Ini, 'PRINTERS', 'EnvelopeLabelPrinterName', '');

  EnsureIniKey(Ini, 'LEADS_ONLINE', 'CSVPath', '');

  // Seed a working image folder so a fresh host install doesn't start with an
  // empty ImageDirectory. Only for local/host installs -- a client uses the
  // host's shared image path. EnsureIniKey won't clobber an existing value.
  if IsDatabaseLocal then
    EnsureIniKey(Ini, 'IMAGE_STORAGE', 'ImageDirectory', ImagesFolder)
  else
    EnsureIniKey(Ini, 'IMAGE_STORAGE', 'ImageDirectory', '');
  // DB image storage is retired in the Firebird version; default to FILE.
  EnsureIniKey(Ini, 'IMAGE_STORAGE', 'StorageMode', 'FILE');

  Ini.WriteString('DATABASE', 'IsLocalDatabase', IsLocalValue);

  EnsureIniKey(Ini, 'IMAGE_BACKUP', 'LastBackupDate', '');
  EnsureIniKey(Ini, 'IMAGE_BACKUP', 'LastAuditWeek', '');

  EnsureIniKey(Ini, 'GOLD_PRICE', 'Url',
    'https://query1.finance.yahoo.com/v8/finance/chart/GC=F?interval=1m&range=1d');

  EnsureIniKey(Ini, 'SETTINGS', 'SHOWGOLDPRICE', 'Y');
end;

procedure TfrmPawnProSetupMain.CreateDefaultPawnProIni(const TargetFolder: string);
var
  IniPath: string;
  Ini: TIniFile;
begin
  IniPath := IncludeTrailingPathDelimiter(TargetFolder) + 'PawnPro.ini';

  if FileExists(IniPath) then
  begin
    Log('PawnPro.ini already exists. Verifying required default keys.');
    Ini := TIniFile.Create(IniPath);
    try
      WriteCommonIniDefaults(Ini);
    finally
      Ini.Free;
    end;
    FormatIniSectionSpacing(IniPath);
    Exit;
  end;

  Log('Creating PawnPro.ini: ' + IniPath);

  Ini := TIniFile.Create(IniPath);
  try
    Ini.WriteString('CONNECTION_FB', 'host', Trim(edHost.Text));
    // Connect via the PAWNDATA alias (registered in databases.conf), not a raw
    // path, so the ini is identical on the host and every workstation.
    Ini.WriteString('CONNECTION_FB', 'database', PAWNPRO_DB_ALIAS);
    Ini.WriteString('CONNECTION_FB', 'user', 'sysdba');
    Ini.WriteString('CONNECTION_FB', 'port', IntToStr(Port));
    Ini.WriteString('CONNECTION_FB', 'charset', 'UTF8');

    WriteCommonIniDefaults(Ini);
  finally
    Ini.Free;
  end;

  FormatIniSectionSpacing(IniPath);
  Log('PawnPro.ini created.');
end;

procedure TfrmPawnProSetupMain.WriteEncryptedConnectionIni(const TargetFolder, Password: string);
var
  LocalIniPath: string;
  Ini: TIniFile;
begin
  LocalIniPath := IncludeTrailingPathDelimiter(TargetFolder) + 'PawnPro.ini';

  if not FileExists(LocalIniPath) then
    CreateDefaultPawnProIni(TargetFolder);

  Log('Writing encrypted Firebird password to PawnPro.ini...');
  Ini := TIniFile.Create(LocalIniPath);
  try
    Ini.WriteString('CONNECTION_FB', 'host', Trim(edHost.Text));
    Ini.WriteString('CONNECTION_FB', 'database', PAWNPRO_DB_ALIAS);
    Ini.WriteString('CONNECTION_FB', 'user', 'sysdba');
    Ini.WriteString('CONNECTION_FB', 'password_enc', DPAPIProtect(Password));
    Ini.DeleteKey('CONNECTION_FB', 'password');
    Ini.WriteString('CONNECTION_FB', 'port', IntToStr(Port));
    Ini.WriteString('CONNECTION_FB', 'charset', 'UTF8');
    WriteCommonIniDefaults(Ini);
  finally
    Ini.Free;
  end;

  FormatIniSectionSpacing(LocalIniPath);
  Log('PawnPro.ini updated. Plain password key removed.');
end;

function TfrmPawnProSetupMain.IsSingleWorkstationInstall: Boolean;
begin
  Result := rgSngleInstallation.ItemIndex = 0;
end;

function TfrmPawnProSetupMain.IsDatabaseLocal: Boolean;
// "Is the database local to this machine?" -- Yes = DB host, No = client/workstation.
// The gbIsDBLocal radios default to neither checked, so callers must gate on
// ValidateDBLocalSelected first; this only reports which one is chosen.
begin
  Result := rbIsDBLocalYES.Checked;
end;

function TfrmPawnProSetupMain.IsDBLocalSelected: Boolean;
begin
  Result := rbIsDBLocalYES.Checked or rbIsDBLocalNO.Checked;
end;

function TfrmPawnProSetupMain.ValidateDBLocalSelected: Boolean;
// Guard shared by installation steps 1/2/3. The DB-local answer drives whether we
// copy a local database, edit the server config, and rotate the SYSDBA password,
// so nothing may run until the operator has explicitly answered Yes or No.
begin
  Result := IsDBLocalSelected;
  if not Result then
  begin
    Log('ERROR: Please answer "Is Database Local?" (Yes or No) before continuing.');
    MessageDlg('Please select whether the database is local to this machine ' +
      '(Yes or No) before running the installation steps.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmPawnProSetupMain.UpdateStepButtonsEnabled;
// Steps 1/2/3 stay disabled until the operator answers "Is Database Local?" so
// the DB-local branching can never run on an unset value. The runtime guard in
// each handler (ValidateDBLocalSelected) still stands as a second line.
var
  Selected: Boolean;
begin
  Selected := IsDBLocalSelected;
  btnCopyPawnProFiles.Enabled := Selected;
  btnEnterStoreInfo.Enabled := Selected;
  btnTestConnection.Enabled := Selected;
end;

procedure TfrmPawnProSetupMain.IsDBLocalSelectionChanged(Sender: TObject);
begin
  UpdateStepButtonsEnabled;
end;

function FirstExistingFile(const FileNames: array of string): string;
var
  I: Integer;
begin
  Result := '';
  for I := Low(FileNames) to High(FileNames) do
  begin
    if (Trim(FileNames[I]) <> '') and FileExists(FileNames[I]) then
      Exit(FileNames[I]);
  end;
end;

function TfrmPawnProSetupMain.FindFirebirdConfPath: string;
var
  ProgramFiles64, ProgramFiles: string;
begin
  ProgramFiles64 := GetEnvironmentVariable('ProgramW6432');
  ProgramFiles := GetEnvironmentVariable('ProgramFiles');
  if ProgramFiles64 <> '' then
    ProgramFiles64 := IncludeTrailingPathDelimiter(ProgramFiles64);
  if ProgramFiles <> '' then
    ProgramFiles := IncludeTrailingPathDelimiter(ProgramFiles);

  // Only the real Firebird install is edited; a copy in the setup source folder
  // would never be read by the running server, so it is intentionally not searched.
  Result := FirstExistingFile([
    ProgramFiles64 + 'Firebird\Firebird_5_0\firebird.conf',
    ProgramFiles + 'Firebird\Firebird_5_0\firebird.conf'
  ]);
end;

function TfrmPawnProSetupMain.FindFirebirdDatabasesConfPath: string;
var
  FirebirdConfPath: string;
  ProgramFiles64, ProgramFiles: string;
begin
  FirebirdConfPath := FindFirebirdConfPath;
  if (FirebirdConfPath <> '') and FileExists(ExtractFilePath(FirebirdConfPath) + 'databases.conf') then
    Exit(ExtractFilePath(FirebirdConfPath) + 'databases.conf');

  ProgramFiles64 := GetEnvironmentVariable('ProgramW6432');
  ProgramFiles := GetEnvironmentVariable('ProgramFiles');
  if ProgramFiles64 <> '' then
    ProgramFiles64 := IncludeTrailingPathDelimiter(ProgramFiles64);
  if ProgramFiles <> '' then
    ProgramFiles := IncludeTrailingPathDelimiter(ProgramFiles);

  // As with firebird.conf, only the real Firebird install is searched.
  Result := FirstExistingFile([
    ProgramFiles64 + 'Firebird\Firebird_5_0\databases.conf',
    ProgramFiles + 'Firebird\Firebird_5_0\databases.conf'
  ]);
end;

procedure TfrmPawnProSetupMain.SetFirebirdDatabaseAlias;
var
  ConfPath, AliasLine, Line, Trimmed: string;
  Lines: TStringList;
  I: Integer;
  Found: Boolean;

  function IsAliasLine(const S: string): Boolean;
  var
    T: string;
  begin
    T := Trim(S);
    if (T <> '') and (T[1] = '#') then
      T := Trim(Copy(T, 2, MaxInt));

    Result :=
      SameText(Copy(T, 1, Length(PAWNPRO_DB_ALIAS)), PAWNPRO_DB_ALIAS) and
      ((Length(T) = Length(PAWNPRO_DB_ALIAS)) or
       CharInSet(T[Length(PAWNPRO_DB_ALIAS) + 1], [' ', #9, '=']));
  end;

begin
  ConfPath := FindFirebirdDatabasesConfPath;
  if ConfPath = '' then
    raise Exception.Create(
      'databases.conf was not found. Expected Firebird 5 x64 path: ' +
      'C:\Program Files\Firebird\Firebird_5_0\databases.conf');

  AliasLine := PAWNPRO_DB_ALIAS + ' = ' + DatabasePath;

  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(ConfPath);
    Found := False;

    for I := 0 to Lines.Count - 1 do
    begin
      Line := Lines[I];
      Trimmed := Trim(Line);

      if IsAliasLine(Trimmed) then
      begin
        if not Found then
        begin
          Lines[I] := AliasLine;
          Found := True;
        end
        else if (Trimmed <> '') and (Trimmed[1] <> '#') then
          Lines[I] := '# Duplicate ' + PAWNPRO_DB_ALIAS + ' alias disabled by PawnProSetup: ' + Trimmed;
      end;
    end;

    if not Found then
    begin
      Lines.Add('');
      Lines.Add('# Set by PawnProSetup.');
      Lines.Add(AliasLine);
    end;

    Lines.SaveToFile(ConfPath);
  finally
    Lines.Free;
  end;

  Log('Updated Firebird database alias in ' + ConfPath + ': ' + AliasLine);
end;

procedure TfrmPawnProSetupMain.SetFirebirdRemoteAccess(AllowRemoteAccess: Boolean);
// Standalone lockdown is done via RemoteBindAddress, NOT RemoteAccess. Firebird
// treats every TCP/IP connection -- including localhost -- as "remote", so
// RemoteAccess=false would also reject PawnPro's own localhost:3050 connection.
// RemoteBindAddress=localhost binds the listener to loopback only: other machines
// on the LAN cannot reach the server, but the local app still connects over TCP.
var
  ConfPath, Trimmed: string;
  Lines: TStringList;
  I: Integer;
  Found: Boolean;

  function IsBindLine(const S: string): Boolean;
  var
    T: string;
  begin
    T := Trim(S);
    if (T <> '') and (T[1] = '#') then
      T := Trim(Copy(T, 2, MaxInt));

    Result :=
      SameText(Copy(T, 1, Length('RemoteBindAddress')), 'RemoteBindAddress') and
      ((Length(T) = Length('RemoteBindAddress')) or
       CharInSet(T[Length('RemoteBindAddress') + 1], [' ', #9, '=']));
  end;

begin
  ConfPath := FindFirebirdConfPath;
  if ConfPath = '' then
  begin
    Log('WARNING: firebird.conf was not found. RemoteBindAddress was not changed.');
    Log('Expected Firebird 5 x64 path: C:\Program Files\Firebird\Firebird_5_0\firebird.conf');
    Exit;
  end;

  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(ConfPath);
    Found := False;

    for I := 0 to Lines.Count - 1 do
    begin
      Trimmed := Trim(Lines[I]);
      if not IsBindLine(Trimmed) then
        Continue;

      if AllowRemoteAccess then
      begin
        // Multi-workstation: disable any active bind restriction so the server
        // listens on all interfaces (Firebird's default when unset).
        if (Trimmed <> '') and (Trimmed[1] <> '#') then
          Lines[I] := '# Disabled by PawnProSetup (listen on all interfaces): ' + Trimmed;
      end
      else
      begin
        // Standalone: restrict the listener to loopback only.
        if not Found then
        begin
          Lines[I] := 'RemoteBindAddress = localhost';
          Found := True;
        end
        else if (Trimmed <> '') and (Trimmed[1] <> '#') then
          Lines[I] := '# Duplicate RemoteBindAddress disabled by PawnProSetup: ' + Trimmed;
      end;
    end;

    if (not AllowRemoteAccess) and (not Found) then
    begin
      Lines.Add('');
      Lines.Add('# Set by PawnProSetup (standalone store: loopback only).');
      Lines.Add('RemoteBindAddress = localhost');
    end;

    Lines.SaveToFile(ConfPath);
  finally
    Lines.Free;
  end;

  if AllowRemoteAccess then
    Log('Updated Firebird in ' + ConfPath + ': RemoteBindAddress cleared (listen on all interfaces).')
  else
    Log('Updated Firebird in ' + ConfPath + ': RemoteBindAddress = localhost (loopback only).');
  Log('Restart the Firebird Server service for this setting to take effect.');
end;

procedure TfrmPawnProSetupMain.UpdateFirebirdRemoteAccessFromSelection;
begin
  // RemoteBindAddress lives in the server's firebird.conf and is a server-only
  // setting. A client/workstation has no local Firebird server to configure, so
  // skip it there (avoids a misleading "firebird.conf not found" warning).
  if not IsDatabaseLocal then
  begin
    Log('Client/workstation install: RemoteBindAddress is a server setting; skipping.');
    Exit;
  end;

  if rgSngleInstallation.ItemIndex < 0 then
  begin
    Log('WARNING: Single/multiple workstation installation was not selected. Firebird RemoteBindAddress was not changed.');
    Exit;
  end;

  SetFirebirdRemoteAccess(not IsSingleWorkstationInstall);
end;

function TfrmPawnProSetupMain.GetStationMode: TStationMode;
// Reads the CURRENT multi-workstation state straight from the server's
// firebird.conf so the UI reflects reality, not the radio-group selection.
// An active "RemoteBindAddress = localhost/127.0.0.1/::1" line means the
// listener is bound to loopback => Single. No active bind restriction (line
// absent or commented, or bound to an external address) => Multiple. No local
// firebird.conf => Unknown (this is a client PC or Firebird is not installed).
var
  ConfPath, T, Value: string;
  Lines: TStringList;
  I, P: Integer;
begin
  Result := smUnknown;
  ConfPath := FindFirebirdConfPath;
  if ConfPath = '' then
    Exit;

  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(ConfPath);
    // Firebird's default when RemoteBindAddress is unset is to listen on all
    // interfaces, so absence of an active bind line means Multiple.
    Result := smMultiple;

    for I := 0 to Lines.Count - 1 do
    begin
      T := Trim(Lines[I]);
      if (T = '') or (T[1] = '#') then
        Continue;
      if not SameText(Copy(T, 1, Length('RemoteBindAddress')), 'RemoteBindAddress') then
        Continue;
      if not ((Length(T) = Length('RemoteBindAddress')) or
              CharInSet(T[Length('RemoteBindAddress') + 1], [' ', #9, '='])) then
        Continue;

      P := Pos('=', T);
      if P = 0 then
        Continue;

      Value := LowerCase(Trim(Copy(T, P + 1, MaxInt)));
      // SetFirebirdRemoteAccess keeps at most one active bind line, but if a
      // hand-edited file has several the last active one wins (matches Firebird).
      if (Value = 'localhost') or (Value = '127.0.0.1') or (Value = '::1') then
        Result := smSingle
      else if Value <> '' then
        Result := smMultiple;
    end;
  finally
    Lines.Free;
  end;
end;

procedure TfrmPawnProSetupMain.RefreshStationStatus;
// Syncs the standalone gbStationMng controls (status label + toggle button) with
// the live firebird.conf state. Called at startup and after every toggle.
begin
  case GetStationMode of
    smSingle:
      begin
        lblStationsStatus.Caption := 'Current: SINGLE workstation (loopback only)';
        btnMultStationsEnableDisable.Caption := 'Enable Multiple Workstations';
        btnMultStationsEnableDisable.Enabled := True;
      end;
    smMultiple:
      begin
        lblStationsStatus.Caption := 'Current: MULTIPLE workstations (all interfaces)';
        btnMultStationsEnableDisable.Caption := 'Disable (Single Workstation)';
        btnMultStationsEnableDisable.Enabled := True;
      end;
  else
    lblStationsStatus.Caption := 'No local Firebird server on this PC (client install)';
    btnMultStationsEnableDisable.Caption := 'Enable Multiple Workstations';
    btnMultStationsEnableDisable.Enabled := False;
  end;
end;

procedure TfrmPawnProSetupMain.btnMultStationsEnableDisableClick(Sender: TObject);
// Standalone enable/disable of multiple workstations. Touches ONLY the server's
// firebird.conf RemoteBindAddress -- no binaries, no database, no PawnPro.ini,
// no SYSDBA password -- so it is safe to run against a good working setup.
var
  Mode: TStationMode;
  EnableMultiple: Boolean;
  Prompt: string;
begin
  Mode := GetStationMode;
  if Mode = smUnknown then
  begin
    Log('ERROR: Firebird 5 server (firebird.conf) was not found on this machine.');
    Log('The multiple-workstation setting only applies to the DB-host PC.');
    Exit;
  end;

  EnableMultiple := (Mode = smSingle);  // toggle to the opposite of the current state

  if EnableMultiple then
    Prompt := 'Enable MULTIPLE workstations?' + sLineBreak + sLineBreak +
      'The Firebird server will listen on all network interfaces so other PCs ' +
      'on the LAN can connect to this database.'
  else
    Prompt := 'Switch to a SINGLE workstation?' + sLineBreak + sLineBreak +
      'The Firebird server will listen on loopback only. Other PCs on the LAN ' +
      'will no longer be able to connect to this database.';

  if MessageDlg(Prompt, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    // AllowRemoteAccess = True enables multiple workstations (clears the loopback
    // bind); False restricts to loopback for a single workstation.
    SetFirebirdRemoteAccess(EnableMultiple);

    if EnableMultiple then
    begin
      Log('Multiple workstations ENABLED.');
      Log('Reminder: open TCP port ' + IntToStr(Port) + ' in Windows Firewall, and ' +
        'confirm the PAWNDATA alias exists in databases.conf so workstations resolve it.');
    end
    else
      Log('Multiple workstations DISABLED (single workstation, loopback only).');
  except
    on E: Exception do
      Log('ERROR: ' + E.Message);
  end;

  RefreshStationStatus;
end;

procedure TfrmPawnProSetupMain.FormatIniSectionSpacing(const IniPath: string);
var
  Lines, Formatted: TStringList;
  I: Integer;
  Line: string;
begin
  Lines := TStringList.Create;
  try
    Formatted := TStringList.Create;
    try
      Lines.LoadFromFile(IniPath);

      for I := 0 to Lines.Count - 1 do
      begin
        Line := Lines[I];
        if (I > 0) and (Line <> '') and (Line[1] = '[') then
        begin
          if (Formatted.Count > 0) and (Formatted[Formatted.Count - 1] <> '') then
            Formatted.Add('');
        end;
        Formatted.Add(Line);
      end;

      Formatted.SaveToFile(IniPath);
    finally
      Formatted.Free;
    end;
  finally
    Lines.Free;
  end;
end;

procedure TfrmPawnProSetupMain.btnCopyPawnProFilesClick(Sender: TObject);
var
  SrcFolder, InstallFolder: string;
begin
  SrcFolder := SourceFolder;
  InstallFolder := TargetFolder;

  if not ValidateDBLocalSelected then
    Exit;

  if Trim(edInstallFolder.Text) = '' then
  begin
    Log('ERROR: Please enter the target install folder.');
    Exit;
  end;

  try
    Log('Setup executable: ' + ParamStr(0));
    Log('Using setup source folder: ' + SrcFolder);

    if not DirectoryExists(InstallFolder) then
    begin
      Log('Creating target folder: ' + InstallFolder);
      if not ForceDirectories(InstallFolder) then
        raise Exception.CreateFmt('Could not create target folder: %s', [InstallFolder]);
    end;

    if Trim(edDatabase.Text) = '' then
      edDatabase.Text := InstallFolder + 'PAWNDATA.FDB';

    CopyPawnProFiles(SrcFolder, InstallFolder);
    CopyFbClientCryptoFiles(SrcFolder, InstallFolder);
    CopyDatabaseFile(SrcFolder);
    CreateImagesFolder;
    CreateDefaultPawnProIni(InstallFolder);
  except
    on E: Exception do
    begin
      Log('ERROR: ' + E.Message);
    end;
  end;

end;

procedure TfrmPawnProSetupMain.btnTestConnectionClick(Sender: TObject);
var
  ErrorMsg: string;
  StatesCount: Integer;
begin
  if not ValidateDBLocalSelected then
    Exit;

  if Trim(edInstallFolder.Text) = '' then
  begin
    Log('ERROR: Please enter the target install folder.');
    Exit;
  end;

  Log('Testing database connection using encrypted PawnPro.ini: ' + IniPath);

  if DM.TestConnectionFromIni(IniPath, StatesCount, ErrorMsg) then
    Log(Format('Connection OK. STATES count: %d', [StatesCount]))
  else
    Log('ERROR: Connection test failed. ' + ErrorMsg);
end;

procedure TfrmPawnProSetupMain.btnEnterStoreInfoClick(Sender: TObject);
var
  ErrorMsg: string;
  StatesCount: Integer;
begin
  if not ValidateDBLocalSelected then
    Exit;

  if Trim(edInstallFolder.Text) = '' then
  begin
    Log('ERROR: Please enter the target install folder.');
    Exit;
  end;

  if Trim(edHost.Text) = '' then
  begin
    Log('ERROR: Please enter the Firebird server.');
    Exit;
  end;

  if DatabasePath = '' then
  begin
    Log('ERROR: Please enter the database path.');
    Exit;
  end;

  if edCurrentPassword.Text = '' then
  begin
    Log('ERROR: Please enter the current SYSDBA password.');
    Exit;
  end;

  if edNewPassword.Text = '' then
  begin
    Log('ERROR: Please enter the new SYSDBA password.');
    Exit;
  end;

  if MessageDlg(
       'Change the Firebird SYSDBA password and write the encrypted password to PawnPro.ini?',
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    if not DirectoryExists(TargetFolder) then
    begin
      Log('Creating target folder: ' + TargetFolder);
      if not ForceDirectories(TargetFolder) then
        raise Exception.CreateFmt('Could not create target folder: %s', [TargetFolder]);
    end;

    if not FileExists(IniPath) then
      CreateDefaultPawnProIni(TargetFolder);

    // Make sure the seeded ImageDirectory actually exists (no-op if Copy Files
    // already created it, or on a client install).
    CreateImagesFolder;

    Log('Testing current SYSDBA password...');
    if not DM.TestConnection(Trim(edHost.Text), ConnectDatabase, edCurrentPassword.Text,
      Port, StatesCount, ErrorMsg) then
      raise Exception.Create('Current SYSDBA password failed: ' + ErrorMsg);

    // The PAWNDATA alias lives in the server's databases.conf and is resolved
    // server-side. Only the DB-host machine should edit databases.conf; a
    // client/workstation has no local Firebird server, so touching it here
    // would raise "databases.conf was not found" and abort before the encrypted
    // INI is written. The client still connects fine via database=PAWNDATA.
    if IsDatabaseLocal then
      SetFirebirdDatabaseAlias
    else
      Log('Client/workstation install: PAWNDATA alias is resolved on the server; ' +
        'skipping local databases.conf.');

    // ALTER USER SYSDBA changes the Firebird *security database*, which is
    // server-wide -- not scoped to this .FDB. It must only ever be done from the
    // DB-host machine. From a client it would rotate the whole server's password
    // and silently break the server's own PawnPro.ini (still holding the old
    // encrypted password). A client only writes its own encrypted INI.
    if not IsDatabaseLocal then
      Log('Client/workstation install: not changing the server SYSDBA password; ' +
        'writing the encrypted INI only.')
    else if SameText(edCurrentPassword.Text, edNewPassword.Text) then
      Log('Current and new passwords match. Skipping ALTER USER; updating encrypted INI.')
    else
    begin
      Log('Changing Firebird SYSDBA password...');
      if not DM.ChangeSysdbaPassword(Trim(edHost.Text), ConnectDatabase,
        edCurrentPassword.Text, edNewPassword.Text, Port, ErrorMsg) then
        raise Exception.Create('Could not change SYSDBA password: ' + ErrorMsg);
      Log('SYSDBA password changed and verified with a fresh connection.');
    end;

    // On the host, the password to store is the (possibly rotated) new one. On a
    // client we never rotate, so store the current password that just verified a
    // successful connection -- not edNewPassword, which the client ignores.
    if IsDatabaseLocal then
      WriteEncryptedConnectionIni(TargetFolder, edNewPassword.Text)
    else
      WriteEncryptedConnectionIni(TargetFolder, edCurrentPassword.Text);

    UpdateFirebirdRemoteAccessFromSelection;

    Log('Testing encrypted INI after update...');
    if not DM.TestConnectionFromIni(IniPath, StatesCount, ErrorMsg) then
      raise Exception.Create('Encrypted INI connection test failed: ' + ErrorMsg);

    Log(Format('Setup security step complete. STATES count: %d', [StatesCount]));
  except
    on E: Exception do
      Log('ERROR: ' + E.Message);
  end;
end;

end.
