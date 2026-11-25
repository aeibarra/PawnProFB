unit uPrinting;

{ Where every printed document goes.

  A store sets up a few PHYSICAL printers per PC (PawnPro.ini [PRINTERS],
  per PC because each PC can see the same network printer under a different
  name), and every document is routed to one of them here. Screens never
  read printer names themselves: they ask CanPrint (show the button?) and
  GetPrintTarget (where, and is it there?).

    Printer            Documents
    -----------------  -----------------------------------------------------
    Page printer       police form (laser types 2, 3); Letter receipts
    Letter receipts    optional: another printer and/or tray for the Letter
                       receipts ("same as page printer" by default)
    Dot-matrix         police form, dot-matrix types 1 and 4
    Receipt (80 mm)    every receipt that has an 80 mm layout
    Envelope label     envelope item labels (1.1" x 3.5")

  A receipt prints on the receipt printer in its 80 mm layout; when this PC
  has no receipt printer, or the receipt has no 80 mm layout yet, it prints
  its Letter layout on the page printer (or the Letter receipts printer).

  Lists and reports are not routed: they open in preview and print through
  the preview's print dialog, as before.

  Settings before 2026-11 were per document (POLICEREP, PAYRECEIPTPRN,
  LAYAWAYRCPTPRN, EnvelopeLabelPrinterName + Use* flags). They are read once
  to fill the new keys while SettingsVersion is missing, and never written
  again, so an upgrading PC keeps printing where it did. }

interface

uses
  System.SysUtils, Vcl.Controls;

type
  TPrintDoc = (pdPoliceForm, pdPawnPaymentRcpt, pdLayawayRcpt, pdSaleRcpt, pdEnvelopeLabel);

  TPrinterSettings = record
    PagePrinter, PagePrinterBin: string;
    LetterRcptPrinter: string;   // '' = same as the page printer
    LetterRcptBin: string;       // '' = the printer's default tray
    ReceiptPrinter: string;      // 80 mm
    EnvelopeLabelPrinter: string;
    DotMatrixPrinter: string;
  end;

  TPrintTarget = record
    PrinterName: string;
    Bin: string;            // '' = the printer's default tray
    Thermal: boolean;       // print the 80 mm layout (else Letter / the only one)
    Why: string;            // when not resolved: what is missing, for the user
  end;

const
  // The documents listed in Printer Settings' "What prints where".
  PrintDocsListed: array[0..4] of TPrintDoc =
    (pdPoliceForm, pdPawnPaymentRcpt, pdLayawayRcpt, pdSaleRcpt, pdEnvelopeLabel);

var
  // This PC's printers, loaded at startup (TDM) and after Printer Settings.
  AppPrinterSettings: TPrinterSettings;

function PrintDocName(Doc: TPrintDoc): string;
function IsDotMatrixPoliceForm(PoliceFormType: integer): boolean;
function PrinterInstalled(const PrinterName: string): boolean;

procedure ReloadPrinterSettings;
procedure SavePrinterSettings(const S: TPrinterSettings);

{ The routing rules, on any settings (Printer Settings shows its unsaved
  choices with it). False when no printer is set for Doc; T.Why says why. }
function ResolvePrintTarget(const S: TPrinterSettings; Doc: TPrintDoc;
  PoliceFormType: integer; out T: TPrintTarget): boolean;

