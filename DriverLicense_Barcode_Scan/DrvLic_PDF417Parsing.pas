unit DrvLic_PDF417Parsing;

interface

uses System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
     System.strUtils;

type
  TScanDataList = TList<ansichar>;

  DriverLicenseInfo = record
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
  end;

procedure ParsePDF417_US_Driver_License(const BarcodeData: string; out DrvLic: DriverLicenseInfo);
procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: DriverLicenseInfo);

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

type
  HeaderInfomation = (H_Idnumber,
                      H_LastName, H_FirstName, H_MiddleName,
                      H_VehicleClass,
                      H_IssuedDate, H_DOB, H_ExpirationDate,
                      H_Sex, H_Height,
                      H_Address_1, H_City, H_State, H_ZipCode,
                      H_Country,
                      H_None);

  SecDataType = (F_String, F_Date);

  TSectionHeader = record
    Header: string;
    ID: HeaderInfomation;
    SecLength: integer;
    DataType: SecDataType;
  end;

const
  NumberOfHeaderSections = 23;

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
    (Header: 'DCK'; ID: H_None;           SecLength: 0; DataType: F_String),
    (Header: 'DDK'; ID: H_None;           SecLength: 0; DataType: F_String)
  );

var
  AllHeaderTags: string = '';

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
  Day, Month, Year: Integer;
begin
  Result := 0;
  if Length(D) < 8 then
    Exit;

  if not TryStrToInt(Copy(D, 1, 2), Month) then Exit;
  if not TryStrToInt(Copy(D, 3, 2), Day) then Exit;
  if not TryStrToInt(Copy(D, 5, 4), Year) then Exit;

  if not TryEncodeDate(Year, Month, Day, Result) then
    Result := 0;
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

procedure ParsePDF417_US_Driver_License(const BarcodeData: string; out DrvLic: DriverLicenseInfo);
var
  p, pEnd: integer;
  i, NextHPos: integer;
  SectionName: HeaderInfomation;
  SectionLength: integer;
  SectionDataType: SecDataType;
  D: ansistring;
  Ddate: TDate;
begin
  p := 1;

  if BarcodeData.Length < 250 then
    FormatError('Invalid Driver License Data');

  //Field 01 Size: 1 char  always @
  if BarcodeData[p] <> '@' then
    FormatError('@ not found');

   p := pos(#13, BarcodeData);
   pEnd := posex(#13, BarcodeData, p + 1);

  for i := p + 2 to pEnd - 1 do
    begin
      if IsSectionHeader(BarcodeData[i-2] + BarcodeData[i-1] + BarcodeData[i],
                         SectionName, SectionLength, SectionDataType)  then
        begin
          D := '';

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
              Ddate := GetSecDate(D);
            end;

          case SectionName of
          H_Idnumber: DrvLic.ID := D;
          H_LastName: DrvLic.LastName := D;
          H_FirstName: DrvLic.FirstName := D;
          H_MiddleName: DrvLic.MiddleName := D;
          H_VehicleClass: DrvLic.VehicleClass := D;
          H_IssuedDate: DrvLic.IssuedDate := Ddate;
          H_DOB: DrvLic.DOB := Ddate;
          H_ExpirationDate: DrvLic.Exp := Ddate;
          H_Sex:
            begin
              if D = '1' then
                DrvLic.Gender := 'M'
              else if D = '2' then
                DrvLic.Gender := 'F'
              else if D = '3' then
                DrvLic.Gender := 'N' //not specified
              else
                DrvLic.Gender := ''
            end;
          H_Height: DrvLic.Height := D;
          H_Address_1: DrvLic.Address := D;
          H_City: DrvLic.City := D;
          H_State: DrvLic.State := D;
          H_ZipCode: DrvLic.ZipCode := D;
          H_Country: DrvLic.Country := D;
          else ;
          end; //case


        end;
    end;
end;

procedure ParseScanBarcodeData(ScanData: TScanDataList; out DrvLic: DriverLicenseInfo);
var
  i: integer;
  BarcodeData: string;
begin
  SetLength(BarcodeData, ScanData.Count);

  for i := 1 to ScanData.Count do
    BarcodeData[i] := Char(ScanData[i-1]);

  ParsePDF417_US_Driver_License(BarcodeData, DrvLic);
end;

end.
