unit DrvLic_AAMVA;

interface

uses System.SysUtils, System.Variants;

type
  EDriverLicenseBarcode = class(Exception);

  TDriverLicenseInfo = record
    FirstName, MiddleName, LastName: string;
    Sex, PersonHeight: string;
    Address, City, State, ZipCode, Country: string;
    DOB: Variant;
    IssuedDate, Exp: TDate;
    VehicleClass, DrivervLicNumber: string;
    IssuerIdentifier: string;
    AAMVAVersion, JurisdictionVersion: Integer;
    FirstNameTruncation, MiddleNameTruncation, LastNameTruncation: string;
  end;

// Accept raw AAMVA data and explicitly supported keyboard-reader transformations.
// On failure the output remains empty; callers must not populate/search with it.
procedure ParseAAMVADriverLicense(const Data: string; out Info: TDriverLicenseInfo);
function NormalizeUSZipCode(const ZipCode: string): string;

implementation

uses System.Classes, System.StrUtils, System.Generics.Collections;

const
  RawPrefix = '@'#10#30#13'ANSI ';
  MaxBarcodeLength = 32768;

type
  TSubfile = record
    Kind: string;
    Offset, Size: Integer;
  end;
  TSubfiles = TArray<TSubfile>;

function NormalizeUSZipCode(const ZipCode: string): string;
var I: Integer;
begin
  Result := Trim(ZipCode);
  if not (((Length(Result) = 9) and (Copy(Result, 6, 4) = '0000')) or
          ((Length(Result) = 10) and (Copy(Result, 6, 5) = '-0000'))) then Exit;
  for I := 1 to 5 do
    if not CharInSet(Result[I], ['0'..'9']) then Exit;
  Result := Copy(Result, 1, 5);
end;

procedure Invalid(const Detail: string);
begin
  raise EDriverLicenseBarcode.Create('The license scan is incomplete or invalid. ' +
    Detail + ' Please scan again.');
end;

function Decimal(const S: string): Integer;
var C: Char;
begin
  if S = '' then Invalid('Missing numeric data.');
  for C in S do
    if not CharInSet(C, ['0'..'9']) then Invalid('Invalid numeric data.');
  if not TryStrToInt(S, Result) then Invalid('Invalid numeric data.');
end;

// Decimal() above rejects by raising; this one just answers the question, for
// descriptive fields that must not bring a scan down.
function IsDecimal(const S: string): Boolean;
var C: Char;
begin
  Result := S <> '';
  for C in S do
    Result := Result and CharInSet(C, ['0'..'9']);
end;

function IsTag(const S: string): Boolean;
var C: Char;
begin
  Result := Length(S) = 3;
  for C in S do Result := Result and CharInSet(C, ['A'..'Z']);
end;

function CleanValue(const S: string): string;
begin
  Result := UpperCase(Trim(S));
  if SameText(Result, 'NONE') or SameText(Result, 'UNAVL') then Result := '';
end;

procedure ReadHeader(const S: string; out Files: TSubfiles; out HeaderSize: Integer);
var I, P, Count, NextOffset: Integer;
begin
  if Copy(S, 1, Length(RawPrefix)) <> RawPrefix then Invalid('Unrecognized header.');
  if Length(S) < 21 then Invalid('Incomplete header.');
  Decimal(Copy(S, 10, 6));
  if Decimal(Copy(S, 16, 2)) = 0 then Invalid('Unsupported barcode version.');
  Decimal(Copy(S, 18, 2));
  Count := Decimal(Copy(S, 20, 2));
  if Count = 0 then Invalid('Missing subfiles.');
  HeaderSize := 21 + Count * 10;
  if Length(S) < HeaderSize then Invalid('Incomplete subfile directory.');
  SetLength(Files, Count);
  NextOffset := HeaderSize;
  for I := 0 to Count - 1 do
  begin
    P := 22 + I * 10;
    Files[I].Kind := Copy(S, P, 2);
    if (Files[I].Kind <> 'DL') and (Files[I].Kind <> 'ID') and
       not ((Files[I].Kind[1] = 'Z') and CharInSet(Files[I].Kind[2], ['A'..'Z'])) then
      Invalid('Unsupported subfile type.');
    Files[I].Offset := Decimal(Copy(S, P + 2, 4));
    Files[I].Size := Decimal(Copy(S, P + 6, 4));
    if (Files[I].Offset <> NextOffset) or (Files[I].Size < 3) then
      Invalid('Invalid subfile boundaries.');
    Inc(NextOffset, Files[I].Size);
    if NextOffset > MaxBarcodeLength then Invalid('Barcode is too long.');
  end;
