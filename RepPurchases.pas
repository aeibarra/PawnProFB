unit RepPurchases;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, ppProd, ppClass, ppReport, ppComm,
  ppRelatv, ppDB, ppDBPipe, ppCtrls, ppVar, ppPrnabl, ppBands, ppCache,
  ppDesignLayer, ppParameter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.DBCtrls, RzCmboBx;

type
  TfrmRepPurchases = class(TForm)
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edFrom: TRzDateTimeEdit;
    edTo: TRzDateTimeEdit;
    GroupBox1: TGroupBox;
    btnExit: TBitBtn;
    btnPreview: TRzBitBtn;
    btnPrint: TRzBitBtn;
    qryPruchases: TFDQuery;
    qryPruchasesTranDate: TDateField;
    qryPruchasesTranTicketNo: TWideStringField;
    qryPruchasesPurchaseAmount: TFloatField;
    dsPruchases: TDataSource;
    DBPPurchases: TppDBPipeline;
    RepPruchases: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    lblFromToDates1: TppLabel;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    qryPruchasesTotalPNWt: TFloatField;
    ppLine2: TppLine;
    lblPrnTotalAmount: TppLabel;
    lblPrmTotalWt: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    Label3: TLabel;
    cbWeightUnit: TRzComboBox;
    lblCapWUnit: TppLabel;
    lbllblSummaryWUnit: TppLabel;
    procedure FormShow(Sender: TObject);
    procedure lblFromToDates1GetText(Sender: TObject; var Text: string);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure lblPrnTotalAmountGetText(Sender: TObject; var Text: string);
    procedure lblPrmTotalWtGetText(Sender: TObject; var Text: string);
    procedure lblCapWUnitGetText(Sender: TObject; var Text: string);
    procedure lbllblSummaryWUnitGetText(Sender: TObject; var Text: string);
  private
    // Totals are summed in Pascal after the query opens rather than by TppDBCalc.
    // A purchase with no inventory items yields a NULL weight; AsFloat reads that
    // as 0, so a missing weight can no longer blow up the band the way the old
    // DBCalc-based average did.
    FTotalAmount: Double;
    FTotalWeight: Double;
    // Item weights may be stored per-item in pennyweight or grams (and are most
    // often NULL, meaning "the store's default unit"). The query normalises every
    // item to pennyweight and then scales to whatever the operator picked, so the
    // detail column and the totals always agree and never sum mixed units.
    function SelectedWeightUnit: string;
    function DefaultUnitForNulls: string;
    procedure CalcTotals;
    procedure ExecReport(Preview: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRepPurchases: TfrmRepPurchases;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils, PawnGlobal, uPawnDialogs;

procedure TfrmRepPurchases.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRepPurchases.btnPreviewClick(Sender: TObject);
begin
  ExecReport(true);
end;

procedure TfrmRepPurchases.btnPrintClick(Sender: TObject);
begin
  ExecReport(false);
end;

const
  GramsPerPennyweight = 1.55517384;   // 1 dwt = 1/20 troy oz = 1.55517384 g

// Unit the operator chose for this run. Pennyweight is the default and the far
// more common choice, so anything unexpected falls back to it.
function TfrmRepPurchases.SelectedWeightUnit: string;
begin
  if cbWeightUnit.ItemIndex = 1 then
    Result := WeightUnitGram
  else
    Result := WeightUnitPennyweight;
end;

// Unit to assume for items whose WEIGHT_UNIT is NULL -- by far the common case.
// NULL means "the store's configured unit", NOT "unknown": treating it as unknown
// would drop almost every weight from the totals.
function TfrmRepPurchases.DefaultUnitForNulls: string;
begin
  if SameText(DefaultWeightMeasureUnit, WeightUnitGram) then
    Result := WeightUnitGram
  else
    Result := WeightUnitPennyweight;
end;

// One pass over the open result set to total the amount and pennyweight columns.
// Leaves the cursor back at the first row so the report traverses from the top.
procedure TfrmRepPurchases.CalcTotals;
begin
  FTotalAmount := 0;
  FTotalWeight := 0;

  if not qryPruchases.Active then
    Exit;

  qryPruchases.DisableControls;
  try
    qryPruchases.First;
    while not qryPruchases.Eof do
    begin
      FTotalAmount := FTotalAmount + qryPruchasesPurchaseAmount.AsFloat;
      FTotalWeight := FTotalWeight + qryPruchasesTotalPNWt.AsFloat;  // NULL reads as 0
      qryPruchases.Next;
    end;
    qryPruchases.First;
  finally
    qryPruchases.EnableControls;
  end;
end;

procedure TfrmRepPurchases.lblPrnTotalAmountGetText(Sender: TObject; var Text: string);
begin
  Text := FormatFloat('$#,0.00;($#,0.00)', FTotalAmount);
end;

procedure TfrmRepPurchases.lblPrmTotalWtGetText(Sender: TObject; var Text: string);
begin
  Text := FormatFloat('#,0.00;-#,0.00', FTotalWeight);
end;

// The selected weight unit is shown in its own labels -- beside the column
// heading and beside the summary total -- so a gram figure can never be misread
// as pennyweight.
procedure TfrmRepPurchases.lblCapWUnitGetText(Sender: TObject; var Text: string);
begin
  Text := DM.GetWeightUnitAbbr(SelectedWeightUnit);
end;

procedure TfrmRepPurchases.lbllblSummaryWUnitGetText(Sender: TObject; var Text: string);
begin
  Text := DM.GetWeightUnitAbbr(SelectedWeightUnit);
end;

procedure TfrmRepPurchases.ExecReport(Preview: boolean);
begin
  // An inverted range silently produced an empty report; say so instead.
  if edFrom.Date > edTo.Date then
  begin
    PawnWarn('The "From" date is after the "To" date. Please correct the date range.',
             'Purchases Report', Self);
    edFrom.SetFocus;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    qryPruchases.Close;
    qryPruchases.Params.ParamByName('FDate').AsDate := edFrom.Date;
    qryPruchases.Params.ParamByName('TDate').AsDate := edTo.Date;
    qryPruchases.Params.ParamByName('DefUnit').AsString := DefaultUnitForNulls;
    // Weights are normalised to pennyweight in SQL; scale to grams only if asked.
    if SelectedWeightUnit = WeightUnitGram then
      qryPruchases.Params.ParamByName('UnitFactor').AsFloat := GramsPerPennyweight
    else
      qryPruchases.Params.ParamByName('UnitFactor').AsFloat := 1.0;
    qryPruchases.Open;
    CalcTotals;
  finally
    Screen.Cursor := crDefault;
  end;

  RepPruchases.DeviceType := PrnPreview[Preview];
  RepPruchases.Print;
end;

procedure TfrmRepPurchases.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  edFrom.Date := IncMonth(Date, -1);
  edTo.Date := Date;

  if cbWeightUnit.Items.Count = 0 then
  begin
    cbWeightUnit.Items.Add('Pennyweight (dwt)');
    cbWeightUnit.Items.Add('Gram (g)');
  end;
  // Default to the store's configured unit (pennyweight for every store so far).
  if SameText(DefaultWeightMeasureUnit, WeightUnitGram) then
    cbWeightUnit.ItemIndex := 1
  else
    cbWeightUnit.ItemIndex := 0;
end;

procedure TfrmRepPurchases.lblFromToDates1GetText(Sender: TObject;
  var Text: string);
begin
  Text := 'From ' + FormatDateTime('mm/dd/yyyy', edFrom.Date) + ' To ' + FormatDateTime('mm/dd/yyyy', edTo.Date);
end;

end.
