unit PawnProSetupMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Hash, System.IniFiles, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton;

type
  TPawnProFileInfo = record
    FileName: string;
    Overwrite: Boolean;
  end;

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
    chkIsDBLocal: TCheckBox;
    procedure btnBrowseInstallFolderClick(Sender: TObject);
    procedure btnCopyPawnProFilesClick(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
    procedure btnEnterStoreInfoClick(Sender: TObject);
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
    function Port: Integer;
    procedure SyncDatabasePathWithInstallFolder;
    function FilesAreSame(const FileName1, FileName2: string): Boolean;
    procedure CopyPawnProFile(const SrcFolder, TargetFolder: string;
      const FileInfo: TPawnProFileInfo);
    procedure CopyPawnProFiles(const SrcFolder, TargetFolder: string);
    procedure CreateDefaultPawnProIni(const TargetFolder: string);
    procedure WriteCommonIniDefaults(Ini: TIniFile);
    procedure WriteEncryptedConnectionIni(const TargetFolder, Password: string);
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
  PAWNPRO_FILES: array[0..2] of TPawnProFileInfo = (
    (FileName: 'fbclient.dll';   Overwrite: True),
    (FileName: 'PAWNDATA.FDB';   Overwrite: False),
    (FileName: 'PawnProFB.exe';  Overwrite: True)
  );

procedure TfrmPawnProSetupMain.FormCreate(Sender: TObject);
begin
  FDatabasePathFollowsInstallFolder := True;
  SyncDatabasePathWithInstallFolder;
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
  SourceFile, TargetFile, FileName: string;
begin
  FileName := FileInfo.FileName;
  SourceFile := SrcFolder + FileName;
  TargetFile := TargetFolder + FileName;

  if not FileExists(SourceFile) then
    raise Exception.CreateFmt('Source file is missing: %s', [SourceFile]);

  if FileExists(TargetFile) then
  begin
    if not FileInfo.Overwrite then
    begin
      Log(FileName + ' already exists. Skipped because overwrite is disabled.');
      Exit;
    end;

    if FilesAreSame(SourceFile, TargetFile) then
    begin
      Log(FileName + ' is already current. Skipped.');
      Exit;
    end;

    Log(FileName + ' is different. Replacing target file.');
  end
  else
    Log(FileName + ' is missing. Copying file.');

  if not CopyFile(PChar(SourceFile), PChar(TargetFile), False) then
    raise Exception.CreateFmt('Copy failed for %s. Windows error: %d',
      [FileName, GetLastError]);

  Log(FileName + ' copied.');
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

procedure EnsureIniKey(Ini: TIniFile; const Section, Key, Value: string);
begin
  if not Ini.ValueExists(Section, Key) then
    Ini.WriteString(Section, Key, Value);
end;

procedure TfrmPawnProSetupMain.WriteCommonIniDefaults(Ini: TIniFile);
var
  IsLocalValue: string;
begin
  if chkIsDBLocal.Checked then
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
    Ini.WriteString('CONNECTION_FB', 'database', DatabasePath);
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
    Ini.WriteString('CONNECTION_FB', 'database', DatabasePath);
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

    Log('Testing current SYSDBA password...');
    if not DM.TestConnection(Trim(edHost.Text), DatabasePath, edCurrentPassword.Text,
      Port, StatesCount, ErrorMsg) then
      raise Exception.Create('Current SYSDBA password failed: ' + ErrorMsg);

    if SameText(edCurrentPassword.Text, edNewPassword.Text) then
      Log('Current and new passwords match. Skipping ALTER USER; updating encrypted INI.')
    else
    begin
      Log('Changing Firebird SYSDBA password...');
      if not DM.ChangeSysdbaPassword(Trim(edHost.Text), DatabasePath,
        edCurrentPassword.Text, edNewPassword.Text, Port, ErrorMsg) then
        raise Exception.Create('Could not change SYSDBA password: ' + ErrorMsg);
      Log('SYSDBA password changed and verified with a fresh connection.');
    end;

    WriteEncryptedConnectionIni(TargetFolder, edNewPassword.Text);

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
