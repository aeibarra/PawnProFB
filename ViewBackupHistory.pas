unit ViewBackupHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB, Grids, DBGrids;

type
  TfrmViewBackupHist = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    GroupBox2: TGroupBox;
    qryBckHist: TADOQuery;
    dsBckHist: TDataSource;
    DBGrid1: TDBGrid;
    qryBckHistBckId: TAutoIncField;
    qryBckHistBckDate: TDateTimeField;
    qryBckHistBckPath: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewBackupHist: TfrmViewBackupHist;

implementation

uses PawnDM;

{$R *.dfm}

procedure TfrmViewBackupHist.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewBackupHist.FormShow(Sender: TObject);
begin
  qryBckHist.Open;
end;

end.
