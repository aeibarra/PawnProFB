unit PawnProSetupDM;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, Data.DB;

type
  TDM = class(TDataModule)
    ConnFB: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
    procedure ConfigureConnection(const Host, DatabasePath, Password: string; Port: Integer);
    procedure ConfigureConnectionFromIni(const IniPath: string);
  public
    function TestConnection(const Host, DatabasePath, Password: string; Port: Integer;
      out StatesCount: Integer; out ErrorMsg: string): Boolean;
    function TestConnectionFromIni(const IniPath: string; out StatesCount: Integer;
      out ErrorMsg: string): Boolean;
    function ChangeSysdbaPassword(const Host, DatabasePath, CurrentPassword,
      NewPassword: string; Port: Integer; out ErrorMsg: string): Boolean;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  DPAPIUtils;

procedure TDM.ConfigureConnection(const Host, DatabasePath, Password: string; Port: Integer);
begin
  if Trim(DatabasePath) = '' then
    raise Exception.Create('Database path is blank.');

  ConnFB.Connected := False;
  ConnFB.Params.Clear;
  ConnFB.DriverName := 'FB';
  ConnFB.Params.Values['Server'] := Host;
  ConnFB.Params.Values['Database'] := DatabasePath;
  ConnFB.Params.Values['User_Name'] := 'SYSDBA';
  ConnFB.Params.Values['Password'] := Password;
  ConnFB.Params.Values['Protocol'] := 'TCPIP';
  ConnFB.Params.Values['Port'] := IntToStr(Port);
  ConnFB.Params.Values['CharacterSet'] := 'UTF8';
  ConnFB.LoginPrompt := False;
end;

procedure TDM.ConfigureConnectionFromIni(const IniPath: string);
var
  Ini: TIniFile;
  Host, DatabasePath, Password, PasswordEnc: string;
  Port: Integer;
begin
  if not FileExists(IniPath) then
    raise Exception.CreateFmt('PawnPro.ini not found: %s', [IniPath]);

  Ini := TIniFile.Create(IniPath);
  try
    Host := Ini.ReadString('CONNECTION_FB', 'host', 'localhost');
    DatabasePath := Ini.ReadString('CONNECTION_FB', 'database', '');
    PasswordEnc := Ini.ReadString('CONNECTION_FB', 'password_enc', '');
    Password := Ini.ReadString('CONNECTION_FB', 'password', '');
    Port := Ini.ReadInteger('CONNECTION_FB', 'port', 3050);
  finally
    Ini.Free;
  end;

  if PasswordEnc <> '' then
    Password := DPAPIUnprotect(PasswordEnc);
  if Password = '' then
    raise Exception.Create('PawnPro.ini has no encrypted database password.');

  ConfigureConnection(Host, DatabasePath, Password, Port);
end;

function TDM.TestConnection(const Host, DatabasePath, Password: string; Port: Integer;
  out StatesCount: Integer; out ErrorMsg: string): Boolean;
var
  Q: TFDQuery;
begin
  Result := False;
  StatesCount := 0;
  ErrorMsg := '';

  try
    ConfigureConnection(Host, DatabasePath, Password, Port);
    ConnFB.Connected := True;
    try
      Q := TFDQuery.Create(nil);
      try
        Q.Connection := ConnFB;
        Q.SQL.Text := 'select count(*) as STATE_COUNT from STATES';
        Q.Open;
        StatesCount := Q.FieldByName('STATE_COUNT').AsInteger;
      finally
        Q.Free;
      end;
    finally
      ConnFB.Connected := False;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
      ConnFB.Connected := False;
    end;
  end;
end;

function TDM.TestConnectionFromIni(const IniPath: string; out StatesCount: Integer;
  out ErrorMsg: string): Boolean;
var
  Q: TFDQuery;
begin
  Result := False;
  StatesCount := 0;
  ErrorMsg := '';

  try
    ConfigureConnectionFromIni(IniPath);
    ConnFB.Connected := True;
    try
      Q := TFDQuery.Create(nil);
      try
        Q.Connection := ConnFB;
        Q.SQL.Text := 'select count(*) as STATE_COUNT from STATES';
        Q.Open;
        StatesCount := Q.FieldByName('STATE_COUNT').AsInteger;
      finally
        Q.Free;
      end;
    finally
      ConnFB.Connected := False;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
      ConnFB.Connected := False;
    end;
  end;
end;

function TDM.ChangeSysdbaPassword(const Host, DatabasePath, CurrentPassword,
  NewPassword: string; Port: Integer; out ErrorMsg: string): Boolean;
var
  StatesCount: Integer;
begin
  Result := False;
  ErrorMsg := '';

  if NewPassword = '' then
  begin
    ErrorMsg := 'New SYSDBA password is blank.';
    Exit;
  end;

  try
    if SameText(CurrentPassword, NewPassword) then
    begin
      Result := TestConnection(Host, DatabasePath, NewPassword, Port, StatesCount, ErrorMsg);
      Exit;
    end;

    ConfigureConnection(Host, DatabasePath, CurrentPassword, Port);
    ConnFB.Connected := True;
    try
      ConnFB.ExecSQL('ALTER USER SYSDBA SET PASSWORD ' + QuotedStr(NewPassword));
    finally
      ConnFB.Connected := False;
    end;

    Result := TestConnection(Host, DatabasePath, NewPassword, Port, StatesCount, ErrorMsg);
    if not Result then
      ErrorMsg := 'Password was changed, but reconnect with the new password failed. ' + ErrorMsg;
  except
    on E: Exception do
    begin
      ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
      ConnFB.Connected := False;
    end;
  end;
end;

end.
