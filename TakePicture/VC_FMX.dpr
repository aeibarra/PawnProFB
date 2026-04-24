program VC_FMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  VideoCaptureSample in 'VideoCaptureSample.pas' {frmCamera};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCamera, frmCamera);
  Application.Run;
end.
