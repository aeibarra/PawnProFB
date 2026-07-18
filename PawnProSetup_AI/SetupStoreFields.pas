unit SetupStoreFields;

// STORE-row helpers for PawnProSetup. The STORE table holds a single row
// per shop (STORE_NO='0' invariant; multi-DB scenarios are out of scope).
// Used by the New Install wizard (insert/update) and the Edit Store mode
// (read + update).
//
// WriteStoreRow uses Firebird's UPDATE OR INSERT ... MATCHING (STORE_NO),
// which works whether the row already exists (e.g. from
// Schema\PawnPro_FB5_SeedReferenceData.sql) or not.
//
// DefaultStoreFields matches the values populated by the seed script so
// re-running the wizard on a freshly seeded DB with unchanged defaults is
// a no-op.

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.stan.Param;

const
  STORE_NO_DEFAULT = '0';

type
  TStoreFields = record
    StoreNo:                  string;   // STORE_NO        VARCHAR(10)
    StoreName:                string;   // STORE_NAME      VARCHAR(55)
    StoreAddr:                string;   // STORE_ADDR      VARCHAR(55)
    StoreCityStZip:           string;   // STORE_CITY_ST_ZIP VARCHAR(55)
    StorePhone:               string;   // STORE_PHONE     VARCHAR(14)
    StorePoliceId:            string;   // STORE_POLICE_ID VARCHAR(30)
    StoreNumber:              string;   // STORE_NUMBER    VARCHAR(30)
    DefaultPawnInterestRate:  Double;   // DEFAULT_PAWN_INTERESTRATE
    DefaultMaturityMonths:    Integer;  // DEFAULT_MATURITY_MONTHS
    PawnDefaultMonths:        Integer;  // PAWN_DEFAULT_MONTHS
    SalesTaxPerc:             Double;   // SALES_TAX_PERC
    PawnDateCalculationBase:  Char;     // 'D' = days, 'M' = months
    DefaultWeightMeasureUnit: Char;     // 'P' = Pennyweight, 'G' = Gram
    LeadsStoreId:             string;
    LeadsOnlineFtpAddress:    string;
    LeadsOnlineUserName:      string;
    LeadsOnlinePassword:      string;
    FtpPassive:               Boolean;
  end;

function DefaultStoreFields: TStoreFields;

function ReadStoreRow(AConn: TFDConnection; out Fields: TStoreFields): Boolean;
procedure WriteStoreRow(AConn: TFDConnection; const Fields: TStoreFields);

implementation

function DefaultStoreFields: TStoreFields;
begin
  // Mirror Schema\PawnPro_FB5_SeedReferenceData.sql for the seeded fields,
  // and FB column DEFAULTs for the rest. Keeping these aligned means the
  // wizard's first-screen prefill matches what's already in the DB after
  // PawnPro_FB5_NewStoreFullDeploy.sql ran -- no surprise UPDATE on save.
  Result := Default(TStoreFields);
  Result.StoreNo                  := STORE_NO_DEFAULT;
  Result.StoreName                := 'TEST STORE';
  Result.DefaultPawnInterestRate  := 10.0;
  Result.DefaultMaturityMonths    := 1;
  Result.PawnDefaultMonths        := 2;
  Result.SalesTaxPerc             := 7.0;
  Result.PawnDateCalculationBase  := 'D';
  Result.DefaultWeightMeasureUnit := 'P';
  Result.LeadsOnlineFtpAddress    := 'ftp.leadsonline.com';
  Result.FtpPassive               := True;
end;

function ReadStoreRow(AConn: TFDConnection; out Fields: TStoreFields): Boolean;
var
  Q: TFDQuery;
begin
  Fields := DefaultStoreFields;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text :=
      'SELECT STORE_NO, STORE_NAME, STORE_ADDR, STORE_CITY_ST_ZIP, STORE_PHONE, ' +
      '       STORE_POLICE_ID, STORE_NUMBER, ' +
      '       DEFAULT_PAWN_INTERESTRATE, DEFAULT_MATURITY_MONTHS, PAWN_DEFAULT_MONTHS, ' +
      '       SALES_TAX_PERC, PAWN_DATE_CALCULATION_BASE, DEFAULT_WEIGHT_MEASURE_UNIT, ' +
      '       LEADS_STORE_ID, LEADS_ONLINE_FTP_ADDRESS, LEADS_ONLINE_USER_NAME, ' +
      '       LEADS_ONLINE_PASSWORD, FTP_PASSIVE ' +
      'FROM STORE ' +
      'WHERE STORE_NO = :STORE_NO';
    Q.ParamByName('STORE_NO').AsString := STORE_NO_DEFAULT;
    Q.Open;
    Result := not Q.Eof;
    if not Result then Exit;

    Fields.StoreNo         := Q.FieldByName('STORE_NO').AsString;
    Fields.StoreName       := Q.FieldByName('STORE_NAME').AsString;
    Fields.StoreAddr       := Q.FieldByName('STORE_ADDR').AsString;
    Fields.StoreCityStZip  := Q.FieldByName('STORE_CITY_ST_ZIP').AsString;
    Fields.StorePhone      := Q.FieldByName('STORE_PHONE').AsString;
    Fields.StorePoliceId   := Q.FieldByName('STORE_POLICE_ID').AsString;
    Fields.StoreNumber     := Q.FieldByName('STORE_NUMBER').AsString;

    if not Q.FieldByName('DEFAULT_PAWN_INTERESTRATE').IsNull then
      Fields.DefaultPawnInterestRate := Q.FieldByName('DEFAULT_PAWN_INTERESTRATE').AsFloat;
    if not Q.FieldByName('DEFAULT_MATURITY_MONTHS').IsNull then
      Fields.DefaultMaturityMonths := Q.FieldByName('DEFAULT_MATURITY_MONTHS').AsInteger;
    if not Q.FieldByName('PAWN_DEFAULT_MONTHS').IsNull then
      Fields.PawnDefaultMonths := Q.FieldByName('PAWN_DEFAULT_MONTHS').AsInteger;
    if not Q.FieldByName('SALES_TAX_PERC').IsNull then
      Fields.SalesTaxPerc := Q.FieldByName('SALES_TAX_PERC').AsFloat;

    if (Q.FieldByName('PAWN_DATE_CALCULATION_BASE').AsString <> '') then
      Fields.PawnDateCalculationBase := Q.FieldByName('PAWN_DATE_CALCULATION_BASE').AsString[1];
    if (Q.FieldByName('DEFAULT_WEIGHT_MEASURE_UNIT').AsString <> '') then
      Fields.DefaultWeightMeasureUnit := Q.FieldByName('DEFAULT_WEIGHT_MEASURE_UNIT').AsString[1];

    Fields.LeadsStoreId          := Q.FieldByName('LEADS_STORE_ID').AsString;
    Fields.LeadsOnlineFtpAddress := Q.FieldByName('LEADS_ONLINE_FTP_ADDRESS').AsString;
    Fields.LeadsOnlineUserName   := Q.FieldByName('LEADS_ONLINE_USER_NAME').AsString;
    Fields.LeadsOnlinePassword   := Q.FieldByName('LEADS_ONLINE_PASSWORD').AsString;
    Fields.FtpPassive            := Q.FieldByName('FTP_PASSIVE').AsBoolean;
  finally
    Q.Free;
  end;
