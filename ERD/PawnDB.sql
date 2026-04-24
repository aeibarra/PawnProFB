--
-- This script file reloads a database that was unloaded using "dbunload".
--
-- (Version:  12.0.1.3942)
--


-- Database file: F:\Projects\Pawn\DB\OkJewelry_New\Pawn.db
-- Database CHAR collation: 1252LATIN1, NCHAR collation: UCA
-- Connection Character Set: windows-1252
--
-- CREATE DATABASE command: CREATE DATABASE 'F:\\Projects\\Pawn\\DB\\OkJewelry_New\\Pawn.db' LOG ON 'F:\\Projects\\Pawn\\DB\\OkJewelry_New\\Pawn.log' PAGE SIZE 8192 COLLATION '1252LATIN1(CaseSensitivity=Ignore)' NCHAR COLLATION 'UCA(CaseSensitivity=Ignore;AccentSensitivity=Ignore;PunctuationSensitivity=Primary)' BLANK PADDING ON JCONNECT ON CHECKSUM ON
--


SET OPTION date_order          = 'YMD'
go

SET OPTION PUBLIC.preserve_source_format = 'OFF'
go

SET TEMPORARY OPTION tsql_outer_joins = 'ON'
go

SET TEMPORARY OPTION st_geometry_describe_type = 'binary'
go

SET TEMPORARY OPTION st_geometry_on_invalid = 'Ignore'
go

SET OPTION PUBLIC.reserved_keywords = ''
go


-------------------------------------------------
--   Create dbspaces
-------------------------------------------------


-------------------------------------------------
--   Create login policies
-------------------------------------------------


-------------------------------------------------
--   Create users
-------------------------------------------------

GRANT CONNECT,DBA,RESOURCE TO "DBA" IDENTIFIED BY sql
go

GRANT CONNECT,DBA,GROUP,RESOURCE TO "dbo"
go


-------------------------------------------------
--   Create user types
-------------------------------------------------


-------------------------------------------------
--   Create spatial units of measure
-------------------------------------------------

CREATE  SPATIAL UNIT OF MEASURE IF NOT EXISTS  "degree"
	TYPE ANGULAR
	CONVERT USING .017453292519943
go

CREATE  SPATIAL UNIT OF MEASURE IF NOT EXISTS  "meter"
	TYPE LINEAR
	CONVERT USING 1
go

CREATE  SPATIAL UNIT OF MEASURE IF NOT EXISTS  "planar degree"
	TYPE LINEAR
	CONVERT USING 111120
go


-------------------------------------------------
--   Create spatial reference systems
-------------------------------------------------

CREATE  SPATIAL REFERENCE SYSTEM IF NOT EXISTS  "Default"
	IDENTIFIED BY 0
	ORGANIZATION 'Sybase' IDENTIFIED BY 0
	LINEAR UNIT OF MEASURE "metre"
	TYPE PLANAR
	SNAP TO GRID .000001
	TOLERANCE .000001
	AXIS ORDER 'x/y/z/m'
	POLYGON FORMAT 'EvenOdd'
	COORDINATE X BETWEEN -1000000 AND 1000000
	COORDINATE Y BETWEEN -1000000 AND 1000000
go

CREATE  SPATIAL REFERENCE SYSTEM IF NOT EXISTS  "sa_octahedral_gnomonic"
	IDENTIFIED BY 2147483647
	ORGANIZATION 'Sybase' IDENTIFIED BY 2147483647
	LINEAR UNIT OF MEASURE "metre"
	TYPE PLANAR
	SNAP TO GRID .000000000001
	TOLERANCE .000000000001
	AXIS ORDER 'x/y/z/m'
	POLYGON FORMAT 'EvenOdd'
	COORDINATE X BETWEEN 0 AND 1
	COORDINATE Y BETWEEN -1 AND 1
go

CREATE  SPATIAL REFERENCE SYSTEM IF NOT EXISTS  "sa_planar_unbounded"
	IDENTIFIED BY 2147483646
	ORGANIZATION 'Sybase' IDENTIFIED BY 2147483646
	LINEAR UNIT OF MEASURE "metre"
	TYPE PLANAR
	SNAP TO GRID 0
	TOLERANCE 0
	AXIS ORDER 'x/y/z/m'
	POLYGON FORMAT 'EvenOdd'
	COORDINATE X BETWEEN -1.79769313E308 AND 1.79769313E308
	COORDINATE Y BETWEEN -1.79769313E308 AND 1.79769313E308
go

CREATE  SPATIAL REFERENCE SYSTEM IF NOT EXISTS  "WGS 84"
	IDENTIFIED BY 4326
	ORGANIZATION 'EPSG' IDENTIFIED BY 4326
	LINEAR UNIT OF MEASURE "metre"
	ANGULAR UNIT OF MEASURE "degree"
	TYPE ROUND EARTH
	SNAP TO GRID 0
	TOLERANCE 0
	ELLIPSOID SEMI MAJOR AXIS 6378137 INVERSE FLATTENING 298.257223563
	AXIS ORDER 'long/lat/z/m'
	POLYGON FORMAT 'EvenOdd'
	COORDINATE LATITUDE BETWEEN -90 AND 90
	COORDINATE LONGITUDE BETWEEN -180 AND 180
	DEFINITION 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]]'
	TRANSFORM DEFINITION '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
