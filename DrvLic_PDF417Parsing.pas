unit DrvLic_PDF417Parsing;

interface

uses System.SysUtils, System.Variants, System.Classes, VCL.Forms, System.DateUtils,
     System.Generics.Collections, System.strUtils, Vcl.ExtCtrls, Controls, Vcl.Dialogs;

type
  TKeyQueue = array [1..2] of word;

  TDriverLicenseInfo = record
    FirstName, MiddleName, LastName: string;
    Sex: string;
    PersonHeight: String;
    Address, City, State, ZipCode, Country: string;
    DOB: Variant;
    IssuedDate: TDate;
    Exp: TDate;
    VehicleClass: string;
    DrivervLicNumber: string;
  end;

//  TGetScanDataBuffer = procedure (var S: string) of object;
//  TFillDataProc      = procedure (const DrvLicInfo: TDriverLicenseInfo) of object;

  TPopulateData = procedure (const DrvLicInfo: TDriverLicenseInfo) of object;

  TScanDataList = TList<char>;

{  DriverLicenseInfo = record
    FirstName: string;
    MiddleName: string;
    LastName: string;
    DOB: TDate;
    IssuedDate: TDate;
    Exp: TDate;
    ID: string;
    VehicleClass: string;
    Gender: string;
    Height: string;
    Address: string;
    City: string;
    State: string;
    ZipCode: string;
    Country: string;
  end;}

const
  CardHeader:  TKeyQueue = ($10,$35);
//  CardFooter:  TKeyQueue = ($00,$10,$BF,$0D);//  $10 $BF $0D
  CardNewLine: TKeyQueue = ($10,$BF);//  $31 $10 $BF $0D

//  PDF417Header = '@'#13#10'ANSI';
  USA_DrvLic_Header_PDF417: String = '@ANSI ';
//  USA_DrvLic_Header_PDF417: String = '@ANSI';


procedure ParsePDF417_US_Driver_License(var BarcodeData: string; out DrvLic: TDriverLicenseInfo);
procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: TDriverLicenseInfo);
function BarcodePDF417PatterDetected(const D: string): boolean;
function GetLastSevenReadChars(Key: Char; var ReadChars: string): String;
//procedure ParseUSA_DL_String(ProcGetDataBuffer: TGetScanDataBuffer; ShowDrvLicData: TFillDataProc);

procedure ProcessKeyForPDF417barcodeScan(var Key: Char;
                                         var ScanningPDF417Barcode: boolean;
                                         var ScanData: TScanDataList;
                                         var ReadChars: string;
                                         var TimerTimeOut: TTimer;
                                         var LastDataCount: integer);

function GetStrToShow(S: String): string;

/////////////////////////////////////////////////////////////////////////////////////////
procedure ParseFL_DL(RawData: string; var DrvLicInfo: TDriverLicenseInfo);


implementation

(*
01 @  - Field 1 Char(1)
ANSI 636010
09
00
02
DL00410250ZF02910067DLDAQI160005651820DCSIBARRADDENDACALBERTODDFNDADENRIQUEDDGNDCAEDCBADCDNONEDBD04172019DBB05221965DBA05222027DBC1DAU068 INDAG3654 NW 20TH STDAIMIAMIDAJFLDAK331426806  DCFX631904170710DCGUSADCK0100372324019086DDAFDDB03162017DDK1
ZFZFAZFBZFCSAFE DRIVERZFDZFEZFFZFGZFHZFIZFJ0037160707ZFK


*)

uses GLbUtils;

type
  HeaderInfomation = (H_Idnumber,
                      H_LastName, H_FirstName, H_MiddleName,
                      H_VehicleClass,
                      H_IssuedDate, H_DOB, H_ExpirationDate,
                      H_Sex, H_Height,
                      H_Address_1, H_City, H_State, H_ZipCode,
                      H_Country, H_FullName,
                      H_None);

  SecDataType = (F_String, F_Date);

  TSectionHeader = record
    Header: string;
    ID: HeaderInfomation;
    SecLength: integer;
    DataType: SecDataType;
  end;

