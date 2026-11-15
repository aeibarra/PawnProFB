unit StoreSettings;

{ Store Settings: the per-STORE defaults (TDM.qryStore, one row in STORE).

  Everything here lives in the database, so a change made on one PC applies to
  every PC of the store -- unlike "Select Report Printers", which is per PC
  (PawnPro.ini). Formerly SetDefaultMaturityMonth / "Pawn Defaults".

    Pawns              DEFAULT_MATURITY_MONTHS, DEFAULT_PAWN_INTERESTRATE
    Sales tax          SALES_TAX_PERC (layaways, Sell Items)
    Default weight     DEFAULT_WEIGHT_MEASURE_UNIT 'P' / 'G' -- new items and
                       stones only; existing rows keep the unit they were
                       entered with. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit;

type
  TfrmStoreSettings = class(TForm)
    gbButtons: TGroupBox;
    btnClose: TBitBtn;
    btnSave: TRzBitBtn;
    gbPawns: TGroupBox;
    lblMaturityMonths: TLabel;
    edDefaultMaturityMonths: TEdit;
    lblInterestRate: TLabel;
    edDefaultPawnInterestRate: TRzNumericEdit;
    lblInterestPerc: TLabel;
    gbSalesTax: TGroupBox;
    lblSalesTax: TLabel;
    edSalesTaxPerc: TRzNumericEdit;
    lblSalesTaxPerc: TLabel;
    gbWeightUnit: TGroupBox;
    rbWeightPennyweight: TRadioButton;
    rbWeightGrams: TRadioButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  end;

var
  frmStoreSettings: TfrmStoreSettings;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal, uPawnDialogs;

const
  MaxSalesTaxPerc = 20;

procedure TfrmStoreSettings.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmStoreSettings.FormShow(Sender: TObject);
begin
  edDefaultMaturityMonths.Text := DM.qryStoreDEFAULT_MATURITY_MONTHS.AsString;
  edDefaultPawnInterestRate.Value := DM.qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat;
  edSalesTaxPerc.Value := DM.qryStoreSALES_TAX_PERC.AsFloat;

  // Same fallback as TDM startup: anything but Grams is Pennyweight.
  rbWeightGrams.Checked := DM.qryStoreDEFAULT_WEIGHT_MEASURE_UNIT.AsString = WeightUnitGram;
  rbWeightPennyweight.Checked := not rbWeightGrams.Checked;
end;

procedure TfrmStoreSettings.btnSaveClick(Sender: TObject);
var
  DMonths: integer;
  WeightUnit: string;
begin
  if not TryStrToInt(Trim(edDefaultMaturityMonths.Text), DMonths) or (DMonths <= 0) then
    begin
      PawnInfo('Please enter a valid number of months.', 'Store Settings', Self);
      edDefaultMaturityMonths.SetFocus;
      exit;
    end;

  if edDefaultPawnInterestRate.Value < 0 then
    begin
      PawnInfo('The interest rate cannot be negative.', 'Store Settings', Self);
      edDefaultPawnInterestRate.SetFocus;
      exit;
    end;

  if (edSalesTaxPerc.Value < 0) or (edSalesTaxPerc.Value > MaxSalesTaxPerc) then
    begin
      PawnInfo(Format('The sales tax must be between 0 and %d%%.', [MaxSalesTaxPerc]), 'Store Settings', Self);
      edSalesTaxPerc.SetFocus;
      exit;
    end;

  if rbWeightGrams.Checked then
    WeightUnit := WeightUnitGram
  else
    WeightUnit := WeightUnitPennyweight;

  DM.qryStore.Edit;
  DM.qryStoreDEFAULT_MATURITY_MONTHS.AsInteger := DMonths;
  DM.qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat := edDefaultPawnInterestRate.Value;
  DM.qryStoreSALES_TAX_PERC.AsFloat := edSalesTaxPerc.Value;
  DM.qryStoreDEFAULT_WEIGHT_MEASURE_UNIT.AsString := WeightUnit;
  DM.qryStore.Post;

  // Read once at startup into a global; update it so new items use the new
  // unit without restarting the app.
  DefaultWeightMeasureUnit := WeightUnit;

  ModalResult := mrOk;
end;

end.
