unit DrvLic_PDF417Parsing;

{ Capture layer for driver licence reads, and the home of the LEGACY MAGNETIC
  STRIPE parser.

  TWO PARSERS LIVE HERE ON PURPOSE. They are not duplicates and must not be
  merged -- they read different physical media, in different formats:

    ParseAAMVADriverLicense  (DrvLic_AAMVA)  2D PDF417 barcode on the back of
                                             the card. Structural: validates the
                                             AAMVA header, subfile directory,
                                             offsets and lengths.

    ParseFL_DL               (this unit)     Florida MAGNETIC STRIPE. A different
                                             encoding entirely, still used by
                                             CardReader, EnterClientInfo,
                                             SearchClient and PawnGlobal.

  ConvertToFeetInches / GetHeightToFeets belong to the magnetic path. They look
  unused from outside and are not.

  What this unit contributes to the barcode path is capture only: recognising the
  header in the key stream and accumulating the raw bytes -- CONTROL CHARACTERS
  INCLUDED, because the parser validates byte offsets against them. }

interface

uses System.SysUtils, System.Variants, System.Classes, Vcl.Forms,
  System.Generics.Collections, System.StrUtils, Vcl.ExtCtrls, Vcl.Controls, DrvLic_AAMVA;

type
  TKeyQueue = array [1..2] of Word;
  TDriverLicenseInfo = DrvLic_AAMVA.TDriverLicenseInfo;
  EDriverLicenseBarcode = DrvLic_AAMVA.EDriverLicenseBarcode;
  TPopulateData = procedure (const DrvLicInfo: TDriverLicenseInfo) of object;
  TScanDataList = TList<Char>;

const
  CardHeader: TKeyQueue = ($10, $35);
  CardNewLine: TKeyQueue = ($10, $BF);
  USA_DrvLic_Header_PDF417 = '@ANSI ';

procedure ParsePDF417_US_Driver_License(var BarcodeData: string; out DrvLic: TDriverLicenseInfo);
procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: TDriverLicenseInfo);
function BarcodePDF417PatterDetected(const D: string): Boolean;
function GetLastSevenReadChars(Key: Char; var ReadChars: string): string;
procedure ProcessKeyForPDF417barcodeScan(var Key: Char;
  var ScanningPDF417Barcode: Boolean; var ScanData: TScanDataList;
  var ReadChars: string; var TimerTimeOut: TTimer; var LastDataCount: Integer);
function ScanBufferIsIdle(CurrentCount: Integer; var LastCount, IdleChecks: Integer): Boolean;
function GetStrToShow(S: string): string;
procedure ParseFL_DL(RawData: string; var DrvLicInfo: TDriverLicenseInfo);

implementation

function GetStrToShow(S: String): string;
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

function GetLastSevenReadChars(Key: Char; var ReadChars: string): String;
begin
  if Key >= #32 then
    Result := AnsiRightStr(String(ReadChars), 5) + Key
  else
    Result := AnsiRightStr(String(ReadChars), 6);

  ReadChars := Result;
end;

function BarcodePDF417PatterDetected(const D: string): Boolean;
var C: Char; Header: string;
begin
  Header := '';
  for C in D do
  begin
    if C >= #32 then Header := Header + C;
    if Length(Header) = 6 then Break;
  end;
  Result := SameText(Header, USA_DrvLic_Header_PDF417);
end;

procedure ProcessKeyForPDF417barcodeScan(var Key: Char;
  var ScanningPDF417Barcode: Boolean; var ScanData: TScanDataList;
  var ReadChars: string; var TimerTimeOut: TTimer; var LastDataCount: Integer);
var C: Char; Header: string;
begin
  if ScanningPDF417Barcode then
  begin
    ScanData.Add(Key);
    Key := #0;
    Exit;
  end;

  // Retain header controls: offsets are relative to the original barcode bytes.
  if Key = '@' then ReadChars := '@'
  else if ReadChars <> '' then ReadChars := ReadChars + Key
  else Exit;
  Header := '';
  for C in ReadChars do
    if C >= #32 then Header := Header + C;
  if (Length(ReadChars) > 16) or
     not SameText(Header, Copy(USA_DrvLic_Header_PDF417, 1, Length(Header))) then
  begin
    ReadChars := '';
    Exit;
  end;
  if SameText(Header, USA_DrvLic_Header_PDF417) then
  begin
    ScanData.Clear;
    for C in ReadChars do ScanData.Add(C);
    ReadChars := '';
    LastDataCount := 0;
    ScanningPDF417Barcode := True;
    TimerTimeOut.Enabled := True;
    Screen.Cursor := crHourGlass;
    Key := #0;
  end;
end;