go

CREATE  SPATIAL REFERENCE SYSTEM IF NOT EXISTS  "WGS 84 (planar)"
	IDENTIFIED BY 1000004326
	ORGANIZATION 'EPSG' IDENTIFIED BY 4326
	LINEAR UNIT OF MEASURE "planar degree"
	ANGULAR UNIT OF MEASURE "degree"
	TYPE PLANAR
	SNAP TO GRID .000000001
	TOLERANCE .000000001
	ELLIPSOID SEMI MAJOR AXIS 6378137 INVERSE FLATTENING 298.257223563
	AXIS ORDER 'long/lat/z/m'
	POLYGON FORMAT 'EvenOdd'
	COORDINATE LATITUDE BETWEEN -90 AND 90
	COORDINATE LONGITUDE BETWEEN -180 AND 180
	DEFINITION 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]]'
	TRANSFORM DEFINITION '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
go


-------------------------------------------------
--   Create group memberships
-------------------------------------------------


-------------------------------------------------
--   Create remote servers
-------------------------------------------------


-------------------------------------------------
--   Create dbspace permissions
-------------------------------------------------

begin
    for dbspaces as dbcurs cursor for 
	select privilege_type, dbspace_name, user_name 
		from SYS.SYSDBSPACEPERM p 
		join SYS.SYSDBSPACE d on p.dbspace_id = d.dbspace_id
		join SYS.SYSUSER u on u.user_id = p.grantee
    do
	execute immediate 'revoke ' + if privilege_type = 1 then 'CREATE' else 'UNKNOWN' endif + ' on "' + dbspace_name + '" from "' + user_name + '"'
    end for;
end

go

grant CREATE on "system" to "PUBLIC"
go

grant CREATE on "temporary" to "PUBLIC"
go


-------------------------------------------------
--   Create external environments
-------------------------------------------------

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'java' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "java"
        LOCATION '' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'perl' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "perl"
        LOCATION 'perl' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'clr' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "clr"
        LOCATION 'dbextclr[VER_MAJOR]' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'php' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "php"
        LOCATION 'php' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'c_esql32' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "c_esql32"
        LOCATION 'bin32[SLASH]dbexternc[VER_MAJOR]' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'c_odbc32' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "c_odbc32"
        LOCATION 'bin32[SLASH]dbexternc[VER_MAJOR]' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'c_esql64' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "c_esql64"
        LOCATION 'bin64[SLASH]dbexternc[VER_MAJOR]' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'c_odbc64' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "c_odbc64"
        LOCATION 'bin64[SLASH]dbexternc[VER_MAJOR]' 
END IF 
go

IF EXISTS( SELECT * FROM SYS.SYSEXTERNENV WHERE name = 'dbmlsync' ) THEN 
    ALTER EXTERNAL ENVIRONMENT "dbmlsync"
        LOCATION '' 
END IF 
go


-------------------------------------------------
--   Create external environment objects
-------------------------------------------------

create temporary procedure sa_unload_display_table_status( 
    msgid int, ord int, numtabs int, user_name char(128), table_name char(128) )
begin 
  declare @fullmsg long varchar; 
  set @fullmsg = lang_message( msgid ) ||
      ' (' || ord || '/' || numtabs || ') ' ||
      '"' || user_name || '"."' || table_name || '"'; 
  message @fullmsg type info to client; 
end
go


-------------------------------------------------
--   Create sequences
-------------------------------------------------


-------------------------------------------------
--   Create tables
-------------------------------------------------

CREATE TABLE "DBA"."States" (
    "State_Abbr"                     varchar(2) NULL
   ,"State_Name"                     varchar(30) NULL
)
go

CREATE TABLE "DBA"."Store" (
    "StoreNo"                        varchar(10) NULL
   ,"StoreName"                      varchar(55) NULL
   ,"StoreAddr"                      varchar(55) NULL
   ,"StoreCityStZIP"                 varchar(55) NULL
   ,"StorePhone"                     varchar(14) NULL
   ,"StorePoliceID"                  varchar(30) NULL
   ,"StoreAdjTopMarg"                integer NULL
   ,"StoreNumber"                    varchar(30) NULL
   ,"StoreAdjDetailHeight"           integer NULL DEFAULT 0
   ,"StoreAdjFooterHeight"           integer NULL DEFAULT 0
   ,"InterestCalcMethod"             integer NULL DEFAULT 1
   ,"PoliceReportToPrint"            integer NULL DEFAULT 1
   ,"PoliceReportLaserCopies"        integer NULL DEFAULT 3
   ,"DefaultMaturityMonths"          integer NULL DEFAULT 1
   ,"PawnDefaultMonths"              integer NULL DEFAULT 2
   ,"LeadsStoreId"                   varchar(20) NULL
   ,"LeadsOnlineFTPAddress"          varchar(50) NULL
   ,"LeadsOnlineUserName"            varchar(50) NULL
   ,"LeadsOnlinePassword"            varchar(50) NULL
   ,"FTPPassive"                     bit NOT NULL DEFAULT 1
   ,"PawnDateCalculationBase"        char(1) NULL DEFAULT 'D'
   ,"DefaultWeightMeasureUnit"       char(1) NULL
)
go

