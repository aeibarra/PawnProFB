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
    gbApi: TGroupBox;
    lblApiUser: TRzLabel;
    lblApiPassword: TRzLabel;
    edApiUser: TRzDBEdit;
    edApiPassword: TRzDBEdit;
    chkUseSandbox: TDBCheckBox;
    btnTestConnection: TRzBitBtn;
    rgExportMethod: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLeadsOnlineFTPParams: TfrmLeadsOnlineFTPParams;

implementation

{$R *.dfm}

uses PawnDM, uPawnDialogs, uLeadsOnlineClient;

procedure TfrmLeadsOnlineFTPParams.FormShow(Sender: TObject);
begin
  DM.qryStore.edit;

  if trim(DM.qryStoreLEADS_ONLINE_FTP_ADDRESS.AsString) = '' then
    begin
      DM.qryStoreLEADS_ONLINE_FTP_ADDRESS.AsString := 'ftp.leadsonline.com';
    end;

end;

// Verifies the API credentials as currently typed, without saving them. The
// store number is shared with the FTP export (STORE.LEADS_STORE_ID) -- SOAP
// wants it as an integer, so a store with anything else in there has to be told
// plainly rather than being sent a storeId of 0.
procedure TfrmLeadsOnlineFTPParams.btnTestConnectionClick(Sender: TObject);
var
  StoreId: Integer;
  Client: TLeadsOnlineClient;
  Res: TLeadsOnlineResult;
  Err: string;
begin
  // The dataset is left in edit mode by FormShow, and the focused control has
  // not written its value back yet. Without this, the test runs against the
  // previous password and the result is a confusing pass or fail.
  DM.qryStore.UpdateRecord;

  if not TryStrToInt(Trim(DM.qryStoreLEADS_STORE_ID.AsString), StoreId) then
  begin
    PawnWarn('The LeadsOnline Store ID must be the numeric store number they ' +
             'issued (for example 57390).' + sLineBreak + sLineBreak +
             'It is currently ' +
             AnsiQuotedStr(Trim(DM.qryStoreLEADS_STORE_ID.AsString), '"') + '.');
    RzDBEdit1.SetFocus;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    Client := TLeadsOnlineClient.Create(StoreId,
                                        Trim(DM.qryStoreLEADS_ONLINE_API_USER.AsString),
                                        DM.qryStoreLEADS_ONLINE_API_PASSWORD.AsString,
                                        DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean);
    try
      if Client.TryCheckLogin(Res, Err) then
        PawnInfo('LeadsOnline accepted these credentials.' + sLineBreak + sLineBreak +
                 'Endpoint: ' + Client.EndpointURL)
      else
        PawnError('LeadsOnline did not accept these credentials.' + sLineBreak + sLineBreak +
                  Err + sLineBreak + sLineBreak +
                  'Endpoint: ' + Client.EndpointURL);
    finally
      Client.Free;
    end;
  finally
    Screen.Cursor := crDefault;
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