function ScanBufferIsIdle(CurrentCount: Integer; var LastCount, IdleChecks: Integer): Boolean;
begin
  if (LastCount = 0) or (CurrentCount <> LastCount) then
  begin
    LastCount := CurrentCount;
    IdleChecks := 0;
  end
  else Inc(IdleChecks);
  // Two unchanged 500 ms checks allow a brief transmission pause. The parser
  // still verifies every declared subfile length before any data is applied.
  Result := IdleChecks >= 2;
end;

procedure ParsePDF417_US_Driver_License(var BarcodeData: string; out DrvLic: TDriverLicenseInfo);
begin
  ParseAAMVADriverLicense(BarcodeData, DrvLic);
end;

procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: TDriverLicenseInfo);
var I: Integer; S: string;
begin
  SetLength(S, ScanData.Count);
  for I := 0 to ScanData.Count - 1 do S[I + 1] := ScanData[I];
  ParseAAMVADriverLicense(S, DrvLic);
end;

function ConvertToFeetInches(N: integer): string;
var
  Ft: Extended;
  Fr: Extended;
  Feet, Inches: integer;
begin
  Ft := N / 12.0;
  Fr := Frac(Ft);

  Feet := trunc(Ft);
  Inches := Round(Fr * 12.00);

  Result := Feet.ToString + '''' + Inches.ToString + '"';
end;

function GetHeightToFeets(S: string): string;
var
  F: integer;
  C: Char;
  Digits: string;
begin
  Result := S;

  // Keep this adapter independent of the application's database/UI utilities.
  Digits := '';
  for C in S do
    if CharInSet(C, ['0'..'9']) then Digits := Digits + C;

  if not TryStrToInt(Digits, F) then
    Exit;

  if F > 10 then
    begin
      Result := ConvertToFeetInches(F);
    end;

end;

// Magnetic-stripe compatibility path.

procedure GetNextParam(const RawData: string; var NextParam: string; var RawParamLen: integer; IncludeBlank: boolean = false);
var
  i, iParamStart, iParamEnd: integer;
begin
  RawParamLen := 0;
  iParamStart := 0;
  iParamEnd := 0;
  for i := 1 to Length(RawData) do
    begin
      inc(RawParamLen);
      if (iParamStart = 0) and ( (CharInSet(RawData[i], ['0'..'9', 'a'..'z', 'A'..'Z'])) ) then
        iParamStart := i;

      if (iParamStart <> 0) and (iParamEnd = 0) and not ((CharInSet(RawData[i], ['0'..'9', 'a'..'z', 'A'..'Z'])) or (IncludeBlank and (RawData[i] = ' ')) ) then
        begin
          iParamEnd := i - 1;
          break;
        end;
    end;

  if iParamEnd = 0 then
    iParamEnd := RawData.Length;

  NextParam := Copy(RawData, iParamStart, iParamEnd - iParamStart + 1);

end;

procedure GetDrvLicZipCode(const RawZipCode: string; var ZipCode: string; var NewDrvLic: boolean);
begin
  if RawZipCode.Length = 11 then  //New Drv Lic
    begin
      NewDrvLic := true;
      ZipCode := Copy(RawZipCode, 3, 5) + '-' + Copy(RawZipCode, 8, 4);
    end
  else
    begin
      NewDrvLic := false;
      ZipCode := Copy(trim(RawZipCode), 1, 5);
    end;
  ZipCode := NormalizeUSZipCode(ZipCode);
end;

procedure ParseFL_DL(RawData: string; var DrvLicInfo: TDriverLicenseInfo);
var
  StCity, LastName, DOBStr, FirstNames, FName, MName, RawZipCode, GenderHeight: string;
  DOB: TDateTime;
  NewLic: boolean;
  P, RawParamLen: integer;
begin
  if RawData = '' then
    exit;

//  WriteTextFile('C:\Temp\RawData.txt', RawData);
  NewLic := false;

  GetNextParam(RawData, StCity, RawParamLen);

//  p := pos('^', RawData);
//  StCity := CharsOnly(Copy(RawData, 1, p));
  DrvLicInfo.State := UpperCase(Copy(StCity, 1, 2));
  DrvLicInfo.City := UpperCase(Copy(StCity, 3, Length(StCity)));
  Delete(RawData, 1, RawParamLen);

  P := Pos('$', RawData);
  LastName := Copy(RawData, 1, P - 1);
  DrvLicInfo.LastName := UpperCase(LastName);
  Delete(RawData, 1, P);

  P := Pos('^', RawData);
  FirstNames := Copy(RawData, 1, P - 1);
  Delete(RawData, 1, P);

  GetNextParam(FirstNames, FName, RawParamLen);
  DrvLicInfo.FirstName := UpperCase(FName);
  Delete(FirstNames, 1, RawParamLen);


  GetNextParam(FirstNames, MName, RawParamLen);
  DrvLicInfo.MiddleName := UpperCase(MName);

//  P := Pos(' ', FirstNames);
//  if p > 0 then
//    begin
//      DrvLicInfo.FirstName := UpperCase(Copy(FirstNames, 1, P - 1));
//      DrvLicInfo.MiddleName := Copy(FirstNames, p + 1, length(FirstNames));
//    end
//  else
//    begin
//      DrvLicInfo.FirstName := FirstNames;
//      DrvLicInfo.MiddleName := '';
//    end;

//  P := Pos('$', RawData);
//  if P = 0 then  //This is happening in the new  Licenses (5/2/2018)
//    begin
//      P := Pos(' ', RawData);
//      NewLic := true;
//    end;


//  GetNextParam(RawData, DrvLicInfo.FirstName, RawParamLen);
//  Delete(RawData, 1, RawParamLen);

//  P := Pos('^', RawData);
//  DrvLicInfo.MiddleName := UpperCase(Copy(RawData, 1, P - 1));
//  Delete(RawData, 1, P);
//
//  P := Pos('^', RawData);
//  if P = 0 then
//    P := Pos('?', RawData);

  GetNextParam(RawData, DrvLicInfo.Address, RawParamLen, true);

//  DrvLicInfo.Address := UpperCase(Copy(RawData, 1, P - 1));

//  P := Pos(';', RawData);
  Delete(RawData, 1, RawParamLen);

  GetNextParam(RawData, DrvLicInfo.DrivervLicNumber, RawParamLen);
  DrvLicInfo.DrivervLicNumber := UpperCase(Copy(LastName, 1, 1) + Copy(DrvLicInfo.DrivervLicNumber, 9, DrvLicInfo.DrivervLicNumber.Length) + '0');
  Delete(RawData, 1, RawParamLen);

//  P := Pos('=', RawData);
//  DrvLicInfo.DrivervLicNumber := UpperCase(Copy(LastName, 1, 1) + Copy(RawData, 9, 11) + '0');
//  if Length(DrvLicInfo.DrivervLicNumber) = 13 then
//    DrvLicInfo.DrivervLicNumber := Copy(DrvLicInfo.DrivervLicNumber, 1, 4) + //'-' +
//                                   Copy(DrvLicInfo.DrivervLicNumber, 5, 3) + //'-' +
//                                   Copy(DrvLicInfo.DrivervLicNumber, 8, 2) + //'-' +
//                                   Copy(DrvLicInfo.DrivervLicNumber, 10, 3) + //'-' +
//                                   Copy(DrvLicInfo.DrivervLicNumber, 13, 1);
//  Delete(RawData, 1, P);

  ///////////DOB////////////////////////////////////
  GetNextParam(RawData, DOBStr, RawParamLen, false);

  if not TryEncodeDate(StrToIntDef(Copy(DOBStr, 5, 4), 0),
                       StrToIntDef(Copy(DOBStr, 3, 2), 0),
                       StrToIntDef(Copy(DOBStr, 11, 2), 0),
                       DOB) then
    DrvLicInfo.DOB := null
  else
    DrvLicInfo.DOB := DOB;


  Delete(RawData, 1, RawParamLen);
  //////////////////////////////////////////////////

  /////////////////ZIP CODE/////////////////////////
  GetNextParam(RawData, RawZipCode, RawParamLen, false);
  GetDrvLicZipCode(RawZipCode, DrvLicInfo.ZipCode, NewLic);

  Delete(RawData, 1, RawParamLen);
  ///////////////////////////////////////////////////

//  GetNextParam(RawData, Dummy, RawParamLen, false);
//  Delete(RawData, 1, RawParamLen);

  /////////GENDER AND HEIGHT////////////////////////////////
  GenderHeight := trim(Copy(RawData, 15, 12));

  if Copy(GenderHeight, 1, 1) = '1' then
    DrvLicInfo.Sex := 'M'
  else
    DrvLicInfo.Sex := 'F';

  if NewLic then
    DrvLicInfo.PersonHeight := GetHeightToFeets(Copy(GenderHeight, 2, 3))
  else
    DrvLicInfo.PersonHeight := Copy(GenderHeight, 2, 1) + '-' + Copy(GenderHeight, 3, 2);

  Delete(RawData, 1, RawParamLen);
  //////////////////////////////////////////////////////////////


//  P := Pos(#13, RawData);
//  if P = 0 then
//    P := Pos('?+!', RawData);

//  Delete(RawData, 1, P);

//  ZipCodeStr := Copy(RawData, 1, 20);
//
//  ZipCodeStr := CharsOnly(trim(ZipCodeStr));
//
//  if NewLic then
//    DrvLicInfo.ZipCode := GetDriverLicZip(ZipCodeStr)
//  else
//    DrvLicInfo.ZipCode := Copy(ZipCodeStr, 1, 5);

//  Delete(RawData, 1, 20);

//  RawData := trim(RawData);


end;


end.
