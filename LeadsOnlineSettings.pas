unit LeadsOnlineSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RzButton, RzLabel, Vcl.Mask, RzEdit, RzDBEdit, Vcl.DBCtrls;

type
  TfrmLeadsOnlineSettings = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    btnSave: TRzBitBtn;
    btnCancel: TRzBitBtn;
    gbApi: TGroupBox;
    lblApiUser: TRzLabel;
    lblApiPassword: TRzLabel;
    edApiUser: TRzDBEdit;
    edApiPassword: TRzDBEdit;
    chkUseSandbox: TDBCheckBox;
    chkSkipCsvSent: TDBCheckBox;
    lblSkipCsvHint: TLabel;
    btnTestConnection: TRzBitBtn;
    rgExportMethod: TDBRadioGroup;
    GroupBox3: TGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edLeadsOnlineFTPAddress: TRzDBEdit;
    edUserName: TRzDBEdit;
    edPassword: TRzDBEdit;
    DBCheckBox1: TDBCheckBox;
    RzLabel4: TRzLabel;
    edStoreId: TRzDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLeadsOnlineSettings: TfrmLeadsOnlineSettings;

implementation

{$R *.dfm}

uses PawnDM, uPawnDialogs, uLeadsOnlineClient;

procedure TfrmLeadsOnlineSettings.FormShow(Sender: TObject);
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
procedure TfrmLeadsOnlineSettings.btnTestConnectionClick(Sender: TObject);
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
    edStoreId.SetFocus;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    Client := TLeadsOnlineClient.Create(StoreId,
                                        Trim(DM.qryStoreLEADS_ONLINE_API_USER.AsString),
                                        DM.qryStoreLEADS_ONLINE_API_PASSWORD.AsString,
                                        DM.qryStoreLEADS_ONLINE_USE_SANDBOX.AsBoolean);
    try
      // Three outcomes, not two. Reporting a dead line as "wrong credentials"
      // sends the operator off re-typing a password that was always correct --
      // which is exactly what happened the first time this was used against
      // production.
      if not Client.TryCheckLogin(Res, Err) then
        PawnError('Could not reach LeadsOnline, so the credentials were never ' +
                  'checked.' + sLineBreak + sLineBreak +
                  DiagnoseEndpoint(Client.EndpointURL) + sLineBreak + sLineBreak +
                  'Endpoint: ' + Client.EndpointURL + sLineBreak +
                  'Details: ' + Err)
      else if Res.Succeeded then
        PawnInfo('LeadsOnline accepted these credentials.' + sLineBreak + sLineBreak +
                 'Endpoint: ' + Client.EndpointURL)
      else
        PawnError('LeadsOnline was reached, but did not accept these ' +
                  'credentials.' + sLineBreak + sLineBreak +
                  Res.Text + sLineBreak + sLineBreak +
                  'Check the Store ID, API user name and API password. Note that ' +
                  'sandbox and production use DIFFERENT credentials, so this also ' +
                  'fails when production details are tested against the sandbox ' +
                  '(or the reverse).' + sLineBreak + sLineBreak +
                  'Endpoint: ' + Client.EndpointURL);
    finally
      Client.Free;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmLeadsOnlineSettings.btnSaveClick(Sender: TObject);
begin
  DM.qryStore.Post;

  ModalResult := mrOk;
end;

procedure TfrmLeadsOnlineSettings.btnCancelClick(Sender: TObject);
begin
  DM.qryStore.Cancel;

  ModalResult := mrCancel;
end;

end.
