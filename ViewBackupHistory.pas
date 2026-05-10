unit ViewBackupHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, FireDAC.Comp.Client, Grids, DBGrids;

type
  TfrmViewBackupHist = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    GroupBox2: TGroupBox;
    qryBckHist: TFDQuery;
    dsBckHist: TDataSource;
    DBGrid1: TDBGrid;
    qryBckHistBckId: TIntegerField;
    qryBckHistBckDate: TSQLTimeStampField;
    qryBckHistBckPath: TWideStringField;
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