end;

function TerminateSubfile(const Part: string; ExpectedSize: Integer): string;
begin
  // AAMVA permits LF before CR. Florida's published calibration barcode uses
  // it; keyboard/memo normalization may remove that empty final field.
  if Length(Part) + 1 = ExpectedSize then Result := Part + #13
  else if Length(Part) + 2 = ExpectedSize then Result := Part + #10#13
  else
  begin
    Invalid('Subfile length does not match the scan.');
    Result := '';
  end;
end;

// Older keyboard readers strip field separators. Only the documented Florida
// 2016 layout is recovered here. Required successor tags delimit variable values;
// a repeated successor is ambiguous and is rejected instead of guessing.
function RecoverFlorida(const Body: string; const Files: TSubfiles): string;
var
  S, Part, Value, Tag, NextTag: string;
  P, N, I, J, Z, Boundary: Integer;

  procedure Expect(const Expected: string);
  begin
    if Copy(S, P, Length(Expected)) <> Expected then
      Invalid('Unsupported separator-free Florida layout.');
    Inc(P, Length(Expected));
  end;

  procedure Add(const ATag, AValue: string);
  begin
    if Part <> '' then Part := Part + #10;
    Part := Part + ATag + AValue;
  end;

  procedure Fixed(const ATag: string; Size: Integer);
  begin
    Expect(ATag);
    if P + Size - 1 > Length(S) then Invalid('Incomplete field.');
    Add(ATag, Copy(S, P, Size));
    Inc(P, Size);
  end;

  procedure UntilTag(const ATag, Following: string);
  var Q: Integer;
  begin
    Expect(ATag);
    Q := PosEx(Following, S, P);
    if (Q = 0) or (PosEx(Following, S, Q + 3) > 0) then
      Invalid('Ambiguous separator-free field. Configure the reader to preserve line separators.');
    Add(ATag, Copy(S, P, Q - P));
    P := Q;
  end;

