/* ============================================================
   Pre-cutover survey -- READ ONLY, changes nothing.

   Run against the LIVE store database before switching it from
   the CSV/FTP export to the LeadsOnline web service.

     isql -i PreCutover_Survey.sql -user sysdba -password <pw>
          -ch UTF8 127.0.0.1/3050:C:\path\to\PAWNDATA.FDB

   Capture the output as <Store>_BASELINE_<date>.txt beside this
   script, so the same store can be diffed against it later with
   Week1_Review.sql.

   Uses only tables that exist BEFORE the new EXE runs its
   migrations, so it is safe on a store still on the old build.
   ============================================================ */
SET LIST ON;

/* -- 1. Who is this, and what store number do they report under? ----
   The LEADS_STORE_ID is the value to quote to Russell and the value
   the web service will send as LoginInfo.storeId.                  */
SELECT STORE_NAME, STORE_ADDR, STORE_CITY_ST_ZIP, STORE_PHONE,
       STORE_POLICE_ID,
       LEADS_STORE_ID,
       LEADS_ONLINE_USER_NAME AS FTP_USER,
       LEADS_ONLINE_FTP_ADDRESS
  FROM STORE;

/* -- 2. Backups: where do they land, and are they automatic? -------
   If BACKUP_PATH is a folder on the system disk, the store is not
   recoverable from a disk failure no matter what else is in place. */
SELECT BACKUP_PATH, BACKUP_IMAGES_PATH, AUTO_BACKUP_WHEN_CLOSE_APP
  FROM BACKUP_SETTINGS;

SELECT COUNT(*) AS BACKUPS_LOGGED,
       MAX(BCK_DATE) AS LAST_BACKUP
  FROM BACKUP_HISTORY;

/* -- 3. Size of the job ------------------------------------------
   TOTAL_PU        = every pawn/purchase ever (what SOAP could send)
   NEVER_IN_A_CSV  = never appeared in any CSV export file, i.e. the
                     real backlog if "skip CSV-already-sent" is on.  */
SELECT COUNT(*) AS TOTAL_PU,
       SUM(IIF(NOT EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                            WHERE D.TRANSACTION_NO = T.TRANSACTION_NO), 1, 0))
         AS NEVER_IN_A_CSV,
       MIN(T.TRAN_DATE) AS OLDEST,
       MAX(T.TRAN_DATE) AS NEWEST
  FROM TRANSACTIONS T
 WHERE T.TRAN_TYPE IN ('P','U');

/* -- 4. The $0.00 problem ----------------------------------------
   Multi-item tickets where no item carries a UNIT_COST. The mapper
   can only substitute the loan amount on SINGLE-item tickets, so
   these would reach law enforcement showing $0.00 per item.
   With no correction path in v1, that is permanent.               */
SELECT COUNT(*) AS MULTI_ITEM_ZERO_AMOUNT
  FROM TRANSACTIONS T
 WHERE T.TRAN_TYPE IN ('P','U')
   AND (SELECT COUNT(*) FROM INVENTORY_ITEMS I
         WHERE I.TRANSACTION_NO = T.TRANSACTION_NO) > 1
   AND NOT EXISTS (SELECT 1 FROM INVENTORY_ITEMS I2
                    WHERE I2.TRANSACTION_NO = T.TRANSACTION_NO
                      AND COALESCE(I2.UNIT_COST, 0) > 0);

/* same, but only the ones that would actually be sent (never in a CSV) */
SELECT COUNT(*) AS ZERO_AMOUNT_AND_UNSENT
  FROM TRANSACTIONS T
 WHERE T.TRAN_TYPE IN ('P','U')
   AND NOT EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                    WHERE D.TRANSACTION_NO = T.TRANSACTION_NO)
   AND (SELECT COUNT(*) FROM INVENTORY_ITEMS I
         WHERE I.TRANSACTION_NO = T.TRANSACTION_NO) > 1
   AND NOT EXISTS (SELECT 1 FROM INVENTORY_ITEMS I2
                    WHERE I2.TRANSACTION_NO = T.TRANSACTION_NO
                      AND COALESCE(I2.UNIT_COST, 0) > 0);

/* -- 5. Customer data quality ------------------------------------
   Impossible dates of birth are omitted from the ticket rather than
   failing it, but the police record is then missing a DOB. Fixing
   them BEFORE the cutover is free; afterwards there is no resend.  */
SELECT COUNT(*) AS CUSTOMERS,
       SUM(IIF(C.CUST_DOB IS NULL, 1, 0))                       AS DOB_MISSING,
       SUM(IIF(C.CUST_DOB > CURRENT_DATE, 1, 0))                AS DOB_IN_FUTURE,
       SUM(IIF(C.CUST_DOB < DATEADD(-120 YEAR TO CURRENT_DATE), 1, 0))
                                                                AS DOB_TOO_OLD
  FROM CUSTOMER C;

/* -- 6. Images that would go with the tickets --------------------
   ITEM_PHOTOS  = photos hanging off items (IMAGE_TYPE_NO 2)
   ID_PHOTOS    = customer ID photos (IMAGE_TYPE_NO 1); only the
                  newest per customer is ever sent.               */
SELECT SUM(IIF(IM.IMAGE_TYPE_NO = 2, 1, 0)) AS ITEM_PHOTOS,
       SUM(IIF(IM.IMAGE_TYPE_NO = 1, 1, 0)) AS ID_PHOTOS
  FROM IMAGES_DATA IM;

/* -- 7. Stones the mapper would silently drop --------------------
   SQLTicketStones inner-joins the colour and shape lookups, so a
   stone with an unmatched value disappears from the ticket.
   Expect zero; anything else is worth fixing before cutover.      */
SELECT COUNT(*) AS STONES_THAT_WOULD_DROP
  FROM STONES S
 WHERE NOT EXISTS (SELECT 1 FROM J_STONE_COLORS C
                    WHERE C.J_STONE_COLOR = S.STONE_COLOR)
    OR NOT EXISTS (SELECT 1 FROM J_STONE_SHAPES H
                    WHERE H.J_SHAPE = S.STONE_SHAPE);
