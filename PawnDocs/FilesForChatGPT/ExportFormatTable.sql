-------------------------------------------------
--   Create tables
-------------------------------------------------

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

-------------------------------------------------
--   Reload data
-------------------------------------------------

call sa_unload_display_table_status( 17737, 1, 1, 'DBA', 'ExportFormat' )
go

LOAD TABLE "DBA"."ExportFormat" ("ID","DataFieldName","DataFieldType","DataFieldMaxSize","DataFieldCaption","DataFieldDesc")
    FROM '746.dat'
    FORMAT 'TEXT' QUOTES ON
    ORDER OFF ESCAPES ON
    CHECK CONSTRAINTS OFF COMPUTES OFF
    STRIP OFF DELIMITED BY ','
    ENCODING 'windows-1252'
go

commit work
go


-------------------------------------------------
--   Create indexes
-------------------------------------------------

call sa_unload_display_table_status( 17738, 1, 1, 'DBA', 'ExportFormat' )
go

commit work
go


-------------------------------------------------
--   Create triggers
-------------------------------------------------

commit
go

