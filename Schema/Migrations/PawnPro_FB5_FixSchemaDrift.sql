/*******************************************************************************
 * PawnPro - Firebird 5 schema drift fixes
 *
 * Run once against an existing (empty) FB5 PawnPro database to align the
 * remaining column-level differences with SQL Anywhere 16.
 *
 * Contents:
 *   1. TRANSACTION_TYPES: drop & recreate with column renamed TRANTYPE ->
 *      TRAN_TYPE and TRAN_TYPE_DESC restored to NOT NULL.
 *      (ALTER COLUMN ... TO on a PK column is refused by FB, so we rebuild.)
 *   2. GOLD_PRICE_HISTORY.FETCHDATETIME -> default CURRENT_TIMESTAMP
 *                                          (was CURRENT_DATE on a TIMESTAMP col)
 *   3. GOLD_PRICE_HISTORY.SOURCE        -> default 'CryptoCompare'
 ******************************************************************************/


/* ---------------------------------------------------------------------------
 * 1. TRANSACTION_TYPES: drop & recreate with corrected column name and NOT NULL
 * ------------------------------------------------------------------------ */

DROP TABLE TRANSACTION_TYPES;
COMMIT;

CREATE TABLE TRANSACTION_TYPES
(
  TRAN_TYPE                      CHAR(1) NOT NULL,
  TRAN_TYPE_DESC              VARCHAR(20) NOT NULL,
  CONSTRAINT PK_TRANSACTION_TYPES PRIMARY KEY (TRAN_TYPE)
);
COMMIT;


/* ---------------------------------------------------------------------------
 * 2. GOLD_PRICE_HISTORY.FETCHDATETIME: fix the default
 *    Column is TIMESTAMP; ASA default was `current timestamp`. FB had it set
 *    to CURRENT_DATE which silently dropped the time-of-day on inserts that
 *    omit the column.
 * ------------------------------------------------------------------------ */

ALTER TABLE GOLD_PRICE_HISTORY ALTER COLUMN FETCHDATETIME SET DEFAULT CURRENT_TIMESTAMP;


/* ---------------------------------------------------------------------------
 * 3. GOLD_PRICE_HISTORY.SOURCE: restore the 'CryptoCompare' default from ASA
 *    SPI_GOLD_PRICE already passes SOURCE explicitly, but any direct INSERT
 *    that omitted it failed (column is NOT NULL with no default).
 * ------------------------------------------------------------------------ */

ALTER TABLE GOLD_PRICE_HISTORY ALTER COLUMN SOURCE SET DEFAULT 'CryptoCompare';


COMMIT;
