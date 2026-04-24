unit ReportExportTransactions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Data.DB, Data.Win.ADODB;

type
  TfrmReportExportTransactions = class(TForm)
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edFrom: TRzDateTimeEdit;
    edTo: TRzDateTimeEdit;
    GroupBox3: TGroupBox;
    rbTransactionsOnly: TRadioButton;
    rbTransactionsAndItems: TRadioButton;
    GroupBox1: TGroupBox;
    btnExit: TBitBtn;
    btnExport: TRzBitBtn;
    qryTransactionsOnly: TADOQuery;
    qryTransactionsAndItems: TADOQuery;
    qryTransactionsOnlyTranTicketNo: TStringField;
    qryTransactionsOnlyTranDate: TDateTimeField;
    qryTransactionsOnlyTransactionDesc: TStringField;
    qryTransactionsOnlyTranMaturity: TDateField;
    qryTransactionsOnlyTranAmount: TFloatField;
    SaveDialog: TSaveDialog;
    qryTransactionsAndItemsDescription: TStringField;
    qryTransactionsAndItemsWeight: TFloatField;
    qryTransactionsAndItemsSizeLength: TFloatField;
    qryTransactionsAndItemsJTypeDesc: TStringField;
    qryTransactionsAndItemsJStyleDesc: TStringField;
    qryTransactionsAndItemsJMetalDesc: TStringField;
    qryTransactionsAndItemsTranTicketNo: TStringField;
    qryTransactionsAndItemsTranDate: TDateTimeField;
    qryTransactionsAndItemsTransactionDesc: TStringField;
    qryTransactionsAndItemsTranMaturity: TDateField;
    qryTransactionsAndItemsTranAmount: TFloatField;
    rbClientInfoAndItems: TRadioButton;
    qryClientTranscItems: TADOQuery;
    qryClientTranscItemsTranTicketNo: TStringField;
    qryClientTranscItemsTranDate: TDateTimeField;
    qryClientTranscItemsTransactionDesc: TStringField;
    qryClientTranscItemsTranMaturity: TDateField;
    qryClientTranscItemsTranAmount: TFloatField;
    qryClientTranscItemsDescription: TStringField;
    qryClientTranscItemsWeight: TFloatField;
    qryClientTranscItemsSizeLength: TFloatField;
    qryClientTranscItemsJTypeDesc: TStringField;
    qryClientTranscItemsJStyleDesc: TStringField;
    qryClientTranscItemsJMetalDesc: TStringField;
    qryClientTranscItemsCustLast: TStringField;
    qryClientTranscItemsCustFirst: TStringField;
    qryClientTranscItemsCustMid: TStringField;
    qryClientTranscItemsCustDOB: TDateField;
    qryClientTranscItemsCustGender: TStringField;
    qryClientTranscItemsCustRace: TStringField;
    qryClientTranscItemsCustHair: TStringField;
    qryClientTranscItemsCustEyes: TStringField;
    qryClientTranscItemsCustMark: TStringField;
    qryClientTranscItemsCustWeight: TFloatField;
    qryClientTranscItemsCustHeight: TStringField;
    qryClientTranscItemsCustAddr: TStringField;
    qryClientTranscItemsCustApt: TStringField;
    qryClientTranscItemsCustCity: TStringField;
    qryClientTranscItemsCustState: TStringField;
    qryClientTranscItemsCustZip: TStringField;
    qryClientTranscItemsCustPlaceEmply: TStringField;
    qryClientTranscItemsCustPhHome: TStringField;
    qryClientTranscItemsCustPhBussiness: TStringField;
    qryClientTranscItemsCustPhCell: TStringField;
    qryClientTranscItemsTransactionNo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ExportClientsTransactionsAndItems(qry: TADOQuery);
//    procedure ExportTransactionOnly;
//    procedure ExportTransactionsAndItems;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReportExportTransactions: TfrmReportExportTransactions;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils;

procedure TfrmReportExportTransactions.btnExitClick(Sender: TObject);
begin
  Close;
end;

//procedure TfrmReportExportTransactions.ExportTransactionOnly;
//begin
//  if SaveDialog.Execute then
//    begin
//      Screen.Cursor := crHourGlass;
//      try
//        qryTransactionsOnly.Close;
//        qryTransactionsOnly.Parameters.ParamByName('FDate').Value := edFrom.Date;
//        qryTransactionsOnly.Parameters.ParamByName('TDate').Value := edTo.Date;
//        qryTransactionsOnly.Open;
//
//        CreateCSV(SaveDialog.FileName, qryTransactionsOnly, false);
//      finally
//        Screen.Cursor := crDefault;
//      end;
//
//      MsgInfo(Format('%d Rows exported', [qryTransactionsOnly.RecordCount]));
//    end;
//end;
//
//procedure TfrmReportExportTransactions.ExportTransactionsAndItems;
//begin
//  if SaveDialog.Execute then
//    begin
//      Screen.Cursor := crHourGlass;
//      try
//        qryTransactionsAndItems.Close;
//        qryTransactionsAndItems.Parameters.ParamByName('FDate').Value := edFrom.Date;
//        qryTransactionsAndItems.Parameters.ParamByName('TDate').Value := edTo.Date;
//        qryTransactionsAndItems.Open;
//
//        CreateCSV(SaveDialog.FileName, qryTransactionsAndItems, false);
//      finally
//        Screen.Cursor := crDefault;
//      end;
//
//      MsgInfo(Format('%d Rows exported', [qryTransactionsAndItems.RecordCount]));
//    end;
//end;

procedure TfrmReportExportTransactions.ExportClientsTransactionsAndItems(qry: TADOQuery);
begin
  if SaveDialog.Execute then
    begin
      Screen.Cursor := crHourGlass;
      try
        Qry.Close;
        Qry.Parameters.ParamByName('FDate').Value := edFrom.Date;
        Qry.Parameters.ParamByName('TDate').Value := edTo.Date;
        Qry.Open;

        CreateCSV(SaveDialog.FileName, Qry, false);
      finally
        Screen.Cursor := crDefault;
      end;

      MsgInfo(Format('%d Rows exported', [qry.RecordCount]));
    end;
end;

procedure TfrmReportExportTransactions.btnExportClick(Sender: TObject);
begin
  if rbTransactionsOnly.Checked then
    ExportClientsTransactionsAndItems(qryTransactionsOnly)
  else if rbTransactionsAndItems.Checked then
    ExportClientsTransactionsAndItems(qryTransactionsAndItems)
  else  if rbClientInfoAndItems.Checked then
    ExportClientsTransactionsAndItems(qryClientTranscItems);
end;

procedure TfrmReportExportTransactions.FormCreate(Sender: TObject);
begin
  edFrom.Date := Date;
  edTo.Date := Date;
end;

procedure TfrmReportExportTransactions.FormShow(Sender: TObject);
begin
  FrmSetViewSize(Self);
end;

end.
