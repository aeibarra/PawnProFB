unit SetupBarcodePrinter;

{ Printer Settings.

  Top: the printers of THIS PC (PawnPro.ini), one row each, with a Test
  button. Middle: the settings of the whole STORE (police form type and
  copies, in STORE). Bottom: "What prints where", worked out live from the
  choices on screen by the same rules the app prints with (uPrinting), so
  nobody has to know the rules to check the result. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Printers, Buttons, Vcl.Mask, RzEdit, RzSpnEdt,
  Vcl.ExtCtrls, RzButton, RzCmboBx, RzLabel, RzPanel, Vcl.ComCtrls, uPrinting;

type
  TfrmSetupBarcodePrinter = class(TForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnExit: TRzBitBtn;
    gbThisPC: TGroupBox;
    lblHdrPrinter: TLabel;
    lblHdrTray: TLabel;
    lblPagePrinter: TLabel;
    cbPagePrinter: TComboBox;
    cbPagePrinterBin: TComboBox;
    btnTestPage: TRzBitBtn;
    lblLetterRcpt: TLabel;
    cbLetterRcptPrinter: TComboBox;
    cbLetterRcptBin: TComboBox;
    btnTestLetterRcpt: TRzBitBtn;
    lblReceiptPrinter: TLabel;
    cbReceiptPrinter: TComboBox;
    btnTestReceipt: TRzBitBtn;
    lblEnvelopePrinter: TLabel;
    cbEnvelopePrinter: TComboBox;
    btnTestEnvelope: TRzBitBtn;
    lblDotMatrix: TLabel;
    cbDotMatrixPrinter: TComboBox;
    btnTestDotMatrix: TRzBitBtn;
    gbStore: TGroupBox;
    lblPoliceForm: TLabel;
    cbTypeOfPoliceReport: TRzComboBox;
    lblLaserCopies: TLabel;
    edLaserCopies: TRzSpinEdit;
    gbWhere: TGroupBox;
    lvWhere: TListView;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cbTypeOfPoliceReportChange(Sender: TObject);
    procedure cbPagePrinterChange(Sender: TObject);
    procedure cbLetterRcptPrinterChange(Sender: TObject);
    procedure SettingChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    FLoading: boolean;
    procedure FillPrinters(Combo: TComboBox; const FirstItem, Current: string);
    function ComboPrinter(Combo: TComboBox): string;
    procedure FillBins(Combo: TComboBox; const PrinterName, Current: string);
    function ComboBin(Combo: TComboBox): string;
    function ScreenSettings: TPrinterSettings;
    function PoliceFormType: integer;
    procedure UpdateWhere;
  end;

var
  frmSetupBarcodePrinter: TfrmSetupBarcodePrinter;

implementation

Uses PawnGlobal, PawnDM, uPawnDialogs;

{$R *.dfm}

const
  NoPrinter = '(none)';
  SameAsPage = '(same as page printer)';
  DefaultTray = '(default tray)';
  NotInstalled = '  (not installed on this PC)';

{ ---- printer and tray lists ---------------------------------------------- }

{ FirstItem ('(none)' or '(same as page printer)') stands for ''. A saved
  printer this PC no longer has stays in the list, marked, so saving does not
  quietly drop it and the list below shows the problem. }
procedure TfrmSetupBarcodePrinter.FillPrinters(Combo: TComboBox; const FirstItem, Current: string);
begin
  Combo.Items.BeginUpdate;
  try
    Combo.Items.Clear;
    Combo.Items.Add(FirstItem);
    Combo.Items.AddStrings(Printer.Printers);
    if (Current <> '') and (Printer.Printers.IndexOf(Current) < 0) then
      Combo.Items.Add(Current + NotInstalled);
  finally
    Combo.Items.EndUpdate;
  end;

  if Current = '' then
    Combo.ItemIndex := 0
  else if Printer.Printers.IndexOf(Current) >= 0 then
    Combo.ItemIndex := Combo.Items.IndexOf(Current)
  else
    Combo.ItemIndex := Combo.Items.Count - 1;
end;

function TfrmSetupBarcodePrinter.ComboPrinter(Combo: TComboBox): string;
begin
  if Combo.ItemIndex <= 0 then
    exit('');
  Result := Combo.Items[Combo.ItemIndex];
  if Result.EndsWith(NotInstalled) then
    Result := Copy(Result, 1, Length(Result) - Length(NotInstalled));
end;

procedure TfrmSetupBarcodePrinter.FillBins(Combo: TComboBox; const PrinterName, Current: string);
var
  Bin: string;
begin
  Combo.Items.BeginUpdate;
  try
    Combo.Items.Clear;
    Combo.Items.Add(DefaultTray);
    if PrinterName <> '' then
      for Bin in GetPrinterBinNames(PrinterName) do
        Combo.Items.Add(Bin);
  finally
    Combo.Items.EndUpdate;
  end;
  Combo.ItemIndex := Combo.Items.IndexOf(Current);
  if Combo.ItemIndex < 0 then
    Combo.ItemIndex := 0;
end;

function TfrmSetupBarcodePrinter.ComboBin(Combo: TComboBox): string;
begin
  if Combo.ItemIndex <= 0 then
    Result := ''
  else
    Result := Combo.Items[Combo.ItemIndex];
end;

{ ---- show / save ---------------------------------------------------------- }

procedure TfrmSetupBarcodePrinter.FormShow(Sender: TObject);
var
  S: TPrinterSettings;
  Idx: integer;
begin
  FLoading := True;
  try
    DM.RefreshStoreQry;
    ReloadPrinterSettings;
    S := AppPrinterSettings;

    cbTypeOfPoliceReport.AddItemValue('Dot Matrix Printer. Preprinted Police Report (10-0920)', '1');
    cbTypeOfPoliceReport.AddItemValue('Dot Matrix Printer. Preprinted Police Report (10-0924)', '4');
    cbTypeOfPoliceReport.AddItemValue('Laser Printer. Generate Police Report Form', '2');
    cbTypeOfPoliceReport.AddItemValue('Laser Printer. Fill Pre-Printed Police Report Form (10-0909)', '3');
    Idx := cbTypeOfPoliceReport.Values.IndexOf(DM.qryStorePOLICE_REPORT_TO_PRINT.AsString);
    if Idx < 0 then
      Idx := 0;
    cbTypeOfPoliceReport.ItemIndex := Idx;
    edLaserCopies.Value := DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger;

    FillPrinters(cbPagePrinter, NoPrinter, S.PagePrinter);
    FillBins(cbPagePrinterBin, S.PagePrinter, S.PagePrinterBin);
    FillPrinters(cbLetterRcptPrinter, SameAsPage, S.LetterRcptPrinter);
    if S.LetterRcptPrinter <> '' then
      FillBins(cbLetterRcptBin, S.LetterRcptPrinter, S.LetterRcptBin)
    else
      FillBins(cbLetterRcptBin, S.PagePrinter, S.LetterRcptBin);
    FillPrinters(cbReceiptPrinter, NoPrinter, S.ReceiptPrinter);
    FillPrinters(cbEnvelopePrinter, NoPrinter, S.EnvelopeLabelPrinter);
    FillPrinters(cbDotMatrixPrinter, NoPrinter, S.DotMatrixPrinter);
  finally
    FLoading := False;
  end;
  cbTypeOfPoliceReportChange(nil);   // also fills "What prints where"
end;

function TfrmSetupBarcodePrinter.ScreenSettings: TPrinterSettings;
begin
  Result := Default(TPrinterSettings);
  Result.PagePrinter          := ComboPrinter(cbPagePrinter);
  Result.PagePrinterBin       := ComboBin(cbPagePrinterBin);
  Result.LetterRcptPrinter    := ComboPrinter(cbLetterRcptPrinter);
  Result.LetterRcptBin        := ComboBin(cbLetterRcptBin);
  Result.ReceiptPrinter       := ComboPrinter(cbReceiptPrinter);
  Result.EnvelopeLabelPrinter := ComboPrinter(cbEnvelopePrinter);
  // Kept even while hidden (a laser form): switching back finds it again.
  Result.DotMatrixPrinter     := ComboPrinter(cbDotMatrixPrinter);
end;

function TfrmSetupBarcodePrinter.PoliceFormType: integer;
begin
  if cbTypeOfPoliceReport.ItemIndex < 0 then
    Result := 0
  else
    Result := StrToIntDef(cbTypeOfPoliceReport.Value, 0);
end;

procedure TfrmSetupBarcodePrinter.btnSaveClick(Sender: TObject);
begin
  SavePrinterSettings(ScreenSettings);

  DM.qryStore.Edit;
  DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger := Trunc(edLaserCopies.Value);
  if PoliceFormType in [1, 2, 3, 4] then
    DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger := PoliceFormType;
  DM.qryStore.Post;

  ModalResult := mrOk;
end;

procedure TfrmSetupBarcodePrinter.btnExitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

{ ---- changes -------------------------------------------------------------- }

{ The dot-matrix row matters only for the dot-matrix forms; laser copies only
  for the laser ones. }
procedure TfrmSetupBarcodePrinter.cbTypeOfPoliceReportChange(Sender: TObject);
var
  DotMatrix: boolean;
begin
  DotMatrix := IsDotMatrixPoliceForm(PoliceFormType);
  lblDotMatrix.Visible := DotMatrix;
  cbDotMatrixPrinter.Visible := DotMatrix;
  btnTestDotMatrix.Visible := DotMatrix;
  lblLaserCopies.Enabled := not DotMatrix;
  edLaserCopies.Enabled := not DotMatrix;
  UpdateWhere;
end;

procedure TfrmSetupBarcodePrinter.cbPagePrinterChange(Sender: TObject);
begin
  FillBins(cbPagePrinterBin, ComboPrinter(cbPagePrinter), '');
  if ComboPrinter(cbLetterRcptPrinter) = '' then
    FillBins(cbLetterRcptBin, ComboPrinter(cbPagePrinter), '');
  UpdateWhere;
end;

procedure TfrmSetupBarcodePrinter.cbLetterRcptPrinterChange(Sender: TObject);
begin
  if ComboPrinter(cbLetterRcptPrinter) <> '' then
    FillBins(cbLetterRcptBin, ComboPrinter(cbLetterRcptPrinter), '')
  else
    FillBins(cbLetterRcptBin, ComboPrinter(cbPagePrinter), '');
  UpdateWhere;
end;

procedure TfrmSetupBarcodePrinter.SettingChange(Sender: TObject);
begin
  UpdateWhere;
end;

{ Each row's Test button: a one-page test on that row's printer. }
procedure TfrmSetupBarcodePrinter.btnTestClick(Sender: TObject);
var
  Name, UsedFor: string;
begin
  if Sender = btnTestPage then
    begin
      Name := ComboPrinter(cbPagePrinter);
      UsedFor := 'Page printer (Letter)';
    end
  else if Sender = btnTestLetterRcpt then
    begin
      Name := ComboPrinter(cbLetterRcptPrinter);
      if Name = '' then
        Name := ComboPrinter(cbPagePrinter);
      UsedFor := 'Letter receipts';
    end
  else if Sender = btnTestReceipt then
    begin
      Name := ComboPrinter(cbReceiptPrinter);
      UsedFor := 'Receipt printer (80 mm)';
    end
  else if Sender = btnTestEnvelope then
    begin
      Name := ComboPrinter(cbEnvelopePrinter);
      UsedFor := 'Envelope label printer';
    end
  else
    begin
      Name := ComboPrinter(cbDotMatrixPrinter);
      UsedFor := 'Dot-matrix printer (police form)';
    end;

  if Name = '' then
    PawnInfo('Choose a printer on this row first.', 'Test Print', Self)
  else
    PrintTestPage(Name, UsedFor, Self);
end;

{ ---- what prints where ---------------------------------------------------- }

procedure TfrmSetupBarcodePrinter.UpdateWhere;
var
  S: TPrinterSettings;
  Doc: TPrintDoc;
  T: TPrintTarget;
  Txt: string;
  Item: TListItem;
begin
  if FLoading then
    exit;
  S := ScreenSettings;

  lvWhere.Items.BeginUpdate;
  try
    lvWhere.Items.Clear;
    for Doc in PrintDocsListed do
      begin
        if ResolvePrintTarget(S, Doc, PoliceFormType, T) then
          begin
            Txt := T.PrinterName;
            if T.Bin <> '' then
              Txt := Txt + ', ' + T.Bin;
            if Doc in [pdPawnPaymentRcpt, pdLayawayRcpt, pdSaleRcpt] then
              if T.Thermal then
                Txt := Txt + '  (80 mm)'
              else
                Txt := Txt + '  (Letter)';
            if not PrinterInstalled(T.PrinterName) then
              Txt := Txt + '  - NOT INSTALLED on this PC';
          end
        else
          Txt := 'Does not print: ' + T.Why;

        Item := lvWhere.Items.Add;
        Item.Caption := PrintDocName(Doc);
        Item.SubItems.Add(Txt);
      end;
  finally
    lvWhere.Items.EndUpdate;
  end;
end;

end.
