unit SetupEditStore;

// Mode 4: Edit Store Info.
// Plain CRUD over the STORE row. Reads connection details from the local
// PawnPro.ini (decrypting password_enc) and updates the STORE row on save.
// No password rotation, no INI writes, no recovery.dat changes.
//
// Intentionally duplicates fields managed by the existing scattered editors
// (LeadsOnlineFTPParams, SetupBarcodePrinter, etc.) -- the point of this
// mode is to let a fresh install fix forgotten store info before the main
// app is even launched.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.IniFiles,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Comp.Client,
  SetupStoreFields;

type
  TfrmSetupEditStore = class(TForm)
    lblStoreName: TLabel;        edStoreName: TEdit;
    lblStoreAddr: TLabel;        edStoreAddr: TEdit;
    lblStoreCityStZip: TLabel;   edStoreCityStZip: TEdit;
    lblStorePhone: TLabel;       edStorePhone: TEdit;
    lblStorePoliceId: TLabel;    edStorePoliceId: TEdit;
    lblStoreNumber: TLabel;      edStoreNumber: TEdit;
    lblInterestRate: TLabel;     edInterestRate: TEdit;
    lblMaturityMonths: TLabel;   edMaturityMonths: TEdit;
    lblDefaultMonths: TLabel;    edDefaultMonths: TEdit;
    lblSalesTax: TLabel;         edSalesTax: TEdit;
    rgDateCalc: TRadioGroup;
    rgWeightUnit: TRadioGroup;
    gbLeads: TGroupBox;
    lblLeadsStoreId: TLabel;     edLeadsStoreId: TEdit;
    lblLeadsFtp: TLabel;         edLeadsFtp: TEdit;
    lblLeadsUser: TLabel;        edLeadsUser: TEdit;
    lblLeadsPassword: TLabel;    edLeadsPassword: TEdit;
    chkFtpPassive: TCheckBox;
    lblStatus: TLabel;
    btnSave: TButton;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FHost, FDatabase, FPassword: string;
    FPort: Integer;
    FConnectedOK: Boolean;
    function IniPath: string;
    function ReadIniAndDecrypt: Boolean;
    procedure ApplyToControls(const F: TStoreFields);
    function CollectFromControls: TStoreFields;
    procedure SetControlsEnabled(AEnabled: Boolean);
  end;

implementation

{$R *.dfm}

uses
  DPAPIUtils, SetupConnection, PawnProSetupDM;

const
  INI_FILE_NAME   = 'PawnPro.ini';
  INI_SEC_CONN_FB = 'CONNECTION_FB';

function TfrmSetupEditStore.IniPath: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + INI_FILE_NAME;
end;

function TfrmSetupEditStore.ReadIniAndDecrypt: Boolean;
var
  Ini: TIniFile;
  PasswordEnc, PasswordClear: string;
begin
  Result := False;
  Ini := TIniFile.Create(IniPath);
  try
    FHost     := Ini.ReadString (INI_SEC_CONN_FB, 'host',         'localhost');
    FDatabase := Ini.ReadString (INI_SEC_CONN_FB, 'database',     '');
    FPort     := Ini.ReadInteger(INI_SEC_CONN_FB, 'port',         3050);
    PasswordEnc   := Ini.ReadString(INI_SEC_CONN_FB, 'password_enc', '');
    PasswordClear := Ini.ReadString(INI_SEC_CONN_FB, 'password',     '');
  finally
    Ini.Free;
  end;

  if FDatabase = '' then
  begin
    lblStatus.Caption := 'INI missing [CONNECTION_FB] database= entry.';
    Exit;
  end;

  if PasswordEnc <> '' then
  begin
    try
      FPassword := DPAPIUnprotect(PasswordEnc);
    except
      on E: Exception do
      begin
        lblStatus.Caption := 'INI password_enc could not be decrypted: ' + E.Message;
        Exit;
      end;
    end;
  end
  else if PasswordClear <> '' then
    FPassword := PasswordClear   // pre-encryption install
  else
  begin
    lblStatus.Caption := 'INI has no password (encrypted or otherwise).';
    Exit;
  end;

  Result := True;
end;

procedure TfrmSetupEditStore.SetControlsEnabled(AEnabled: Boolean);
begin
  edStoreName.Enabled       := AEnabled;
  edStoreAddr.Enabled       := AEnabled;
  edStoreCityStZip.Enabled  := AEnabled;
  edStorePhone.Enabled      := AEnabled;
  edStorePoliceId.Enabled   := AEnabled;
  edStoreNumber.Enabled     := AEnabled;
  edInterestRate.Enabled    := AEnabled;
  edMaturityMonths.Enabled  := AEnabled;
  edDefaultMonths.Enabled   := AEnabled;
  edSalesTax.Enabled        := AEnabled;
  rgDateCalc.Enabled        := AEnabled;
  rgWeightUnit.Enabled      := AEnabled;
  gbLeads.Enabled           := AEnabled;
  btnSave.Enabled           := AEnabled;