{ This PC has a printer set for Doc (drives the print buttons' visibility). }
function CanPrint(Doc: TPrintDoc): boolean;

{ Where Doc prints on this PC. False, after telling the user what to set up,
  when no printer is set or the one set is not installed here: nothing must
  silently go to whatever printer Windows or ReportBuilder falls back to. }
function GetPrintTarget(Doc: TPrintDoc; out T: TPrintTarget; Parent: TWinControl = nil): boolean;

{ A one-page test print naming the printer and what it is used for, on its
  default tray (never a tray of pre-printed forms). }
procedure PrintTestPage(const PrinterName, UsedFor: string; Parent: TWinControl = nil);

implementation

uses
  System.IniFiles, Vcl.Printers, Vcl.Graphics, PawnGlobal, PawnDM, uPawnDialogs;

const
  SEC = 'PRINTERS';
  KEY_VERSION        = 'SettingsVersion';
  KEY_PAGE           = 'PagePrinter';
  KEY_PAGE_BIN       = 'PagePrinterBin';
  KEY_LETTER_RCPT    = 'LetterReceiptPrinter';
  KEY_LETTER_RCPT_BIN = 'LetterReceiptPrinterBin';
  KEY_RECEIPT        = 'ReceiptPrinter';
  KEY_ENVELOPE       = 'EnvelopeLabelPrinter';
  KEY_DOT_MATRIX     = 'DotMatrixPrinter';
  SETTINGS_VERSION   = 2;

  // Which layouts exist. A receipt with neither cannot print yet.
  HasThermalLayout: array[TPrintDoc] of boolean = (False, False, False, False, False);
  HasLetterLayout:  array[TPrintDoc] of boolean = (False, True,  True,  False, False);

  IsReceipt: array[TPrintDoc] of boolean = (False, True, True, True, False);

function PrintDocName(Doc: TPrintDoc): string;
begin
  case Doc of
    pdPoliceForm:      Result := 'Police form';
    pdPawnPaymentRcpt: Result := 'Pawn payment receipt';
    pdLayawayRcpt:     Result := 'Layaway receipt';
    pdSaleRcpt:        Result := 'Sale receipt';
    pdEnvelopeLabel:   Result := 'Envelope label';
  else
    Result := '';
  end;
end;

function IsDotMatrixPoliceForm(PoliceFormType: integer): boolean;
begin
  Result := PoliceFormType in [1, 4];
end;

function PrinterInstalled(const PrinterName: string): boolean;
begin
  Result := (PrinterName <> '') and (Printer.Printers.IndexOf(PrinterName) >= 0);
end;

function CurrentPoliceFormType: integer;
begin
  if (DM <> nil) and DM.qryStore.Active then
    Result := DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger
  else
    Result := 2;
end;

{ ---- settings ------------------------------------------------------------- }

function YN(const S: string): boolean;
begin
  Result := SameText(Trim(S), 'Y') or SameText(Trim(S), 'YES') or (Trim(S) = '1');
end;

{ First load on a PC set up with the per-document keys: map them onto the
  printers. The police printer is the page printer, unless the store prints
  a dot-matrix form, then it is the dot-matrix printer and the receipt
  printer (if any) becomes the page printer. The receipt printer and tray of
  the Letter receipts are kept as the "Letter receipts" choice. }
procedure MigrateOldKeys(Ini: TIniFile; var S: TPrinterSettings);
var
  Police, PoliceBin, Pay, PayBin, Lay, LayBin, Rcpt, RcptBin: string;
  UsePay, UseLay: boolean;
begin
  Police    := Ini.ReadString(SEC, 'POLICEREP', '');
  PoliceBin := Ini.ReadString(SEC, 'POLICEREPBIN', '');

  UsePay := YN(Ini.ReadString(SEC, 'UsePaymentReceiptPrinter', 'N'));
  Pay    := Ini.ReadString(SEC, 'PAYRECEIPTPRN', '');
  PayBin := Ini.ReadString(SEC, 'PAYRECEIPTPRNBIN', '');
  // The layaway receipt used to borrow the payment receipt's settings.
  UseLay := YN(Ini.ReadString(SEC, 'UseLayawayReceiptPrinter', YesNo[UsePay]));
  Lay    := Ini.ReadString(SEC, 'LAYAWAYRCPTPRN', Pay);
  LayBin := Ini.ReadString(SEC, 'LAYAWAYRCPTPRNBIN', PayBin);

  Rcpt := '';
  RcptBin := '';
  if UsePay and (Pay <> '') then
    begin
      Rcpt := Pay;
      RcptBin := PayBin;
    end
  else if UseLay and (Lay <> '') then
    begin
      Rcpt := Lay;
      RcptBin := LayBin;
    end;

  if IsDotMatrixPoliceForm(CurrentPoliceFormType) then
    begin
      S.DotMatrixPrinter := Police;
      S.PagePrinter := Rcpt;
      S.PagePrinterBin := RcptBin;
    end
  else
    begin
      S.PagePrinter := Police;
      S.PagePrinterBin := PoliceBin;
      if S.PagePrinter = '' then
        S.PagePrinter := Rcpt;
    end;

  if SameText(Rcpt, S.PagePrinter) then
    S.LetterRcptPrinter := ''          // same printer: only the tray may differ
  else
    S.LetterRcptPrinter := Rcpt;
  S.LetterRcptBin := RcptBin;

  if YN(Ini.ReadString(SEC, 'UseEnvelopeLabelPrinter', 'N')) then
    S.EnvelopeLabelPrinter := Ini.ReadString(SEC, 'EnvelopeLabelPrinterName', '');
end;

procedure ReloadPrinterSettings;
var
  Ini: TIniFile;
  S: TPrinterSettings;
begin
  S := Default(TPrinterSettings);
  Ini := TIniFile.Create(GlobalIniFile);
  try
    if Ini.ReadInteger(SEC, KEY_VERSION, 0) < SETTINGS_VERSION then
      MigrateOldKeys(Ini, S)
    else
      begin
        S.PagePrinter          := Ini.ReadString(SEC, KEY_PAGE, '');
        S.PagePrinterBin       := Ini.ReadString(SEC, KEY_PAGE_BIN, '');
        S.LetterRcptPrinter    := Ini.ReadString(SEC, KEY_LETTER_RCPT, '');
        S.LetterRcptBin        := Ini.ReadString(SEC, KEY_LETTER_RCPT_BIN, '');
        S.ReceiptPrinter       := Ini.ReadString(SEC, KEY_RECEIPT, '');
        S.EnvelopeLabelPrinter := Ini.ReadString(SEC, KEY_ENVELOPE, '');
        S.DotMatrixPrinter     := Ini.ReadString(SEC, KEY_DOT_MATRIX, '');
      end;
  finally
    Ini.Free;
  end;
  AppPrinterSettings := S;
end;

procedure SavePrinterSettings(const S: TPrinterSettings);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(GlobalIniFile);
  try
    Ini.WriteString(SEC, KEY_PAGE,            S.PagePrinter);
    Ini.WriteString(SEC, KEY_PAGE_BIN,        S.PagePrinterBin);
    Ini.WriteString(SEC, KEY_LETTER_RCPT,     S.LetterRcptPrinter);
    Ini.WriteString(SEC, KEY_LETTER_RCPT_BIN, S.LetterRcptBin);
    Ini.WriteString(SEC, KEY_RECEIPT,         S.ReceiptPrinter);
    Ini.WriteString(SEC, KEY_ENVELOPE,        S.EnvelopeLabelPrinter);
    Ini.WriteString(SEC, KEY_DOT_MATRIX,      S.DotMatrixPrinter);
    // Last: from now on the old per-document keys are not read.
    Ini.WriteInteger(SEC, KEY_VERSION, SETTINGS_VERSION);
  finally
    Ini.Free;
  end;
  AppPrinterSettings := S;
end;

{ ---- routing -------------------------------------------------------------- }

function ResolvePrintTarget(const S: TPrinterSettings; Doc: TPrintDoc;
  PoliceFormType: integer; out T: TPrintTarget): boolean;
begin
  T := Default(TPrintTarget);

  if IsReceipt[Doc] then
    begin
      if HasThermalLayout[Doc] and (S.ReceiptPrinter <> '') then
        begin
          T.PrinterName := S.ReceiptPrinter;
          T.Thermal := True;
        end
      else if HasLetterLayout[Doc] then
        begin
          if S.LetterRcptPrinter <> '' then
            T.PrinterName := S.LetterRcptPrinter
          else
            T.PrinterName := S.PagePrinter;
          T.Bin := S.LetterRcptBin;
          if T.PrinterName = '' then
            T.Why := 'No page printer is set up on this PC.';
        end
      else
        T.Why := 'This receipt cannot be printed yet.';
    end
  else
    case Doc of
      pdPoliceForm:
        if IsDotMatrixPoliceForm(PoliceFormType) then
          begin
            T.PrinterName := S.DotMatrixPrinter;
            if T.PrinterName = '' then
              T.Why := 'No dot-matrix printer is set up on this PC.';
          end
        else
          begin
            T.PrinterName := S.PagePrinter;
            T.Bin := S.PagePrinterBin;
            if T.PrinterName = '' then
              T.Why := 'No page printer is set up on this PC.';
          end;
      pdEnvelopeLabel:
        begin
          T.PrinterName := S.EnvelopeLabelPrinter;
          if T.PrinterName = '' then
            T.Why := 'No envelope label printer is set up on this PC.';
        end;
    end;

  Result := T.PrinterName <> '';
end;

function CanPrint(Doc: TPrintDoc): boolean;
var
  T: TPrintTarget;
begin
  Result := ResolvePrintTarget(AppPrinterSettings, Doc, CurrentPoliceFormType, T);
end;

function GetPrintTarget(Doc: TPrintDoc; out T: TPrintTarget; Parent: TWinControl): boolean;
begin
  Result := ResolvePrintTarget(AppPrinterSettings, Doc, CurrentPoliceFormType, T);
  if not Result then
    begin
      PawnWarn(Format('%s: nothing was printed.'#13#10#13#10'%s'#13#10 +
                      'Set it up in Settings > Printer Settings.',
                      [PrintDocName(Doc), T.Why]), 'Print', Parent);
      exit;
    end;

  if not PrinterInstalled(T.PrinterName) then
    begin
      PawnWarn(Format('%s: nothing was printed.'#13#10#13#10 +
                      'The printer "%s" is not installed on this PC (renamed, ' +
                      'removed, or the network printer is not reachable).'#13#10 +
                      'Check it in Windows, or choose another one in Settings > Printer Settings.',
                      [PrintDocName(Doc), T.PrinterName]), 'Print', Parent);
      Result := False;
    end;
end;

procedure PrintTestPage(const PrinterName, UsedFor: string; Parent: TWinControl);
var
  Idx, OldIdx, X, Y, LineH: integer;

  procedure Line(const S: string);
  begin
    Printer.Canvas.TextOut(X, Y, S);
    Inc(Y, LineH);
  end;

begin
  Idx := Printer.Printers.IndexOf(PrinterName);
  if Idx < 0 then
    begin
      PawnWarn(Format('The printer "%s" is not installed on this PC.', [PrinterName]),
               'Test Print', Parent);
      exit;
    end;

  OldIdx := Printer.PrinterIndex;
  Printer.PrinterIndex := Idx;
  try
    Printer.Title := 'PawnPro test page';
    Printer.BeginDoc;
    try
      Printer.Canvas.Font.Name := 'Segoe UI';
      Printer.Canvas.Font.Size := 10;
      LineH := Round(Printer.Canvas.TextHeight('Xg') * 1.3);
      // A small margin that also suits an 80 mm roll.
      X := Round(Printer.PageWidth * 0.04);
      Y := LineH;
      Printer.Canvas.Font.Style := [fsBold];
      Line('PawnPro test page');
      Printer.Canvas.Font.Style := [];
      Line('Printer: ' + PrinterName);
      Line('Used for: ' + UsedFor);
      Line(FormatDateTime('mm/dd/yyyy hh:nn', Now));
    finally
      Printer.EndDoc;
    end;
  finally
    Printer.PrinterIndex := OldIdx;
  end;
end;

end.
