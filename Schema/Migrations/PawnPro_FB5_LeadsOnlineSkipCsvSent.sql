/*******************************************************************************
 * PawnPro — Firebird 5 migration: skip transactions already sent by CSV
 *
 * Adds STORE.LEADS_ONLINE_SKIP_CSV_SENT, which answers the question every store
 * faces on the day it switches from the CSV/FTP export to the SOAP one:
 * "what happens to the years of transactions I have already reported?"
 *
 * The CSV export already records what it sent, one row per transaction in
 * EXPORT_LOG_FILE_DETAIL. With this flag on, the SOAP export screen leaves those
 * transactions out, so the list contains only what has genuinely never been
 * reported by either channel — including gaps in the middle of the history,
 * which a simple "start reporting from this date" cutoff would silently abandon.
 *
 * On a real store this is the difference between being offered ~29,000
 * transactions and being offered ~550.
 *
 * DEFAULT TRUE is safe for every store:
 *   - a store with CSV history wants exactly this;
 *   - a brand-new store has an empty EXPORT_LOG_FILE_DETAIL, so the condition
 *     excludes nothing and the flag does not matter.
 *
 * Turn it OFF for the pilot parallel run, where both channels deliberately
 * report the same transactions so their output can be compared.
 *
 * Note this reflects what the store BELIEVES it reported: EXPORT_LOG_FILE_DETAIL
 * records that a transaction was written into an export file, not that
 * LeadsOnline confirmed receiving it. That is the right standard for not
 * double-reporting, and re-sending a ticket they already hold is not an error
 * on their side anyway (codes 6 and 13).
 *
 * Idempotent: the column is added only if absent.
 ******************************************************************************/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATION_FIELDS
                  WHERE RDB$RELATION_NAME = 'STORE'
                    AND RDB$FIELD_NAME = 'LEADS_ONLINE_SKIP_CSV_SENT')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE STORE ADD LEADS_ONLINE_SKIP_CSV_SENT BOOLEAN DEFAULT TRUE';
END^

COMMIT^

/* Firebird applies a new column's DEFAULT to future inserts only, so existing
   rows read NULL until told otherwise. Run dynamically: the column does not
   exist when this block is compiled on a store that has not been migrated. */
EXECUTE BLOCK AS
BEGIN
  EXECUTE STATEMENT
    'UPDATE STORE SET LEADS_ONLINE_SKIP_CSV_SENT = TRUE
      WHERE LEADS_ONLINE_SKIP_CSV_SENT IS NULL';
END^

SET TERM ; ^
