unit uPawnIniDefaults;

interface

// EnsureIniDefaults: scans the INI file and writes a safe default for every
// required key that's missing. Never overwrites a value the user already set,
// even if blank. Models the same "fill in what's missing" pattern that the
// old ASA-era CheckForMissingDBChanges used for the database.
//
// Run this once at startup, BEFORE any code reads from the INI (otherwise
// the readers will fall back to their own per-call defaults, never visible
// in the INI file). Currently called from TDM.DataModuleCreate.
//
// Adding a new INI-backed setting?  Add one line to EnsureIniDefaults and
// you're done -- no other code change needed for first-run safety.

procedure EnsureIniDefaults(const AFileName: string);

implementation

uses
  System.SysUtils, System.Classes, IniFiles;

{ A UTF-8 BOM at the start of the INI silently breaks the FIRST section header.
  TIniFile goes through the Windows profile API, which sees the three BOM bytes
  as part of the line and therefore never matches "[CONNECTION_FB]". Every key
  in that section then falls back to its per-call default, so the app quietly
  connects to a different database -- or to none -- with no error anywhere.
  Worse, a later WriteString cannot find the section either and APPENDS a second
  copy of it at the end of the file, which then wins on the next startup.

  A BOM gets here easily: Notepad's "Save as UTF-8", a deployment script, or any
  editor used to set the per-store host and database path. Since PawnPro.ini is
  pure ASCII configuration, a BOM is never legitimate -- strip it and carry on.
  Failing to start would be a worse outcome than repairing it silently, but the
  repair is recorded so it is not invisible.

  Returns True if a BOM was found and removed. }
function StripUtf8BomIfPresent(const AFileName: string): Boolean;
const
  Bom: array[0..2] of Byte = ($EF, $BB, $BF);
var
  Stream: TFileStream;
  Head: array[0..2] of Byte;
  Body: TBytes;
begin
  Result := False;
  if not FileExists(AFileName) then
    Exit;
  try
    Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
    try
      if Stream.Size < Length(Bom) then
        Exit;
      Stream.ReadBuffer(Head, Length(Head));
      if not CompareMem(@Head, @Bom, Length(Bom)) then
        Exit;
      SetLength(Body, Stream.Size - Length(Bom));
      if Length(Body) > 0 then
        Stream.ReadBuffer(Body[0], Length(Body));
    finally
      Stream.Free;
    end;

    Stream := TFileStream.Create(AFileName, fmCreate);
    try
      if Length(Body) > 0 then
        Stream.WriteBuffer(Body[0], Length(Body));
    finally
      Stream.Free;
    end;
    Result := True;
  except
    // A settings file we cannot repair must not stop the app from starting.
    // The original symptom (defaults being used) is what the caller will see.
    Result := False;
  end;
end;

procedure EnsureKey(Ini: TIniFile; const Section, Key, DefaultValue: string);
begin
  if not Ini.ValueExists(Section, Key) then
    Ini.WriteString(Section, Key, DefaultValue);
end;

procedure EnsureIniDefaults(const AFileName: string);
var
  Ini: TIniFile;
  BomRemoved: Boolean;
begin
  // Before anything reads a key: a BOM here makes the first section invisible.
  BomRemoved := StripUtf8BomIfPresent(AFileName);

  Ini := TIniFile.Create(AFileName);
  try
    if BomRemoved then
      Ini.WriteString('DIAGNOSTICS', 'LastBomRepair',
        FormatDateTime('yyyy-mm-dd hh:nn:ss', Now, TFormatSettings.Invariant));

    // ----- [PRINTERS] -----
    // Police-report printer is the only one shown by default; the rest are
    // opt-in via these flags. Their respective buttons stay hidden until the
    // user flips the flag and configures the printer name.
    EnsureKey(Ini, 'PRINTERS', 'UsePaymentReceiptPrinter', 'N');
    EnsureKey(Ini, 'PRINTERS', 'UseEnvelopeLabelPrinter',  'N');
    EnsureKey(Ini, 'PRINTERS', 'EnvelopeLabelPrinterName', '');

    // ----- [LEADS_ONLINE] -----
    EnsureKey(Ini, 'LEADS_ONLINE', 'CSVPath', '');

    // ----- [IMAGE_STORAGE] -----
    EnsureKey(Ini, 'IMAGE_STORAGE', 'ImageDirectory', '');
    // DB image storage is retired in the Firebird version; default to FILE.
    EnsureKey(Ini, 'IMAGE_STORAGE', 'StorageMode', 'FILE');

    // ----- [DATABASE] -----
    // IsLocalDatabase is intentionally NOT seeded here. On first run, when the
    // key is absent, TDM.DataModuleCreate detects it from the configured FB
    // host (DetectDatabaseIsLocal) and writes the answer. Remote-DB stores
    // resolve to 'N' and lose the backup option (no backup drive attached).

    // ----- [IMAGE_BACKUP] -----
    EnsureKey(Ini, 'IMAGE_BACKUP', 'LastBackupDate', '');
    EnsureKey(Ini, 'IMAGE_BACKUP', 'LastAuditWeek', '');

    // ----- [GOLD_PRICE] -----
    EnsureKey(Ini, 'GOLD_PRICE', 'Url',
      'https://query1.finance.yahoo.com/v8/finance/chart/GC=F?interval=1m&range=1d');
    // Karats shown under the spot price, highest first. Blank hides the line.
    EnsureKey(Ini, 'GOLD_PRICE', 'Karats', '10,14,18');
    // G (gram) or P (pennyweight). Blank follows the store's own weight unit.
    EnsureKey(Ini, 'GOLD_PRICE', 'WeightUnit', '');

    // ----- [SETTINGS] -----
    EnsureKey(Ini, 'SETTINGS', 'SHOWGOLDPRICE', 'Y');

    // ----- [CONNECTION_FB] -----
    // Deployment defaults. The DB path is the production target; dev machines
    // override `database` by hand. Passwords are intentionally not defaulted
    // here; PawnDM prompts for the DB password and writes password_enc via
    // Windows DPAPI when needed.
    // 127.0.0.1, not 'localhost': a store hit intermittent getaddrinfo(localhost)
    // failures (WSANO_DATA) where Windows could not resolve the name; a literal IP
    // needs no name lookup. The server binds IPv4 (RemoteBindAddress=0.0.0.0), so
    // loopback IPv4 is always the right target for a local DB.
    EnsureKey(Ini, 'CONNECTION_FB', 'host',     '127.0.0.1');
    EnsureKey(Ini, 'CONNECTION_FB', 'database', 'C:\Pawn\PAWNDATA.FDB');
    EnsureKey(Ini, 'CONNECTION_FB', 'user',     'sysdba');
    EnsureKey(Ini, 'CONNECTION_FB', 'port',     '3050');
    EnsureKey(Ini, 'CONNECTION_FB', 'charset',  'UTF8');
  finally
    Ini.Free;
  end;
end;

end.
