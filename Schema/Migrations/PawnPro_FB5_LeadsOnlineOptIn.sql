/*******************************************************************************
 * PawnPro — Firebird 5 migration: LeadsOnline becomes opt-in
 *
 * Not every store is a LeadsOnline customer. Until now
 * STORE.LEADS_ONLINE_EXPORT_METHOD only distinguished 'C' (CSV over FTP) from
 * 'S' (SOAP), with 'C' as the default, so a brand-new store looked like a
 * LeadsOnline CSV reporter before anyone had configured anything.
 *
 * This changes the column DEFAULT to 'N' — not using LeadsOnline — so a new
 * store starts opted out and the whole LeadsOnline export UI stays hidden until
 * someone deliberately turns it on.
 *
 * EXISTING STORES ARE NOT TOUCHED, and that is the point. The earlier
 * PawnPro_FB5_LeadsOnlineSoap migration explicitly backfilled every existing
 * row to 'C', so the stores that really are exporting by CSV today keep their
 * value and keep working. Only future inserts see the new default — which in
 * practice means only brand-new store databases.
 *
 * A store that is not a LeadsOnline customer can now be switched off in
 * LeadsOnline Settings; that writes 'N' and hides the export screen.
 *
 * Idempotent: setting a column default is a no-op when it is already set.
 ******************************************************************************/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$RELATION_FIELDS
              WHERE RDB$RELATION_NAME = 'STORE'
                AND RDB$FIELD_NAME = 'LEADS_ONLINE_EXPORT_METHOD')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE STORE ALTER COLUMN LEADS_ONLINE_EXPORT_METHOD SET DEFAULT ''N''';
END^

SET TERM ; ^
