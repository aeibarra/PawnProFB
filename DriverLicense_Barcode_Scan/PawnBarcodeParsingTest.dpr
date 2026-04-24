program PawnBarcodeParsingTest;

uses
  Vcl.Forms,
  PawnBarcodeParsing in 'PawnBarcodeParsing.pas' {Form2},
  DrvLic_PDF417Parsing in 'DrvLic_PDF417Parsing.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
