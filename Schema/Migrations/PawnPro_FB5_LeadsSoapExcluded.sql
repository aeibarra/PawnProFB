/*******************************************************************************
 * PawnPro — Firebird 5 migration: LEADS_SOAP_EXCLUDED
 *
 * Transactions the store has decided must NEVER be sent to LeadsOnline over
 * SOAP. The export screen's grid offers this on a right-click.
 *
 * Why this exists: a store coming onto the web service brings its whole history
 * with it. Perez Cash has 13,516 pawns and purchases that never appeared in any
 * CSV export, the oldest from 2000 — decades older than anything LeadsOnline
 * will accept. Left alone they sit in the candidate list forever, because a
 * transaction only leaves that list once the service has answered about it, and
 * offering thousands of rows that can never succeed makes the screen useless
 * for the handful that matter.
 *
 * WHY A SEPARATE TABLE, and not a sentinel ERROR_CODE on LEADS_SOAP_SUBMISSION:
 * that table's TICKET_TYPE, TICKET_NUMBER and TICKET_DATETIME are NOT NULL and
 * mean "exactly what was transmitted". An excluded transaction was never
 * transmitted, so there is nothing honest to put in them — and inventing values
 * to satisfy the constraints would corrupt the one table whose job is to be the
 * authoritative record of what went to law enforcement. "What we sent" and
 * "what we chose never to send" are different facts.
 *
 * No EXCLUDED_BY column: PawnPro has no application login, so there is no user
 * to record. EXCLUDED_AT still answers "when was this decided", which is what
 * anyone asking why a 2003 pawn never appeared actually needs.
 *
 * The UI presents exclusion as permanent, and it should — but the data is one
 * DELETE away from undo on purpose. A mis-click with several hundred rows
 * ticked must not be a one-way door.
 *
 * Idempotent: safe to re-run.
 ******************************************************************************/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS
                  WHERE RDB$RELATION_NAME = 'LEADS_SOAP_EXCLUDED')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE LEADS_SOAP_EXCLUDED
       (
         TRANSACTION_NO  INTEGER    NOT NULL,
         EXCLUDED_AT     TIMESTAMP  DEFAULT CURRENT_TIMESTAMP NOT NULL,
         REASON          VARCHAR(255),
         CONSTRAINT PK_LEADS_SOAP_EXCLUDED PRIMARY KEY (TRANSACTION_NO)
       )';
END^

SET TERM ; ^
