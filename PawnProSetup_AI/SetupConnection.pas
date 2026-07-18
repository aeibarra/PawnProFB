unit SetupConnection;

// FireDAC connection helpers for PawnProSetup. Centralizes the FB connection-
// param shape so the wizard never duplicates the main app's ConfigureFBConnectionFor
// (PawnDM.pas:527) -- if the main app's params drift, this unit drifts with it.
//
// Also exposes:
//   - TestFBConnection: probe an arbitrary (Server,DB,User,Password,Port) without
//     touching ConnFB. Used by the [Test Connection] button.
//   - AlterSysdbaPassword: execute the ALTER USER statement on an open connection.
//     Connects to the target DB; FB routes ALTER USER to the security DB internally.
//   - GenerateStrongPassword: 24-char password from a 74-char alphabet, sourced
//     from BCryptGenRandom (Windows CSPRNG) with rejection sampling to avoid bias.

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Comp.Client;

procedure BuildFBConnection(AConn: TFDConnection;
                            const Server, Database, User, Password: string;
                            Port: Integer;
                            const CharSet: string = 'UTF8');

function TestFBConnection(const Server, Database, User, Password: string;
                          Port: Integer;
                          Conn: TFDConnection;
                          out ErrorMsg: string): Boolean;

procedure AlterSysdbaPassword(AConn: TFDConnection; const NewPassword: string);

function GenerateStrongPassword(APasswordLen: Integer = 24): string;

implementation

uses
  Winapi.Windows;

const
  // 74-char alphabet. The constants below depend on this exact length.
  PASSWORD_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*-_=+';
  ALPHABET_LEN     = 74;
  // 256 mod 74 = 34, so bytes 0..221 map cleanly to the alphabet via mod 74
  // (3 full cycles of 74). Bytes 222..255 are rejected to avoid modulo bias.
  REJECT_THRESHOLD = 222;

  BCRYPT_USE_SYSTEM_PREFERRED_RNG = 2;

function BCryptGenRandom(hAlgorithm: Pointer; pbBuffer: PByte; cbBuffer: ULONG;
                         dwFlags: ULONG): Integer; stdcall; external 'bcrypt.dll';

procedure BuildFBConnection(AConn: TFDConnection;
                            const Server, Database, User, Password: string;
                            Port: Integer;
                            const CharSet: string = 'UTF8');
var
  EffectiveServer: string;
begin
  EffectiveServer := Trim(Server);
  if SameText(EffectiveServer, '127.0.0.1') then
    EffectiveServer := 'localhost';

  AConn.Connected := False;
  AConn.Params.Clear;
  AConn.DriverName := 'FB';
  AConn.Params.Values['Server']       := EffectiveServer;
  AConn.Params.Values['Database']     := Database;
  AConn.Params.Values['User_Name']    := User;
  AConn.Params.Values['Password']     := Password;
  AConn.Params.Values['Protocol']     := 'TCPIP';
  AConn.Params.Values['Port']         := IntToStr(Port);
  AConn.Params.Values['CharacterSet'] := CharSet;
  AConn.LoginPrompt := False;
end;

function TestFBConnection(const Server, Database, User, Password: string;
                          Port: Integer;
                          Conn: TFDConnection;
                          out ErrorMsg: string): Boolean;
var
//  Conn: TFDConnection;
  Q: TFDQuery;
begin
  ErrorMsg := '';
//  Conn := TFDConnection.Create(nil);
  try
    try
      BuildFBConnection(Conn, Server, Database, User, Password, Port);
      Conn.Connected := True;
      try
        Q := TFDQuery.Create(nil);
        try
          Q.Connection := Conn;
          Q.SQL.Text := 'SELECT 1 AS X FROM RDB$DATABASE';
          Q.Open;
          Result := Q.Fields[0].AsInteger = 1;
        finally
          Q.Free;
        end;
      finally
        Conn.Connected := False;
      end;
    except
      on E: Exception do
      begin
        ErrorMsg := Format('[%s] %s', [E.ClassName, E.Message]);
        Result := False;
      end;
    end;
  finally
//    Conn.Free;
  end;
end;

procedure AlterSysdbaPassword(AConn: TFDConnection; const NewPassword: string);
var
  Escaped: string;
begin
  // Single quotes in the password must be doubled for SQL. The password
  // alphabet excludes single quote on purpose, but the routine is defensive
  // in case a future caller passes a manually-typed password.
  Escaped := StringReplace(NewPassword, '''', '''''', [rfReplaceAll]);
  AConn.ExecSQL(Format('ALTER USER SYSDBA SET PASSWORD ''%s''', [Escaped]));
end;

function GenerateStrongPassword(APasswordLen: Integer = 24): string;
var
  Buf: TBytes;
  Idx, ByteIdx: Integer;
  rc: Integer;
begin
  if APasswordLen <= 0 then
    raise Exception.Create('GenerateStrongPassword: APasswordLen must be > 0.');

  // 4x oversample handles rejection sampling without needing a refill in
  // practically every run (worst-case rejection rate is ~13%).
  SetLength(Buf, APasswordLen * 4);
  rc := BCryptGenRandom(nil, @Buf[0], ULONG(Length(Buf)), BCRYPT_USE_SYSTEM_PREFERRED_RNG);
  if rc <> 0 then
    raise Exception.CreateFmt('BCryptGenRandom failed (NTSTATUS 0x%.8x).', [rc]);

  SetLength(Result, APasswordLen);
  Idx := 1;
  ByteIdx := 0;
  while Idx <= APasswordLen do
  begin
    if ByteIdx >= Length(Buf) then
    begin
      // Out of random bytes. Refill (extremely unlikely with 4x oversampling).
      rc := BCryptGenRandom(nil, @Buf[0], ULONG(Length(Buf)), BCRYPT_USE_SYSTEM_PREFERRED_RNG);
      if rc <> 0 then
        raise Exception.CreateFmt('BCryptGenRandom refill failed (NTSTATUS 0x%.8x).', [rc]);
      ByteIdx := 0;
    end;
    if Buf[ByteIdx] < REJECT_THRESHOLD then
    begin
      Result[Idx] := PASSWORD_ALPHABET[(Buf[ByteIdx] mod ALPHABET_LEN) + 1];
      Inc(Idx);
    end;
    Inc(ByteIdx);
  end;

  // Zero the entropy buffer -- the bytes used to derive password chars are
  // sensitive even after the password is in Result.
  FillChar(Buf[0], Length(Buf), 0);
end;

end.
