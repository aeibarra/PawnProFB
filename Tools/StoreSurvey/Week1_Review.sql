/* ============================================================
   LeadsOnline SOAP -- post-cutover review.  READ ONLY.

   Run against a fresh copy of a store's live database after the
   SOAP channel has been in use for a while. Answers "did it
   actually work", which the pre-cutover survey cannot, because
   the SOAP tables are empty until the store starts sending.

     isql -i Week1_Review.sql -user sysdba -password <pw>
          -ch UTF8 127.0.0.1/3050:C:\path\to\PAWNDATA.FDB

   Requires DB schema version 10 or later (the tables below are
   created by Step6 / Step9 / Step10 of uDBMigrations).
   ============================================================ */
SET LIST ON;

/* -- 0. Confirm the store is on the expected build ---------------- */
SELECT
  (SELECT VALUE_INT  FROM APP_STATE WHERE STATE_KEY = 'DB_SCHEMA_VERSION') AS DB_VERSION,
  (SELECT VALUE_TEXT FROM APP_STATE WHERE STATE_KEY = 'APP_VERSION')       AS APP_VERSION
  FROM RDB$DATABASE;

/* -- 1. What has been submitted, and how did it land? -------------
   ERROR_CODE 0 = accepted. 6/13 = LeadsOnline already held the
   ticket (also success). 7 = outside their retention window, which
   is expected for old history and is not a fault. Anything else is
   worth reading the ERROR_RESPONSE for.                            */
SELECT COUNT(*)                                          AS SUBMISSIONS_LOGGED,
       SUM(IIF(ERROR_CODE = 0, 1, 0))                    AS ACCEPTED,
       SUM(IIF(ERROR_CODE IN (6, 13), 1, 0))             AS ALREADY_HELD,
       SUM(IIF(ERROR_CODE = 7, 1, 0))                    AS TOO_OLD,
       SUM(IIF(ERROR_CODE NOT IN (0, 6, 7, 13), 1, 0))   AS OTHER_ERRORS,
       MIN(SUBMITTED_AT)                                 AS FIRST_SUBMISSION,
       MAX(SUBMITTED_AT)                                 AS LAST_SUBMISSION
  FROM LEADS_SOAP_SUBMISSION;

/* Every failure that is not "too old", newest first -- the actual
   read-this list. Empty output here is the good outcome.           */
SELECT S.SUBMITTED_AT, S.TRANSACTION_NO, S.TICKET_NUMBER,
       S.ERROR_CODE, S.ERROR_RESPONSE
  FROM LEADS_SOAP_SUBMISSION S
 WHERE S.ERROR_CODE NOT IN (0, 6, 7, 13)
 ORDER BY S.SUBMITTED_AT DESC
 ROWS 25;

/* -- 2. Images ---------------------------------------------------
   A ticket is reported even when its photos fail, so image failures
   do not show up as failed submissions and have to be counted here. */
SELECT COUNT(*)                            AS IMAGE_ATTEMPTS,
       SUM(IIF(ERROR_CODE = 0, 1, 0))      AS UPLOADED,
       SUM(IIF(ERROR_CODE <> 0, 1, 0))     AS FAILED,
       SUM(IIF(IMAGE_CATEGORY = 'CustomerID', 1, 0)) AS CUSTOMER_IDS
  FROM LEADS_SOAP_IMAGE_SENT;

/* -- 3. Exclusions made by the store ------------------------------ */
SELECT COUNT(*)          AS EXCLUDED_TOTAL,
       MIN(EXCLUDED_AT)  AS FIRST_EXCLUSION,
       MAX(EXCLUDED_AT)  AS LAST_EXCLUSION
  FROM LEADS_SOAP_EXCLUDED;

/* Anything excluded that was NOT old history is worth a second look
   -- excluding a recent pawn means it is never reported.            */
SELECT COUNT(*) AS EXCLUDED_BUT_RECENT
  FROM LEADS_SOAP_EXCLUDED X
  JOIN TRANSACTIONS T ON T.TRANSACTION_NO = X.TRANSACTION_NO
 WHERE T.TRAN_DATE >= DATEADD(-12 MONTH TO CURRENT_DATE);

/* -- 4. Is the channel keeping up?  THE HEALTH CHECK --------------
   Everything above is history. This is whether transactions written
   this week are reaching law enforcement.

   Days BEFORE the store cut over show REPORTED 0 because the CSV
   export handled them. That is correct, not a gap -- read this from
   the cutover date onwards.

   From there, any day where WRITTEN and REPORTED differ is a day
   something did not go, except the current day before the operator
   has run the export.                          */
SELECT T.TRAN_DATE, COUNT(*) AS WRITTEN,
       SUM(IIF(EXISTS (SELECT 1 FROM LEADS_SOAP_SUBMISSION S
                        WHERE S.TRANSACTION_NO = T.TRANSACTION_NO
                          AND S.ERROR_CODE IN (0, 6, 13)), 1, 0)) AS REPORTED
  FROM TRANSACTIONS T
 WHERE T.TRAN_TYPE IN ('P','U')
   AND T.TRAN_DATE >= DATEADD(-30 DAY TO CURRENT_DATE)
 GROUP BY T.TRAN_DATE
 ORDER BY T.TRAN_DATE;

/* -- 5. What the operator's screen actually shows -----------------
   NOT the same as "not yet sent". When STORE.LEADS_ONLINE_SKIP_CSV_SENT
   is on -- which it is for any store carrying history -- the screen
   also hides everything the CSV export already reported. Counting
   without that filter reports tens of thousands of rows the operator
   never sees, which reads like a catastrophic backlog and is nothing
   of the sort. Perez Cash showed 25,228 by that measure and 2 in
   reality. This mirrors the screen, honouring the store's setting.  */
SELECT COUNT(*) AS SCREEN_SHOWS
  FROM TRANSACTIONS T1
  LEFT JOIN LEADS_SOAP_SUBMISSION S ON S.TRANSACTION_NO = T1.TRANSACTION_NO
 WHERE T1.TRAN_TYPE IN ('P','U')
   AND COALESCE(T1.TRAN_CLOSE_REASON, 0) <> 1
   AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_EXCLUDED X
                    WHERE X.TRANSACTION_NO = T1.TRANSACTION_NO)
   AND ((SELECT COALESCE(MAX(IIF(LEADS_ONLINE_SKIP_CSV_SENT, 1, 0)), 0) FROM STORE) = 0
        OR NOT EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                        WHERE D.TRANSACTION_NO = T1.TRANSACTION_NO))
   AND (S.ID IS NULL OR S.ERROR_CODE IS NULL
        OR S.ERROR_CODE NOT IN (0, 6, 7, 13));

/* -- 6. Did they keep backing up while all this was going on? ----- */
SELECT MAX(BCK_DATE) AS LAST_BACKUP,
       (SELECT MAX(TRAN_DATE) FROM TRANSACTIONS) AS NEWEST_TRANSACTION
  FROM BACKUP_HISTORY;
