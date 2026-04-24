unit Report02;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, ppProd, ppClass,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, ppVar, ppPrnabl, ppCtrls, ppBands,
  ppCache, ppDesignLayer, ppParameter, RzLabel, RzPanel, RzRadChk;

type
  TfrmReport02 = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    btnExit: TBitBtn;
    btnPreview: TRzBitBtn;
    btnPrint: TRzBitBtn;
    GroupBox3: TGroupBox;
    rbPawnList: TRadioButton;
    rbPawnWithPayments: TRadioButton;
    qryPawnAndPurchases: TADOQuery;
    qryPawnAndPurchasesCustFirst: TStringField;
    qryPawnAndPurchasesCustMid: TStringField;
    qryPawnAndPurchasesCustLast: TStringField;
    qryPawnAndPurchasesCustPhCell: TStringField;
    qryPawnAndPurchasesTranTicketNo: TStringField;
    qryPawnAndPurchasesTranType: TStringField;
    qryPawnAndPurchasesTranPawnAmount: TFloatField;
    qryPawnAndPurchasesTranInterest: TFloatField;
    qryPawnAndPurchasesPrincBalance: TFloatField;
    qryPawnAndPurchasesInsterestBalance: TFloatField;
    qryPawnAndPurchasesTranDate: TDateTimeField;
    qryPawnAndPurchasesTranTime: TTimeField;
    qryPawnAndPurchasesTranMaturity: TDateField;
    dsPawnAndPurchases: TDataSource;
    DBPPawnAndPurchases: TppDBPipeline;
    RepPawnAndPurchases: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppDetailBand1: TppDetailBand;
    ppTitleBand1: TppTitleBand;
    lblRep1PawnAndPurchaseTitle: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    qryPawnAndPurchasescFullName: TStringField;
    ppDBText1: TppDBText;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    lblTranType: TppLabel;
    lblFromToDates: TppLabel;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLabel9: TppLabel;
    ppDBText7: TppDBText;
    ppLine2: TppLine;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    qryPawnAndPurchasesTranTypeDesc: TStringField;
    qryTranPayments: TADOQuery;
    dsTranPayments: TDataSource;
    DBPTranPayments: TppDBPipeline;
    RepTranPayments: TppReport;
    qryTranPaymentscFullName: TStringField;
    qryTranPaymentsPayDate: TDateField;
    qryTranPaymentsPayAmount: TFloatField;
    qryTranPaymentsPayPrincipal: TFloatField;
    qryTranPaymentsPayInterest: TFloatField;
    qryTranPaymentsCustFirst: TStringField;
    qryTranPaymentsCustMid: TStringField;
    qryTranPaymentsCustLast: TStringField;
    qryTranPaymentsCustPhCell: TStringField;
    qryTranPaymentsTranTicketNo: TStringField;
    qryTranPaymentsTranType: TStringField;
    qryTranPaymentsTranPawnAmount: TFloatField;
    qryTranPaymentsTranInterest: TFloatField;
    qryTranPaymentsPrincBalance: TFloatField;
    qryTranPaymentsInsterestBalance: TFloatField;
    qryTranPaymentsTranDate: TDateTimeField;
    qryTranPaymentsTranTime: TTimeField;
    qryTranPaymentsTranMaturity: TDateField;
    qryTranPaymentsTranTypeDesc: TStringField;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppDetailBand2: TppDetailBand;
    ppTitleBand2: TppTitleBand;
    ppLabel10: TppLabel;
    lblFromToDates2: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppSystemVariable4: TppSystemVariable;
    ppLine3: TppLine;
    ppLabel3: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppLine4: TppLine;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBText15: TppDBText;
    ppDBCalc7: TppDBCalc;
    ppLabel16: TppLabel;
    ppDBText14: TppDBText;
    pnDateRange: TRzPanel;
    edFrom: TRzDateTimeEdit;
    edTo: TRzDateTimeEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    rbTranStatusActive: TRzRadioButton;
    rbDateRange: TRzRadioButton;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryPawnAndPurchasesCalcFields(DataSet: TDataSet);
    procedure lblTranTypeGetText(Sender: TObject; var Text: string);
    procedure lblFromToDatesGetText(Sender: TObject; var Text: string);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryTranPaymentsCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure rbDateRangeClick(Sender: TObject);
  private
    Param_LineNo_qryPawnAndPurchases: integer;
    Param_LineNo_qryTranPayments: integer;
    procedure Report_1(Preview: boolean);
    procedure Report_2(Preview: boolean);
    procedure ExecReport(Preview: boolean);
  public
    { Public declarations }
  end;

