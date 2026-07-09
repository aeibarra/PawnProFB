unit ReportExportTransactions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet;

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
    qryTransactionsOnly: TFDQuery;
    qryTransactionsAndItems: TFDQuery;
    qryTransactionsOnlyTranTicketNo: TWideStringField;
    qryTransactionsOnlyTranDate: TDateField;
    qryTransactionsOnlyTransactionDesc: TWideStringField;
    qryTransactionsOnlyTranMaturity: TDateField;
    qryTransactionsOnlyTranAmount: TFloatField;
    SaveDialog: TSaveDialog;
    qryTransactionsAndItemsDescription: TWideStringField;
    qryTransactionsAndItemsWeight: TFloatField;
    qryTransactionsAndItemsSizeLength: TFloatField;
    qryTransactionsAndItemsJTypeDesc: TWideStringField;
    qryTransactionsAndItemsJStyleDesc: TWideStringField;
    qryTransactionsAndItemsJMetalDesc: TWideStringField;
    qryTransactionsAndItemsTranTicketNo: TWideStringField;
    qryTransactionsAndItemsTranDate: TDateField;
    qryTransactionsAndItemsTransactionDesc: TWideStringField;
    qryTransactionsAndItemsTranMaturity: TDateField;
    qryTransactionsAndItemsTranAmount: TFloatField;
    rbClientInfoAndItems: TRadioButton;
    qryClientTranscItems: TFDQuery;
    qryClientTranscItemsTranTicketNo: TWideStringField;
    qryClientTranscItemsTranDate: TDateField;
    qryClientTranscItemsTransactionDesc: TWideStringField;
    qryClientTranscItemsTranMaturity: TDateField;
    qryClientTranscItemsTranAmount: TFloatField;
    qryClientTranscItemsDescription: TWideStringField;
    qryClientTranscItemsWeight: TFloatField;
    qryClientTranscItemsSizeLength: TFloatField;
    qryClientTranscItemsJTypeDesc: TWideStringField;
    qryClientTranscItemsJStyleDesc: TWideStringField;
    qryClientTranscItemsJMetalDesc: TWideStringField;
    qryClientTranscItemsCustLast: TWideStringField;
    qryClientTranscItemsCustFirst: TWideStringField;
    qryClientTranscItemsCustMid: TWideStringField;
    qryClientTranscItemsCustDOB: TDateField;
    qryClientTranscItemsCustGender: TWideStringField;
    qryClientTranscItemsCustRace: TWideStringField;
    qryClientTranscItemsCustHair: TWideStringField;
    qryClientTranscItemsCustEyes: TWideStringField;
    qryClientTranscItemsCustMark: TWideStringField;
    qryClientTranscItemsCustWeight: TFloatField;
    qryClientTranscItemsCustHeight: TWideStringField;
    qryClientTranscItemsCustAddr: TWideStringField;
    qryClientTranscItemsCustApt: TWideStringField;
    qryClientTranscItemsCustCity: TWideStringField;
    qryClientTranscItemsCustState: TWideStringField;
    qryClientTranscItemsCustZip: TWideStringField;
    qryClientTranscItemsCustPlaceEmply: TWideStringField;
    qryClientTranscItemsCustPhHome: TWideStringField;
    qryClientTranscItemsCustPhBussiness: TWideStringField;
    qryClientTranscItemsCustPhCell: TWideStringField;
    qryClientTranscItemsTransactionNo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ExportClientsTransactionsAndItems(qry: TFDQuery);
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

procedure TfrmReportExportTransactions.ExportClientsTransactionsAndItems(qry: TFDQuery);
begin
  if SaveDialog.Execute then
    begin
      Screen.Cursor := crHourGlass;
      try
        Qry.Close;
        Qry.Params.ParamByName('FDate').AsDate := edFrom.Date;
        Qry.Params.ParamByName('TDate').AsDate := edTo.Date;
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
