/*******************************************************************************
 * PawnPro — Firebird 5 migration: APP_STATE key/value table
 *
 * General-purpose key -> typed-value store. Holds both configuration values
 * and runtime markers (e.g. "last time the export ran"). One row per key;
 * use whichever VALUE_* column fits the key (others stay NULL).
 *
 * Idempotent: safe to re-run. The table is created only if it does not
 * already exist. Procedures are created or replaced.
 ******************************************************************************/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS
                  WHERE RDB$RELATION_NAME = 'APP_STATE')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE APP_STATE
       (
         STATE_KEY        VARCHAR(50)   NOT NULL,
         STATE_DESC       VARCHAR(255),
         VALUE_TEXT       VARCHAR(255),
         VALUE_INT        INTEGER,
         VALUE_CURRENCY   NUMERIC(18,2),
         VALUE_DATE       TIMESTAMP,
         CONSTRAINT PK_APP_STATE PRIMARY KEY (STATE_KEY)
       )';
END^

CREATE OR ALTER PROCEDURE SPS_APP_STATE (
  P_STATE_KEY VARCHAR(50))
RETURNS (
  STATE_DESC      VARCHAR(255),
  VALUE_TEXT      VARCHAR(255),
  VALUE_INT       INTEGER,
  VALUE_CURRENCY  NUMERIC(18,2),
  VALUE_DATE      TIMESTAMP)
SQL SECURITY INVOKER
AS
BEGIN
  FOR
    SELECT
      STATE_DESC,
      VALUE_TEXT,
      VALUE_INT,
      VALUE_CURRENCY,
      VALUE_DATE
    FROM APP_STATE
    WHERE STATE_KEY = :P_STATE_KEY
    INTO
      :STATE_DESC,
      :VALUE_TEXT,
      :VALUE_INT,
      :VALUE_CURRENCY,
      :VALUE_DATE
  DO
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE SPU_APP_STATE (
  P_STATE_KEY       VARCHAR(50),
  P_VALUE_TEXT      VARCHAR(255),
  P_VALUE_INT       INTEGER,
  P_VALUE_CURRENCY  NUMERIC(18,2),
  P_VALUE_DATE      TIMESTAMP)
SQL SECURITY INVOKER
AS
BEGIN
  UPDATE OR INSERT INTO APP_STATE (
    STATE_KEY,
    VALUE_TEXT,
    VALUE_INT,
    VALUE_CURRENCY,
    VALUE_DATE)
  VALUES (
    :P_STATE_KEY,
    :P_VALUE_TEXT,
    :P_VALUE_INT,
    :P_VALUE_CURRENCY,
    :P_VALUE_DATE)
  MATCHING (STATE_KEY);
END^

SET TERM ; ^

COMMIT;
