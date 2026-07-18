unit SetupNewInstall;

// New Install wizard. 4 pages of a TPageControl with tabs hidden -- navigate
// via Back/Next/Apply/Close at the bottom. The atomic apply flow is the
// canonical sequence from plan §"New Install Page 3":
//
//   1. Generate strong password (24 chars).
//   2. Sanity connect with current SYSDBA password.
//   3. ALTER USER SYSDBA SET PASSWORD '<new>'.
//   4. Reconnect with new password to verify -- on failure, attempt to revert
//      via ALTER USER back to the original password.
//   5. DPAPIProtect(<new>) -> password_enc value.
//   6. Write PawnPro.ini's [CONNECTION_FB] section with password_enc, removing
//      any legacy cleartext password=.
//   7. SealedBoxSeal(<new>, VendorPublicKey) -> recovery.dat next to the EXE.
//   8. UPDATE OR INSERT INTO STORE row with page-2 values.
//   9. Smoke test: read the just-written INI back and open a fresh
//      TFDConnection; SELECT 1 FROM RDB$DATABASE.
//
// Failures past step 4 leave the new password set on the DB but the INI may
// not reflect it. Page 4 surfaces this clearly so the admin can recover.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils,
  System.Variants, System.Classes, System.UITypes,
  System.IniFiles,
  Vcl.Clipbrd, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Comp.Client, FireDAC.Stan.Def,
  SetupStoreFields, RzLabel, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB;

