unit Report01;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, RzButton,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, ppBands, ppCache, ppDesignLayer, ppParameter, ppVar, ppPrnabl,
  ppCtrls, ppStrtch, ppSubRpt, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  Datasnap.Provider, Vcl.Mask, RzEdit, RzSpnEdt, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmReport01 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    dsLatePawn: TDataSource;
    DBPLatePawn: TppDBPipeline;
    RepLatePawn: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    lblRptLatePayTitle: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppLabel3: TppLabel;
    ppDBText4: TppDBText;
    qryPayments: TFDQuery;
    dsPayments: TDataSource;
    ppDBText2: TppDBText;
    prvLatePawn: TDataSetProvider;
    clnLatePawn: TClientDataSet;
    clnLatePawncFullName: TWideStringField;
    clnLatePawnTransactionNo: TIntegerField;
    clnLatePawnTranTicketNo: TWideStringField;
    clnLatePawnCustno: TIntegerField;
    clnLatePawnCustLast: TWideStringField;
    clnLatePawnCustFirst: TWideStringField;
    clnLatePawnCustMid: TWideStringField;
    clnLatePawnTranPawnAmount: TFloatField;
    clnLatePawnLatePayment: TIntegerField;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    DBPPayments: TppDBPipeline;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppDetailBand2: TppDetailBand;
    ppDBText3: TppDBText;
    ppDBText6: TppDBText;
    ppTitleBand1: TppTitleBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLine2: TppLine;
    ppSummaryBand1: TppSummaryBand;
    ppLine3: TppLine;
    Label2: TLabel;
    edMonths: TRzSpinEdit;
    btnExit: TBitBtn;
    spLatePawn: TFDQuery;
    clnLatePawnTranDate: TDateField;
    clnLatePawncPhones: TWideStringField;
    clnLatePawnCustPhCell: TWideStringField;
    clnLatePawnCustPhHome: TWideStringField;
    clnLatePawnCustPhBussiness: TWideStringField;
    ppLabel10: TppLabel;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure clnLatePawnAfterScroll(DataSet: TDataSet);
    procedure clnLatePawnCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    procedure PrintReport(Preview: boolean);
  public
    { Public declarations }
  end;

var
  frmReport01: TfrmReport01;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils, PawnGlobal;

procedure TfrmReport01.RzBitBtn1Click(Sender: TObject);
begin
  PrintReport(true);
end;

procedure TfrmReport01.RzBitBtn2Click(Sender: TObject);
begin
  PrintReport(false);
end;

procedure TfrmReport01.clnLatePawnAfterScroll(DataSet: TDataSet);
begin
  qryPayments.Close;
  qryPayments.Params.ParamByName('TransactionNo').AsInteger := clnLatePawnTransactionNo.AsInteger;
  qryPayments.Open;
end;

procedure TfrmReport01.clnLatePawnCalcFields(DataSet: TDataSet);
begin
  clnLatePawncFullName.AsString := GetFullName(clnLatePawnCustFirst.AsString, clnLatePawnCustMid.AsString, clnLatePawnCustLast.AsString);

  clnLatePawncPhones.AsString := CombinePhones(' / ',  [clnLatePawnCustPhCell.AsString,
                                                        clnLatePawnCustPhHome.AsString,
                                                        clnLatePawnCustPhBussiness.AsString]);

end;

procedure TfrmReport01.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);
end;

procedure TfrmReport01.PrintReport(Preview: boolean);
var
  LateMonths: integer;
begin
  Screen.Cursor := crHourGlass;
  try
    LateMonths := Trunc(edMonths.Value);

    qryPayments.Close;
    qryPayments.Open;

    clnLatePawn.Close;
    clnLatePawn.Params.ParamByName('Mons').AsInteger := LateMonths;
    clnLatePawn.Open;

  finally
    Screen.Cursor := crDefault;
  end;

  lblRptLatePayTitle.Caption := Format('Pawns with Payments %d Months Late', [LateMonths]);
  RepLatePawn.DeviceType := PrnPreview[Preview];
  RepLatePawn.Print;

end;

end.
