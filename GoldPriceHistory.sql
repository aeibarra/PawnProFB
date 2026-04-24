-- =====================================================================
-- Gold Price History Table
-- Created: 2026-01-04
-- Purpose: Store gold price data fetched from CryptoCompare API
-- Fetch Interval: Every 15 minutes
-- =====================================================================

-- Drop existing table if needed (comment out if table exists)
-- DROP TABLE "DBA"."GoldPriceHistory"
-- go

-- Create the GoldPriceHistory table
CREATE TABLE "DBA"."GoldPriceHistory" (
    "PriceID"                       integer NOT NULL DEFAULT autoincrement
   ,"PricePerOunce"                 numeric(10, 2) NOT NULL
   ,"Currency"                      varchar(3) NOT NULL DEFAULT 'USD'
   ,"FetchDateTime"                 "datetime" NOT NULL DEFAULT current timestamp
   ,"Source"                        varchar(50) NOT NULL DEFAULT 'CryptoCompare'
   ,"APIResponse"                   long varchar NULL  -- Optional: store full API response for debugging
   ,PRIMARY KEY ("PriceID" ASC) 
)
go

-- Create an index on FetchDateTime for faster queries
CREATE INDEX "idx_GoldPrice_FetchDateTime" 
ON "DBA"."GoldPriceHistory" ( "FetchDateTime" DESC )
go


-- Grant permissions to DBA
GRANT SELECT, INSERT, UPDATE, DELETE ON "DBA"."GoldPriceHistory" TO "DBA"
go
CREATE PROCEDURE "DBA"."spi_GoldPrice"( @PricePerOunce numeric(10,2),@Currency varchar(3) ) 
as
begin
  declare @LastGPrice numeric(10,2)
  select top 1 @LastGPrice = PricePerOunce
    from GoldPriceHistory
    -- where 1= 0
    order by PriceID desc
  set @LastGPrice = isnull(@LastGPrice,0)
  if @LastGPrice <> @PricePerOunce
    insert into GoldPriceHistory( PricePerOunce,Currency,FetchDateTime,Source ) values( @PricePerOunce,@Currency,current timestamp,'CryptoCompare' ) 
  select LastGPrice=@LastGPrice
end
go

31.1034768 -- grams per ounce