type
  TfrmSetupNewInstall = class(TForm)
    PageControl1: TPageControl;
    tsLocation: TTabSheet;
    tsStore: TTabSheet;
    tsConfirm: TTabSheet;
    tsDone: TTabSheet;

    // Page 1 -- Install location + database
    lblInstallFolder: TLabel;
    edInstallFolder: TEdit;
    btnBrowseInstallFolder: TButton;
    lblHost: TLabel;
    edHost: TEdit;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    lblPort: TLabel;
    edPort: TEdit;
    lblCurrentPassword: TLabel;
    edCurrentPassword: TEdit;
    btnTest: TButton;

    // Page 2 -- Store identity
    lblStoreName: TLabel;        edStoreName: TEdit;
    lblStoreAddr: TLabel;        edStoreAddr: TEdit;
    lblStoreCityStZip: TLabel;   edStoreCityStZip: TEdit;
    lblStorePhone: TLabel;       edStorePhone: TEdit;
    lblStorePoliceId: TLabel;    edStorePoliceId: TEdit;
    lblStoreNumber: TLabel;      edStoreNumber: TEdit;
    lblInterestRate: TLabel;     edInterestRate: TEdit;
    lblMaturityMonths: TLabel;   edMaturityMonths: TEdit;
    lblDefaultMonths: TLabel;    edDefaultMonths: TEdit;
    lblSalesTax: TLabel;         edSalesTax: TEdit;
    rgDateCalc: TRadioGroup;     // 0 = Days, 1 = Months
    rgWeightUnit: TRadioGroup;   // 0 = Pennyweight, 1 = Gram
    gbLeads: TGroupBox;
    edLeadsStoreId: TEdit;       lblLeadsStoreId: TLabel;
    edLeadsFtp: TEdit;           lblLeadsFtp: TLabel;
    edLeadsUser: TEdit;          lblLeadsUser: TLabel;
    edLeadsPassword: TEdit;      lblLeadsPassword: TLabel;
    chkFtpPassive: TCheckBox;

    // Page 3 -- Confirm + Apply
    memSummary: TMemo;
    btnApply: TButton;
    memProgress: TMemo;

    // Page 4 -- Done
    lblDoneHeader: TLabel;
    edNewPassword: TEdit;
    btnCopyPassword: TButton;
    lblRecoveryPath: TLabel;
    lblSmokeTestResult: TLabel;
    memDoneNotes: TMemo;

    // Nav (always visible)
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    lblTestResult: TRzLabel;

    procedure FormShow(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCopyPasswordClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnBrowseInstallFolderClick(Sender: TObject);
    procedure edInstallFolderChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FConnectionTested: Boolean;
    FAppliedOK: Boolean;
    FAppliedAt: TDateTime;
    FNewPassword: string;
    FRecoveryPath: string;
    FSmokeTestPassed: Boolean;
    FInstallFolder: string;
    function SourceFolder: string;
    function NormalizedInstallFolder: string;
    function IniPath: string;
    function RecoveryDatPath: string;
    function CollectStoreFields: TStoreFields;
    procedure ApplyStoreToControls(const Fields: TStoreFields);
    procedure WriteIniConnectionFB(const Host, DatabasePath, User, PasswordEnc: string; Port: Integer);
    procedure FillSummary;
    procedure ApplyAtomic;
    procedure CopyInstallFiles;
    procedure ProgressLog(const S: string);
    procedure UpdateNavButtons;
    procedure GoToPage(Index: Integer);
  end;

implementation

{$R *.dfm}

uses
  DPAPIUtils, SealedBox, SetupConnection, PawnProSetupDM;

{$I SetupVendorPublicKey.inc}

const
  INI_FILE_NAME      = 'PawnPro.ini';
  RECOVERY_FILE_NAME = 'recovery.dat';
  INI_SEC_CONN_FB    = 'CONNECTION_FB';

procedure TfrmSetupNewInstall.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  // Tabs are intentionally left visible as a wizard step indicator (their
  // captions are "1. ...", "2. ...", etc.). Users navigate via Back/Next/Apply
  // at the bottom; clicking a tab directly is allowed but the validation
  // inside btnNextClick / btnApplyClick catches any out-of-order field state.
  //
  // (Previously this set PageControl1.Style := tsButtons and
  // TabVisible := False on all tabs to hide the strip, but that left the
  // page area blank in some Delphi/VCL builds.)

  // Prefill Page 1 with sensible defaults; admin overrides if needed.
  // Install folder defaults to C:\Pawn\ -- the new-store convention.
  edInstallFolder.Text    := 'C:\Pawn\';
  edHost.Text             := 'localhost';
  edDatabase.Text         := 'C:\Pawn\PAWNDATA.FDB';
  edPort.Text             := '3050';
  edCurrentPassword.Text  := 'masterkey';
  lblTestResult.Caption   := '';
  FInstallFolder := '';

  // Prefill Page 2 with the seed-defaults so this wizard run is a no-op
  // on a freshly seeded DB if the admin doesn't change anything.
  ApplyStoreToControls(DefaultStoreFields);

  FConnectionTested := False;
  FAppliedOK := False;
  UpdateNavButtons;
end;

procedure TfrmSetupNewInstall.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // On the Done page, the apply is irreversible -- closing is always OK.
  // Before that, confirm so an accidental close doesn't lose entered data.
  if FAppliedOK then
    CanClose := True
  else if PageControl1.ActivePageIndex = 0 then
    CanClose := True
  else
    CanClose := MessageDlg('Cancel setup? Any data entered will be lost.',
                           mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TfrmSetupNewInstall.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmSetupNewInstall.SourceFolder: string;
begin
  // Where the running PawnProSetup.exe lives. On a USB-stick install this is
  // the USB drive root; the installer copies files from here into the target
  // install folder during Apply.
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

function TfrmSetupNewInstall.NormalizedInstallFolder: string;
begin
  // Use FInstallFolder if ApplyAtomic has captured it (during/after apply),
  // otherwise read live from the edit box. Always ensures trailing backslash.
  if FInstallFolder <> '' then
    Result := IncludeTrailingPathDelimiter(FInstallFolder)
  else
    Result := IncludeTrailingPathDelimiter(Trim(edInstallFolder.Text));
end;

function TfrmSetupNewInstall.IniPath: string;
begin
  Result := NormalizedInstallFolder + INI_FILE_NAME;
end;

function TfrmSetupNewInstall.RecoveryDatPath: string;
begin
  Result := NormalizedInstallFolder + RECOVERY_FILE_NAME;
end;

procedure TfrmSetupNewInstall.UpdateNavButtons;
begin
  btnBack.Enabled := (PageControl1.ActivePageIndex > 0) and not FAppliedOK;
  case PageControl1.ActivePageIndex of
    0: btnNext.Caption := 'Next >';
    1: btnNext.Caption := 'Next >';
    2: btnNext.Caption := 'Apply';
    3:
      begin
        btnNext.Caption := 'Close';
        btnBack.Enabled := False;
      end;
  end;
  btnCancel.Visible := not FAppliedOK;
end;

procedure TfrmSetupNewInstall.GoToPage(Index: Integer);
begin
  PageControl1.ActivePageIndex := Index;
  UpdateNavButtons;
end;

procedure TfrmSetupNewInstall.btnBackClick(Sender: TObject);
begin
  if PageControl1.ActivePageIndex > 0 then
    GoToPage(PageControl1.ActivePageIndex - 1);
end;

procedure TfrmSetupNewInstall.btnNextClick(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0:
      begin
        if not FConnectionTested then
        begin
          MessageDlg('Please click [Test Connection] first.', mtInformation, [mbOK], 0);
          Exit;
        end;
        GoToPage(1);
      end;
    1:
      begin
        if Trim(edStoreName.Text) = '' then
        begin
          MessageDlg('Store name is required.', mtInformation, [mbOK], 0);
          edStoreName.SetFocus;
          Exit;
        end;
        FillSummary;
        GoToPage(2);
      end;
    2:
      begin
        // "Apply" button shares the Next slot on page 2; click goes through
        // btnApplyClick instead. This branch shouldn't be hit because btnNext
        // is hidden on page 3 and btnApply is shown.
        if MessageDlg('Apply changes now? This will rotate the SYSDBA password.',
                      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          ApplyAtomic;
      end;
    3:
      Close;
  end;
end;

procedure TfrmSetupNewInstall.btnTestClick(Sender: TObject);
var
  ErrorMsg: string;
  Port: Integer;
begin
  Port := StrToIntDef(edPort.Text, 3050);

  // Validate install folder is set.
  if Trim(edInstallFolder.Text) = '' then
  begin
    FConnectionTested := False;
    lblTestResult.Caption := 'Install folder is empty.';
    lblTestResult.Font.Color := clRed;
    Exit;
  end;

  // Copy install files unconditionally. CopyInstallFiles short-circuits when
  // source == target, so re-running from C:\Pawn\ is a no-op. Otherwise it
  // writes the files into the install folder. Apply's Step 0 will call this
  // again later; it's idempotent overwrite, harmless.
  lblTestResult.Caption := 'Copying install files to ' + Trim(edInstallFolder.Text) + ' ...';
  lblTestResult.Font.Color := clWindowText;
  Application.ProcessMessages;
  try
    CopyInstallFiles;
  except
    on E: Exception do
    begin
      FConnectionTested := False;
      lblTestResult.Caption := 'File copy failed: ' + E.Message;
      lblTestResult.Font.Color := clRed;
      Exit;
    end;
  end;

  // Sanity check: after the copy, the target FDB must exist. If it doesn't,
  // the install media is missing PAWNDATA.FDB.
  if not FileExists(edDatabase.Text) then
  begin
    FConnectionTested := False;
    lblTestResult.Caption :=
      'PAWNDATA.FDB is not at the target after copy. ' +
      'Make sure the install media has the template FDB next to PawnProSetup.exe.';
    lblTestResult.Font.Color := clRed;
    Exit;
  end;

  // Now probe the target FDB.
  lblTestResult.Caption := 'Testing connection...';
  lblTestResult.Font.Color := clWindowText;
  Application.ProcessMessages;

  if TestFBConnection(edHost.Text, edDatabase.Text, 'SYSDBA',
                      edCurrentPassword.Text, Port, DM.Conn, ErrorMsg) then
  begin
    FConnectionTested := True;
    lblTestResult.Caption := 'Connection OK -- files in place, password works.';
    lblTestResult.Font.Color := clGreen;
  end
  else
  begin
    FConnectionTested := False;
    lblTestResult.Caption := 'FAILED: ' + ErrorMsg;
    lblTestResult.Font.Color := clRed;
  end;
end;

procedure TfrmSetupNewInstall.btnApplyClick(Sender: TObject);
begin
  if MessageDlg('Apply changes now? This will rotate the SYSDBA password and write the INI.',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  ApplyAtomic;
end;

procedure TfrmSetupNewInstall.btnCopyPasswordClick(Sender: TObject);
begin
  Clipboard.AsText := edNewPassword.Text;
  MessageDlg('Password copied to clipboard. Paste it into your password manager NOW.',
             mtInformation, [mbOK], 0);
end;

procedure TfrmSetupNewInstall.btnBrowseInstallFolderClick(Sender: TObject);
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

procedure TfrmSetupNewInstall.edInstallFolderChange(Sender: TObject);
var
  Folder: string;
begin
  // Auto-track Database path to <install folder>\PAWNDATA.FDB so the customer
  // doesn't have to keep them in sync manually. They can still override
  // Database if they really want the FDB on a different drive.
  Folder := Trim(edInstallFolder.Text);
  if Folder = '' then Exit;
  edDatabase.Text := IncludeTrailingPathDelimiter(Folder) + 'PAWNDATA.FDB';
end;

function TfrmSetupNewInstall.CollectStoreFields: TStoreFields;
begin
  Result := DefaultStoreFields;
  Result.StoreName        := edStoreName.Text;
  Result.StoreAddr        := edStoreAddr.Text;
  Result.StoreCityStZip   := edStoreCityStZip.Text;
  Result.StorePhone       := edStorePhone.Text;
  Result.StorePoliceId    := edStorePoliceId.Text;
  Result.StoreNumber      := edStoreNumber.Text;

  Result.DefaultPawnInterestRate := StrToFloatDef(edInterestRate.Text, 10.0);
  Result.DefaultMaturityMonths   := StrToIntDef(edMaturityMonths.Text, 1);
  Result.PawnDefaultMonths       := StrToIntDef(edDefaultMonths.Text, 2);
  Result.SalesTaxPerc            := StrToFloatDef(edSalesTax.Text, 7.0);

  if rgDateCalc.ItemIndex = 1 then
    Result.PawnDateCalculationBase := 'M'
  else
    Result.PawnDateCalculationBase := 'D';

  if rgWeightUnit.ItemIndex = 1 then
    Result.DefaultWeightMeasureUnit := 'G'
  else
    Result.DefaultWeightMeasureUnit := 'P';

  Result.LeadsStoreId          := edLeadsStoreId.Text;
  Result.LeadsOnlineFtpAddress := edLeadsFtp.Text;
  Result.LeadsOnlineUserName   := edLeadsUser.Text;
  Result.LeadsOnlinePassword   := edLeadsPassword.Text;
  Result.FtpPassive            := chkFtpPassive.Checked;
end;

procedure TfrmSetupNewInstall.ApplyStoreToControls(const Fields: TStoreFields);
begin
  edStoreName.Text       := Fields.StoreName;
  edStoreAddr.Text       := Fields.StoreAddr;
  edStoreCityStZip.Text  := Fields.StoreCityStZip;
  edStorePhone.Text      := Fields.StorePhone;
  edStorePoliceId.Text   := Fields.StorePoliceId;
  edStoreNumber.Text     := Fields.StoreNumber;

  edInterestRate.Text    := FormatFloat('0.##', Fields.DefaultPawnInterestRate);
  edMaturityMonths.Text  := IntToStr(Fields.DefaultMaturityMonths);
  edDefaultMonths.Text   := IntToStr(Fields.PawnDefaultMonths);
  edSalesTax.Text        := FormatFloat('0.##', Fields.SalesTaxPerc);

  if Fields.PawnDateCalculationBase = 'M' then
    rgDateCalc.ItemIndex := 1
  else
    rgDateCalc.ItemIndex := 0;

  if Fields.DefaultWeightMeasureUnit = 'G' then
    rgWeightUnit.ItemIndex := 1
  else
    rgWeightUnit.ItemIndex := 0;

  edLeadsStoreId.Text  := Fields.LeadsStoreId;
  edLeadsFtp.Text      := Fields.LeadsOnlineFtpAddress;
  edLeadsUser.Text     := Fields.LeadsOnlineUserName;
  edLeadsPassword.Text := Fields.LeadsOnlinePassword;
  chkFtpPassive.Checked := Fields.FtpPassive;
end;

procedure TfrmSetupNewInstall.FillSummary;
var
  F: TStoreFields;
begin
  F := CollectStoreFields;
  memSummary.Lines.Clear;
  memSummary.Lines.Add('Database:');
  memSummary.Lines.Add(Format('  Host:     %s', [edHost.Text]));
  memSummary.Lines.Add(Format('  Database: %s', [edDatabase.Text]));
  memSummary.Lines.Add(Format('  Port:     %s', [edPort.Text]));
  memSummary.Lines.Add('');
  memSummary.Lines.Add('Store:');
  memSummary.Lines.Add(Format('  Name:     %s', [F.StoreName]));
  memSummary.Lines.Add(Format('  Address:  %s', [F.StoreAddr]));
  memSummary.Lines.Add(Format('  CSZ:      %s', [F.StoreCityStZip]));
  memSummary.Lines.Add(Format('  Phone:    %s', [F.StorePhone]));
  memSummary.Lines.Add(Format('  Police#:  %s', [F.StorePoliceId]));
  memSummary.Lines.Add(Format('  Store#:   %s', [F.StoreNumber]));
  memSummary.Lines.Add('');
  memSummary.Lines.Add(Format('Interest rate: %.2f%%', [F.DefaultPawnInterestRate]));
  memSummary.Lines.Add(Format('Sales tax:     %.2f%%', [F.SalesTaxPerc]));
  memSummary.Lines.Add(Format('Maturity:      %d months', [F.DefaultMaturityMonths]));
  memSummary.Lines.Add(Format('Default:       %d months', [F.PawnDefaultMonths]));
  memSummary.Lines.Add(Format('Date calc:     %s', [
    IfThen(F.PawnDateCalculationBase = 'M', 'Months', 'Days')]));
  memSummary.Lines.Add(Format('Weight unit:   %s', [
    IfThen(F.DefaultWeightMeasureUnit = 'G', 'Gram', 'Pennyweight')]));
  memSummary.Lines.Add('');
  memSummary.Lines.Add('LeadsOnline:');
  memSummary.Lines.Add(Format('  Store ID: %s', [F.LeadsStoreId]));
  memSummary.Lines.Add(Format('  FTP:      %s', [F.LeadsOnlineFtpAddress]));
  memSummary.Lines.Add(Format('  User:     %s', [F.LeadsOnlineUserName]));
  memSummary.Lines.Add(Format('  Passive:  %s', [BoolToStr(F.FtpPassive, True)]));
  memSummary.Lines.Add('');
  memSummary.Lines.Add('On Apply: SYSDBA password will be rotated, INI');
  memSummary.Lines.Add('will be encrypted, recovery.dat will be written.');
end;

procedure TfrmSetupNewInstall.ProgressLog(const S: string);
begin
  memProgress.Lines.Add(Format('[%s] %s', [FormatDateTime('hh:nn:ss', Now), S]));
  Application.ProcessMessages;
end;

procedure TfrmSetupNewInstall.CopyInstallFiles;
var
  Source, Dest, SourceExe, SetupVendorIncName: string;
  SR: TSearchRec;
  SourceFile, DestFile: string;
begin
  Source := SourceFolder;
  Dest := NormalizedInstallFolder;

  if SameText(Source, Dest) then
  begin
    ProgressLog('  Source and target are the same folder -- no files to copy.');
    Exit;
  end;

  if not DirectoryExists(Dest) then
  begin
    ProgressLog('  Creating ' + Dest);
    if not ForceDirectories(Dest) then
      raise Exception.CreateFmt('Could not create install folder: %s', [Dest]);
  end;

  // Skip the running PawnProSetup.exe itself (avoids any "file in use" weirdness;
  // the customer can copy it manually later if they want a local copy for
  // future Add Workstation / Rotate runs).
  SourceExe := ExtractFileName(ParamStr(0));
  // Also skip the developer's vendor keypair include if it somehow ended up
  // on the install media -- it doesn't belong on a customer's machine.
  SetupVendorIncName := 'SetupVendorPublicKey.inc';

  if FindFirst(Source + '*', faAnyFile, SR) = 0 then
  try
    repeat
      // Skip directories (including . and ..) and the EXE itself.
      if (SR.Attr and faDirectory) <> 0 then Continue;
      if SameText(SR.Name, SourceExe) then Continue;
      if SameText(SR.Name, SetupVendorIncName) then Continue;

      SourceFile := Source + SR.Name;
      DestFile   := Dest + SR.Name;

      if not CopyFile(PChar(SourceFile), PChar(DestFile), False) then
        raise Exception.CreateFmt('CopyFile failed for "%s": Win32 error %d',
                                  [SR.Name, GetLastError]);
      ProgressLog('  ' + SR.Name);
    until FindNext(SR) <> 0;
  finally
    FindClose(SR);
  end;
end;

procedure TfrmSetupNewInstall.WriteIniConnectionFB(
  const Host, DatabasePath, User, PasswordEnc: string; Port: Integer);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(IniPath);
  try
    Ini.WriteString(INI_SEC_CONN_FB, 'host',         Host);
    Ini.WriteString(INI_SEC_CONN_FB, 'database',     DatabasePath);
    Ini.WriteString(INI_SEC_CONN_FB, 'user',         User);
    Ini.WriteString(INI_SEC_CONN_FB, 'password_enc', PasswordEnc);
    Ini.WriteInteger(INI_SEC_CONN_FB, 'port',        Port);
    Ini.WriteString(INI_SEC_CONN_FB, 'charset',      'UTF8');
    // Delete legacy cleartext key so the main app's fallback never fires.
    Ini.DeleteKey(INI_SEC_CONN_FB, 'password');
  finally
    Ini.Free;
  end;
end;

procedure TfrmSetupNewInstall.ApplyAtomic;
var
  Host, DatabasePath, OldPassword, NewPassword, PasswordEnc, ErrorMsg: string;
  Port: Integer;
  StoreF: TStoreFields;
  Sealed, RecipientPub, PlainBytes: TBytes;
  RollbackAttempted: Boolean;
  PasswordChangedOnDb: Boolean;
  FS: TFileStream;
  I: Integer;
begin
  btnApply.Enabled := False;
  btnBack.Enabled  := False;
  btnCancel.Enabled := False;
  memProgress.Lines.Clear;
  PasswordChangedOnDb := False;
  RollbackAttempted := False;

  FInstallFolder := Trim(edInstallFolder.Text);
  if FInstallFolder = '' then
  begin
    MessageDlg('Install folder cannot be empty.', mtError, [mbOK], 0);
    btnApply.Enabled := True;
    btnBack.Enabled  := True;
    btnCancel.Enabled := True;
    Exit;
  end;

  Host          := edHost.Text;
  DatabasePath  := edDatabase.Text;
  OldPassword   := edCurrentPassword.Text;
  Port          := StrToIntDef(edPort.Text, 3050);

  try
    // Step 0: Copy install files (USB -> target folder). Skipped when source
    // == target (e.g. running an in-place re-setup from C:\Pawn\).
    ProgressLog('Step 0/10: Copying install files to ' + NormalizedInstallFolder + '...');
    CopyInstallFiles;

    // Step 1: Generate strong password.
    ProgressLog('Step 1/10: Generating strong password...');
    NewPassword := GenerateStrongPassword(24);
    ProgressLog('  Generated 24-char password.');

    // Step 2: Sanity-connect with current password.
    ProgressLog('Step 2/10: Verifying current SYSDBA password...');
    if not TestFBConnection(Host, DatabasePath, 'SYSDBA', OldPassword, Port, DM.Conn, ErrorMsg) then
    begin
      ProgressLog('  FAILED: ' + ErrorMsg);
      raise Exception.Create('Current SYSDBA password is wrong or DB unreachable. No changes made.');
    end;
    ProgressLog('  Current password works.');

    // Step 3: ALTER USER SYSDBA SET PASSWORD '<new>'.
    ProgressLog('Step 3/10: Rotating SYSDBA password on the database...');
    BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA', OldPassword, Port);
    DM.Conn.Connected := True;
    try
      AlterSysdbaPassword(DM.Conn, NewPassword);
      PasswordChangedOnDb := True;
      ProgressLog('  ALTER USER succeeded.');
    finally
      DM.Conn.Connected := False;
    end;

    // Step 4: Reconnect with new password.
    ProgressLog('Step 4/10: Verifying new password by reconnecting...');
    if not TestFBConnection(Host, DatabasePath, 'SYSDBA', NewPassword, Port, DM.Conn, ErrorMsg) then
    begin
      ProgressLog('  FAILED: ' + ErrorMsg);
      ProgressLog('  Attempting rollback (ALTER USER back to old password)...');
        BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA', NewPassword, Port);
        DM.Conn.Connected := True;
        try
          AlterSysdbaPassword(DM.Conn, OldPassword);
          PasswordChangedOnDb := False;
          RollbackAttempted := True;
          ProgressLog('  Rollback succeeded. Original password restored.');
        finally
          DM.Conn.Connected := False;
        end;

      raise Exception.Create('Post-ALTER verify failed and password was rolled back. ' +
                             'No INI was written. See progress log.');
    end;
    ProgressLog('  New password works.');

    // Step 5: DPAPI-encrypt the new password.
    ProgressLog('Step 5/10: Encrypting new password with DPAPI...');
    PasswordEnc := DPAPIProtect(NewPassword);
    ProgressLog(Format('  DPAPI blob: %d Base64 chars.', [Length(PasswordEnc)]));

    // Step 6: Write the INI (this also deletes legacy password=).
    ProgressLog('Step 6/10: Writing PawnPro.ini [CONNECTION_FB] section...');
    WriteIniConnectionFB(Host, DatabasePath, 'SYSDBA', PasswordEnc, Port);
    ProgressLog('  ' + IniPath);

    // Step 7: Seal the new password to recovery.dat.
    ProgressLog('Step 7/10: Writing recovery.dat (sealed with vendor public key)...');
    SetLength(RecipientPub, Length(VENDOR_PUBLIC_KEY));
    for I := 0 to High(VENDOR_PUBLIC_KEY) do
      RecipientPub[I] := VENDOR_PUBLIC_KEY[I];
    PlainBytes := TEncoding.UTF8.GetBytes(NewPassword);
    Sealed := SealedBoxSeal(PlainBytes, RecipientPub);
    FS := TFileStream.Create(RecoveryDatPath, fmCreate or fmShareExclusive);
    try
      if Length(Sealed) > 0 then
        FS.WriteBuffer(Sealed[0], Length(Sealed));
    finally
      FS.Free;
    end;
    FRecoveryPath := RecoveryDatPath;
    ProgressLog('  ' + FRecoveryPath);

    // Step 8: UPDATE OR INSERT STORE row.
    ProgressLog('Step 8/10: Writing STORE row...');
    StoreF := CollectStoreFields;

    BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA', NewPassword, Port);
    DM.Conn.Connected := True;
    try
      WriteStoreRow(DM.Conn, StoreF);
      ProgressLog(Format('  STORE row updated (STORE_NO=%s, STORE_NAME=%s).',
                         [StoreF.StoreNo, StoreF.StoreName]));
    finally
      DM.Conn.Connected := False;
    end;

    // Step 9: Smoke test -- independent re-read of the INI we just wrote.
    ProgressLog('Step 9/10: Smoke test (open ConnFB from freshly-written INI)...');
    FSmokeTestPassed := False;
      // Re-read INI to be sure the bytes on disk actually decrypt.
      with TIniFile.Create(IniPath) do
      try
        PasswordEnc := ReadString(INI_SEC_CONN_FB, 'password_enc', '');
      finally
        Free;
      end;
      if PasswordEnc = '' then
        raise Exception.Create('Smoke test: password_enc not found in INI after write.');
      BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA',
                        DPAPIUnprotect(PasswordEnc), Port);
      DM.Conn.Connected := True;
      DM.Conn.Connected := False;
      FSmokeTestPassed := True;
      ProgressLog('  Smoke test PASSED.');

    // Success.
    FNewPassword := NewPassword;
    FAppliedOK   := True;
    FAppliedAt   := Now;

    edNewPassword.Text       := FNewPassword;
    lblRecoveryPath.Caption  := 'Recovery: ' + FRecoveryPath;
    if FSmokeTestPassed then
    begin
      lblSmokeTestResult.Caption := 'Smoke test: PASSED';
      lblSmokeTestResult.Font.Color := clGreen;
    end
    else
    begin
      lblSmokeTestResult.Caption := 'Smoke test: FAILED -- check progress log';
      lblSmokeTestResult.Font.Color := clRed;
    end;

    memDoneNotes.Lines.Clear;
    memDoneNotes.Lines.Add('Save the password above to your vendor password manager NOW.');
    memDoneNotes.Lines.Add('It will not be shown again on this screen.');
    memDoneNotes.Lines.Add('');
    memDoneNotes.Lines.Add('A recovery.dat file has been written next to PawnProSetup.exe.');
    memDoneNotes.Lines.Add('Keep it in case the password manager entry is lost. Only the');
    memDoneNotes.Lines.Add('vendor (holding the offline secret key) can decrypt it.');
    memDoneNotes.Lines.Add('');
    memDoneNotes.Lines.Add('Other workstations: run PawnProSetup.exe in "Add Workstation"');
    memDoneNotes.Lines.Add('mode on each one with this password, before they can connect.');

    GoToPage(3);
  except
    on E: Exception do
    begin
      ProgressLog('ERROR: ' + E.Message);
      if PasswordChangedOnDb and not RollbackAttempted then
      begin
        // Worst case: password rotated on DB but INI is unsynced. Display the
        // new password prominently so the admin can salvage manually.
        memProgress.Lines.Add('');
        memProgress.Lines.Add('=== CRITICAL: NEW PASSWORD ON DB BUT INI NOT WRITTEN ===');
        memProgress.Lines.Add('SAVE THIS PASSWORD NOW:');
        memProgress.Lines.Add('  ' + NewPassword);
        memProgress.Lines.Add('');
        memProgress.Lines.Add('To recover: re-run PawnProSetup.exe with the above as');
        memProgress.Lines.Add('the "current password" on Page 1. Or manually edit');
        memProgress.Lines.Add(IniPath);
      end;
      MessageDlg('Apply failed. See progress log on this page.', mtError, [mbOK], 0);
      btnApply.Enabled := True;
      btnBack.Enabled  := True;
      btnCancel.Enabled := True;
    end;
  end;
end;

end.
