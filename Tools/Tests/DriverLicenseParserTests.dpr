program DriverLicenseParserTests;

{$APPTYPE CONSOLE}
{$RANGECHECKS ON}
{$OVERFLOWCHECKS ON}

uses
  System.SysUtils, System.Variants, System.StrUtils,
  Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls,
  DrvLic_AAMVA in '..\..\DrvLic_AAMVA.pas',
  DrvLic_PDF417Parsing in '..\..\DrvLic_PDF417Parsing.pas';

const
  // Public FLHSMV calibration sample, 2019 revision. DAK has two padding spaces.
  FloridaZF = 'ZFA'#10'ZFB'#10'ZFCSAFE DRIVER'#10'ZFD'#10'ZFE'#10'ZFF'#10+
    'ZFG'#10'ZFH'#10'ZFI'#10'ZFJ'#10'ZFK';

var Checks: Integer;

function SampleFields: string;
begin
  Result := 'DAQS123456579010'#10'DCSSAMPLE'#10'DDEU'#10'DACNICK'#10'DDFU'#10+
    'DADNONE'#10'DDGU'#10'DCAE'#10'DCBNONE'#10'DCDNONE'#10'DBD07272016'#10+
    'DBB01121957'#10'DBA01122024'#10'DBC1'#10'DAU070 IN'#10+
    'DAG123 MAIN STREET'#10'DAITALLAHASSEE'#10'DAJFL'#10'DAK000001234  '#10+
    'DCFQ931611290000'#10'DCGUSA'#10'DCK0110009295000261'#10'DDAF'#10'DDB05012019';
end;

function Frame(const Fields: string; const Issuer: string = '636010';
  const Version: string = '09'; const Kind: string = 'DL'): string;
var DL, ZF: string;
begin
  DL := Kind + Fields + #10#13;
  ZF := 'ZF' + FloridaZF + #10#13;
  Result := '@'#10#30#13'ANSI ' + Issuer + Version + '0002' + Kind + '0041' +
    Format('%.4d', [Length(DL)]) + 'ZF' + Format('%.4d%.4d', [41 + Length(DL), Length(ZF)]) + DL + ZF;
end;

function Flat(const S: string): string;
var C: Char;
begin
  Result := '';
  for C in S do if C >= #32 then Result := Result + C;
end;

function Changed(const OldValue, NewValue: string): string;
begin
  Result := StringReplace(SampleFields, OldValue, NewValue, [rfReplaceAll]);
end;

procedure Check(Value: Boolean; const Name: string);
begin
  Inc(Checks);
  if not Value then raise Exception.Create('FAILED: ' + Name);
end;

procedure Reject(const S, Name: string);
var Info: TDriverLicenseInfo;
begin
  Info.FirstName := 'OLD';
  try
    ParseAAMVADriverLicense(S, Info);
  except
    on E: EDriverLicenseBarcode do
    begin
      Check(Info.FirstName = '', Name + ': output cleared');
      Check(VarIsNull(Info.DOB), Name + ': DOB cleared');
      Exit;
    end;
  end;
  raise Exception.Create('FAILED: accepted ' + Name);
end;

procedure CheckCapture(const S: string);
var
  Data: TScanDataList;
  Timer: TTimer;
  Captured, Header: string;
  C, Key: Char;
  Scanning: Boolean;
  Count, Idle, I: Integer;
begin
  Data := TScanDataList.Create;
  Timer := TTimer.Create(nil);
  try
    Timer.Enabled := False;
    Header := '';
    Scanning := False;
    Count := 0;
    Idle := 0;
    for C in S do
    begin
      Key := C;
      ProcessKeyForPDF417barcodeScan(Key, Scanning, Data, Header, Timer, Count);
    end;
    Captured := '';
    for I := 0 to Data.Count - 1 do Captured := Captured + Data[I];
    Check(Scanning and (Captured = S), 'capture preserves all header/payload characters');
    Check(BarcodePDF417PatterDetected(S), 'reader dialog recognizes header');
    Check(not ScanBufferIsIdle(Data.Count, Count, Idle), 'first timer check waits');
    Check(not ScanBufferIsIdle(Data.Count, Count, Idle), 'brief pause waits');
    Check(ScanBufferIsIdle(Data.Count, Count, Idle), 'two unchanged checks complete');
    Check(not ScanBufferIsIdle(Data.Count + 1, Count, Idle), 'new data resets idle');
  finally
    Timer.Free;
    Data.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure Run;
