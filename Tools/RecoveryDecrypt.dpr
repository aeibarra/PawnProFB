program RecoveryDecrypt;

// Offline recovery decrypter. Lives on the vendor's vault drive alongside
// vendor_secret.key (and vendor_public.key as the matching half). Reads a
// customer-supplied recovery.dat, prints the password it contains.
//
// Used only when a customer loses both their password manager entry AND we
// need to recover. In that case the customer emails recovery.dat to the
// vendor; the vendor runs this tool on the vault machine.
//
// Usage:
//   RecoveryDecrypt.exe [path-to-recovery.dat]
// Defaults to .\recovery.dat if no arg given.
//
// Files looked up in the working directory:
//   vendor_secret.key   32 bytes, raw binary
//   vendor_public.key   32 bytes, raw binary

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  SealedBox in '..\..\COMMON\SealedBox.pas';

const
  SECRET_KEY_FILE = 'vendor_secret.key';
  PUBLIC_KEY_FILE = 'vendor_public.key';
  DEFAULT_RECOVERY_FILE = 'recovery.dat';

function ReadAllBytes(const FileName: string): TBytes;
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Result, FS.Size);
    if FS.Size > 0 then
      FS.ReadBuffer(Result[0], FS.Size);
  finally
    FS.Free;
  end;
end;

procedure Run;
var
  RecoveryPath: string;
  PubKey, SecretKey, Sealed, Plain: TBytes;
  Password: string;
begin
  Writeln('PawnPro recovery decrypter');
  Writeln('--------------------------');
  Writeln('');

  if ParamCount >= 1 then
    RecoveryPath := ParamStr(1)
  else
    RecoveryPath := DEFAULT_RECOVERY_FILE;

  if not FileExists(SECRET_KEY_FILE) then
  begin
    Writeln('ERROR: ' + SECRET_KEY_FILE + ' not found in working directory.');
    Halt(1);
  end;
  if not FileExists(PUBLIC_KEY_FILE) then
  begin
    Writeln('ERROR: ' + PUBLIC_KEY_FILE + ' not found in working directory.');
    Halt(2);
  end;
  if not FileExists(RecoveryPath) then
  begin
    Writeln('ERROR: recovery file not found: ' + RecoveryPath);
    Halt(3);
  end;

  Writeln('Reading keys and recovery file...');
  SecretKey := ReadAllBytes(SECRET_KEY_FILE);
  PubKey    := ReadAllBytes(PUBLIC_KEY_FILE);
  Sealed    := ReadAllBytes(RecoveryPath);

  if Length(SecretKey) <> SEALBOX_SECRET_KEY_BYTES then
  begin
    Writeln(Format('ERROR: %s is %d bytes; expected %d.',
      [SECRET_KEY_FILE, Length(SecretKey), SEALBOX_SECRET_KEY_BYTES]));
    Halt(4);
  end;
  if Length(PubKey) <> SEALBOX_PUBLIC_KEY_BYTES then
  begin
    Writeln(Format('ERROR: %s is %d bytes; expected %d.',
      [PUBLIC_KEY_FILE, Length(PubKey), SEALBOX_PUBLIC_KEY_BYTES]));
    Halt(5);
  end;

  Writeln('Decrypting...');
  Plain := SealedBoxOpen(Sealed, PubKey, SecretKey);
  Password := TEncoding.UTF8.GetString(Plain);

  Writeln('');
  Writeln('Recovered password:');
  Writeln('  ' + Password);
  Writeln('');
  Writeln('Give this to the customer. The current SYSDBA password on their');
  Writeln('database is the value above. They should change it via PawnProSetup');
  Writeln('Rotate Password mode immediately after recovery.');

  // Zero the buffer holding the cleartext.
  if Length(Plain) > 0 then
    FillChar(Plain[0], Length(Plain), 0);
end;

begin
  try
    Run;
    Halt(0);
  except
    on E: Exception do
    begin
      Writeln(Format('ERROR: [%s] %s', [E.ClassName, E.Message]));
      Halt(10);
    end;
  end;
end.
