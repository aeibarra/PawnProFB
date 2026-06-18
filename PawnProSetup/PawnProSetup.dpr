program PawnProSetup;

uses
  Vcl.Forms,
  PawnProSetupMain in 'PawnProSetupMain.pas' {frmPawnProSetupMain},
  PawnProSetupDM in 'PawnProSetupDM.pas' {DM: TDataModule},
  DPAPIUtils in '..\..\COMMON\DPAPIUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPawnProSetupMain, frmPawnProSetupMain);
  Application.Run;
end.
