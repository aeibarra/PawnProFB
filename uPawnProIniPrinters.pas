unit uPawnProIniPrinters;

interface

uses
  SysUtils, IniFiles, PawnGlobal;

const
  C_SEC_PRINTERS    = 'PRINTERS';

  // Existing keys
  C_KEY_POLICEREP        = 'POLICEREP';
  C_KEY_POLICEREPBIN     = 'POLICEREPBIN';

  C_KEY_PAYRECEIPTPRN    = 'PAYRECEIPTPRN';
  C_KEY_PAYRECEIPTPRNBIN = 'PAYRECEIPTPRNBIN';
  C_KEY_USE_PAY_RECEIPT_PRN   = 'UsePaymentReceiptPrinter';

  C_KEY_USE_ENVELOPE_PRN      = 'UseEnvelopeLabelPrinter';
  C_KEY_ENVELOPE_PRN_NAME     = 'EnvelopeLabelPrinterName';

type
  TPrinterIniSettings = record
    // Existing:
    PoliceReportPrinter:     string;  // POLICEREP
    PoliceReportBin:         string;  // POLICEREPBIN

    UsePaymentReceiptPrinter: Boolean; // Y/N in INI
    PayReceiptPrinter:       string;  // PAYRECEIPTPRN
    PayReceiptPrinterBin:    string;  // PAYRECEIPTPRNBIN

    UseEnvelopeLabelPrinter:  Boolean; // Y/N in INI
    EnvelopeLabelPrinterName: string;
  end;

var
  AppPrinterSettings: TPrinterIniSettings;

procedure LoadPrinterSettingsFromIni(const AFileName: string; var Settings: TPrinterIniSettings);
procedure SavePrinterSettingsToIni(const AFileName: string; const Settings: TPrinterIniSettings);

implementation

function BoolToYN(const B: Boolean): string;
begin
  Result := YesNo[B];
end;

function YNToBool(const S: string): Boolean;
begin
  Result := SameText(Trim(S), 'Y') or SameText(Trim(S), 'YES') or (Trim(S) = '1');
end;

procedure LoadPrinterSettingsFromIni(const AFileName: string; var Settings: TPrinterIniSettings);
var
  Ini: TIniFile;
  S: string;
begin
  Ini := TIniFile.Create(AFileName);
  try
    // Existing entries (with safe defaults)
    Settings.PoliceReportPrinter   := Ini.ReadString(C_SEC_PRINTERS, C_KEY_POLICEREP,        '');
    Settings.PoliceReportBin       := Ini.ReadString(C_SEC_PRINTERS, C_KEY_POLICEREPBIN,     '');

    // UsePaymentReceiptPrinter (Y/N ? Boolean)
    S := Ini.ReadString(C_SEC_PRINTERS, C_KEY_USE_PAY_RECEIPT_PRN, 'N');
    Settings.UsePaymentReceiptPrinter := YNToBool(S);

    Settings.PayReceiptPrinter     := Ini.ReadString(C_SEC_PRINTERS, C_KEY_PAYRECEIPTPRN,    '');
    Settings.PayReceiptPrinterBin  := Ini.ReadString(C_SEC_PRINTERS, C_KEY_PAYRECEIPTPRNBIN, '');

    // UseEnvelopeLabelPrinter
    S := Ini.ReadString(C_SEC_PRINTERS, C_KEY_USE_ENVELOPE_PRN, 'N');
    Settings.UseEnvelopeLabelPrinter := YNToBool(S);

    // EnvelopeLabelPrinterName
    Settings.EnvelopeLabelPrinterName := Ini.ReadString(C_SEC_PRINTERS, C_KEY_ENVELOPE_PRN_NAME, '');
  finally
    Ini.Free;
  end;
end;

procedure SavePrinterSettingsToIni(const AFileName: string; const Settings: TPrinterIniSettings);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(AFileName);
  try
    // Existing
    Ini.WriteString(C_SEC_PRINTERS, C_KEY_POLICEREP,        Settings.PoliceReportPrinter);
    Ini.WriteString(C_SEC_PRINTERS, C_KEY_POLICEREPBIN,     Settings.PoliceReportBin);

    Ini.WriteString(C_SEC_PRINTERS, C_KEY_USE_PAY_RECEIPT_PRN, BoolToYN(Settings.UsePaymentReceiptPrinter));
    Ini.WriteString(C_SEC_PRINTERS, C_KEY_PAYRECEIPTPRN,    Settings.PayReceiptPrinter);
    Ini.WriteString(C_SEC_PRINTERS, C_KEY_PAYRECEIPTPRNBIN, Settings.PayReceiptPrinterBin);

    Ini.WriteString(C_SEC_PRINTERS, C_KEY_USE_ENVELOPE_PRN, BoolToYN(Settings.UseEnvelopeLabelPrinter));
    Ini.WriteString(C_SEC_PRINTERS, C_KEY_ENVELOPE_PRN_NAME, Settings.EnvelopeLabelPrinterName);
  finally
    Ini.Free;
  end;
end;

end.


