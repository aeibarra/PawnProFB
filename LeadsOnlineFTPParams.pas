unit LeadsOnlineFTPParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RzButton, RzLabel, Vcl.Mask, RzEdit, RzDBEdit, Vcl.DBCtrls;

type
  TfrmLeadsOnlineFTPParams = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    edLeadsOnlineFTPAddress: TRzDBEdit;
    RzLabel1: TRzLabel;
    edUserName: TRzDBEdit;
    edPassword: TRzDBEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzDBEdit1: TRzDBEdit;
    DBCheckBox1: TDBCheckBox;
    RzLabel4: TRzLabel;
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLeadsOnlineFTPParams: TfrmLeadsOnlineFTPParams;

implementation

{$R *.dfm}

uses PawnDM;

procedure TfrmLeadsOnlineFTPParams.FormShow(Sender: TObject);
begin
  DM.qryStore.edit;

  if trim(DM.qryStoreLeadsOnlineFTPAddress.AsString) = '' then
    begin
      DM.qryStoreLeadsOnlineFTPAddress.AsString := 'ftp.leadsonline.com';
    end;
  
end;

procedure TfrmLeadsOnlineFTPParams.RzBitBtn1Click(Sender: TObject);
begin
  DM.qryStore.Post;

  ModalResult := mrOk;
end;

procedure TfrmLeadsOnlineFTPParams.RzBitBtn2Click(Sender: TObject);
begin
  DM.qryStore.Cancel;

  ModalResult := mrCancel;
end;

end.
