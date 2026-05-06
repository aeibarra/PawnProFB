/*******************************************************************************
 * PawnPro - Firebird 5: drop the deprecated multi-station/sync feature
 *
 * Run once against an existing FB5 PawnPro database. Removes:
 *   1. STATIONS table  (per-workstation registry, never read by current app)
 *   2. SEQ_TABLE table (station-sync sequence counter)
 *   3. SP_CONNECTED procedure (station connect/disconnect logger)
 *
 * The corresponding ASA-side counterparts (Stations, SEQTable, sp_Connected,
 * sp_GetStationNo, fn_NextSEQ, fn_GetLastKey) are left alone because the ASA
 * source database is read-only during the pump and gets retired post-cutover.
 *
 * Idempotent: each DROP is wrapped in IF EXISTS so reruns are safe.
 ******************************************************************************/


-- 1. STATIONS table
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS
              WHERE RDB$RELATION_NAME = 'STATIONS')) THEN
    EXECUTE STATEMENT 'DROP TABLE STATIONS';
END^^

-- 2. SEQ_TABLE table
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS
              WHERE RDB$RELATION_NAME = 'SEQ_TABLE')) THEN
    EXECUTE STATEMENT 'DROP TABLE SEQ_TABLE';
END^^

-- 3. SP_CONNECTED procedure
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$PROCEDURES
              WHERE RDB$PROCEDURE_NAME = 'SP_CONNECTED')) THEN
    EXECUTE STATEMENT 'DROP PROCEDURE SP_CONNECTED';
END^^

COMMIT;
