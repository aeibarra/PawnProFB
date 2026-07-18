unit SetupMain;

// Mode-picker landing form for PawnProSetup.exe.
// The user picks one of four modes; this form creates and shows the chosen
// sub-form modally, then closes when the sub-form returns.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB;

type
  TfrmSetupMain = class(TForm)
    GroupBox1: TGroupBox;
    rbNewInstall: TRadioButton;
    rbAddWorkstation: TRadioButton;
    rbRotatePassword: TRadioButton;
    rbEditStore: TRadioButton;
    btnContinue: TButton;
    btnExit: TButton;
    lblIntro: TLabel;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    procedure btnContinueClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    procedure RunNewInstall;
    procedure RunAddWorkstation;
    procedure RunRotatePassword;
    procedure RunEditStore;
  end;

var
  frmSetupMain: TfrmSetupMain;

implementation

{$R *.dfm}

uses
  SetupNewInstall, SetupAddWorkstation, SetupRotatePassword, SetupEditStore;

procedure TfrmSetupMain.btnContinueClick(Sender: TObject);
begin
  if rbNewInstall.Checked then
    RunNewInstall
  else if rbAddWorkstation.Checked then
    RunAddWorkstation
  else if rbRotatePassword.Checked then
    RunRotatePassword
  else if rbEditStore.Checked then
    RunEditStore
  else
    MessageDlg('Please select a mode.', mtInformation, [mbOK], 0);
end;

procedure TfrmSetupMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSetupMain.RunNewInstall;
var
  Form: TfrmSetupNewInstall;
begin
  Form := TfrmSetupNewInstall.Create(Self);
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TfrmSetupMain.RunAddWorkstation;
var
  Form: TfrmSetupAddWorkstation;
begin
  Form := TfrmSetupAddWorkstation.Create(Self);
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TfrmSetupMain.RunRotatePassword;
var
  Form: TfrmSetupRotatePassword;
begin
  Form := TfrmSetupRotatePassword.Create(Self);
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TfrmSetupMain.RunEditStore;
var
  Form: TfrmSetupEditStore;
begin
  Form := TfrmSetupEditStore.Create(Self);
  try
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

end.
