/* ============================================================
   Kendale Jewelry -- put four wrongly-excluded transactions
   back into the LeadsOnline export list.

   Paste into DBeaver against the store's live database, or run
   with isql. Read the SELECT, then run the DELETE.

   These four were caught in the bulk exclusion of 2026-09-01:
   all 514 landed within half a second, and these sat inside the
   selected range. None has ever appeared in a CSV export either,
   so as things stand they have reached law enforcement through
   no channel at all.

   Removing the row sends nothing. It puts the transaction back
   on the export screen, to be ticked and submitted normally.
   ============================================================ */

/* -- 1. LOOK FIRST. Four rows, all EVER_IN_A_CSV = NO. -------- */
SELECT T.TRANSACTION_NO, T.TRAN_DATE, T.TRAN_TYPE, T.TRAN_TICKET_NO,
       CASE WHEN EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                          WHERE D.TRANSACTION_NO = T.TRANSACTION_NO)
            THEN 'yes' ELSE 'NO' END AS EVER_IN_A_CSV
  FROM LEADS_SOAP_EXCLUDED X
  JOIN TRANSACTIONS T ON T.TRANSACTION_NO = X.TRANSACTION_NO
 WHERE T.TRAN_DATE >= DATEADD(-12 MONTH TO CURRENT_DATE)
 ORDER BY T.TRAN_DATE;

/* -- 2. THE FIX. Removes only those four. --------------------- */
DELETE FROM LEADS_SOAP_EXCLUDED
 WHERE TRANSACTION_NO IN (31871, 32132, 32191, 32315);
COMMIT;

/* -- 3. CHECK. Expect EXCLUDED_BUT_RECENT = 0 and the export
      screen showing 4 more rows than before. ------------------ */
SELECT (SELECT COUNT(*) FROM LEADS_SOAP_EXCLUDED) AS EXCLUDED_TOTAL,
       (SELECT COUNT(*) FROM LEADS_SOAP_EXCLUDED X
          JOIN TRANSACTIONS T ON T.TRANSACTION_NO = X.TRANSACTION_NO
         WHERE T.TRAN_DATE >= DATEADD(-12 MONTH TO CURRENT_DATE)) AS EXCLUDED_BUT_RECENT
  FROM RDB$DATABASE;
