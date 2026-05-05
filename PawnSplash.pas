unit PawnSplash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, DB, FireDAC.Comp.Client, Vcl.Imaging.jpeg, RzLabel;

type
  TfrmSplash = class(TForm)
    Panel1: TPanel;
    st_Msg: TStaticText;
    Panel2: TPanel;
    Image1: TImage;
    lblStoreName: TDBText;
    LblStoreAddr: TDBText;
    lblStorePhone: TDBText;
    lblClientsCount: TDBText;
    lblCaptionClientsCount: TLabel;
    qryCustomerCount: TFDQuery;
    qryCustomerCountTCUSTOMER: TIntegerField;
    lblCustCount: TLabel;
    LblPhone: TRzLabel;
    LblEMail: TRzLabel;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure ShowCustomersCount;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.DFM}

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  st_Msg.Caption := '';
  lblCustCount.Caption := '';
end;

procedure TfrmSplash.ShowCustomersCount;
begin
  qryCustomerCount.Close;
  qryCustomerCount.Open;
  lblCustCount.Caption := trim(Format('%10.0n', [qryCustomerCountTCUSTOMER.AsInteger * 1.0]));
end;

procedure TfrmSplash.Image1Click(Sender: TObject);
begin
  Close;
end;

end.