end;

procedure WriteStoreRow(AConn: TFDConnection; const Fields: TStoreFields);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text :=
      'UPDATE OR INSERT INTO STORE (' +
      '  STORE_NO, STORE_NAME, STORE_ADDR, STORE_CITY_ST_ZIP, STORE_PHONE,' +
      '  STORE_POLICE_ID, STORE_NUMBER,' +
      '  DEFAULT_PAWN_INTERESTRATE, DEFAULT_MATURITY_MONTHS, PAWN_DEFAULT_MONTHS,' +
      '  SALES_TAX_PERC, PAWN_DATE_CALCULATION_BASE, DEFAULT_WEIGHT_MEASURE_UNIT,' +
      '  LEADS_STORE_ID, LEADS_ONLINE_FTP_ADDRESS, LEADS_ONLINE_USER_NAME,' +
      '  LEADS_ONLINE_PASSWORD, FTP_PASSIVE' +
      ') VALUES (' +
      '  :STORE_NO, :STORE_NAME, :STORE_ADDR, :STORE_CITY_ST_ZIP, :STORE_PHONE,' +
      '  :STORE_POLICE_ID, :STORE_NUMBER,' +
      '  :DEFAULT_PAWN_INTERESTRATE, :DEFAULT_MATURITY_MONTHS, :PAWN_DEFAULT_MONTHS,' +
      '  :SALES_TAX_PERC, :PAWN_DATE_CALCULATION_BASE, :DEFAULT_WEIGHT_MEASURE_UNIT,' +
      '  :LEADS_STORE_ID, :LEADS_ONLINE_FTP_ADDRESS, :LEADS_ONLINE_USER_NAME,' +
      '  :LEADS_ONLINE_PASSWORD, :FTP_PASSIVE' +
      ') MATCHING (STORE_NO)';

    Q.ParamByName('STORE_NO').AsString          := Fields.StoreNo;
    Q.ParamByName('STORE_NAME').AsString        := Fields.StoreName;
    Q.ParamByName('STORE_ADDR').AsString        := Fields.StoreAddr;
    Q.ParamByName('STORE_CITY_ST_ZIP').AsString := Fields.StoreCityStZip;
    Q.ParamByName('STORE_PHONE').AsString       := Fields.StorePhone;
    Q.ParamByName('STORE_POLICE_ID').AsString   := Fields.StorePoliceId;
    Q.ParamByName('STORE_NUMBER').AsString      := Fields.StoreNumber;

    Q.ParamByName('DEFAULT_PAWN_INTERESTRATE').AsFloat  := Fields.DefaultPawnInterestRate;
    Q.ParamByName('DEFAULT_MATURITY_MONTHS').AsInteger  := Fields.DefaultMaturityMonths;
    Q.ParamByName('PAWN_DEFAULT_MONTHS').AsInteger      := Fields.PawnDefaultMonths;
    Q.ParamByName('SALES_TAX_PERC').AsFloat             := Fields.SalesTaxPerc;
    Q.ParamByName('PAWN_DATE_CALCULATION_BASE').AsString := Fields.PawnDateCalculationBase;
    Q.ParamByName('DEFAULT_WEIGHT_MEASURE_UNIT').AsString := Fields.DefaultWeightMeasureUnit;

    Q.ParamByName('LEADS_STORE_ID').AsString          := Fields.LeadsStoreId;
    Q.ParamByName('LEADS_ONLINE_FTP_ADDRESS').AsString := Fields.LeadsOnlineFtpAddress;
    Q.ParamByName('LEADS_ONLINE_USER_NAME').AsString  := Fields.LeadsOnlineUserName;
    Q.ParamByName('LEADS_ONLINE_PASSWORD').AsString   := Fields.LeadsOnlinePassword;
    Q.ParamByName('FTP_PASSIVE').AsBoolean            := Fields.FtpPassive;

    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

end.
