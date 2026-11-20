/*******************************************************************************
 * PawnPro — Firebird 5 migration: payment type spelling (schema v16)
 *
 * PAYMENT_TYPES row 6 was seeded as 'America Express'; it is American Express.
 * Data-only fix: the row keeps its PAY_TYPE_NO, so payments, sales and stock
 * receipts that point at it are unchanged and simply show the right name.
 *
 * Idempotent: it only touches the misspelt value, so a store whose operator
 * renamed the row to something else is left alone, and a re-run does nothing.
 *
 * Mirror of Step16_FixAmexSpelling in uDBMigrations.pas.
 ******************************************************************************/

UPDATE PAYMENT_TYPES
   SET PAYMENT_TYPE = 'American Express'
 WHERE PAYMENT_TYPE = 'America Express';

COMMIT;
