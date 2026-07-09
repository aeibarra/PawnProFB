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
  IniFiles;

procedure EnsureKey(Ini: TIniFile; const Section, Key, DefaultValue: string);
begin
  if not Ini.ValueExists(Section, Key) then
    Ini.WriteString(Section, Key, DefaultValue);
end;

procedure EnsureIniDefaults(const AFileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(AFileName);
  try
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

    // ----- [SETTINGS] -----
    EnsureKey(Ini, 'SETTINGS', 'SHOWGOLDPRICE', 'Y');

    // ----- [CONNECTION_FB] -----
    // Deployment defaults. The DB path is the production target; dev machines
    // override `database` by hand. Passwords are intentionally not defaulted
    // here; PawnDM prompts for the DB password and writes password_enc via
    // Windows DPAPI when needed.
    EnsureKey(Ini, 'CONNECTION_FB', 'host',     'localhost');
    EnsureKey(Ini, 'CONNECTION_FB', 'database', 'C:\Pawn\PAWNDATA.FDB');
    EnsureKey(Ini, 'CONNECTION_FB', 'user',     'sysdba');
    EnsureKey(Ini, 'CONNECTION_FB', 'port',     '3050');
    EnsureKey(Ini, 'CONNECTION_FB', 'charset',  'UTF8');
  finally
    Ini.Free;
  end;
end;

end.
