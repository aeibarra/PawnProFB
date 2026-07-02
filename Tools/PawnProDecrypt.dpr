program PawnProDecrypt;

// Offline vendor decrypter for encrypted PawnPro backups (*.fbk.enc).
//
// Lives on the vendor's vault drive / USB stick alongside vendor_secret.key
// (and vendor_public.key as the matching half). Takes an encrypted backup and
// writes the plaintext Firebird .fbk that gbak/Firebird can restore.
//
// The store's PawnPro.exe encrypts every backup to the vendor PUBLIC key, so
// only this tool (with the offline SECRET key) can decrypt. All stores use the
// same vendor keypair -- one tool decrypts any store's backup.
//
// Usage:
//   PawnProDecrypt.exe <EncDBPath> <PlainTextDBPath>
//   e.g. PawnProDecrypt.exe PawnPro_20260701_083000.fbk.enc PAWNDATA.fbk
//
// Files looked up in the working directory:
//   vendor_secret.key   32 bytes, raw binary
//   vendor_public.key   32 bytes, raw binary
//
// Then restore the plaintext .fbk the usual way, e.g.:
//   gbak -c -user sysdba -password <pw> PAWNDATA.fbk localhost:C:\DB\PAWNDATA.FDB

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  SealedBox in '..\..\COMMON\SealedBox.pas',
  Nvv.Crypto.FileEnvelope in '..\..\COMMON\Nvv.Crypto.FileEnvelope.pas';

const
  SECRET_KEY_FILE = 'vendor_secret.key';
  PUBLIC_KEY_FILE = 'vendor_public.key';

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
  EncPath, PlainPath: string;
  PubKey, SecretKey: TBytes;
begin
  Writeln('PawnPro backup decrypter');
  Writeln('------------------------');
  Writeln('');

  if ParamCount < 2 then
  begin
    Writeln('Usage: PawnProDecrypt.exe <EncDBPath> <PlainTextDBPath>');
    Writeln('  <EncDBPath>        encrypted backup produced by PawnPro (*.fbk.enc)');
    Writeln('  <PlainTextDBPath>  output path for the decrypted Firebird .fbk');
    Halt(1);
  end;

  EncPath   := ParamStr(1);
  PlainPath := ParamStr(2);

  if not FileExists(SECRET_KEY_FILE) then
  begin
    Writeln('ERROR: ' + SECRET_KEY_FILE + ' not found in working directory.');
    Halt(2);
  end;
  if not FileExists(EncPath) then
  begin
    Writeln('ERROR: encrypted backup not found: ' + EncPath);
    Halt(4);
  end;

  Writeln('Reading vendor secret key...');
  SecretKey := ReadAllBytes(SECRET_KEY_FILE);
  if Length(SecretKey) <> SEALBOX_SECRET_KEY_BYTES then
  begin
    Writeln(Format('ERROR: %s is %d bytes; expected %d.',
      [SECRET_KEY_FILE, Length(SecretKey), SEALBOX_SECRET_KEY_BYTES]));
    Halt(5);
  end;

  // The public key is optional: if vendor_public.key isn't alongside the secret
  // (e.g. the vault USB holds only the secret), derive it from the secret key.
  if FileExists(PUBLIC_KEY_FILE) then
  begin
    PubKey := ReadAllBytes(PUBLIC_KEY_FILE);
    if Length(PubKey) <> SEALBOX_PUBLIC_KEY_BYTES then
    begin
      Writeln(Format('ERROR: %s is %d bytes; expected %d.',
        [PUBLIC_KEY_FILE, Length(PubKey), SEALBOX_PUBLIC_KEY_BYTES]));
      Halt(6);
    end;
  end
  else
  begin
    Writeln(PUBLIC_KEY_FILE + ' not found -- deriving public key from secret.');
    PubKey := DerivePublicKey(SecretKey);
  end;

  Writeln('Decrypting ' + EncPath + ' ...');
  DecryptFileWithVendor(EncPath, PlainPath, PubKey, SecretKey);

  Writeln('');
  Writeln('Done. Plaintext backup written to:');
  Writeln('  ' + PlainPath);
  Writeln('');
  Writeln('Restore it with gbak, e.g.:');
  Writeln('  gbak -c -user sysdba -password <pw> "' + PlainPath +
          '" localhost:C:\DB\PAWNDATA.FDB');
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