const
  NumberOfHeaderSections = 24;

  SectionHeaders: array [1..NumberOfHeaderSections] of TSectionHeader = (
    (Header: 'DAQ'; ID: H_Idnumber;       SecLength: 13; DataType: F_String),
    (Header: 'DCS'; ID: H_LastName;       SecLength: 0; DataType: F_String),
    (Header: 'DDE'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DAC'; ID: H_FirstName;      SecLength: 0; DataType: F_String),
    (Header: 'DDF'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DAD'; ID: H_MiddleName;     SecLength: 0; DataType: F_String),
    (Header: 'DDG'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DCA'; ID: H_VehicleClass;   SecLength: 1; DataType: F_String),
    (Header: 'DCB'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DCD'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DBD'; ID: H_IssuedDate;     SecLength: 8; DataType: F_Date),
    (Header: 'DBB'; ID: H_DOB;            SecLength: 8; DataType: F_Date),
    (Header: 'DBA'; ID: H_ExpirationDate; SecLength: 8; DataType: F_Date),
    (Header: 'DBC'; ID: H_Sex;            SecLength: 1; DataType: F_String),
    (Header: 'DAU'; ID: H_Height;         SecLength: 6; DataType: F_String),
    (Header: 'DAG'; ID: H_Address_1;      SecLength: 0; DataType: F_String),
    (Header: 'DAI'; ID: H_City;           SecLength: 0; DataType: F_String),
    (Header: 'DAJ'; ID: H_State;          SecLength: 0; DataType: F_String),
    (Header: 'DAK'; ID: H_ZipCode;        SecLength: 9; DataType: F_String),
    (Header: 'DCF'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DCG'; ID: H_Country;        SecLength: 0; DataType: F_String),
    (Header: 'DAA'; ID: H_FullName;       SecLength: 0; DataType: F_String),
    (Header: 'DCK'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DDK'; ID: H_None;           SecLength: 0; DataType: F_String)
  );

var
  AllHeaderTags: string = '';

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

function BarcodePDF417PatterDetected(const D: string): boolean;
var
  HeaderStr: string;
begin
  Result := false;

  if D.Length < 7 then
    exit;

  HeaderStr := UpperCase(Copy(D, 1, 20));

  Result := (HeaderStr[1] = '@') and (HeaderStr[2] = #13) and (HeaderStr[3] = #10) and
            (HeaderStr[4] = 'A') and (HeaderStr[5] = 'N') and (HeaderStr[6] = 'S') and (HeaderStr[7] = 'I');

end;

procedure ProcessKeyForPDF417barcodeScan(var Key: Char;
                                         var ScanningPDF417Barcode: boolean;
                                         var ScanData: TScanDataList;
                                         var ReadChars: string;
                                         var TimerTimeOut: TTimer;
                                         var LastDataCount: integer);
var
  LastChars: String;
//  ListLen: integer;
//  DrvLic: TDriverLicenseInfo;
begin
  if ScanningPDF417Barcode then   ///// FINISH //////
    begin
      ScanData.Add(Key);

      Key := #0;
{      if ScanData.Count > 2 then
        begin
          ListLen := ScanData.Count;
          if (ScanData[ListLen - 2] = #13) and (ScanData[ListLen - 1] = #13) then
            begin
              TimerTimeOut.Enabled := false;

              Screen.Cursor := crDefault;

              ScanningPDF417Barcode := false;
              ParseScanBarcodeData(ScanData, DrvLic);

              PopulateData(DrvLic);
            end;
        end;}
    end
  else
    begin   ///// START ////////}
      LastChars := UpperCase(GetLastSevenReadChars(Key, ReadChars));

      if LastChars = USA_DrvLic_Header_PDF417 then
        begin
          Screen.Cursor := crHourGlass;

          LastDataCount := 0;
          TimerTimeOut.Enabled := true;

          ScanningPDF417Barcode := true;

          ScanData.Clear;
          ScanData.Add(LastChars[1]);
          ScanData.Add(LastChars[2]);
          ScanData.Add(LastChars[3]);
          ScanData.Add(LastChars[4]);
          ScanData.Add(LastChars[5]);
          ScanData.Add(LastChars[6]);

        end;
    end
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
begin
  Result := S;

  S := GetNumbersOnly(S);

  if not TryStrToInt(S, F) then
    Exit;

  if F > 10 then
    begin
      Result := ConvertToFeetInches(F);
    end;

end;

procedure FormatError(Err: string);
begin
  raise Exception.Create(Err);
end;

function GetAllHeaderTags: string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to NumberOfHeaderSections do
    begin
      Result := Result + SectionHeaders[i].Header + ';';
    end;
end;

function IsSectionHeader(PossibleHeader: string;
                         out SectionName: HeaderInfomation; out SectionLength: integer;
                         out SectionDataType: SecDataType): boolean;
var
  i: integer;
begin
  Result := false;
  SectionLength := -1;
  SectionName := H_None;
  SectionDataType := F_String;

  for i := 1 to NumberOfHeaderSections do
    begin
      if PossibleHeader = SectionHeaders[i].Header then
        begin
          Result := true;
          SectionName := SectionHeaders[i].ID;
          SectionLength := SectionHeaders[i].SecLength;
          SectionDataType := SectionHeaders[i].DataType;
          exit;
        end;
    end;
end;

function GetSecDate(D: string): TDateTime;
var
  Day, Month, Year, FirstPart: Integer;
begin
  Result := 0;
  if Length(D) < 8 then
    Exit;

  if TryStrToInt(Copy(D, 1, 2), FirstPart) then
    begin
      if FirstPart <= 12 then
      begin
        if not TryStrToInt(Copy(D, 1, 2), Month) then Exit;
        if not TryStrToInt(Copy(D, 3, 2), Day) then Exit;
        if not TryStrToInt(Copy(D, 5, 4), Year) then Exit;
      end
      else
      begin
        if not TryStrToInt(Copy(D, 1, 4), Year) then Exit;
        if not TryStrToInt(Copy(D, 5, 2), Month) then Exit;
        if not TryStrToInt(Copy(D, 7, 2), Day) then Exit;
      end;

      if not TryEncodeDate(Year, Month, Day, Result) then
        Result := 0;
    end;
end;

function FindNextSecHeaderPosition(const BarcodeData: string; StartPos, EndPos: integer): integer;
var
  i: integer;
  CurrChars: String;
begin
  Result := 0;

  if AllHeaderTags = '' then
    AllHeaderTags := GetAllHeaderTags;

  for i := StartPos + 3 to EndPos do
    begin
      CurrChars := String(BarcodeData[i-2] + BarcodeData[i-1] + BarcodeData[i]);

      if pos(CurrChars, AllHeaderTags) > 0 then
        begin
          Exit(i - 3);
        end;
    end;

end;

procedure SplitFullName(D: string; var FirstName: string; var MiddleName: string; var LastName: string);
var
  F, L: string;
  p: integer;
begin
  p := pos(',', D);
  L := Copy(D, 1, p - 1);
  F := Copy(D, p + 1, length(D));

  F := ReplaceStr(F, ',', '');

  p := pos(' ', F);
  if p > 0 then
    begin
      FirstName := Copy(F, 1, p - 1);
      MiddleName := Copy(F, p + 1, Length(F));
    end
  else
    begin
      FirstName := F;
      MiddleName := '';
    end;


  LastName := L;
end;

procedure ParsePDF417_US_Driver_License(var BarcodeData: string; out DrvLic: TDriverLicenseInfo);
var
  p, pEnd: integer;
  i, NextHPos: integer;
  SectionName: HeaderInfomation;
  SectionLength: integer;
  SectionDataType: SecDataType;
  D: String;
  Ddate: TDate;
begin
  p := 1;

  if BarcodeData.Length < 50 then
    FormatError('Invalid Driver License Data');

  //Field 01 Size: 1 char  always @
  if BarcodeData[p] <> '@' then
    FormatError('@ not found');

//   p := pos(#13, BarcodeData);
//   pEnd := posex(#13, BarcodeData, p + 1);

   BarcodeData := UpperCase(BarcodeData);

   p := pos(' ', BarcodeData);
   pEnd := BarcodeData.Length - P;

  for i := p + 2 to pEnd - 1 do
    begin
      if IsSectionHeader(BarcodeData[i-2] + BarcodeData[i-1] + BarcodeData[i],
                         SectionName, SectionLength, SectionDataType)  then
        begin
          D := '';
          Ddate := 0;

          if SectionName = H_None then
            Continue;

          if SectionLength > 0 then
            begin
              D := Copy(BarcodeData, i + 1, SectionLength);
            end
          else  //Variable Length
            begin
              NextHPos := FindNextSecHeaderPosition(BarcodeData, i + 1, pEnd - 1);
              D := Copy(BarcodeData, i + 1, NextHPos - i);
            end;

          if SectionDataType = F_Date then
            begin
              Ddate := GetSecDate(String(D));
            end;

          case SectionName of
          H_Idnumber: DrvLic.DrivervLicNumber := String(D);
          H_LastName: DrvLic.LastName := String(D);
          H_FirstName: DrvLic.FirstName := String(D);
          H_MiddleName: DrvLic.MiddleName := String(D);
          H_VehicleClass: DrvLic.VehicleClass := String(D);
          H_IssuedDate: DrvLic.IssuedDate := Ddate;
          H_DOB: DrvLic.DOB := Ddate;
          H_ExpirationDate: DrvLic.Exp := Ddate;
          H_Sex:
            begin
              if D = '1' then
                DrvLic.Sex := 'M'
              else if D = '2' then
                DrvLic.Sex := 'F'
              else if D = '3' then
                DrvLic.Sex := 'N' //not specified
              else
                DrvLic.Sex := '';
            end;
          H_Height: DrvLic.PersonHeight := GetHeightToFeets(D);
          H_Address_1: DrvLic.Address := String(D);
          H_City: DrvLic.City := String(D);
          H_State: DrvLic.State := String(D);
          H_ZipCode: DrvLic.ZipCode := String(D);
          H_Country: DrvLic.Country := String(D);
          H_FullName: SplitFullName(D, DrvLic.FirstName, DrvLic.MiddleName, DrvLic.LastName);
          else ;
          end; //case


        end;
    end;
end;

procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: TDriverLicenseInfo);
var
  i: integer;
  BarcodeData: string;
begin
  SetLength(BarcodeData, ScanData.Count);

  for i := 1 to ScanData.Count do
    BarcodeData[i] :=  Char(ScanData[i-1]);

  ParsePDF417_US_Driver_License(BarcodeData, DrvLic);
end;
 (*
procedure ParseUSA_DL_String(ProcGetDataBuffer: TGetScanDataBuffer; ShowDrvLicData: TFillDataProc);
var
  DrvLicInfo: TDriverLicenseInfo;
  OneSec: TDateTime;
  SecDiff: int64;
  CurrCount, PrevCount: integer;
  DataBuffer: string;
begin
  PrevCount := 0;
  SecDiff := 0;
  repeat
    OneSec := Now;
    repeat
      Application.ProcessMessages;
    until MilliSecondsBetween(Now, OneSec) >= 500;

    inc(SecDiff);

//    ProcGetDataBuffer(DataBuffer);

    DataBuffer := 'aaaa';

    CurrCount := Length(DataBuffer);

    if (CurrCount > PrevCount) then
      PrevCount := CurrCount
    else if (CurrCount = PrevCount) and ((SecDiff mod 2) = 0) then
      Break;

  until SecDiff > 18;

//  ParsePDF417_US_Driver_License(DataBuffer, DrvLicInfo);

//  ShowDrvLicData(DrvLicInfo);

end;
*)
//////////////////////////////// Magnetic Scan /////////////////////////////////


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
