/*******************************************************************************
 * PawnPro - Firebird 5: backfill PAWNED_DATE on copied pawn items
 * -----------------------------------------------------------------------------
 * The "copy items into a new pawn" path (renewal/rewrite, qryInsItems in
 * EnterTransactions) inserted rows with INV_ITEM_STATUS='P' but left
 * PAWNED_DATE NULL. TfrmClients.GetPawnItemStatus derives an item's status from
 * the date columns rather than from INV_ITEM_STATUS, so those rows fell through
 * every branch and displayed a blank Status - and, once the Status Date column
 * was added, a blank date beside it.
 *
 * The insert is fixed, so no new rows can land in this state. This repairs the
 * ones already written, dating each to its own ticket's TRAN_DATE - the item was
 * pawned when that ticket was written, which also keeps back-dated tickets
 * honest. CURRENT_DATE would have been wrong for every historical row.
 *
 * Narrowly guarded on purpose. It only touches rows that are:
 *   - flagged as pawned (INV_ITEM_STATUS='P'),
 *   - carrying NO entry date at all, so nothing is ever overwritten, and
 *   - attached to a transaction that actually has a TRAN_DATE.
 * An item whose status was derived from any other date is left alone.
 *
 * Idempotent: once a row has PAWNED_DATE the WHERE clause no longer selects it,
 * so re-running is a no-op.
 *
 * Mirrored by Step5_BackfillPawnedDate in uDBMigrations.pas (v5), which applies
 * this automatically at startup for already-deployed stores.
 ******************************************************************************/

UPDATE INVENTORY_ITEMS ii
   SET ii.PAWNED_DATE = (SELECT t.TRAN_DATE
                           FROM TRANSACTIONS t
                          WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO)
 WHERE ii.INV_ITEM_STATUS = 'P'
   AND ii.PAWNED_DATE    IS NULL
   AND ii.PURCHASE_DATE  IS NULL
   AND ii.LAYAWAY_DATE   IS NULL
   AND ii.SOLD_DATE      IS NULL
   AND EXISTS (SELECT 1
                 FROM TRANSACTIONS t
                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO
                  AND t.TRAN_DATE IS NOT NULL);

COMMIT;
