/*******************************************************************************
 * PawnPro - Firebird 5: guarantee STORE.DEFAULT_WEIGHT_MEASURE_UNIT has a value
 * -----------------------------------------------------------------------------
 * DEFAULT_WEIGHT_MEASURE_UNIT drives DefaultWeightMeasureUnit (PawnDM), which
 * now feeds the gold price bar as well as new item/stone weights. The column was
 * created nullable with no DEFAULT, so a store that never opened the settings
 * screen could sit on NULL -- or on a stray value that is neither 'G' nor 'P'.
 *
 * Valid values:
 *   'P'  Pennyweight  (the trade default, and what the seed data uses)
 *   'G'  Gram
 *
 * Two changes, both idempotent:
 *   1. Repair existing rows -- anything NULL, blank, or outside ('G','P') to 'P'.
 *      Note a CHAR(1) written as an empty string comes back as a single space,
 *      so the NOT IN test catches that case too.
 *   2. SET DEFAULT 'P' on the column, so a STORE row inserted by hand or by a
 *      future script cannot reintroduce the NULL.
 *
 * The column is deliberately left NULLable. The settings screen can write a
 * blank, which NOT NULL would not catch anyway, and a failed migration is fatal
 * at startup -- so the value is guarded here, by the DEFAULT, and by the
 * fallback in TDM.DataModuleCreate rather than by a constraint that buys little.
 *
 * Mirrored by Step4_DefaultWeightMeasureUnit in uDBMigrations.pas (v4), which
 * applies this automatically at startup for already-deployed stores.
 ******************************************************************************/

UPDATE STORE
   SET DEFAULT_WEIGHT_MEASURE_UNIT = 'P'
 WHERE DEFAULT_WEIGHT_MEASURE_UNIT IS NULL
    OR DEFAULT_WEIGHT_MEASURE_UNIT NOT IN ('G', 'P');

ALTER TABLE STORE ALTER COLUMN DEFAULT_WEIGHT_MEASURE_UNIT SET DEFAULT 'P';

COMMIT;
