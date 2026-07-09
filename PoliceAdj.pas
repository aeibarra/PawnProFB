unit PoliceAdj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Mask, RzButton;

type
  TfrmPoliceRptAdj = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edAdjTopMargin: TMaskEdit;
    UpDown1: TUpDown;
    edDetail: TMaskEdit;
    UpDown2: TUpDown;
    Label3: TLabel;
    edFooter: TMaskEdit;
    UpDown3: TUpDown;
    lblDetail: TLabel;
    lblFooter: TLabel;
    btnSave: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FooterH, DetailH: single;
  end;

var
  frmPoliceRptAdj: TfrmPoliceRptAdj;

implementation

uses PawnDM, PawnGlobal;

{$R *.dfm}

procedure TfrmPoliceRptAdj.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPoliceRptAdj.btnSaveClick(Sender: TObject);
begin
  ExecSQLStatementFB(Format(
    'UPDATE STORE SET STORE_ADJ_TOP_MARG = %d, STORE_ADJ_DETAIL_HEIGHT = %d, STORE_ADJ_FOOTER_HEIGHT = %d WHERE STORE_NO = ''0''',
    [StrToIntDef(Trim(edAdjTopMargin.Text), 0),
     StrToIntDef(Trim(edDetail.Text), 0),
     StrToIntDef(Trim(edFooter.Text), 0)]));
  ModalResult := mrOk;
end;

procedure TfrmPoliceRptAdj.FormShow(Sender: TObject);
begin
  with DM do
    begin
      DM.RefreshStoreQry;
      lblDetail.Caption := IntToStr(trunc(DetailH * 100));
      lblFooter.Caption := IntToStr(trunc(FooterH * 100));
      edAdjTopMargin.Text := qryStoreSTORE_ADJ_TOP_MARG.AsString;
      edDetail.Text := qryStoreSTORE_ADJ_DETAIL_HEIGHT.AsString;
      edFooter.Text := qryStoreSTORE_ADJ_FOOTER_HEIGHT.AsString;
    end;
end;

end.