CREATE TABLE "DBA"."Stations" (
    "StationNo"                      integer NOT NULL DEFAULT autoincrement
   ,"StationGUID"                    char(37) NOT NULL
   ,"StationName"                    char(20) NOT NULL
   ,"StationConnected"               char(1) NOT NULL DEFAULT 'N'
   ,"Created"                        "datetime" NOT NULL DEFAULT current timestamp
   ,"ConnStart"                      "datetime" NULL DEFAULT current timestamp
   ,"ConnThru"                       "datetime" NULL
   ,PRIMARY KEY ("StationNo" ASC) 
)
go

ALTER TABLE "DBA"."Stations"
    ADD UNIQUE ( "StationGUID" )
go

CREATE TABLE "DBA"."SEQTable" (
    "StationSEQ"                     unsigned bigint NOT NULL DEFAULT 0
   ,PRIMARY KEY ("StationSEQ" ASC) 
)
go

CREATE TABLE "DBA"."Customer" (
    "Custno"                         integer NOT NULL DEFAULT autoincrement
   ,"CustTicketNo"                   varchar(15) NULL
   ,"CustLast"                       varchar(35) NULL
   ,"CustFirst"                      varchar(35) NULL
   ,"CustMid"                        varchar(1) NULL
   ,"CustDOB"                        date NULL
   ,"CustGender"                     varchar(1) NULL
   ,"CustRace"                       varchar(1) NULL
   ,"CustHair"                       varchar(5) NULL
   ,"CustEyes"                       varchar(5) NULL
   ,"CustMark"                       varchar(10) NULL
   ,"CustWeight"                     double NULL
   ,"CustHeight"                     varchar(8) NULL
   ,"CustAddr"                       varchar(55) NULL
   ,"CustApt"                        varchar(5) NULL
   ,"CustCity"                       varchar(40) NULL
   ,"CustState"                      varchar(2) NULL
   ,"CustZip"                        varchar(11) NULL
   ,"CustPlaceEmply"                 varchar(30) NULL
   ,"CustFlDrvLic"                   varchar(20) NULL
   ,"CustID"                         varchar(25) NULL
   ,"CustIDType"                     varchar(20) NULL
   ,"CustIDAgencyState"              varchar(10) NULL
   ,"CustPhHome"                     varchar(14) NULL
   ,"CustPhBussiness"                varchar(14) NULL
   ,"CustPhBeep"                     varchar(14) NULL
   ,"CustPhCell"                     varchar(14) NULL
   ,"CustComment"                    long varchar NULL
   ,"StationID"                      integer NULL
   ,"StationSEQ"                     integer NULL
   ,PRIMARY KEY ("Custno" ASC) 
)
go

CREATE TABLE "DBA"."Payments" (
    "PaymentNo"                      integer NOT NULL DEFAULT autoincrement
   ,"TransactionNo"                  integer NULL
   ,"PayDate"                        date NULL
   ,"PayAmount"                      double NULL
   ,"PayComment"                     long varchar NULL
   ,"PayMethod"                      smallint NULL DEFAULT 1
   ,"PayInterest"                    double NULL
   ,"PayPrincipal"                   double NULL
   ,"PrincBalance"                   double NULL
   ,"InsterestBalance"               double NULL
   ,PRIMARY KEY ("PaymentNo" ASC) 
)
go

CREATE TABLE "DBA"."Transactions" (
    "TransactionNo"                  integer NOT NULL
   ,"CustNo"                         integer NULL
   ,"TranDate"                       timestamp NULL DEFAULT current date
   ,"TranTicketNo"                   varchar(30) NULL
   ,"TranComment"                    long varchar NULL
   ,"TranMaturity"                   date NULL
   ,"TranType"                       char(1) NULL DEFAULT 'P'
   ,"TranStatus"                     char(1) NULL DEFAULT 'A'
   ,"TranVoidDate"                   "datetime" NULL
   ,"TranPawnAmount"                 double NULL
   ,"TranInterest"                   double NULL
   ,"PrincBalance"                   double NULL
   ,"InsterestBalance"               double NULL
   ,"TranTime"                       time NULL DEFAULT current time
   ,"TranCloseReason"                smallint NOT NULL DEFAULT 0
   ,PRIMARY KEY ("TransactionNo" ASC) 
)
go

COMMENT ON COLUMN "DBA"."Transactions"."TranStatus" IS 
	'A-Active
V-Void'
go

COMMENT ON COLUMN "DBA"."Transactions"."TranCloseReason" IS 
	'0-Open 1-Void 2-Redeemed 3-Defaulted 4-Mix Defaulted/Redeemed'
go

CREATE TABLE "DBA"."InvCategories" (
    "InvCatNo"                       integer NOT NULL DEFAULT autoincrement
   ,"InvCategory"                    varchar(40) NOT NULL
   ,PRIMARY KEY ("InvCatNo" ASC) 
)
go