end;

procedure TfrmSetupEditStore.ApplyToControls(const F: TStoreFields);
begin
  edStoreName.Text       := F.StoreName;
  edStoreAddr.Text       := F.StoreAddr;
  edStoreCityStZip.Text  := F.StoreCityStZip;
  edStorePhone.Text      := F.StorePhone;
  edStorePoliceId.Text   := F.StorePoliceId;
  edStoreNumber.Text     := F.StoreNumber;
  edInterestRate.Text    := FormatFloat('0.##', F.DefaultPawnInterestRate);
  edMaturityMonths.Text  := IntToStr(F.DefaultMaturityMonths);
  edDefaultMonths.Text   := IntToStr(F.PawnDefaultMonths);
  edSalesTax.Text        := FormatFloat('0.##', F.SalesTaxPerc);
  if F.PawnDateCalculationBase = 'M' then rgDateCalc.ItemIndex := 1 else rgDateCalc.ItemIndex := 0;
  if F.DefaultWeightMeasureUnit = 'G' then rgWeightUnit.ItemIndex := 1 else rgWeightUnit.ItemIndex := 0;
  edLeadsStoreId.Text   := F.LeadsStoreId;
  edLeadsFtp.Text       := F.LeadsOnlineFtpAddress;
  edLeadsUser.Text      := F.LeadsOnlineUserName;
  edLeadsPassword.Text  := F.LeadsOnlinePassword;
  chkFtpPassive.Checked := F.FtpPassive;
end;

function TfrmSetupEditStore.CollectFromControls: TStoreFields;
begin
  Result := DefaultStoreFields;
  Result.StoreName               := edStoreName.Text;
  Result.StoreAddr               := edStoreAddr.Text;
  Result.StoreCityStZip          := edStoreCityStZip.Text;
  Result.StorePhone              := edStorePhone.Text;
  Result.StorePoliceId           := edStorePoliceId.Text;
  Result.StoreNumber             := edStoreNumber.Text;
  Result.DefaultPawnInterestRate := StrToFloatDef(edInterestRate.Text, 10.0);
  Result.DefaultMaturityMonths   := StrToIntDef(edMaturityMonths.Text, 1);
  Result.PawnDefaultMonths       := StrToIntDef(edDefaultMonths.Text, 2);
  Result.SalesTaxPerc            := StrToFloatDef(edSalesTax.Text, 7.0);
  if rgDateCalc.ItemIndex = 1 then Result.PawnDateCalculationBase := 'M' else Result.PawnDateCalculationBase := 'D';
  if rgWeightUnit.ItemIndex = 1 then Result.DefaultWeightMeasureUnit := 'G' else Result.DefaultWeightMeasureUnit := 'P';
  Result.LeadsStoreId          := edLeadsStoreId.Text;
  Result.LeadsOnlineFtpAddress := edLeadsFtp.Text;
  Result.LeadsOnlineUserName   := edLeadsUser.Text;
  Result.LeadsOnlinePassword   := edLeadsPassword.Text;
  Result.FtpPassive            := chkFtpPassive.Checked;
end;

procedure TfrmSetupEditStore.FormShow(Sender: TObject);
var
  Loaded: TStoreFields;
begin
  FConnectedOK := False;
  SetControlsEnabled(False);
  lblStatus.Caption := 'Reading INI...';
  Application.ProcessMessages;

  if not ReadIniAndDecrypt then Exit;

  lblStatus.Caption := 'Connecting...';
  Application.ProcessMessages;

  try
    BuildFBConnection(DM.Conn, FHost, FDatabase, 'SYSDBA', FPassword, FPort);
    DM.Conn.Connected := True;
    try
      ReadStoreRow(DM.Conn, Loaded);
      ApplyToControls(Loaded);
      FConnectedOK := True;
      SetControlsEnabled(True);
      lblStatus.Caption := 'Loaded. Make changes and click Save.';
    finally
      DM.Conn.Connected := False;
    end;
  except
    on E: Exception do
      lblStatus.Caption := 'Connection failed: ' + E.Message;
  end;
end;

procedure TfrmSetupEditStore.btnSaveClick(Sender: TObject);
var
  F: TStoreFields;
begin
  if not FConnectedOK then Exit;
  F := CollectFromControls;

    try
      BuildFBConnection(DM.Conn, FHost, FDatabase, 'SYSDBA', FPassword, FPort);
      DM.Conn.Connected := True;
      try
        WriteStoreRow(DM.Conn, F);
        lblStatus.Caption := 'Saved.';
      finally
        DM.Conn.Connected := False;
      end;
    except
      on E: Exception do
        lblStatus.Caption := 'Save failed: ' + E.Message;
    end;
end;

procedure TfrmSetupEditStore.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
