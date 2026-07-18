unit SetupRotatePassword;

// Mode 3: Rotate Password.
// Same atomic flow as New Install except no STORE-row writes. Useful for
// "we suspect a leak" or scheduled rotation. Other workstations must run
// Add Workstation with the new password before they will connect again.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.IniFiles, System.UITypes,
  Vcl.Clipbrd, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  FireDAC.Comp.Client;

type
  TfrmSetupRotatePassword = class(TForm)
    lblHost: TLabel;
    edHost: TEdit;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    lblPort: TLabel;
    edPort: TEdit;
    lblCurrentPassword: TLabel;
    edCurrentPassword: TEdit;
    btnRotate: TButton;
    btnClose: TButton;
    memProgress: TMemo;
    lblNewPasswordHeader: TLabel;
    edNewPassword: TEdit;
    btnCopyPassword: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnRotateClick(Sender: TObject);
    procedure btnCopyPasswordClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    function IniPath: string;
    function RecoveryDatPath: string;
    procedure WriteIniConnectionFB(const Host, DatabasePath, User, PasswordEnc: string; Port: Integer);
    procedure ProgressLog(const S: string);
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

function TfrmSetupRotatePassword.IniPath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + INI_FILE_NAME;
end;

function TfrmSetupRotatePassword.RecoveryDatPath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + RECOVERY_FILE_NAME;
end;

procedure TfrmSetupRotatePassword.WriteIniConnectionFB(
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
    Ini.DeleteKey(INI_SEC_CONN_FB, 'password');
  finally
    Ini.Free;
  end;
end;

procedure TfrmSetupRotatePassword.ProgressLog(const S: string);
begin
  memProgress.Lines.Add(Format('[%s] %s', [FormatDateTime('hh:nn:ss', Now), S]));
  Application.ProcessMessages;
end;

procedure TfrmSetupRotatePassword.FormShow(Sender: TObject);
begin
  edHost.Text             := 'localhost';
  edDatabase.Text         := 'C:\Pawn\PAWNDATA.FDB';
  edPort.Text             := '3050';
  edCurrentPassword.Text  := '';
  edNewPassword.Text      := '';
  edNewPassword.Visible   := False;
  btnCopyPassword.Visible := False;
  lblNewPasswordHeader.Visible := False;
  memProgress.Lines.Clear;
end;

procedure TfrmSetupRotatePassword.btnRotateClick(Sender: TObject);
var
  Host, DatabasePath, OldPassword, NewPassword, PasswordEnc, ErrorMsg: string;
  Port, I: Integer;
  Sealed, RecipientPub, PlainBytes: TBytes;
  FS: TFileStream;
  PasswordChangedOnDb, RollbackAttempted: Boolean;
begin
  if MessageDlg('Rotate SYSDBA password now? Other workstations will need ' +
                'to re-run Setup in Add Workstation mode afterwards.',
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  btnRotate.Enabled := False;
  memProgress.Lines.Clear;
  PasswordChangedOnDb := False;
  RollbackAttempted := False;

  Host         := edHost.Text;
  DatabasePath := edDatabase.Text;
  OldPassword  := edCurrentPassword.Text;
  Port         := StrToIntDef(edPort.Text, 3050);

  try
    ProgressLog('Generating new password...');
    NewPassword := GenerateStrongPassword(24);

    ProgressLog('Verifying current password...');
    if not TestFBConnection(Host, DatabasePath, 'SYSDBA', OldPassword, Port, DM.Conn, ErrorMsg) then
      raise Exception.Create('Current password failed: ' + ErrorMsg);

    ProgressLog('Rotating SYSDBA password on DB...');
      BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA', OldPassword, Port);
      DM.Conn.Connected := True;
      try
        AlterSysdbaPassword(DM.Conn, NewPassword);
        PasswordChangedOnDb := True;
      finally
        DM.Conn.Connected := False;
      end;

    ProgressLog('Verifying new password...');
    if not TestFBConnection(Host, DatabasePath, 'SYSDBA', NewPassword, Port, DM.Conn, ErrorMsg) then
    begin
      ProgressLog('  Reconnect failed -- attempting rollback...');
      BuildFBConnection(DM.Conn, Host, DatabasePath, 'SYSDBA', NewPassword, Port);
      DM.Conn.Connected := True;
      try
        AlterSysdbaPassword(DM.Conn, OldPassword);
        PasswordChangedOnDb := False;
        RollbackAttempted := True;
      finally
        DM.Conn.Connected := False;
      end;

      raise Exception.Create('Post-ALTER verify failed; password rolled back.');
    end;

    ProgressLog('Encrypting with DPAPI...');
    PasswordEnc := DPAPIProtect(NewPassword);

    ProgressLog('Writing PawnPro.ini...');
    WriteIniConnectionFB(Host, DatabasePath, 'SYSDBA', PasswordEnc, Port);

    ProgressLog('Writing recovery.dat...');
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
    ProgressLog('  ' + RecoveryDatPath);

    ProgressLog('Done. Save the new password NOW.');

    edNewPassword.Text := NewPassword;
    lblNewPasswordHeader.Visible := True;
    edNewPassword.Visible := True;
    btnCopyPassword.Visible := True;
  except
    on E: Exception do
    begin
      ProgressLog('ERROR: ' + E.Message);
      if PasswordChangedOnDb and not RollbackAttempted then
      begin
        memProgress.Lines.Add('');
        memProgress.Lines.Add('=== NEW PASSWORD WAS SET ON DB BUT INI NOT WRITTEN ===');
        memProgress.Lines.Add('SAVE THIS NOW:');
        memProgress.Lines.Add('  ' + NewPassword);
      end;
      btnRotate.Enabled := True;
    end;
  end;
end;

procedure TfrmSetupRotatePassword.btnCopyPasswordClick(Sender: TObject);
begin
  Clipboard.AsText := edNewPassword.Text;
  MessageDlg('Copied. Paste into your password manager NOW.', mtInformation, [mbOK], 0);
end;

procedure TfrmSetupRotatePassword.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