var Info: TDriverLicenseInfo; S, Fields: string; I: Integer;
begin
  S := Frame(SampleFields);
  CheckCapture(S);
  CheckCapture(Flat(S));
  Check(Copy(S, 22, 20) = 'DL00410249ZF02900058', 'official subfile directory');
  ParseAAMVADriverLicense(S, Info);
  Check((Info.FirstName = 'NICK') and (Info.LastName = 'SAMPLE'), 'official names');
  Check(Info.MiddleName = '', 'NONE normalized');
  Check(Info.DrivervLicNumber = 'S123456579010', 'license number');
  Check((Info.State = 'FL') and (Info.Country = 'USA'), 'clean state/country');
  Check(Info.ZipCode = '000001234', 'postal padding removed');
  Check(Info.PersonHeight = '5''10"', 'inches');
  Check(Info.DOB = EncodeDate(1957, 1, 12), 'DOB');
  Check((Info.AAMVAVersion = 9) and (Info.FirstNameTruncation = 'U'), 'metadata');

  ParseAAMVADriverLicense(Frame(Changed('DAK000001234  ', 'DAK331420000  ')), Info);
  Check(Info.ZipCode = '33142', 'unknown ZIP+4 removed');
  ParseAAMVADriverLicense(Flat(Frame(Changed('DAK000001234  ', 'DAK331420000  '))), Info);
  Check(Info.ZipCode = '33142', 'flattened unknown ZIP+4 removed');
  Check(NormalizeUSZipCode('33142-0000') = '33142', 'hyphenated unknown ZIP+4 removed');
  Check(NormalizeUSZipCode('331426806') = '331426806', 'known ZIP+4 retained');
  Check(NormalizeUSZipCode('01000') = '01000', 'five-digit ZIP retained');

  ParseAAMVADriverLicense(Flat(S), Info);
  Check(Info.Address = '123 MAIN STREET', 'flattened official sample');
  ParseAAMVADriverLicense(StringReplace(S, #10, #13#10, [rfReplaceAll]), Info);
  Check(Info.FirstName = 'NICK', 'memo CRLF transformation');
  ParseAAMVADriverLicense(StringReplace(S, #10, #13, [rfReplaceAll]), Info);
  Check(Info.FirstName = 'NICK', 'reader CR-only transformation');
  ParseAAMVADriverLicense('@ANSI ' + Copy(S, 10, MaxInt), Info);
  Check(Info.LastName = 'SAMPLE', 'header controls omitted');
  ParseAAMVADriverLicense('@'#10#30#13 + Copy(Flat(S), 2, MaxInt), Info);
  Check(Info.FirstName = 'NICK', 'header retained but fields flattened');
  ParseAAMVADriverLicense(Flat(S).Replace('@ANSI', '@'#13#10'ANSI').Replace('ZFZFA', #13#10'ZFZFA'), Info);
  Check(Info.FirstName = 'NICK', 'flattened fields with subfile line breaks');

  for I := 0 to 1 do
  begin
    Fields := Changed('DCSSAMPLE', 'DCSMCDADAMS');
    S := Frame(Fields); if I = 1 then S := Flat(S);
    ParseAAMVADriverLicense(S, Info);
    Check(Info.LastName = 'MCDADAMS', 'embedded tag in surname');
    Fields := Changed('DAG123 MAIN STREET', 'DAG123 DADLEY STREET');
    S := Frame(Fields); if I = 1 then S := Flat(S);
    ParseAAMVADriverLicense(S, Info);
    Check((Info.Address = '123 DADLEY STREET') and (Info.MiddleName = ''), 'address cannot overwrite middle name');
    S := Frame(Changed('DCGUSA', 'DCGUSA'#10'DCUJR'));
    if I = 1 then S := Flat(S);
    ParseAAMVADriverLicense(S, Info);
    Check(Info.Country = 'USA', 'optional suffix isolated');
  end;

  ParseAAMVADriverLicense(Frame(Changed('DBC1', 'DBC9')), Info);
  Check(Info.Sex = 'N', 'unspecified maps to existing N/A');
  // Descriptive fields degrade rather than reject: an unreadable sex code must
  // not cost us the name, the date of birth or the licence number.
  ParseAAMVADriverLicense(Frame(Changed('DBC1', 'DBC3')), Info);
  Check((Info.Sex = '') and (Info.LastName = 'SAMPLE'), 'invalid sex 3 clears only the sex');
  ParseAAMVADriverLicense(Frame(Changed('DAU070 IN', 'DAU06X IN')), Info);
  Check((Info.PersonHeight = '') and (Info.LastName = 'SAMPLE'), 'bad height clears only the height');
  ParseAAMVADriverLicense(Frame(Changed('DBA01122024', 'DBA99999999')), Info);
  Check((Info.Exp = 0) and (Info.LastName = 'SAMPLE'), 'bad expiry clears only the expiry');
  // Identity stays strict, and must remain so.
  Reject(Frame(Changed('DAQS123456579010', 'DAQ')), 'missing licence number still rejects');
  Reject(Frame(Changed('DBB01121957', 'DBB02301957')), 'invalid date');
  Reject(Frame(Changed('DBB01121957'#10, '')), 'missing DOB');
  Reject(Frame(Changed('DACNICK', 'DACunavl')), 'unavailable first name');
  Reject(Frame(SampleFields + #10'DACOTHER'), 'duplicate name');

  ParseAAMVADriverLicense(Frame(Changed('DAG123 MAIN STREET', 'DZZIGNORED'#10'DAG123 MAIN STREET')), Info);
  Check(Info.Address = '123 MAIN STREET', 'unknown delimited field skipped');
  Fields := Changed('DCGUSA'#10, '');
  ParseAAMVADriverLicense(Frame(Fields + #10'DCGUSA'), Info);
  Check(Info.Country = 'USA', 'last field reaches subfile end');
  ParseAAMVADriverLicense(Frame(Changed('DAU070 IN', 'DAU181 cm')), Info);
  Check(Info.PersonHeight = '5''11"', 'centimeters');
  Fields := Changed('DCGUSA', 'DCGCAN');
  Fields := Fields.Replace('DBB01121957', 'DBB19570112').Replace('DBD07272016', 'DBD20160727').Replace('DBA01122024', 'DBA20240112');
  ParseAAMVADriverLicense(Frame(Fields, '636012'), Info);
  Check(Info.DOB = EncodeDate(1957, 1, 12), 'Canadian date order');
  ParseAAMVADriverLicense(Frame(Changed('DAQS123456579010', 'DAQABC123'), '636000', '10', 'ID'), Info);
  Check(Info.DrivervLicNumber = 'ABC123', 'variable license length and ID subfile');
  ParseAAMVADriverLicense(Frame(Changed('DCAE', 'DCACM'), '636000', '11'), Info);
  Check(Info.VehicleClass = 'CM', 'variable class');

  S := Frame(SampleFields);
  Reject(Copy(S, 1, Length(S) - 1), 'missing final terminator');
  Reject(Copy(S, 1, 150), 'partial scan');
  Reject(S.Replace('DL00410249', 'DL00410248'), 'incorrect length');
  Reject(S.Replace('ZF02900058', 'ZF02910058'), 'incorrect offset');
  Reject(S + 'JUNK', 'trailing data');
  Reject(Flat(Frame(SampleFields, '636000')), 'unsupported flattened jurisdiction');
  Reject(Flat(Frame(Changed('DAG123 MAIN STREET', 'DAG123 DAI STREET'))), 'ambiguous flattened boundary');
  Reject(Copy(Flat(S), 1, Length(Flat(S)) - 3), 'truncated flattened scan');
  // Every shorter prefix must fail with the parser's typed error, not an access
  // violation, a partially populated result, or a successful partial lookup.
  for I := 1 to Length(S) - 1 do
    Reject(Copy(S, 1, I), 'truncated prefix ' + IntToStr(I));
end;

begin
  try
    Run;
    Writeln('PASS: ', Checks, ' checks');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