var
  frmReport02: TfrmReport02;

implementation

{$R *.dfm}

uses PawnGlobal, PawnDM, GLbUtils;

procedure TfrmReport02.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReport02.FormCreate(Sender: TObject);
begin
  Param_LineNo_qryPawnAndPurchases := qryPawnAndPurchases.SQL.IndexOf(' --<PARAMS>');
  Param_LineNo_qryTranPayments := qryTranPayments.SQL.IndexOf(' --<PARAMS>');
end;

procedure TfrmReport02.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);

  edFrom.Date := Date;
  edTo.Date := Date;
end;

procedure TfrmReport02.lblTranTypeGetText(Sender: TObject; var Text: string);
begin
  if qryPawnAndPurchasesTranType.AsString = 'P' then
    Text := 'Pawn'
  else if qryPawnAndPurchasesTranType.AsString = 'U' then
    Text := 'Purchase'
end;

procedure TfrmReport02.lblFromToDatesGetText(Sender: TObject; var Text: string);
begin
  Text := 'From ' + FormatDateTime('mm/dd/yyyy', edFrom.Date) + ' To ' + FormatDateTime('mm/dd/yyyy', edTo.Date);
end;

procedure TfrmReport02.qryPawnAndPurchasesCalcFields(DataSet: TDataSet);
begin
  qryPawnAndPurchasescFullName.AsString := GetFullName(qryPawnAndPurchasesCustFirst.AsString,qryPawnAndPurchasesCustMid.AsString, qryPawnAndPurchasesCustLast.AsString);
end;

procedure TfrmReport02.qryTranPaymentsCalcFields(DataSet: TDataSet);
begin
  qryTranPaymentscFullName.AsString := GetFullName(qryTranPaymentsCustFirst.AsString, qryTranPaymentsCustMid.AsString, qryTranPaymentsCustLast.AsString);
end;

procedure TfrmReport02.Report_1(Preview: boolean);
begin
  Screen.Cursor := crHourGlass;
  try
    qryPawnAndPurchases.Close;
    if rbDateRange.Checked then
      begin
        lblRep1PawnAndPurchaseTitle.Caption := 'Pawn and Purchases';
        lblFromToDates.Visible := true;
        qryPawnAndPurchases.SQL[Param_LineNo_qryPawnAndPurchases] := 'and T2.TranDate between ''' + FormatDateTime('yyyy-mm-dd', edFrom.Date) + ''' and ''' + FormatDateTime('yyyy-mm-dd', edTo.Date) + '''';
      end
    else
      begin
        lblFromToDates.Visible := false;
        lblRep1PawnAndPurchaseTitle.Caption := 'List of Active Pawns';
        qryPawnAndPurchases.SQL[Param_LineNo_qryPawnAndPurchases] := 'and T2.TranType = ''P'' and T2.TranStatus = ''A'' ';
      end;

    qryPawnAndPurchases.Open;
  finally
    Screen.Cursor := crDefault;
  end;

  RepPawnAndPurchases.DeviceType := PrnPreview[true];
  RepPawnAndPurchases.Print;
end;

procedure TfrmReport02.Report_2(Preview: boolean);
begin
  Screen.Cursor := crHourGlass;
  try
    qryTranPayments.Close;

    if rbDateRange.Checked then
      begin
        qryTranPayments.SQL[Param_LineNo_qryTranPayments] := 'and T4.PayDate between :FromDate and :ToDate ';
        qryTranPayments.Parameters.ParamByName('FromDate').Value := edFrom.Date;
        qryTranPayments.Parameters.ParamByName('ToDate').Value := edTo.Date;
      end
    else
      begin
        qryTranPayments.SQL[Param_LineNo_qryTranPayments] := 'and T2.TranType = ''P'' and T2.TranStatus = ''A'' ';
      end;

    qryTranPayments.Open;
  finally
    Screen.Cursor := crDefault;
  end;

  RepTranPayments.DeviceType := PrnPreview[true];
  RepTranPayments.Print;
end;

procedure TfrmReport02.rbDateRangeClick(Sender: TObject);
begin
  pnDateRange.Enabled := rbDateRange.Checked;
//
end;

procedure TfrmReport02.btnPrintClick(Sender: TObject);
begin
  ExecReport(false);
end;

procedure TfrmReport02.ExecReport(Preview: boolean);
begin
  if rbPawnList.Checked then
    begin
      Report_1(Preview);
    end
  else if rbPawnWithPayments.Checked then
    begin
      Report_2(Preview);
    end;
end;

procedure TfrmReport02.btnPreviewClick(Sender: TObject);
begin
  ExecReport(true);
end;

end.
