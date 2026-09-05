unit uLeadsOnlineTicketMap;

{
  PawnPro rows -> LeadsOnline Ticket / Customer / Item / PropertyValue objects.

  This is where every field-level bug will live, so it is deliberately the one
  piece with no UI and no SOAP: it takes datasets in and hands objects back.
  Feed it TFDMemTables and it can be exercised without a database, a network, or
  a form.

  ENGLISH IS THE LANGUAGE OF RECORD. These stores are in the USA and every
  export is English, always; the Spanish UI is operator convenience only. So
  everything here reads either a stored char code (mapped to a fixed English
  vocabulary by the Decode* routines below) or a *_DESC column that the caller's
  SQL joined from a BASE table. Nothing here may read a clnJ* memtable or a
  calculated display field -- those are where a translation lands. If a future
  edit makes a value here depend on the UI language, a Spanish workstation will
  upload Spanish text to law enforcement and nothing in testing will show it.

  Parity with the CSV+FTP export matters: during the pilot both channels run
  side by side and their output is compared. Where the CSV export already makes
  a choice (ID type precedence, phone precedence), this unit makes the SAME
  choice, and says so at the call site.
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, LeadsOnlineWS;

type
  /// Raised when a row cannot be represented as a LeadsOnline ticket at all --
  /// e.g. a transaction type they have no member for. Callers should treat this
  /// as "skip this ticket and report it", never as a transport failure.
  ELeadsOnlineMapping = class(Exception);

const
  /// The SQL the mapper expects. Kept here, beside the code that reads the
  /// columns, so the query and the mapping cannot drift apart unnoticed. This
  /// unit never executes them -- P4 owns the TFDQuery objects.
  ///
  /// Note the joins to J_STYLES / J_METALS / J_TYPES: descriptions come from
  /// the base tables, never from DM's clnJ* memtables. See the header.
  SQLTicketHeader =
    'SELECT T1.TRANSACTION_NO, T1.TRAN_TYPE, T1.TRAN_TICKET_NO, T1.TRAN_DATE,' +
    '       T1.TRAN_TIME, T1.TRAN_MATURITY, T1.TRAN_STATUS, T1.TRAN_CLOSE_REASON,' +
    '       T2.CUST_FIRST, T2.CUST_MID, T2.CUST_LAST, T2.CUST_ADDR, T2.CUST_APT,' +
    '       T2.CUST_CITY, T2.CUST_STATE, T2.CUST_ZIP,' +
    '       T2.CUST_PH_HOME, T2.CUST_PH_BUSINESS, T2.CUST_PH_BEEP, T2.CUST_PH_CELL,' +
    '       T2.CUST_FL_DRV_LIC, T2.CUST_ID, T2.CUST_ID_TYPE, T2.CUST_ID_AGENCY_STATE,' +
    '       T2.CUST_DOB, T2.CUST_WEIGHT, T2.CUST_HEIGHT, T2.CUST_EYES, T2.CUST_HAIR,' +
    '       T2.CUST_RACE, T2.CUST_GENDER, T2.CUST_PLACE_EMPLY, T1.TRAN_PAWN_AMOUNT' +
    '  FROM TRANSACTIONS T1' +
    '  JOIN CUSTOMER T2 ON T2.CUST_NO = T1.CUST_NO' +
    ' WHERE T1.TRANSACTION_NO = :TransactionNo' +
    '   AND T1.TRAN_TYPE IN (''P'', ''U'')';

  SQLTicketItems =
    'SELECT T3.INV_ITEM_NO, T3.INV_ITEM_BRAND, T3.MODEL_NUMBER, T3.SERIAL_NUMBER,' +
    '       T3.DESCRIPTION, T3.NOTE, T3.UNIT_COST, T3.INV_ITEM_STATUS, T3.J_TYPE,' +
    '       T3.INV_ITEM_COUNT,' +
    '       T3.KT, T3.WEIGHT, T3.WEIGHT_UNIT, T3.SIZE_LENGTH, T3.GENDER,' +
    '       T6.J_TYPE_DESC, T4.J_STYLE_DESC, T5.J_METAL_DESC' +
    '  FROM INVENTORY_ITEMS T3' +
    '  LEFT JOIN J_STYLES T4 ON T4.J_STYLE = T3.J_STYLE' +
    '  LEFT JOIN J_METALS T5 ON T5.J_METAL = T3.J_METAL' +
    '  LEFT JOIN J_TYPES  T6 ON T6.J_TYPE  = T3.J_TYPE' +
    ' WHERE T3.TRANSACTION_NO = :TransactionNo' +
    ' ORDER BY T3.INV_ITEM_NO';

  /// Every stone on the ticket in one open dataset, already joined to its
  /// base-table descriptions. Deliberately keyed by TRANSACTION_NO rather than
  /// INV_ITEM_NO: the mapper iterates items itself and cannot re-run a query
  /// without acquiring a database dependency, so it filters these rows in
  /// memory by INV_ITEM_NO instead. Only the first two stones per item are
  /// exported, matching the CSV export.
  // The two lookups translate a stored code into the English word LeadsOnline
  // receives; they are NOT filters. They must stay LEFT joins: a stone recorded
  // without a colour or shape -- common in older data, 487 of them at Perez Cash
  // Joyeria -- matches nothing, and an inner join would drop the whole stone
  // from the ticket, taking its type, carat and weight with it, silently. A
  // stone reported with one attribute missing beats a stone not reported at all.
  // AddProp already omits an empty value, so the NULL description sends nothing.
  SQLTicketStones =
    'SELECT T1.INV_ITEM_NO, T1.STONE_NUMBER, T1.STONE_TYPE, T1.CT, T1.WT,' +
    '       T1.STONE_WEIGHT_UNIT, T2.J_STONE_DESC, T3.J_SHAPE_DESC' +
    '  FROM STONES T1' +
    '  JOIN INVENTORY_ITEMS T4 ON T4.INV_ITEM_NO   = T1.INV_ITEM_NO' +
    '  LEFT JOIN J_STONE_COLORS T2 ON T2.J_STONE_COLOR = T1.STONE_COLOR' +
    '  LEFT JOIN J_STONE_SHAPES T3 ON T3.J_SHAPE       = T1.STONE_SHAPE' +
    ' WHERE T4.TRANSACTION_NO = :TransactionNo' +
    ' ORDER BY T1.INV_ITEM_NO, T1.STONE_NO';

type
  TLeadsOnlineTicketMapper = class
  private
    class function Field(ADataSet: TDataSet; const AName: string): TField;
    class function Str(ADataSet: TDataSet; const AName: string): string;
    class function Num(ADataSet: TDataSet; const AName: string): Double;
    class procedure AddProp(var AList: ArrayOfPropertyValue;
      const AName, AValue: string);
    class function BuildCustomer(AHeader: TDataSet): Customer2;
    class function BuildItem(AItems, AStones: TDataSet; AFallbackAmount: Double): Item2;
    class procedure AddStoneProps(var AList: ArrayOfPropertyValue; AStones: TDataSet;
      AItemNo: Integer);
  public
    { ---- decoders: stored code -> the English value LeadsOnline receives ---- }

    /// TRAN_TYPE -> TicketType. Layaway ('L') is not exported: their enum has no
    /// member for it and the CSV export already restricts itself to P and U, so
    /// both channels report an identical set.
    class function DecodeTicketType(const ATranType: string): TicketType;
    /// CUST_RACE, per EnterClientInfo's picker.
    class function DecodeRace(const ACode: string): string;
    /// CUST_EYES / CUST_HAIR, per EnterClientInfo's pickers.
    class function DecodeEyeColor(const ACode: string): string;
    class function DecodeHairColor(const ACode: string): string;
    /// CUST_GENDER -> their 'sex'. 'N' (not stated) sends nothing.
    class function DecodeSex(const ACode: string): string;
    /// INV_ITEM_STATUS char code -> their suggested itemStatus vocabulary.
    /// Never derived from a display label: those are translatable.
    class function DecodeItemStatus(const ACode: string; ATicketType: TicketType): string;
    /// WEIGHT_UNIT / DEFAULT_WEIGHT_MEASURE_UNIT ('G'/'P') -> the words their
    /// spec asks for: JEWELRY_WEIGHT_UNIT is documented as "dwt or grams".
    class function DecodeWeightUnit(const ACode: string): string;
    /// Jewelry when the row carries jewelry attributes, else Other. Firearm is
    /// never produced: nothing in the schema records one, and inventing a guess
    /// would put a wrong classification in front of law enforcement.
    class function DecodeItemType(AItems: TDataSet): ItemType;

    { ---- formatters ---- }

    /// Their ticketDateTime. TRAN_DATE is a DATE and TRAN_TIME a separate TIME,
    /// so both are needed. Local store time, never converted: this string is
    /// half the composite key we must be able to reproduce later.
    class function FormatTicketDateTime(ADate, ATime: TDateTime): string;
    class function FormatDate(ADate: TDateTime): string;
    /// Could this date be real? Decades-old data carries mistyped years -- one
    /// live store has 74 customers whose date of birth is in the year 0368 --
    /// and LeadsOnline reject the WHOLE ticket with error 1 over one of them.
    class function IsPlausibleDate(ADate: TDateTime): Boolean;
    /// Stricter, for a birth date specifically: not in the future and not more
    /// than 120 years ago. The general check is no use here -- the common typo
    /// is a year like 3193 or 2027, which is a perfectly VALID date, so
    /// LeadsOnline would accept a customer born next year without complaint.
    class function IsPlausibleDateOfBirth(ADate: TDateTime): Boolean;
    /// CUST_HEIGHT is free text (VARCHAR(8)); their height is an integer of
    /// inches. Understands 70, 5'10", 5-10 and 5 10. Returns 0 when unparseable
    /// rather than guessing.
    class function ParseHeightInches(const AText: string): Integer;
    /// First non-empty of cell, home, business, beep -- the same precedence the
    /// CSV export applies in TDM_LeadsOnline.qryGetDataToExpCalcFields.
    class function PreferredPhone(AHeader: TDataSet): string;

    { ---- the entry point ---- }

    /// Builds a complete Ticket from an open header row plus its item rows.
    /// AStones may be nil (no stone detail). The caller owns the result.
    /// AItems is iterated from first to last and left at Eof.
    class function BuildTicket(AHeader, AItems, AStones: TDataSet): Ticket;
  end;

implementation

uses
  System.Math, System.StrUtils, System.DateUtils, PawnGlobal;

{ ---- small helpers ------------------------------------------------------- }

class function TLeadsOnlineTicketMapper.Field(ADataSet: TDataSet; const AName: string): TField;
begin
  Result := ADataSet.FindField(AName);
end;

class function TLeadsOnlineTicketMapper.Str(ADataSet: TDataSet; const AName: string): string;
var
  F: TField;
begin
  F := Field(ADataSet, AName);
  if (F = nil) or F.IsNull then
    Result := ''
  else
    Result := Trim(F.AsString);
end;

class function TLeadsOnlineTicketMapper.Num(ADataSet: TDataSet; const AName: string): Double;
var
  F: TField;
begin
  F := Field(ADataSet, AName);
  if (F = nil) or F.IsNull then
    Result := 0
  else
    Result := F.AsFloat;
end;

class procedure TLeadsOnlineTicketMapper.AddProp(var AList: ArrayOfPropertyValue;
  const AName, AValue: string);
var
  P: PropertyValue;
begin
  // Empty extras are omitted entirely rather than sent blank: their extra*
  // collections are name/value pairs, and a blank value carries no information
  // while still occupying a slot in the ticket.
  if Trim(AValue) = '' then
    Exit;

  P := PropertyValue.Create;
  P.Name_ := AName;
  P.Value := Trim(AValue);
  SetLength(AList, Length(AList) + 1);
  AList[High(AList)] := P;
end;

{ ---- decoders ------------------------------------------------------------ }

class function TLeadsOnlineTicketMapper.DecodeTicketType(const ATranType: string): TicketType;
var
  C: string;
begin
  C := UpperCase(Trim(ATranType));
  if C = TranPawn then
    Result := TicketType.Pawn
  else if C = TranPurchase then
    Result := TicketType.Buy
  else
    raise ELeadsOnlineMapping.CreateFmt(
      'Transaction type %s has no LeadsOnline ticket type (only pawns and buys are exported).',
      [AnsiQuotedStr(ATranType, '"')]);
end;

class function TLeadsOnlineTicketMapper.DecodeRace(const ACode: string): string;
begin
  // EnterClientInfo.cbRace. English canonical, never the rendered picker text.
  case IndexStr(UpperCase(Trim(ACode)), ['W', 'B', 'I', 'A', 'H']) of
    0: Result := 'White';
    1: Result := 'Black';
    2: Result := 'American-Indian';
    3: Result := 'Asian/Oriental';
    4: Result := 'Hispanic';
  else
    Result := '';
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeEyeColor(const ACode: string): string;
begin
  case IndexStr(UpperCase(Trim(ACode)), ['BLU', 'BLK', 'BRN', 'GRN', 'GRY', 'HZL']) of
    0: Result := 'Blue';
    1: Result := 'Black';
    2: Result := 'Brown';
    3: Result := 'Green';
    4: Result := 'Gray';
    5: Result := 'Hazel';
  else
    Result := '';
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeHairColor(const ACode: string): string;
begin
  // Note BLK means Black in both pickers, but BRW (hair) and BRN (eyes) differ.
  case IndexStr(UpperCase(Trim(ACode)), ['BLK', 'BLD', 'BRW', 'GRY', 'RED']) of
    0: Result := 'Black';
    1: Result := 'Blond';
    2: Result := 'Brown';
    3: Result := 'Gray';
    4: Result := 'Red';
  else
    Result := '';
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeSex(const ACode: string): string;
begin
  case IndexStr(UpperCase(Trim(ACode)), ['M', 'F']) of
    0: Result := 'M';
    1: Result := 'F';
  else
    Result := '';   // 'N' (not stated) or empty: send nothing rather than guess
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeItemStatus(const ACode: string;
  ATicketType: TicketType): string;
begin
  // Their suggested vocabulary: Pawn / Buy / Trade / Consigned / Hold / Seized.
  // Mapped from the stored INV_ITEM_STATUS char code, never from the
  // PawnItemStatus_* display labels, which are translatable.
  //
  // In practice a ticket is exported when it is written, so the item is either
  // freshly pawned ('P') or freshly bought ('S'). The later statuses --
  // redeemed, sold, scrapped, layaway -- are not export-time states. Rather
  // than guess a reportable status for each of them, anything else falls back
  // to what the TICKET is, which is the thing actually being reported and is
  // correct by construction.
  case IndexStr(UpperCase(Trim(ACode)), ['P', 'S']) of
    0: Result := 'Pawn';
    1: Result := 'Buy';         // For Sale: acquired outright
  else
    if ATicketType = TicketType.Pawn then
      Result := 'Pawn'
    else
      Result := 'Buy';
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeWeightUnit(const ACode: string): string;
begin
  case IndexStr(UpperCase(Trim(ACode)), ['G', 'P']) of
    0: Result := 'grams';
    1: Result := 'dwt';        // pennyweight
  else
    Result := '';
  end;
end;

class function TLeadsOnlineTicketMapper.DecodeItemType(AItems: TDataSet): ItemType;
begin
  // Every INV_CATEGORIES row is jewelry or OTHER, and J_TYPE is the jewelry
  // classifier, so a row carrying jewelry attributes is Jewelry and everything
  // else is Other. Firearm is intentionally unreachable -- see the interface.
  if (Str(AItems, 'J_TYPE') <> '') or (Str(AItems, 'J_TYPE_DESC') <> '') or
     (Str(AItems, 'J_METAL_DESC') <> '') or (Num(AItems, 'KT') > 0) then
    Result := ItemType.Jewelry
  else
    Result := ItemType.Other;
end;

{ ---- formatters ---------------------------------------------------------- }

class function TLeadsOnlineTicketMapper.FormatTicketDateTime(ADate, ATime: TDateTime): string;
var
  DT: TDateTime;
begin
  // DateOf/TimeOf by hand: TRAN_DATE may arrive with a zero time and TRAN_TIME
  // with a zero date, and adding them naively would be wrong if either ever
  // carried both parts.
  DT := Trunc(ADate) + Frac(ATime);
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', DT);
end;

class function TLeadsOnlineTicketMapper.IsPlausibleDate(ADate: TDateTime): Boolean;
begin
  // Wide on purpose: this is a sanity check, not validation. It has to admit a
  // legitimate future redeem-by date while rejecting a year that cannot be a
  // real one. Zero (an empty date field) falls below the floor and is excluded.
  Result := (ADate >= EncodeDate(1900, 1, 1)) and (ADate < EncodeDate(2100, 1, 1));
end;

class function TLeadsOnlineTicketMapper.IsPlausibleDateOfBirth(ADate: TDateTime): Boolean;
begin
  Result := IsPlausibleDate(ADate) and
            (ADate <= Date) and
            (ADate >= IncYear(Date, -120));
end;

class function TLeadsOnlineTicketMapper.FormatDate(ADate: TDateTime): string;
begin
  // An impossible date is omitted rather than sent. LeadsOnline reject the
  // entire ticket on a malformed date (error 1), so passing a mistyped birth
  // year straight through means a reportable transaction never reaches law
  // enforcement at all -- over an optional field. Reporting the transaction
  // without a date of birth is strictly better than not reporting it.
  if not IsPlausibleDate(ADate) then
    Result := ''
  else
    Result := FormatDateTime('yyyy-mm-dd', ADate);
end;

class function TLeadsOnlineTicketMapper.ParseHeightInches(const AText: string): Integer;
var
  S: string;
  I, Feet, Inches, SepPos: Integer;
begin
  Result := 0;
  S := Trim(AText);
  if S = '' then
    Exit;

  // PawnPro's own format is FEET.INCHES, and it is by far the commonest: 5.08
  // is five feet eight, 5.10 is five feet TEN (not five point one feet), 6.00
  // is six feet. Handled first, because "5.10" would otherwise fall through to
  // the integer branch or be read as a decimal number of feet -- which is how
  // every ticket ended up reporting "Height: N/A" to LeadsOnline.
  SepPos := Pos('.', S);
  if SepPos > 0 then
  begin
    if TryStrToInt(Trim(Copy(S, 1, SepPos - 1)), Feet) and
       TryStrToInt(Trim(Copy(S, SepPos + 1, MaxInt)), Inches) and
       (Feet >= 0) and (Inches >= 0) and (Inches <= 11) then
      Result := Feet * 12 + Inches;
    // Anything else with a dot is not a height we recognise; 0 means "not
    // recorded", which is better than a confident wrong number.
    Exit;
  end;

  // Plain inches, the common case.
  if TryStrToInt(S, I) then
  begin
    // A bare 5 or 6 is feet-with-no-inches, not a 5-inch-tall person.
    if (I > 0) and (I < 12) then
      Result := I * 12
    else
      Result := I;
    Exit;
  end;

  // feet<sep>inches, where sep is ' " - or a space.
  SepPos := 0;
  for I := 1 to Length(S) do
    if CharInSet(S[I], ['''', '-', ' ', '"']) then
    begin
      SepPos := I;
      Break;
    end;
  if SepPos = 0 then
    Exit;

  if not TryStrToInt(Trim(Copy(S, 1, SepPos - 1)), Feet) then
    Exit;

  S := Trim(Copy(S, SepPos + 1, MaxInt));
  S := StringReplace(S, '"', '', [rfReplaceAll]);
  S := StringReplace(S, '''', '', [rfReplaceAll]);
  S := Trim(S);
  if (S = '') or (not TryStrToInt(S, Inches)) then
    Inches := 0;

  Result := Feet * 12 + Inches;
end;

class function TLeadsOnlineTicketMapper.PreferredPhone(AHeader: TDataSet): string;
begin
  // Same precedence as the CSV export, so the two channels agree.
  Result := Str(AHeader, 'CUST_PH_CELL');
  if Result = '' then
    Result := Str(AHeader, 'CUST_PH_HOME');
  if Result = '' then
    Result := Str(AHeader, 'CUST_PH_BUSINESS');
  if Result = '' then
    Result := Str(AHeader, 'CUST_PH_BEEP');
end;

{ ---- builders ------------------------------------------------------------ }

class function TLeadsOnlineTicketMapper.BuildCustomer(AHeader: TDataSet): Customer2;
var
  Extras: ArrayOfPropertyValue;
  V: string;
begin
  Result := Customer2.Create;
  try
    // Every optional string is assigned only when it has content. Assigning ''
    // still marks the property "specified" in Delphi's SOAP runtime, which puts
    // an empty <make/> style element on the wire; their samples omit absent
    // fields, and "absent" reads very differently from "blank" to whoever
    // reviews this downstream.

    // fname/lname are sent separately, so their combined 'name' stays unset --
    // sending both invites the two disagreeing after an edit.
    V := Str(AHeader, 'CUST_FIRST');           if V <> '' then Result.fname := V;
    V := Str(AHeader, 'CUST_LAST');            if V <> '' then Result.lname := V;
    V := Str(AHeader, 'CUST_ADDR');            if V <> '' then Result.address1 := V;
    // The apartment goes in their CUSTOMER_ADDR_APT extra, not glued onto
    // address2 -- their spec documents that field explicitly ("as #4 in
    // 123 N Main Ave #4"), so inventing "APT 4B" free text would be worse data.
    V := Str(AHeader, 'CUST_CITY');            if V <> '' then Result.city := V;
    V := Str(AHeader, 'CUST_STATE');           if V <> '' then Result.state := V;
    V := Str(AHeader, 'CUST_ZIP');             if V <> '' then Result.postalCode := V;
    V := PreferredPhone(AHeader);              if V <> '' then Result.phone := V;

    // ID precedence copied from the CSV export: a Florida driver licence wins
    // over the generic ID columns.
    if Str(AHeader, 'CUST_FL_DRV_LIC') <> '' then
    begin
      Result.idType := 'Driver License';
      Result.idNumber := Str(AHeader, 'CUST_FL_DRV_LIC');
    end
    else
    begin
      V := Str(AHeader, 'CUST_ID_TYPE');       if V <> '' then Result.idType := V;
      V := Str(AHeader, 'CUST_ID');            if V <> '' then Result.idNumber := V;
    end;

    // A birth date is only sent when it could be a birth date. Sending
    // "born 2027" to law enforcement is worse than sending nothing: nothing is
    // visibly missing, whereas a plausible-looking wrong value gets believed.
    if IsPlausibleDateOfBirth(Field(AHeader, 'CUST_DOB').AsDateTime) then
    begin
      V := FormatDate(Field(AHeader, 'CUST_DOB').AsDateTime);
      if V <> '' then Result.dob := V;
    end;
    V := DecodeEyeColor(Str(AHeader, 'CUST_EYES'));
                                               if V <> '' then Result.eyeColor := V;
    V := DecodeHairColor(Str(AHeader, 'CUST_HAIR'));
                                               if V <> '' then Result.hairColor := V;
    V := DecodeRace(Str(AHeader, 'CUST_RACE'));
                                               if V <> '' then Result.race := V;
    V := DecodeSex(Str(AHeader, 'CUST_GENDER'));
                                               if V <> '' then Result.sex := V;

    // weight/height are plain integers in their schema, not optional, so they
    // are always present; 0 is their "not recorded".
    Result.weight := Round(Num(AHeader, 'CUST_WEIGHT'));
    Result.height := ParseHeightInches(Str(AHeader, 'CUST_HEIGHT'));

    // Names verbatim from their spec. CUSTOMER_ID_ISSUER1 is documented as
    // "Issuer of the ID; Federal, particular state or ?", which is exactly what
    // CUST_ID_AGENCY_STATE holds.
    Extras := nil;
    AddProp(Extras, 'CUSTOMER_NAME_MIDDLE', Str(AHeader, 'CUST_MID'));
    AddProp(Extras, 'CUSTOMER_ADDR_APT', Str(AHeader, 'CUST_APT'));
    AddProp(Extras, 'CUSTOMER_EMPLOYER', Str(AHeader, 'CUST_PLACE_EMPLY'));
    AddProp(Extras, 'CUSTOMER_EMPLOYER_PHONE', Str(AHeader, 'CUST_PH_BUSINESS'));
    AddProp(Extras, 'CUSTOMER_ID_ISSUER1', Str(AHeader, 'CUST_ID_AGENCY_STATE'));
    if Length(Extras) > 0 then
      Result.extraCustomer := Extras;
  except
    Result.Free;
    raise;
  end;
end;

class procedure TLeadsOnlineTicketMapper.AddStoneProps(var AList: ArrayOfPropertyValue;
  AStones: TDataSet; AItemNo: Integer);
var
  N: Integer;
  Prefix: string;
begin
  if (AStones = nil) or (not AStones.Active) then
    Exit;

  N := 0;
  AStones.First;
  while (not AStones.Eof) and (N < 2) do
  begin
    // The dataset holds every stone on the ticket; take only this item's.
    if Field(AStones, 'INV_ITEM_NO').AsInteger <> AItemNo then
    begin
      AStones.Next;
      Continue;
    end;

    // A stone has to earn its slot. Only two are ever sent, and older data holds
    // stones recorded with nothing but a quantity -- 490 of them at Perez Cash
    // Joyeria, all with a quantity and 57 with no type or weight either. The
    // lookups are LEFT joined (see SQLTicketStones) so those rows now reach us
    // instead of being dropped, which is right; but letting one occupy a slot
    // would push a genuine stone off the ticket, which is not. Quantity alone is
    // not substance: it says "1" about a stone we cannot otherwise describe.
    if (Str(AStones, 'STONE_TYPE') = '') and
       (Str(AStones, 'J_STONE_DESC') = '') and
       (Str(AStones, 'J_SHAPE_DESC') = '') and
       (Num(AStones, 'CT') <= 0) and
       (Num(AStones, 'WT') <= 0) then
    begin
      AStones.Next;
      Continue;
    end;

    Inc(N);
    // Names are theirs, verbatim from the spec. STONE_TYPE is the stone itself
    // ("diamond"); J_STONE_DESC comes from J_STONE_COLORS and is the colour, so
    // it maps to _COLOR -- the plan's §6 table had these two swapped. _CARAT is
    // documented as "also known as weight" and takes CT; _WT is a separate
    // field and takes the WT column.
    Prefix := Format('JEWELRY_STONE%d_', [N]);
    AddProp(AList, Prefix + 'TYPE',  Str(AStones, 'STONE_TYPE'));
    AddProp(AList, Prefix + 'COLOR', Str(AStones, 'J_STONE_DESC'));
    AddProp(AList, Prefix + 'SHAPE', Str(AStones, 'J_SHAPE_DESC'));
    if Num(AStones, 'CT') > 0 then
      AddProp(AList, Prefix + 'CARAT', FormatFloat('0.##', Num(AStones, 'CT')));
    if Num(AStones, 'WT') > 0 then
      AddProp(AList, Prefix + 'WT', FormatFloat('0.###', Num(AStones, 'WT')));
    AddProp(AList, Prefix + 'QUANTITY', Str(AStones, 'STONE_NUMBER'));
    AStones.Next;
  end;
end;

class function TLeadsOnlineTicketMapper.BuildItem(AItems, AStones: TDataSet;
  AFallbackAmount: Double): Item2;
var
  Extras: ArrayOfPropertyValue;
  Desc, V: string;
begin
  Result := Item2.Create;
  try
    // Optional strings only when populated -- see the note in BuildCustomer.
    V := Str(AItems, 'INV_ITEM_BRAND');  if V <> '' then Result.make := V;
    V := Str(AItems, 'MODEL_NUMBER');    if V <> '' then Result.model := V;
    V := Str(AItems, 'SERIAL_NUMBER');   if V <> '' then Result.serialNumber := V;

    // At least one of make/model/serial/description is required for a non-void
    // item. DESCRIPTION is the usual carrier; fall back to the jewelry type and
    // then the note so the requirement is met from real data rather than filler.
    Desc := Str(AItems, 'DESCRIPTION');
    if Desc = '' then
      Desc := Str(AItems, 'J_TYPE_DESC');
    if Desc = '' then
      Desc := Str(AItems, 'NOTE');
    if Desc <> '' then
      Result.description := Desc;

    // The money on a pawn lives on the TRANSACTION (TRAN_PAWN_AMOUNT); the
    // per-item UNIT_COST is usually filled in too, but not always. LeadsOnline
    // compute the ticket TOTAL by summing item amounts, so an item with no unit
    // cost makes the whole ticket read $0.00 to law enforcement.
    //
    // AFallbackAmount is the ticket's loan amount, and the caller passes it
    // ONLY when the ticket has a single item -- where the whole loan is against
    // that item and the substitution is exact rather than a guess.
    Result.amount := Num(AItems, 'UNIT_COST');
    if (Result.amount = 0) and (AFallbackAmount > 0) then
      Result.amount := AFallbackAmount;
    Result.itemType := DecodeItemType(AItems);
    Result.isVoid := False;
    // itemStatus is set by BuildTicket, which knows the ticket type.

    Extras := nil;
    AddProp(Extras, 'JEWELRY_TYPE',  Str(AItems, 'J_TYPE_DESC'));
    AddProp(Extras, 'JEWELRY_STYLE', Str(AItems, 'J_STYLE_DESC'));
    AddProp(Extras, 'JEWELRY_METAL', Str(AItems, 'J_METAL_DESC'));
    if Num(AItems, 'KT') > 0 then
      AddProp(Extras, 'JEWELRY_KARAT', FormatFloat('0.##', Num(AItems, 'KT')));
    if Num(AItems, 'WEIGHT') > 0 then
    begin
      AddProp(Extras, 'JEWELRY_WEIGHT', FormatFloat('0.###', Num(AItems, 'WEIGHT')));
      AddProp(Extras, 'JEWELRY_WEIGHT_UNIT', DecodeWeightUnit(Str(AItems, 'WEIGHT_UNIT')));
    end;
    if Num(AItems, 'SIZE_LENGTH') > 0 then
      AddProp(Extras, 'JEWELRY_SIZE', FormatFloat('0.##', Num(AItems, 'SIZE_LENGTH')));
    AddProp(Extras, 'JEWELRY_GENDER', Str(AItems, 'GENDER'));
    AddProp(Extras, 'ITEM_NOTES', Str(AItems, 'NOTE'));
    if Num(AItems, 'INV_ITEM_COUNT') > 0 then
      AddProp(Extras, 'ITEM_QUANTITY', Str(AItems, 'INV_ITEM_COUNT'));

    AddStoneProps(Extras, AStones, Field(AItems, 'INV_ITEM_NO').AsInteger);

    if Length(Extras) > 0 then
      Result.extraItem := Extras;
  except
    Result.Free;
    raise;
  end;
end;

class function TLeadsOnlineTicketMapper.BuildTicket(AHeader, AItems, AStones: TDataSet): Ticket;
var
  Key: TicketKey;
  TicketExtras: ArrayOfPropertyValue;
  Items: ArrayOfItem;
  It: Item2;
  TT: TicketType;
  Maturity, CloseReason: TField;
  FallbackAmount: Double;
begin
  if (AHeader = nil) or (not AHeader.Active) or AHeader.IsEmpty then
    raise ELeadsOnlineMapping.Create('No transaction row to map.');

  TT := DecodeTicketType(Str(AHeader, 'TRAN_TYPE'));

  // The transaction's own date is half the ticket key, so an impossible one
  // cannot be quietly dropped the way a bad birth date can. Caught here rather
  // than by a round trip, because "skipped: the transaction date is not valid"
  // points at the data, where LeadsOnline's error 1 just says a date somewhere
  // in the ticket was malformed.
  if not IsPlausibleDate(Field(AHeader, 'TRAN_DATE').AsDateTime) then
    raise ELeadsOnlineMapping.CreateFmt(
      'The transaction date (%s) is not a valid date, so this ticket cannot be ' +
      'reported. Correct the transaction first.',
      [FormatDateTime('yyyy-mm-dd', Field(AHeader, 'TRAN_DATE').AsDateTime)]);

  Result := Ticket.Create;
  try
    Key := TicketKey.Create;
    Key.ticketType := TT;
    Key.ticketnumber := Str(AHeader, 'TRAN_TICKET_NO');
    Key.ticketDateTime := FormatTicketDateTime(
      Field(AHeader, 'TRAN_DATE').AsDateTime,
      Field(AHeader, 'TRAN_TIME').AsDateTime);
    Result.key := Key;

    // Pawns only. A buy has nothing to redeem, and sending a date would imply
    // the customer can come back for it.
    Maturity := Field(AHeader, 'TRAN_MATURITY');
    if (TT = TicketType.Pawn) and (Maturity <> nil) and (not Maturity.IsNull) then
      Result.redeemByDate := FormatDate(Maturity.AsDateTime);

    Result.customer := BuildCustomer(AHeader);

    // A void ticket is reported, not withheld: LeadsOnline need to know a
    // transaction was cancelled, which is what isVoid is for.
    CloseReason := Field(AHeader, 'TRAN_CLOSE_REASON');
    Result.isVoid := (CloseReason <> nil) and (not CloseReason.IsNull) and
                     (CloseReason.AsInteger = PawnCloseReasonVoid);

    Items := nil;
    if (AItems <> nil) and AItems.Active then
    begin
      // Only offered when the ticket has exactly one item: then the loan is
      // wholly against it and using the ticket amount is exact. With several
      // items we genuinely do not know the split, and inventing one would put
      // fabricated per-item values on a law-enforcement record.
      if AItems.RecordCount = 1 then
        FallbackAmount := Num(AHeader, 'TRAN_PAWN_AMOUNT')
      else
        FallbackAmount := 0;

      AItems.First;
      while not AItems.Eof do
      begin
        It := BuildItem(AItems, AStones, FallbackAmount);
        It.itemStatus := DecodeItemStatus(Str(AItems, 'INV_ITEM_STATUS'), TT);
        It.isVoid := Result.isVoid;
        SetLength(Items, Length(Items) + 1);
        Items[High(Items)] := It;
        AItems.Next;
      end;
    end;
    if Length(Items) > 0 then
      Result.items := Items;

    // TICKET_LOAN_AMOUNT is documented as "the total value of a loan/buy when
    // known", which is the ticket-level figure. Item.amount stays per-item
    // (their ITEM_LOAN_AMOUNT covers the same ground and would duplicate it).
    TicketExtras := nil;
    if Num(AHeader, 'TRAN_PAWN_AMOUNT') > 0 then
      AddProp(TicketExtras, 'TICKET_LOAN_AMOUNT',
              FormatFloat('0.00', Num(AHeader, 'TRAN_PAWN_AMOUNT')));
    if Length(TicketExtras) > 0 then
      Result.extraTicket := TicketExtras;
  except
    Result.Free;
    raise;
  end;
end;

end.