CREATE TABLE "DBA"."InventoryItems" (
    "InvItemNo"                      integer NOT NULL
   ,"InvItemBarcode"                 varchar(30) NULL
   ,"InvCatNo"                       integer NOT NULL
   ,"JType"                          char(1) NULL
   ,"JStyle"                         char(1) NULL
   ,"JMetal"                         char(1) NULL
   ,"InvItemCount"                   integer NULL
   ,"Note"                           varchar(80) NULL
   ,"SizeLength"                     double NULL
   ,"Weight"                         double NULL
   ,"KT"                             double NULL
   ,"Created"                        "datetime" NULL DEFAULT current timestamp
   ,"UnitCost"                       "money" NULL
   ,"UnitPrice"                      "money" NULL
   ,"InvItemStatus"                  char(1) NULL DEFAULT 'S'
   ,"TransactionNo"                  integer NULL
   ,"InvOriginalItemNo"              integer NULL
   ,"InvItemBrand"                   varchar(30) NULL
   ,"SerialNumber"                   varchar(40) NULL
   ,"OwnerAppNumber"                 varchar(40) NULL
   ,"ModelNumber"                    varchar(40) NULL
   ,"Gender"                         char(1) NULL
   ,"Description"                    varchar(120) NULL
   ,"WeightUnit"                     char(1) NULL
   ,"PawnedDate"                     date NULL
   ,"PurchaseDate"                   date NULL
   ,"RedeemedDate"                   date NULL
   ,"DefaultedDate"                  date NULL
   ,"MeltedDate"                     date NULL
   ,"ForSaleDate"                    date NULL
   ,"SoldDate"                       date NULL
   ,PRIMARY KEY ("InvItemNo" ASC) 
)
go

ALTER TABLE "DBA"."InventoryItems"
    ADD UNIQUE ( "InvItemNo" )
go

CREATE TABLE "DBA"."JTypes" (
    "JType"                          char(1) NOT NULL
   ,"JTypeDesc"                      varchar(30) NOT NULL
   ,PRIMARY KEY ("JType" ASC) 
)
go

CREATE TABLE "DBA"."JMetals" (
    "JMetal"                         char(1) NOT NULL
   ,"JMetalDesc"                     varchar(30) NOT NULL
   ,PRIMARY KEY ("JMetal" ASC) 
)
go

CREATE TABLE "DBA"."JGenders" (
    "JGender"                        char(1) NOT NULL
   ,"JGenderDesc"                    varchar(30) NOT NULL
   ,PRIMARY KEY ("JGender" ASC) 
)
go

CREATE TABLE "DBA"."JStyles" (
    "JStyle"                         char(1) NOT NULL
   ,"JStyleDesc"                     varchar(30) NOT NULL
   ,PRIMARY KEY ("JStyle" ASC) 
)
go

CREATE TABLE "DBA"."JStoneShapes" (
    "JShape"                         char(1) NOT NULL
   ,"JShapeDesc"                     varchar(30) NOT NULL
   ,PRIMARY KEY ("JShape" ASC) 
)
go

CREATE TABLE "DBA"."JStoneColors" (
    "JStoneColor"                    char(1) NOT NULL
   ,"JStoneDesc"                     varchar(30) NOT NULL
   ,PRIMARY KEY ("JStoneColor" ASC) 
)
go

CREATE TABLE "DBA"."ItemStatus" (
    "Status"                         char(1) NOT NULL
   ,"StatusDesc"                     varchar(30) NOT NULL
   ,PRIMARY KEY ("Status" ASC) 
)
go

CREATE TABLE "DBA"."SalesItems" (
    "SalesItemNo"                    integer NOT NULL DEFAULT autoincrement
   ,"InvItemNo"                      integer NOT NULL
   ,"SalesItemDesc"                  varchar(30) NOT NULL
   ,"CatNo"                          integer NULL
   ,"JType"                          char(1) NULL
   ,"JStyle"                         char(1) NULL
   ,"JMetal"                         char(1) NULL
   ,"JShape"                         char(1) NULL
   ,"JStoneColor"                    char(1) NULL
   ,"SalesItemCount"                 integer NULL
   ,"Amount"                         double NULL
   ,PRIMARY KEY ("SalesItemNo" ASC) 
)
go

CREATE TABLE "DBA"."Stones" (
    "StoneNo"                        integer NOT NULL DEFAULT autoincrement
   ,"InvItemNo"                      integer NULL
   ,"StoneNumber"                    integer NULL
   ,"StoneShape"                     char(1) NULL
   ,"StoneColor"                     char(1) NULL
   ,"CT"                             double NULL
   ,"WT"                             double NULL
   ,"StoneType"                      varchar(30) NULL
   ,"StoneWeightUnit"                char(1) NULL
   ,PRIMARY KEY ("StoneNo" ASC) 
)
go

CREATE TABLE "DBA"."TableKeys" (
    "TableName"                      char(15) NOT NULL
   ,"LastKey"                        integer NOT NULL DEFAULT 0
   ,PRIMARY KEY ("TableName" ASC) 
)
go

