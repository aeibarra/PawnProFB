program SealedBoxTest;

// Quick round-trip verification for COMMON\SealedBox.pas.
// Generates a keypair, seals a sample string, opens it back, checks equality.
//
// Build with Delphi (console target, Win32 or Win64). Place libsodium.dll
// in the same folder as the EXE before running. Exit code 0 on success,
// nonzero on any failure.
//
// One-shot tool: keep around as a smoke-test artifact, no need to ship.

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  SealedBox in '..\..\COMMON\SealedBox.pas';

const
  SAMPLE = 'PawnPro-SealedBox-RoundTrip-Sample-Password-123!@#';

procedure Run;
var
  PubKey, SecretKey, Sealed, Opened: TBytes;
  PlainBytes: TBytes;
  Restored: string;
begin
  Writeln('SealedBox round-trip test');
  Writeln('-------------------------');

  Writeln('1. Generating keypair...');
  if not GenerateKeypair(PubKey, SecretKey) then
  begin
    Writeln('  FAIL: GenerateKeypair returned False');
    Halt(1);
  end;
  Writeln(Format('  PubKey:    %d bytes', [Length(PubKey)]));
  Writeln(Format('  SecretKey: %d bytes', [Length(SecretKey)]));

  Writeln('2. Sealing sample string...');
  PlainBytes := TEncoding.UTF8.GetBytes(SAMPLE);
  Sealed := SealedBoxSeal(PlainBytes, PubKey);
  Writeln(Format('  Plain:  %d bytes', [Length(PlainBytes)]));
  Writeln(Format('  Sealed: %d bytes (expect plain + %d)', [Length(Sealed), SEALBOX_OVERHEAD_BYTES]));
  if Length(Sealed) <> Length(PlainBytes) + SEALBOX_OVERHEAD_BYTES then
  begin
    Writeln('  FAIL: unexpected sealed length');
    Halt(2);
  end;

  Writeln('3. Opening sealed message...');
  Opened := SealedBoxOpen(Sealed, PubKey, SecretKey);
  Restored := TEncoding.UTF8.GetString(Opened);
  Writeln(Format('  Opened: %d bytes', [Length(Opened)]));

  Writeln('4. Comparing...');
  if Restored = SAMPLE then
    Writeln('  PASS: opened plaintext matches original.')
  else
  begin
    Writeln('  FAIL: mismatch.');
    Writeln('  Expected: ' + SAMPLE);
    Writeln('  Got:      ' + Restored);
    Halt(3);
  end;

  Writeln('');
  Writeln('All checks passed. libsodium loaded and crypto_box_seal works.');
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
