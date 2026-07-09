unit SetupBarcodePrinter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Printers, IniFiles, Buttons, Vcl.Mask, RzEdit, RzSpnEdt,
  Vcl.ExtCtrls, RzButton, RzCmboBx, RzLabel, RzPanel;

type
  TfrmSetupBarcodePrinter = class(TForm)
    GroupBox1: TGroupBox;
    btnSelectPrintLabel: TBitBtn;
    GroupBox2: TGroupBox;
    cbPrinters: TComboBox;
    Label1: TLabel;
    btnExit: TRzBitBtn;
    cbTypeOfPoliceReport: TRzComboBox;
    Label3: TLabel;
    pnPoliceRptCopies: TRzPanel;
    edLaserCopies: TRzSpinEdit;
    RzLabel1: TRzLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    cbPrintersPayReceipt: TComboBox;
    cbPolicePrinterBins: TComboBox;
    cbPayReceiptBins: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    chkUsePaymentReceiptPrinter: TCheckBox;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    cbPrintersEnvelopeLabel: TComboBox;
    chkUseEnvelopeLabelPrinter: TCheckBox;
    procedure btnSelectPrintLabelClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbTypeOfPoliceReportChange(Sender: TObject);
    procedure cbPrintersChange(Sender: TObject);
    procedure cbPrintersPayReceiptChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PrinterKey, PrinterPaymentReceiptKey: string;
  end;

var
  frmSetupBarcodePrinter: TfrmSetupBarcodePrinter;

implementation

Uses PawnGlobal, PawnDM, uPawnProIniPrinters;

{$R *.dfm}

procedure TfrmSetupBarcodePrinter.btnSelectPrintLabelClick(Sender: TObject);
begin
  AppPrinterSettings.PoliceReportPrinter := cbPrinters.Text;
  AppPrinterSettings.PoliceReportBin := cbPolicePrinterBins.Text;

  AppPrinterSettings.UsePaymentReceiptPrinter := chkUsePaymentReceiptPrinter.Checked;
  AppPrinterSettings.PayReceiptPrinter := cbPrintersPayReceipt.Text;
  AppPrinterSettings.PayReceiptPrinterBin := cbPayReceiptBins.Text;

  AppPrinterSettings.UseEnvelopeLabelPrinter := chkUseEnvelopeLabelPrinter.Checked;
  AppPrinterSettings.EnvelopeLabelPrinterName := cbPrintersEnvelopeLabel.Text;

  SavePrinterSettingsToIni(GlobalIniFile, AppPrinterSettings);

  DM.qryStore.Edit;
  DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger := trunc(edLaserCopies.Value);

  if cbTypeOfPoliceReport.ItemIndex in [0, 1, 2, 3] then
    DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger := cbTypeOfPoliceReport.Value.ToInteger;// Values[cbTypeOfPoliceReport.ItemIndex];// idx := cbTypeOfPoliceReport.Values.IndexOf(IntToStr(DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger)); //cbTypeOfPoliceReport.ItemIndex + 1;

  DM.qryStore.Post;

  ModalResult := mrOk;
end;

procedure TfrmSetupBarcodePrinter.cbPrintersChange(Sender: TObject);
begin
  FillPrinterTrays(cbPolicePrinterBins, cbPrinters.Text);
end;

procedure TfrmSetupBarcodePrinter.cbPrintersPayReceiptChange(Sender: TObject);
begin
  FillPrinterTrays(cbPayReceiptBins, cbPrintersPayReceipt.Text);
end;

procedure TfrmSetupBarcodePrinter.cbTypeOfPoliceReportChange(Sender: TObject);
var
  V: integer;
  LaserPrinter: boolean;
begin
  V := cbTypeOfPoliceReport.Value.ToInteger;
  LaserPrinter := V in [2, 3];

  edLaserCopies.Enabled := LaserPrinter;
  pnPoliceRptCopies.Enabled := LaserPrinter;
end;

procedure TfrmSetupBarcodePrinter.btnExitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSetupBarcodePrinter.FormShow(Sender: TObject);
var
  idx: integer;
begin
  LoadPrinterSettingsFromIni(GlobalIniFile, AppPrinterSettings);

  cbTypeOfPoliceReport.AddItemValue('Dot Matrix Printer. Preprinted Police Report (10-0920)', '1');
  cbTypeOfPoliceReport.AddItemValue('Dot Matrix Printer. Preprinted Police Report (10-0924)', '4');
  cbTypeOfPoliceReport.AddItemValue('Laser Printer. Generate Police Report Form', '2');
  cbTypeOfPoliceReport.AddItemValue('Laser Printer. Fill Pre-Printed Police Report Form (10-0909)', '3');

  DM.RefreshStoreQry;

  edLaserCopies.Value := DM.qryStorePOLICE_REPORT_LASER_COPIES.AsInteger;
  if DM.qryStorePOLICE_REPORT_TO_PRINT.AsInteger in [1, 2, 3, 4] then
    begin
      idx := cbTypeOfPoliceReport.Values.IndexOf(DM.qryStorePOLICE_REPORT_TO_PRINT.AsString);
      cbTypeOfPoliceReport.ItemIndex := idx;
    end
  else
    cbTypeOfPoliceReport.ItemIndex := 0;

  cbTypeOfPoliceReportChange(nil);

  //Populates the printers dropdown
  cbPrinters.Items.Text := Printer.Printers.Text;
  cbPrintersPayReceipt.Items.Text := Printer.Printers.Text;
  cbPrintersEnvelopeLabel.Items.Text := Printer.Printers.Text;

  cbPrinters.ItemIndex := cbPrinters.Items.IndexOf(AppPrinterSettings.PoliceReportPrinter);
  if cbPrinters.ItemIndex >= 0 then
    begin
      cbPrintersChange(nil);
      idx := cbPolicePrinterBins.Items.IndexOf(AppPrinterSettings.PoliceReportBin);
      if idx >= 0 then
        cbPolicePrinterBins.ItemIndex := idx;
    end;

  chkUsePaymentReceiptPrinter.Checked := AppPrinterSettings.UsePaymentReceiptPrinter;
  cbPrintersPayReceipt.ItemIndex := cbPrintersPayReceipt.Items.IndexOf(AppPrinterSettings.PayReceiptPrinter);
  if cbPrintersPayReceipt.ItemIndex >= 0 then
    begin
      cbPrintersPayReceiptChange(nil);
      idx := cbPayReceiptBins.Items.IndexOf(AppPrinterSettings.PayReceiptPrinterBin);
      if idx >= 0 then
        cbPayReceiptBins.ItemIndex := idx;
    end;

  chkUseEnvelopeLabelPrinter.Checked := AppPrinterSettings.UseEnvelopeLabelPrinter;
  cbPrintersEnvelopeLabel.ItemIndex := cbPrintersEnvelopeLabel.Items.IndexOf(AppPrinterSettings.EnvelopeLabelPrinterName);
end;

end.