CREATE TABLE "DBA"."TransactionTypes" (
    "TranType"                       char(1) NOT NULL
   ,"TranTypeDesc"                   varchar(20) NOT NULL
   ,PRIMARY KEY ("TranType" ASC) 
)
go

CREATE TABLE "DBA"."PaymentTypes" (
    "PayTypeNo"                      integer NOT NULL
   ,"PaymentType"                    varchar(20) NOT NULL
   ,"PaymentMask"                    varchar(25) NOT NULL
   ,"IsCreditCard"                   varchar(1) NULL
)
go

CREATE TABLE "DBA"."BackupHistory" (
    "BckId"                          integer NOT NULL DEFAULT autoincrement
   ,"BckDate"                        "datetime" NOT NULL
   ,"BckPath"                        varchar(120) NOT NULL
   ,PRIMARY KEY ("BckId" ASC) 
)
go

CREATE TABLE "DBA"."BackupSettings" (
    "BackupPath"                     varchar(255) NOT NULL
   ,"AutoBackupWhenCloseApp"         bit NOT NULL DEFAULT 0
   ,CONSTRAINT "ID" PRIMARY KEY ("BackupPath" ASC) 
)
go

CREATE TABLE "DBA"."ExportFormat" (
    "ID"                             integer NOT NULL DEFAULT autoincrement
   ,"DataFieldName"                  varchar(50) NOT NULL
   ,"DataFieldType"                  smallint NOT NULL
   ,"DataFieldMaxSize"               integer NOT NULL
   ,"DataFieldCaption"               varchar(50) NOT NULL
   ,"DataFieldDesc"                  varchar(200) NULL
   ,PRIMARY KEY ("ID" ASC) 
)
go

CREATE TABLE "DBA"."ExportFileLog" (
    "ExportLogID"                    integer NOT NULL DEFAULT autoincrement
   ,"ExportDate"                     "datetime" NOT NULL
   ,"FileName"                       varchar(50) NOT NULL
   ,"ItemCount"                      integer NOT NULL DEFAULT 0
   ,PRIMARY KEY ("ExportLogID" ASC) 
)
go

CREATE TABLE "DBA"."ExportLogFileDetail" (
    "ID"                             integer NOT NULL DEFAULT autoincrement
   ,"ExportLogID"                    integer NOT NULL
   ,"TransactionNo"                  integer NOT NULL
   ,"ExportLine"                     long varchar NULL
   ,"InvItemNo"                      integer NULL
   ,"ItemSeq"                        integer NULL
   ,PRIMARY KEY ("ID" ASC) 
)
go

CREATE TABLE "DBA"."ImagesTypes" (
    "ImageTypeNo"                    unsigned int NOT NULL DEFAULT autoincrement
   ,"ImageType"                      integer NOT NULL
   ,"ImageTypeDesc"                  varchar(80) NULL
   ,PRIMARY KEY ("ImageTypeNo" ASC) 
)
go

CREATE TABLE "DBA"."ImagesData" (
    "ImagesDataNo"                   integer NOT NULL DEFAULT autoincrement
   ,"ImageTypeNo"                    integer NOT NULL
   ,"ImagRefToRowNo"                 integer NOT NULL
   ,"ImageDesc"                      varchar(125) NULL
   ,"ImageData"                      "image" NOT NULL
   ,"Created"                        "datetime" NOT NULL DEFAULT current timestamp
   ,"UploadTime"                     "datetime" NULL
   ,"UploadFileName"                 varchar(50) NULL
   ,PRIMARY KEY ("ImagesDataNo" ASC) 
)
go

commit work
go


-------------------------------------------------
--   Create text configurations
-------------------------------------------------


-------------------------------------------------
--   Create foreign keys
-------------------------------------------------

ALTER TABLE "DBA"."Payments"
    ADD FOREIGN KEY "Transactions" ("TransactionNo" ASC)
    REFERENCES "DBA"."Transactions" ("TransactionNo")
    ON DELETE CASCADE 
go

ALTER TABLE "DBA"."Transactions"
    ADD FOREIGN KEY "Customer" ("CustNo" ASC)
    REFERENCES "DBA"."Customer" ("Custno")
    ON DELETE CASCADE 
go

ALTER TABLE "DBA"."InventoryItems"
    ADD FOREIGN KEY "Transactions" ("TransactionNo" ASC)
    REFERENCES "DBA"."Transactions" ("TransactionNo")
    ON DELETE CASCADE 
go

ALTER TABLE "DBA"."Stones"
    ADD FOREIGN KEY "InventoryItems" ("InvItemNo" ASC)
    REFERENCES "DBA"."InventoryItems" ("InvItemNo")
    ON DELETE CASCADE 
go

commit work
go



-------------------------------------------------
--   Create materialized views
-------------------------------------------------

commit
go



-------------------------------------------------
--   Create indexes
-------------------------------------------------

call sa_unload_display_table_status( 17738, 1, 28, 'DBA', 'States' )
go

CREATE UNIQUE INDEX "States0" ON "DBA"."States"
    ( "State_Abbr" )