begin
  S := '';
  for I := 1 to Length(Body) do
    if Body[I] >= #32 then S := S + Body[I];
  if (Length(Files) <> 2) or (Files[0].Kind <> 'DL') or (Files[1].Kind <> 'ZF') then
    Invalid('This separator-free card layout is not supported.');
  Z := Pos('ZFZFA', S);
  if (Z = 0) or (PosEx('ZFZFA', S, Z + 5) > 0) then Invalid('Missing Florida subfile.');
  Value := Copy(S, Z + 2, MaxInt);
  S := Copy(S, 1, Z - 1);
  P := 1;
  Part := '';
  Expect('DL');
  Fixed('DAQ', 13);
  UntilTag('DCS', 'DDE'); Fixed('DDE', 1);
  UntilTag('DAC', 'DDF'); Fixed('DDF', 1);
  UntilTag('DAD', 'DDG'); Fixed('DDG', 1);
  if Copy(S, P, 3) = 'DCU' then UntilTag('DCU', 'DCA');
  Fixed('DCA', 1);
  UntilTag('DCB', 'DCD'); UntilTag('DCD', 'DBD');
  Fixed('DBD', 8); Fixed('DBB', 8); Fixed('DBA', 8);
  Fixed('DBC', 1); Fixed('DAU', 6);
  UntilTag('DAG', 'DAI'); UntilTag('DAI', 'DAJ'); Fixed('DAJ', 2);
  UntilTag('DAK', 'DCF'); UntilTag('DCF', 'DCG'); Fixed('DCG', 3);

  while P <= Length(S) do
  begin
    Tag := Copy(S, P, 3);
    if (Tag = 'DDA') or (Tag = 'DDD') or (Tag = 'DDK') or (Tag = 'DDL') then Fixed(Tag, 1)
    else if (Tag = 'DDB') or (Tag = 'DDJ') then Fixed(Tag, 8)
    else if (Tag = 'DCK') or (Tag = 'DCU') then
    begin
      // Both remaining variable fields precede another documented optional tag.
      Boundary := Length(S) + 1;
      for J := P + 3 to Length(S) - 2 do
      begin
        NextTag := Copy(S, J, 3);
        if (NextTag = 'DCK') or (NextTag = 'DCU') or (NextTag = 'DDA') or
           (NextTag = 'DDB') or (NextTag = 'DDD') or (NextTag = 'DDJ') or
           (NextTag = 'DDK') or (NextTag = 'DDL') then
        begin
          Boundary := J;
          Break;
        end;
      end;
      Expect(Tag);
      Add(Tag, Copy(S, P, Boundary - P));
      P := Boundary;
    end
    else Invalid('Unknown separator-free field. Configure the reader to preserve line separators.');
  end;
  Result := TerminateSubfile('DL' + Part, Files[0].Size);

  // The Florida sheet specifies ZFA through ZFK, in order, even when empty.
  S := Value;
  P := 1;
  Part := '';
  for I := 0 to 10 do
  begin
    Tag := 'ZF' + Chr(Ord('A') + I);
    if I < 10 then
      UntilTag(Tag, 'ZF' + Chr(Ord('B') + I))
    else
    begin
      Expect(Tag);
      N := Length(S) - P + 1;
      Add(Tag, Copy(S, P, N));
      Inc(P, N);
    end;
  end;
  Result := Result + TerminateSubfile('ZF' + Part, Files[1].Size);
end;

function CanonicalData(const Data: string): string;
var
  S, Body, Header, Part, Token: string;
  Files: TSubfiles;
  I, P, HeaderSize, FileIndex: Integer;
  Tokens: TArray<string>;
