# Gold Price Tracking - Implementation Guide

## Current Implementation

### Button Code Location: [PawnMain.pas](PawnMain.pas#L630)

The `btnGetGoldPricesClick` procedure currently:
- Fetches gold prices from: `https://min-api.cryptocompare.com/data/price?fsym=PAXG&tsyms=USD`
- Uses PAXG (Physical Gold Token) as the symbol
- Returns price per ounce in USD
- Displays result in Label2 (e.g., "123.45 per Ounce")
- Runs asynchronously in a background thread using `TTask.Run`
- Safely updates UI using `TThread.Synchronize`

### Current Code
```pascal
procedure TfrmPawnMain.btnGetGoldPricesClick(Sender: TObject);
begin
  Label2.Caption := 'Loading price...';
  btnGetGoldPrices.Enabled := False;

  TTask.Run(
    procedure
    var
      LClient: TNetHTTPClient;
      LResponse: IHTTPResponse;
      LJSON: TJSONObject;
      PricePerOunce: Double;
      StatusMessage: string;
    begin
      try
        LClient := TNetHTTPClient.Create(nil);
        try
          LResponse := LClient.Get('https://min-api.cryptocompare.com/data/price?fsym=PAXG&tsyms=USD');

          if LResponse.StatusCode = 200 then
          begin
            LJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
            try
              PricePerOunce := LJSON.GetValue<Double>('USD');
              StatusMessage := Format('%.2f per Ounce', [PricePerOunce]);
            finally
              LJSON.Free;
            end;
          end
          else
            StatusMessage := 'Error: ' + LResponse.StatusText;
        finally
          LClient.Free;
        end;
      except
        on E: Exception do
          StatusMessage := 'Error: ' + E.Message;
      end;

      TThread.Synchronize(nil, procedure
      begin
        Label2.Caption := StatusMessage;
        btnGetGoldPrices.Enabled := True;
      end);
    end);
end;
```

---

## New Database Table: `GoldPriceHistory`

### Table Structure

| Column | Type | Description |
|--------|------|-------------|
| `PriceID` | integer (PK) | Auto-incrementing primary key |
| `PricePerOunce` | numeric(10, 2) | Gold price in USD per ounce |
| `Currency` | varchar(3) | Currency code (default: 'USD') |
| `FetchDateTime` | datetime | Timestamp when price was fetched |
| `Source` | varchar(50) | API source (default: 'CryptoCompare') |
| `APIResponse` | long varchar | Optional: Full API response for debugging |

### Indexes
- **idx_GoldPrice_FetchDateTime**: On FetchDateTime DESC for fast queries
- **idx_GoldPrice_Date**: For daily summary queries

### Views Provided
1. **vw_GoldPriceDaily**: Daily min, max, average prices
2. **vw_GoldPriceHourly**: Hourly min, max, average prices

---

## Implementation Steps

### 1. Create the Table
Execute [GoldPriceHistory.sql](GoldPriceHistory.sql) in your SAP SQL Anywhere database

### 2. Add Query Component to Data Module
In `PawnDM.pas`, add a new TADOQuery component:
```pascal
qryGoldPriceHistory: TADOQuery;
```

Set its SQL to:
```sql
SELECT * FROM GoldPriceHistory
```

### 3. Modify Button Handler
Update `btnGetGoldPricesClick` in [PawnMain.pas](PawnMain.pas#L630) to insert the price:

```pascal
procedure TfrmPawnMain.btnGetGoldPricesClick(Sender: TObject);
begin
  Label2.Caption := 'Loading price...';
  btnGetGoldPrices.Enabled := False;

  TTask.Run(
    procedure
    var
      LClient: TNetHTTPClient;
      LResponse: IHTTPResponse;
      LJSON: TJSONObject;
      PricePerOunce: Double;
      StatusMessage: string;
    begin
      try
        LClient := TNetHTTPClient.Create(nil);
        try
          LResponse := LClient.Get('https://min-api.cryptocompare.com/data/price?fsym=PAXG&tsyms=USD');

          if LResponse.StatusCode = 200 then
          begin
            LJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
            try
              PricePerOunce := LJSON.GetValue<Double>('USD');
              StatusMessage := Format('%.2f per Ounce', [PricePerOunce]);
              
              // *** NEW: Store the price in the database ***
              try
                DM.qryGoldPriceHistory.Close;
                DM.qryGoldPriceHistory.SQL.Clear;
                DM.qryGoldPriceHistory.SQL.Add('INSERT INTO GoldPriceHistory (PricePerOunce, Currency, FetchDateTime, Source)');
                DM.qryGoldPriceHistory.SQL.Add('VALUES (?, ?, CURRENT TIMESTAMP, ''CryptoCompare'')');
                DM.qryGoldPriceHistory.Parameters.ParamByName('@param1').Value := PricePerOunce;
                DM.qryGoldPriceHistory.Parameters.ParamByName('@param2').Value := 'USD';
                DM.qryGoldPriceHistory.ExecSQL;
              except
                on E: Exception do
                  StatusMessage := StatusMessage + ' (DB Save Failed: ' + E.Message + ')';
              end;
              
            finally
              LJSON.Free;
            end;
          end
          else
            StatusMessage := 'Error: ' + LResponse.StatusText;
        finally
          LClient.Free;
        end;
      except
        on E: Exception do
          StatusMessage := 'Error: ' + E.Message;
      end;

      TThread.Synchronize(nil, procedure
      begin
        Label2.Caption := StatusMessage;
        btnGetGoldPrices.Enabled := True;
      end);
    end);
end;
```

### 4. Setup 15-Minute Timer (Optional)
To fetch prices automatically every 15 minutes, add a TTimer component to `PawnMain`:
- Set Interval to 900000 (900,000 milliseconds = 15 minutes)
- Set OnTimer event to call `btnGetGoldPricesClick`

---

## Queries for Reporting

### Get Latest Price
```sql
SELECT TOP 1 
    PricePerOunce, 
    FetchDateTime 
FROM GoldPriceHistory 
ORDER BY FetchDateTime DESC
```

### Get Daily Average
```sql
SELECT 
    CAST(FetchDateTime AS DATE) AS PriceDate,
    AVG(PricePerOunce) AS DailyAverage
FROM GoldPriceHistory
WHERE FetchDateTime >= DATEADD(day, -30, CURRENT DATE)
GROUP BY CAST(FetchDateTime AS DATE)
ORDER BY PriceDate DESC
```

### Get Price Trend (Last 7 Days)
```sql
SELECT 
    CAST(FetchDateTime AS DATE) AS PriceDate,
    MIN(PricePerOunce) AS Low,
    MAX(PricePerOunce) AS High,
    AVG(PricePerOunce) AS Average
FROM GoldPriceHistory
WHERE FetchDateTime >= DATEADD(day, -7, CURRENT DATE)
GROUP BY CAST(FetchDateTime AS DATE)
ORDER BY PriceDate DESC
```

---

## Files Modified/Created
- ✅ **GoldPriceHistory.sql** - New table schema (created)
- 🔄 **PawnDM.pas** - Add qryGoldPriceHistory query component (needs update)
- 🔄 **PawnMain.pas** - Update btnGetGoldPricesClick to save prices (needs update)
