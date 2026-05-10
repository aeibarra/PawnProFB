unit ConfirmCloseLayaway;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RzButton, Vcl.Buttons;

type
  TfrmConfirmCloseLayaway = class(TForm)
    lblBalance: TLabel;
    Label1: TLabel;
    btnPayoff: TRzBitBtn;
    btnCancelLayaway: TRzBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnPayoffClick(Sender: TObject);
    procedure btnCancelLayawayClick(Sender: TObject);
  private
    { Private declarations }
  public
    LayawayBalance: Currency;
  end;

var
  frmConfirmCloseLayaway: TfrmConfirmCloseLayaway;

implementation

{$R *.dfm}

uses PawnDM, PawnGlobal;

procedure TfrmConfirmCloseLayaway.btnCancelLayawayClick(Sender: TObject);
begin
  DM.CancelLayaway(DM.qryTransactionsTRANSACTION_NO.AsInteger);

  ModalResult := mrOk;
end;

procedure TfrmConfirmCloseLayaway.btnPayoffClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    DM.LaywayClosePayoffBalance(DM.qryTransactionsTRANSACTION_NO.AsInteger, true);
  finally
    Screen.Cursor := crDefault;
  end;

  ModalResult := mrOk;
end;

procedure TfrmConfirmCloseLayaway.FormShow(Sender: TObject);
begin
  lblBalance.Caption := Format('This layaway still has an outstanding balance of %m', [LayawayBalance]);
end;

end.
