unit RepPurchases;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, ppProd, ppClass, ppReport, ppComm,
  ppRelatv, ppDB, ppDBPipe, ppCtrls, ppVar, ppPrnabl, ppBands, ppCache,
  ppDesignLayer, ppParameter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

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
    qryPruchasesTranTicketNo: TStringField;
    qryPruchasesPurchaseAmount: TFloatField;
    dsPruchases: TDataSource;
    DBPPruchases: TppDBPipeline;
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
    ppSummaryBand1: TppSummaryBand;
    ppLine2: TppLine;
    DBCalcTotalAmount: TppDBCalc;
    DBCalcTotalPNWt: TppDBCalc;
    qryPruchasesTotalPNWt: TFloatField;
    ppLabel6: TppLabel;
    procedure FormShow(Sender: TObject);
    procedure lblFromToDates1GetText(Sender: TObject; var Text: string);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure ppLabel6GetText(Sender: TObject; var Text: string);
  private
    procedure ExecReport(Preview: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRepPurchases: TfrmRepPurchases;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils, PawnGlobal;

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

procedure TfrmRepPurchases.ExecReport(Preview: boolean);
begin
  Screen.Cursor := crHourGlass;
  try
    qryPruchases.Close;
    qryPruchases.Params.ParamByName('FDate').AsDate := edFrom.Date;
    qryPruchases.Params.ParamByName('TDate').AsDate := edTo.Date;
    qryPruchases.Open;
  finally
    Screen.Cursor := crDefault;
  end;

  RepPruchases.DeviceType := PrnPreview[true];
  RepPruchases.Print;
end;

procedure TfrmRepPurchases.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  edFrom.Date := Date;
  edTo.Date := Date;
end;

procedure TfrmRepPurchases.lblFromToDates1GetText(Sender: TObject;
  var Text: string);
begin
  Text := 'From ' + FormatDateTime('mm/dd/yyyy', edFrom.Date) + ' To ' + FormatDateTime('mm/dd/yyyy', edTo.Date);
end;

procedure TfrmRepPurchases.ppLabel6GetText(Sender: TObject; var Text: string);
var
  f: Extended;
begin
  Text := '';
  if DBCalcTotalPNWt.Value > 0 then
    begin
      f := DBCalcTotalAmount.Value / DBCalcTotalPNWt.Value;
      Text := Format('Avg $/PnWt: %.2f', [f]);
    end;
end;

end.
