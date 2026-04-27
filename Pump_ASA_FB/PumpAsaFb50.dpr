program PumpAsaFb50;

uses
  Vcl.Forms,
  PumpAsaFb50Main in 'PumpAsaFb50Main.pas' {frmPumpAsaFb50Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPumpAsaFb50Main, frmPumpAsaFb50Main);
  Application.Run;
end.