begin
  if (Length(Data) < 31) or (Length(Data) > MaxBarcodeLength) then Invalid('Invalid scan length.');
  S := Data;
  // Truly raw field-delimited data must pass its own offsets and lengths,
  // never a repair fallback. Some readers retain only the header controls.
  if (Copy(S, 1, Length(RawPrefix)) = RawPrefix) and (Pos(#13#10, S) = 0) then
  begin
    ReadHeader(S, Files, HeaderSize);
    if PosEx(#10'D', S, HeaderSize + 1) > 0 then Exit(S);
  end;
  P := Pos('ANSI ', S);
  if (P < 2) or (P > 8) or (S[1] <> '@') then Invalid('Unrecognized header.');
  for I := 2 to P - 1 do
    if not CharInSet(S[I], [#10, #13, #30]) then Invalid('Unrecognized header.');
  S := RawPrefix + Copy(S, P + 5, MaxInt);
  ReadHeader(S, Files, HeaderSize);
  Header := Copy(S, 1, HeaderSize);
  Body := Copy(S, HeaderSize + 1, MaxInt);
  if (Pos(#10'D', Body) = 0) and (Pos(#13'D', Body) = 0) then
  begin
    if (Copy(Header, 10, 6) <> '636010') or (Copy(Header, 16, 2) <> '09') then
      Invalid('This reader must preserve line separators for this card.');
    Exit(Header + RecoverFlorida(Body, Files));
  end;

  // Memo controls and keyboard readers may replace LF with CRLF, or omit the
  // header controls. Reconstruct separators, then enforce the original directory.
  Tokens := Body.Split([#10, #13], TStringSplitOptions.ExcludeEmpty);
  Result := Header;
  Part := '';
  FileIndex := -1;
  for Token in Tokens do
  begin
    if (FileIndex < High(Files)) and
       (Copy(Token, 1, 2) = Files[FileIndex + 1].Kind) then
    begin
      if FileIndex >= 0 then Result := Result + TerminateSubfile(Part, Files[FileIndex].Size);
      Inc(FileIndex);
      Part := Token;
    end
    else
    begin
      if FileIndex < 0 then Invalid('Missing subfile data.');
      Part := Part + #10 + Token;
    end;
  end;
  if FileIndex <> High(Files) then Invalid('Missing subfile data.');
  Result := Result + TerminateSubfile(Part, Files[FileIndex].Size);
end;

procedure ParseAAMVADriverLicense(const Data: string; out Info: TDriverLicenseInfo);
var
  S, Body, Tag, Value, UnitName: string;
  Files: TSubfiles;
  Fields: TDictionary<string, string>;
  Parsed: TDriverLicenseInfo;
  HeaderSize, I, P, N, DLCount, Inches: Integer;
  Lines: TArray<string>;
  Line: string;

  function Field(const ATag: string; Required: Boolean = False): string;
  begin
    if not Fields.TryGetValue(ATag, Result) then
    begin
      Result := '';
      if Required then Invalid('Missing field ' + ATag + '.');
    end;
    Result := CleanValue(Result);
  end;

  function RequiredValue(const ATag: string; MaxSize: Integer): string;
  begin
    Result := Field(ATag, True);
    if (Result = '') or (Length(Result) > MaxSize) then Invalid('Invalid field ' + ATag + '.');
  end;

  function DateField(const ATag: string): TDateTime;
  var D, M, Y: Integer; DateText: string;
  begin
    DateText := RequiredValue(ATag, 8);
    if Length(DateText) <> 8 then Invalid('Invalid date in ' + ATag + '.');
    Decimal(DateText);
    if Parsed.Country = 'CAN' then
    begin
      Y := Decimal(Copy(DateText, 1, 4)); M := Decimal(Copy(DateText, 5, 2)); D := Decimal(Copy(DateText, 7, 2));
    end
    else
    begin
      M := Decimal(Copy(DateText, 1, 2)); D := Decimal(Copy(DateText, 3, 2)); Y := Decimal(Copy(DateText, 5, 4));
    end;
    if not TryEncodeDate(Y, M, D, Result) then Invalid('Invalid date in ' + ATag + '.');
  end;

  // Descriptive: an unrecognised flag is dropped, not fatal.
  function SoftTruncation(const ATag: string): string;
  begin
    Result := CleanValue(Field(ATag));
    if (Result <> 'N') and (Result <> 'T') and (Result <> 'U') then Result := '';
  end;

  // Descriptive: an unreadable date is left unset rather than rejected.
  function SoftDate(const ATag: string): TDate;
  begin
    try
      Result := DateField(ATag);
    except
      on EDriverLicenseBarcode do Result := 0;
    end;
  end;

begin
  Info := Default(TDriverLicenseInfo);
  Info.DOB := Null;
  Parsed := Default(TDriverLicenseInfo);
  Parsed.DOB := Null;
  S := CanonicalData(Data);
  ReadHeader(S, Files, HeaderSize);
  Fields := TDictionary<string, string>.Create;
  try
    DLCount := 0;
    for I := 0 to High(Files) do
    begin
      if Files[I].Offset + Files[I].Size > Length(S) then Invalid('Scan ended before the subfile was complete.');
      Body := Copy(S, Files[I].Offset + 1, Files[I].Size);
      if (Copy(Body, 1, 2) <> Files[I].Kind) or (Body[Length(Body)] <> #13) then
        Invalid('Subfile length does not match the scan.');
      if (Files[I].Kind <> 'DL') and (Files[I].Kind <> 'ID') then Continue;
      Inc(DLCount);
      Lines := Copy(Body, 3, Length(Body) - 3).Split([#10]);
      for Line in Lines do
      begin
        if Line = '' then Continue;
        Tag := Copy(Line, 1, 3);
        if not IsTag(Tag) then Invalid('Invalid field identifier.');
        Value := Copy(Line, 4, MaxInt);
        for P := 1 to Length(Value) do
          if (Value[P] < #32) or (Ord(Value[P]) > 126) then Invalid('Invalid field characters.');
        if Fields.ContainsKey(Tag) then Invalid('Duplicate field ' + Tag + '.');
        Fields.Add(Tag, Value);
      end;
    end;
    if DLCount <> 1 then Invalid('Expected one license or ID subfile.');
    P := Files[High(Files)].Offset + Files[High(Files)].Size;
    for I := P + 1 to Length(S) do
      if not CharInSet(S[I], [#10, #13]) then Invalid('Unexpected data after the barcode.');

    Parsed.IssuerIdentifier := Copy(S, 10, 6);
    Parsed.AAMVAVersion := Decimal(Copy(S, 16, 2));
    Parsed.JurisdictionVersion := Decimal(Copy(S, 18, 2));
    Parsed.Country := RequiredValue('DCG', 3);
    if (Parsed.Country <> 'USA') and (Parsed.Country <> 'CAN') then Invalid('Unsupported issuing country.');
    Parsed.DrivervLicNumber := RequiredValue('DAQ', 25);
    Parsed.LastName := RequiredValue('DCS', 40);
    Parsed.FirstName := RequiredValue('DAC', 40);
    { From here the fields divide in two, and the difference matters at the
      counter.

      IDENTITY -- names, date of birth, licence number, address -- stays strict.
      A wrong value there is worse than no scan at all: it files the wrong person
      against a pawn.

      DESCRIPTIVE -- height, sex, vehicle class, issue and expiry dates, the
      truncation flags -- degrades to empty instead. A card whose height field is
      malformed still says who the person is, and that is what the transaction
      needs. Throwing the whole scan away over a cosmetic field fails in the
      shop, with a customer waiting, and teaches the clerk that scanning is
      unreliable. }
    Parsed.MiddleName := Field('DAD');
    if Length(Parsed.MiddleName) > 40 then Parsed.MiddleName := '';
    Parsed.LastNameTruncation := SoftTruncation('DDE');
    Parsed.FirstNameTruncation := SoftTruncation('DDF');
    Parsed.MiddleNameTruncation := SoftTruncation('DDG');
    Parsed.Address := RequiredValue('DAG', 35);
    Parsed.City := RequiredValue('DAI', 20);
    Parsed.State := RequiredValue('DAJ', 2);
    if Length(Parsed.State) <> 2 then Invalid('Invalid state.');
    Parsed.ZipCode := RequiredValue('DAK', 11);
    if Parsed.Country = 'USA' then
      Parsed.ZipCode := NormalizeUSZipCode(Parsed.ZipCode);
    Parsed.VehicleClass := Field('DCA');
    if Length(Parsed.VehicleClass) > 6 then Parsed.VehicleClass := '';

    Parsed.DOB := DateField('DBB');           // identity: strict

    // Shown to the clerk, never stored. Not worth a rejected scan.
    Parsed.IssuedDate := SoftDate('DBD');
    Parsed.Exp := SoftDate('DBA');

    Parsed.Sex := '';
    Value := CleanValue(Field('DBC'));
    if Value = '1' then Parsed.Sex := 'M'
    else if Value = '2' then Parsed.Sex := 'F'
    else if Value = '9' then Parsed.Sex := 'N';
    // Anything else stays empty. '' and 'N' both reach LeadsOnline as "not
    // stated" through DecodeSex, so an unreadable code is recorded as unknown
    // rather than guessed at.

    Parsed.PersonHeight := '';
    Value := CleanValue(Field('DAU'));
    if (Length(Value) = 6) and (Value[4] = ' ') and IsDecimal(Copy(Value, 1, 3)) then
    begin
      N := StrToInt(Copy(Value, 1, 3));
      UnitName := UpperCase(Copy(Value, 5, 2));
      Inches := 0;
      if UnitName = 'CM' then Inches := Round(N / 2.54)
      else if UnitName = 'IN' then Inches := N;
      if Inches > 0 then
        Parsed.PersonHeight := IntToStr(Inches div 12) + '''' + IntToStr(Inches mod 12) + '"';
    end;
    Info := Parsed;
  finally
    Fields.Free;
  end;
end;

end.
