unit SetupAddWorkstation;

// Mode 2: Add Workstation.
// For station #2+ in an existing shop where the SYSDBA password is already
// rotated. This mode only re-encrypts the password under THIS machine's DPAPI
// key (DPAPI blobs are machine-bound). No DB writes, no recovery.dat, no
// STORE row touched.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.IniFiles, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB;

type
  TfrmSetupAddWorkstation = class(TForm)
    lblHost: TLabel;
    edHost: TEdit;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    lblPort: TLabel;
    edPort: TEdit;
    lblPassword: TLabel;
    edPassword: TEdit;
    btnApply: TButton;
    btnClose: TButton;
    lblResult: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    function IniPath: string;
    procedure WriteIniConnectionFB(const Host, DatabasePath, User, PasswordEnc: string; Port: Integer);
  end;

implementation

{$R *.dfm}

uses
  DPAPIUtils, SetupConnection, PawnProSetupDM;

const
  INI_FILE_NAME   = 'PawnPro.ini';
  INI_SEC_CONN_FB = 'CONNECTION_FB';

function TfrmSetupAddWorkstation.IniPath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + INI_FILE_NAME;
end;

procedure TfrmSetupAddWorkstation.WriteIniConnectionFB(
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

procedure TfrmSetupAddWorkstation.FormShow(Sender: TObject);
begin
  edHost.Text     := 'localhost';
  edDatabase.Text := 'C:\Pawn\PAWNDATA.FDB';
  edPort.Text     := '3050';
  edPassword.Text := '';
  lblResult.Caption := '';
end;

procedure TfrmSetupAddWorkstation.btnApplyClick(Sender: TObject);
var
  Port: Integer;
  ErrorMsg, PasswordEnc, ProbePasswordEnc: string;
begin
  if Trim(edPassword.Text) = '' then
  begin
    MessageDlg('Please enter the SYSDBA password.', mtInformation, [mbOK], 0);
    edPassword.SetFocus;
    Exit;
  end;

  Port := StrToIntDef(edPort.Text, 3050);

  // Step 1: verify the typed password works against the DB.
  lblResult.Caption := 'Testing connection...';
  lblResult.Font.Color := clWindowText;
  Application.ProcessMessages;
  if not TestFBConnection(edHost.Text, edDatabase.Text, 'SYSDBA',
                          edPassword.Text, Port, DM.Conn, ErrorMsg) then
  begin
    lblResult.Caption := 'FAILED: ' + ErrorMsg;
    lblResult.Font.Color := clRed;
    Exit;
  end;

  // Step 2: DPAPI-encrypt under THIS machine's key.
  PasswordEnc := DPAPIProtect(edPassword.Text);

  // Step 3: write the INI (deletes legacy cleartext password=).
  WriteIniConnectionFB(edHost.Text, edDatabase.Text, 'SYSDBA', PasswordEnc, Port);

  // Step 4: smoke test -- re-read INI, decrypt, connect.
  with TIniFile.Create(IniPath) do
  try
    ProbePasswordEnc := ReadString(INI_SEC_CONN_FB, 'password_enc', '');
  finally
    Free;
  end;

  try
    BuildFBConnection(DM.Conn, edHost.Text, edDatabase.Text, 'SYSDBA',
                      DPAPIUnprotect(ProbePasswordEnc), Port);
    DM.Conn.Connected := True;
    DM.Conn.Connected := False;
    lblResult.Caption := 'OK -- INI written and smoke-tested. You can now run PawnProFB.exe.';
    lblResult.Font.Color := clGreen;
    btnApply.Enabled := False;
  except
    on E: Exception do
    begin
      lblResult.Caption := 'INI written but smoke test failed: ' + E.Message;
      lblResult.Font.Color := clRed;
    end;
  end;
end;

procedure TfrmSetupAddWorkstation.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
