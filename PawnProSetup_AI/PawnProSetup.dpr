program PawnProSetup;

// PawnPro setup utility: replaces the default 'masterkey' SYSDBA password with
// a strong per-store password, encrypts it via DPAPI into [CONNECTION_FB]
// password_enc=, writes recovery.dat for vendor offline recovery, populates
// the single STORE row. Four modes: New Install, Add Workstation, Rotate
// Password, Edit Store. See SetupMain.pas.

uses
  Vcl.Forms,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  SetupMain in 'SetupMain.pas' {frmSetupMain},
  SetupNewInstall in 'SetupNewInstall.pas' {frmSetupNewInstall},
  SetupAddWorkstation in 'SetupAddWorkstation.pas' {frmSetupAddWorkstation},
  SetupRotatePassword in 'SetupRotatePassword.pas' {frmSetupRotatePassword},
  SetupEditStore in 'SetupEditStore.pas' {frmSetupEditStore},
  SetupConnection in 'SetupConnection.pas',
  SetupStoreFields in 'SetupStoreFields.pas',
  DPAPIUtils in '..\..\COMMON\DPAPIUtils.pas',
  SealedBox in '..\..\COMMON\SealedBox.pas',
  PawnProSetupDM in 'PawnProSetupDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PawnPro Setup';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmSetupMain, frmSetupMain);
  Application.Run;
end.
