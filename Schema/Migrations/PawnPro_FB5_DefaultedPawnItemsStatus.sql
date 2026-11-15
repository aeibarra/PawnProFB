/*******************************************************************************
 * PawnPro — Firebird 5 migration: status char for defaulted pawn items (v11)
 *
 * DATA FIX ONLY — no schema change, so PawnPro_DB_Firebird50_Schema.sql and the
 * new-store full-deploy script are unaffected (a new store has no such rows).
 *
 * Until v3.37.x, defaulting a pawn and choosing For Sale or Scrap for its items
 * wrote only FORSALE_DATE / MELTED_DATE; INV_ITEM_STATUS stayed 'P'. Anything
 * that reads For Sale / Scrap stock by the status char (Inventory filter, the
 * Sell Items screen, reports) missed those items — which is why stores deleted
 * defaulted pawns and re-entered the items as purchases. The app now writes the
 * char; this brings rows written before that in line:
 *
 *   pawn item, still 'P', not sold, FORSALE_DATE set -> 'S' (For Sale)
 *   pawn item, still 'P', not sold, MELTED_DATE set  -> 'C' (Scrap)
 *
 * For Sale wins if both dates are set, matching TDM.PawnItemStatusChar.
 * Derived purely from existing dates; nothing else is touched. The
 * INVENTORY_ITEM_STATUS_LOG trigger records each change.
 *
 * Idempotent: re-running finds no 'P' rows with those dates.
 *
 * Mirror of uDBMigrations.Step11_DefaultedPawnItemsStatus.
 ******************************************************************************/

UPDATE INVENTORY_ITEMS ii
   SET ii.INV_ITEM_STATUS = 'S'
 WHERE ii.INV_ITEM_STATUS = 'P'
   AND ii.SOLD_DATE    IS NULL
   AND ii.FORSALE_DATE IS NOT NULL
   AND EXISTS (SELECT 1 FROM TRANSACTIONS t
                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO
                  AND t.TRAN_TYPE = 'P');

UPDATE INVENTORY_ITEMS ii
   SET ii.INV_ITEM_STATUS = 'C'
 WHERE ii.INV_ITEM_STATUS = 'P'
   AND ii.SOLD_DATE    IS NULL
   AND ii.FORSALE_DATE IS NULL
   AND ii.MELTED_DATE  IS NOT NULL
   AND EXISTS (SELECT 1 FROM TRANSACTIONS t
                WHERE t.TRANSACTION_NO = ii.TRANSACTION_NO
                  AND t.TRAN_TYPE = 'P');

COMMIT;