go

call sa_unload_display_table_status( 17738, 2, 28, 'DBA', 'Store' )
go

CREATE UNIQUE INDEX "Store0" ON "DBA"."Store"
    ( "StoreNo" )
go

call sa_unload_display_table_status( 17738, 3, 28, 'DBA', 'Stations' )
go

CREATE INDEX "idx_Stations" ON "DBA"."Stations"
    ( "StationGUID","StationName" )
go

call sa_unload_display_table_status( 17738, 4, 28, 'DBA', 'SEQTable' )
go

call sa_unload_display_table_status( 17738, 5, 28, 'DBA', 'Customer' )
go

CREATE INDEX "idxFullName" ON "DBA"."Customer"
    ( "CustLast","CustFirst" )
go

CREATE INDEX "idxFirstLast" ON "DBA"."Customer"
    ( "CustFirst","CustLast" )
go

call sa_unload_display_table_status( 17738, 6, 28, 'DBA', 'Payments' )
go

CREATE UNIQUE INDEX "Payments0" ON "DBA"."Payments"
    ( "PaymentNo" )
go

CREATE INDEX "TransactionNo" ON "DBA"."Payments"
    ( "TransactionNo" )
go

call sa_unload_display_table_status( 17738, 7, 28, 'DBA', 'Transactions' )
go

CREATE UNIQUE INDEX "Transactions0" ON "DBA"."Transactions"
    ( "TransactionNo" )
go

CREATE INDEX "CustNo" ON "DBA"."Transactions"
    ( "CustNo" )
go

CREATE INDEX "idx_ShowTranInPawn" ON "DBA"."Transactions"
    ( "CustNo","TranDate" DESC,"TranTicketNo" DESC )
go

call sa_unload_display_table_status( 17738, 8, 28, 'DBA', 'InvCategories' )
go

call sa_unload_display_table_status( 17738, 9, 28, 'DBA', 'InventoryItems' )
go

CREATE INDEX "idx_Inv_TransactionNo" ON "DBA"."InventoryItems"
    ( "TransactionNo" )
go

CREATE INDEX "idx_Barcode" ON "DBA"."InventoryItems"
    ( "InvItemBarcode" )
go

CREATE INDEX "idx_InvBrands" ON "DBA"."InventoryItems"
    ( "InvItemBrand" )
go

call sa_unload_display_table_status( 17738, 10, 28, 'DBA', 'JTypes' )
go

call sa_unload_display_table_status( 17738, 11, 28, 'DBA', 'JMetals' )
go

call sa_unload_display_table_status( 17738, 12, 28, 'DBA', 'JGenders' )
go

call sa_unload_display_table_status( 17738, 13, 28, 'DBA', 'JStyles' )
go

call sa_unload_display_table_status( 17738, 14, 28, 'DBA', 'JStoneShapes' )
go

call sa_unload_display_table_status( 17738, 15, 28, 'DBA', 'JStoneColors' )
go

call sa_unload_display_table_status( 17738, 16, 28, 'DBA', 'ItemStatus' )
go

call sa_unload_display_table_status( 17738, 17, 28, 'DBA', 'SalesItems' )
go

call sa_unload_display_table_status( 17738, 18, 28, 'DBA', 'Stones' )
go

CREATE INDEX "idx_StoneTypes" ON "DBA"."Stones"
    ( "StoneType" )
go

CREATE INDEX "idx_StonesItemNo" ON "DBA"."Stones"
    ( "InvItemNo" )
go

call sa_unload_display_table_status( 17738, 19, 28, 'DBA', 'TableKeys' )
go

call sa_unload_display_table_status( 17738, 20, 28, 'DBA', 'TransactionTypes' )
go

call sa_unload_display_table_status( 17738, 21, 28, 'DBA', 'PaymentTypes' )
go

CREATE UNIQUE INDEX "PaymentTypes UNIQUE _PayTypeNo_" ON "DBA"."PaymentTypes"
    ( "PayTypeNo" )
go

call sa_unload_display_table_status( 17738, 22, 28, 'DBA', 'BackupHistory' )
go

call sa_unload_display_table_status( 17738, 23, 28, 'DBA', 'BackupSettings' )
go

call sa_unload_display_table_status( 17738, 24, 28, 'DBA', 'ExportFormat' )
go

call sa_unload_display_table_status( 17738, 25, 28, 'DBA', 'ExportFileLog' )
go

call sa_unload_display_table_status( 17738, 26, 28, 'DBA', 'ExportLogFileDetail' )
go

call sa_unload_display_table_status( 17738, 27, 28, 'DBA', 'ImagesTypes' )
go

call sa_unload_display_table_status( 17738, 28, 28, 'DBA', 'ImagesData' )
go

commit work
go


-------------------------------------------------
--   Create immediate materialized views
-------------------------------------------------

commit
go



-------------------------------------------------
--   Create functions
-------------------------------------------------

commit
go


create function dba.fn_NextSEQ() /* parameters,... */
returns integer
begin
  declare V_Result unsigned bigint;
  set V_Result = (select top 1 StationSEQ from SEQTable)+1;
  update SEQTable set StationSEQ = V_Result;
  return(V_Result)
