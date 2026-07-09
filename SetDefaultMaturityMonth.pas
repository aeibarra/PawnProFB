unit SetDefaultMaturityMonth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, RzEdit;

type
  TfrmSetDefaultMaturityMonth = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TBitBtn;
    RzBitBtn1: TRzBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edDefaultMaturityMonths: TEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    edDefaultPawnInterestRate: TRzNumericEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetDefaultMaturityMonth: TfrmSetDefaultMaturityMonth;

implementation

{$R *.dfm}

uses PawnDM, GLbUtils;

procedure TfrmSetDefaultMaturityMonth.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSetDefaultMaturityMonth.FormShow(Sender: TObject);
begin
  edDefaultMaturityMonths.Text := DM.qryStoreDEFAULT_MATURITY_MONTHS.AsString;
  edDefaultPawnInterestRate.Value := DM.qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat;
end;

procedure TfrmSetDefaultMaturityMonth.RzBitBtn1Click(Sender: TObject);
var
  DMonths: integer;
begin
  if TryStrToInt(edDefaultMaturityMonths.Text, DMonths) then
    begin
      DM.qryStore.Edit;
      DM.qryStoreDEFAULT_MATURITY_MONTHS.AsInteger := DMonths;
      DM.qryStoreDEFAULT_PAWN_INTERESTRATE.AsFloat := edDefaultPawnInterestRate.Value;
      DM.qryStore.Post;
    end
  else
    begin
      MsgInfo('Please enter a valid month number.');
      exit;
    end;

  ModalResult := mrOk;
end;

end.
