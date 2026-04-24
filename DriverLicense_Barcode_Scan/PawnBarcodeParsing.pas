unit PawnBarcodeParsing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, System.Generics.Collections,
  DrvLic_PDF417Parsing;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Memo1: TMemo;
    Memo3: TMemo;
    Button2: TButton;
    Memo2: TMemo;
    brtnParseData: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure brtnParseDataClick(Sender: TObject);
  private
    ScanData: TScanDataList;
    ScanningPDF417Barcode: boolean;
    procedure ProcessKeysForUSADrvLic(var Key: Char);
    procedure ShowData(Memo: TMemo; DrvLic: DriverLicenseInfo);
  public
    Stop: boolean;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


const
   USA_DrvLic_Header_PDF417: AnsiString = '@'#13'ANSI';

var
    ReadChars: AnsiString = '';
//    RawData: ansistring;

function GetStrToShow(S: ansistring): string;
var
   i: integer;
   c: string;
begin
  Result := '';
  for i := 1 to Length(S) do
    begin
      if S[i] < #32 then
        c := '#' + byte(S[i]).ToString
      else
        c := char(S[i]);

      Result := Result + c;
    end;
end;

procedure TForm2.ShowData(Memo: TMemo ;DrvLic: DriverLicenseInfo);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add('ID #: ' + DrvLic.ID);
  Memo.Lines.Add('First Name: ' + DrvLic.FirstName);
  Memo.Lines.Add('Middle Name: ' + DrvLic.MiddleName);
  Memo.Lines.Add('last Name: ' + DrvLic.LastName);

  Memo.Lines.Add('DOB: ' + FormatDateTime('mm/dd/yyyy', DrvLic.DOB));
  Memo.Lines.Add('Issued: ' + FormatDateTime('mm/dd/yyyy', DrvLic.IssuedDate));
  Memo.Lines.Add('Exp: ' + FormatDateTime('mm/dd/yyyy', DrvLic.Exp));

  Memo.Lines.Add('VehicleClass: ' + DrvLic.VehicleClass);

  Memo.Lines.Add('Gender: ' + DrvLic.Gender);
  Memo.Lines.Add('Height: ' + DrvLic.Height);

  Memo.Lines.Add('Address: ' + DrvLic.Address);
  Memo.Lines.Add('City: ' + DrvLic.City);
  Memo.Lines.Add('State: ' + DrvLic.State);
  Memo.Lines.Add('ZipCode: ' + DrvLic.ZipCode);
  Memo.Lines.Add('Country: ' + DrvLic.Country);

end;

procedure TForm2.brtnParseDataClick(Sender: TObject);
var
  DrvLic: DriverLicenseInfo;
  i: integer;
  S: string;
begin
  ScanData.Clear;
  S := Memo1.Lines.Text;

  for i := 1 to S.Length do
    ScanData.Add(ansichar(S[i]));

  ParseScanBarcodeData(ScanData, DrvLic);

  ShowData(Memo3, DrvLic);

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Stop := true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ScanData := TList<ansichar>.Create;
  ScanData.Clear;

  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;

  Stop := false;
  ScanningPDF417Barcode := false;
end;

function GetLastSixReadChars(Key: Char): AnsiString;
begin
  Result := AnsiString(AnsiRightStr(String(ReadChars), 5) + Key);
  ReadChars := Result;
end;

procedure TForm2.ProcessKeysForUSADrvLic(var Key: Char);
var
  LastSixChars: AnsiString;
  ListLen: integer;
  DrvLic: DriverLicenseInfo;
begin
  if not Stop then
    begin
 //     Memo3.Lines.Add('Key: ' + GetStrToShow(Key));
      if ScanningPDF417Barcode then
        begin
          ScanData.Add(AnsiChar(Key));
          Key := #0;
          if ScanData.Count > 2 then
            begin
              ListLen := ScanData.Count;
              if (ScanData[ListLen - 2] = #13) and (ScanData[ListLen - 1] = #13) then
                begin
                  ScanningPDF417Barcode := false;
                  ParseScanBarcodeData(ScanData, DrvLic);

                  ShowData(Memo3, DrvLic);  //Debug only@
               //   Memo3.Lines.Text := RawData;
               //   Memo3.Lines.SaveToFile('C:\Temp\Pepito.txt');
                end;

            end;

        end
      else
        begin
          LastSixChars := GetLastSixReadChars(Key);
         // Memo2.Lines.Add(GetStrToShow(LastSixChars));

          if LastSixChars = USA_DrvLic_Header_PDF417 then
            begin
              ScanningPDF417Barcode := true;

              ScanData.Add(LastSixChars[1]);
              ScanData.Add(LastSixChars[2]);
              ScanData.Add(LastSixChars[3]);
              ScanData.Add(LastSixChars[4]);
              ScanData.Add(LastSixChars[5]);
              ScanData.Add(LastSixChars[6]);
            end;
        end
    end;
end;
procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  ProcessKeysForUSADrvLic(Key);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Memo1.SetFocus;
end;

end.