end
go

create function dba.fn_GetLastKey( in v_TblName char(20),in v_StationNo integer,in v_StationSEQ unsigned bigint ) 
returns integer
begin
  declare v_Result integer;
  set v_Result = 0;
  if UCase(v_TblName) = 'CUSTOMER' then
    set v_Result = (select MAX(Custno) from CUSTOMER
        where StationID = v_StationNo and StationSEQ = v_StationSEQ)
  end if;
  if UCase(v_TblName) = 'TRANSACTIONS' then
    set v_Result = (select MAX(TransactionNo) from TRANSACTIONS
        where StationID = v_StationNo and StationSEQ = v_StationSEQ)
  end if;
  if UCase(v_TblName) = 'PAYMENTS' then
    set v_Result = (select MAX(PaymentNo) from Payments
        where StationID = v_StationNo and StationSEQ = v_StationSEQ)
  end if;
  return(v_Result)
end
go

create function DBA.fn_GetNextKey( in PTableName char(15) ) 
returns integer
begin
  declare v_Result integer;
  update TableKeys set LastKey = LastKey+1 where TableName = PTableName;
  set v_Result = (select LastKey from TableKeys where TableName = PTableName);
  return(v_Result)
end
go

create function DBA.fn_TranWithLatePayment( @TransactionNo integer,@Mons integer= 1 ) 
returns bit as
begin
  declare @R integer
  declare @PawnDate date,@LastPayDay date,@CmpDate date
  select @PawnDate = TranDate from Transactions where TransactionNo = @TransactionNo
  select @LastPayDay = max(PayDate) from Payments where TransactionNo = @TransactionNo
  if @LastPayDay is null
    set @CmpDate = @PawnDate
  else set @CmpDate = @LastPayDay
  if abs(datediff(month,getdate(),@CmpDate)) > @Mons set @R = 1
  else set @R = 0
  return @R
end
go


-------------------------------------------------
--   Create views
-------------------------------------------------

commit
go


SET TEMPORARY OPTION force_view_creation='ON'
go

create view DBA.ViewCustItems
  as select distinct T1.CustNo,T2.InvCatNo,T2.Description,T2.Weight,T2.SizeLength,T2.JType,T2.JStyle,T2.JMetal
    from DBA.Transactions as T1,DBA.InventoryItems as T2
    where T1.TransactionNo = T2.TransactionNo
go

SET TEMPORARY OPTION force_view_creation='OFF'
go

call dbo.sa_recompile_views(1)
go


-------------------------------------------------
--   Create user messages
-------------------------------------------------


-------------------------------------------------
--   Create procedures
-------------------------------------------------

commit
go


create procedure DBA.sp_GetStationNo( @GUID char(37),@StationName char(20),@StationNo integer output ) as
begin
  select @StationNo = StationNo from Stations where StationGUID = @GUID
  if @StationNo is null
    begin
      insert into Stations( StationGUID,StationName ) values( @GUID,@StationName ) 
      select @StationNo = @@Identity
    end
end
go

create procedure DBA.sp_Connected( @StationNo integer,@Conn char(1) ) 
as
begin
  if Upper(@Conn) = 'Y'
    update Stations set StationConnected = Upper(@Conn),ConnStart = GetDate()
      where StationNo = @StationNo
  else
    update Stations set StationConnected = Upper(@Conn),ConnThru = GetDate()
      where StationNo = @StationNo
end
go

create procedure DBA.sps_CustItemsToCopy( @CustNo integer ) 
begin
  declare local temporary table InvItemList(
    InvItemNo integer null,) on commit delete rows;
  insert into InvItemList
    select(select Max(InvItemNo)
        from Transactions as T1 join InventoryItems as T2 on T1.TransactionNo = T2.TransactionNo
        where T1.CustNo = T01.CustNo
        and T2.InvCatNo = T01.InvCatNo and T2.Description = T01.Description and T2.Weight = T01.Weight
        and T2.SizeLength = T01.SizeLength and T2.JType = T01.JType and T2.JStyle = T01.JStyle and T2.JMetal = T01.JMetal) as InvItemNo
      from ViewCustItems as T01
      where T01.CustNo = @CustNo;
  select T1.InvItemNo,InvItemBarcode,T2.InvCatNo,T2.JType,T2.JStyle,T2.JMetal,InvItemCount,Note,SizeLength,Weight,KT,Created,
    UnitCost,UnitPrice,InvItemStatus,TransactionNo,InvOriginalItemNo,InvItemBrand,OwnerAppNumber,ModelNumber,SerialNumber,
    Gender,Description,T3.InvCategory,JStyleDesc,JTypeDesc,JMetalDesc
    from InvItemList as T1
      join InventoryItems as T2 on T1.InvItemNo = T2.InvItemNo
      left outer join InvCategories as T3 on T3.InvCatNo = T2.InvCatNo
      left outer join JStyles as T4 on T4.JStyle = T2.JStyle
      left outer join JTypes as T5 on T5.JType = T2.JType
      left outer join JMetals as T6 on T6.JMetal = T2.JMetal
end
go

create procedure DBA.spu_CalcUnitCostFromWeight( @TransactionNo integer ) 
as
begin
  declare @TotalWeight double,@TotalAmount double,@DollarPerWeight double
  select @TotalWeight = SUM(Weight)
    from InventoryItems
    where TransactionNo = @TransactionNo
  select @TotalAmount = TranPawnamount
    from Transactions
    where TransactionNo = @TransactionNo
  select @DollarPerWeight = (@TotalAmount/@TotalWeight)
  update InventoryItems set UnitCost = (@DollarPerWeight*Weight)
    where TransactionNo = @TransactionNo
end
go

create procedure DBA.CreateExportLog( @FileName varchar(50),
  @ExportLogID integer output ) as
begin
  insert into ExportFileLog( ExportDate,FileName ) values
    ( GetDate(),@FileName ) 
  set @ExportLogID = @@Identity
end
go

create procedure DBA.Rep_CustomerWithLatePayments( @Mons integer= 1 ) as begin
  create table #PawnTran(
    Custno integer null,
    TransactionNo integer null,
    LatePayment integer null,)
  insert into #PawnTran( Custno,TransactionNo,LatePayment ) 
    select T1.Custno,T2.TransactionNo,DBA.fn_TranWithLatePayment(T2.TransactionNo,@Mons)
      from Customer as T1 join Transactions as T2 on T1.Custno = T2.CustNo
      where T2.TranType = 'P' and T2.TranStatus = 'A'
  select top 1000 T1.TransactionNo,T3.TranTicketNo,TranDate=convert(DateTime,T3.TranDate),
    LatePayment,T2.Custno,T2.CustLast,T2.CustFirst,T2.CustMid,
    T2.CustPhCell,T2.CustPhHome,T2.CustPhBussiness,T3.TranPawnAmount
    from #PawnTran as T1
      join Customer as T2 on T1.Custno = T2.Custno
      join Transactions as T3 on T1.TransactionNo = T3.TransactionNo
    where LatePayment = 1
    order by T2.CustFirst asc,T2.CustLast asc,T2.Custno asc
  drop table #PawnTran
end
go

begin 
  declare prev_count int;
  declare new_count int;
  declare local temporary table dependent_proc ( 
    proc_id    unsigned int    not null, 
    primary key (proc_id) 
  ) in system not transactional; 
  set prev_count = -1;
  lp: loop
      truncate table dependent_proc;
      insert into dependent_proc 
	select proc_id from SYS.SYSPROCEDURE p 
	where exists (select * from SYS.SYSPROCPARM pp 
	    where pp.proc_id = p.proc_id 
	    and parm_name = 'expression' 
	    and parm_type = 1 
	   and domain_id = 1); 
      select count(*) into new_count from dependent_proc;
      if new_count = 0 or (new_count >= prev_count and prev_count >= 0) then
        leave lp;
      end if;
      set prev_count = new_count;
      for l1 as c1 cursor for 
	select u.user_name, proc_name
	from SYS.SYSPROCEDURE p
	    join dependent_proc d on (d.proc_id = p.proc_id)
	    join SYS.SYSUSER u on (p.creator = u.user_id)
      do
        begin
	   execute immediate with quotes on
            'alter procedure "' || user_name || '"."' || proc_name || '" recompile';
          exception when others then
        end
      end for;
  end loop;
end

go

call dbo.sa_recompile_views(0)
go


-------------------------------------------------
--   Create triggers
-------------------------------------------------

commit
go



-------------------------------------------------
--   Create SQL Remote definitions
-------------------------------------------------


-------------------------------------------------
--   Create MobiLink definitions
-------------------------------------------------


-------------------------------------------------
--   Create Synchronization profiles
-------------------------------------------------


-------------------------------------------------
--   Create logins
-------------------------------------------------


-------------------------------------------------
--   Create events
-------------------------------------------------

commit
go



-------------------------------------------------
--   Create services
-------------------------------------------------

commit
go



-------------------------------------------------
--   Create mirror options and servers
-------------------------------------------------


-------------------------------------------------
--   Set DBA password
-------------------------------------------------

GRANT CONNECT TO DBA IDENTIFIED BY ENCRYPTED '\xb3\x4e\xe7\x30\xdc\x58\x04\x99\x28\x19\x2b\x8a\x48\x42\x2b\x75\x34\xbf\x00\x60\x64\x89\x2a\x52\x4d\x00\xbd\x18\x17\x25\xa0\x16\xcb\xcf\x5c\x1a'
go


-------------------------------------------------
--   Create options
-------------------------------------------------

SET OPTION date_order =
go

SET OPTION PUBLIC.preserve_source_format =
go

SET OPTION "PUBLIC"."global_database_id"='0'
go

SET OPTION "PUBLIC"."optimization_goal"='First-row'
go

SET OPTION "PUBLIC"."prefetch"='On'
go

SET OPTION "PUBLIC"."preserve_source_format"='OFF'
go

SET OPTION "PUBLIC"."prevent_article_pkey_update"='Off'
go
