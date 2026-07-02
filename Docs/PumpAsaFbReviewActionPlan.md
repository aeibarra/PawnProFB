# Pump_ASA_FB Review Action Plan

This is the follow-up checklist from the review of `Pump_ASA_FB`, the one-time data pump for existing stores migrating from SQL Anywhere / ASA to Firebird 5.

Priority is ordered by cutover risk. The first item is the Firebird-side image `NULL` issue.

## 1. Fix `IMAGES_DATA.IMAGE_DATA` for disk/file image stores

**Status:** Done for the current FB5 schema path. `IMAGES_DATA.IMAGE_DATA` is nullable in the refreshed schema extract and the combined new-store deploy has been aligned.

**Risk:** High

ASA allows `ImagesData.ImageData` to be `NULL`. FB5 now allows `IMAGES_DATA.IMAGE_DATA` to be `NULL` too, so existing stores that already use disk/file image storage can preserve metadata rows without blob bytes.

**Decision made:**

- Keep `IMAGE_DATA` during the transition, but allow `NULL`.
- Keep the DB-image code path available for now. A later cleanup can remove the blob column only if we decide the fallback is no longer needed.

**Files to inspect/update:**

- `Schema/PawnPro_DB_Firebird50_Schema.sql`
- `Schema/PawnPro_FB5_NewStoreFullDeploy.sql`
- `Docs/DiskOnlyImageMigrationPlan.md`
- `Pump_ASA_FB/PumpAsaFb50Main.pas`

**Done when:**

- [x] A store with `NULL` ASA `ImagesData.ImageData` rows can pump without violating FB `NOT NULL`.
- [x] The FB schema and pump agree that `IMAGE_DATA` exists and allows `NULL`.
- [ ] Image metadata row counts match after pump. Covered by post-pump validation in item 2.

## 2. Add post-pump validation

**Status:** Done. Implemented in `Pump_ASA_FB/PumpAsaFb50Main.pas` and confirmed by a good pump validation log.

**Risk:** High

The pump currently logs per-table insert counts, but it does not perform a final source-vs-target validation pass. For a customer cutover, the tool should prove that the migrated database is complete enough to hand back to the store.

**Add validation checks:**

- Row count parity for every pumped table.
- `SUM(TranPawnAmount)` parity between ASA `Transactions` and FB `TRANSACTIONS`.
- `SUM(PayAmount)` parity between ASA `Payments` and FB `PAYMENTS`.
- `MAX(TranDate)` and `MAX(PayDate)` parity.
- Image row count parity by `ImageTypeNo`.
- Orphan checks for:
  - `TRANSACTIONS.CUST_NO`
  - `INVENTORY_ITEMS.TRANSACTION_NO`
  - `PAYMENTS.TRANSACTION_NO`
  - `STONES.INV_ITEM_NO`
  - `INVENTORY_ITEM_STATUS_LOG.INV_ITEM_NO`

**Done when:**

- [x] Pump ends with a clear `VALIDATION PASSED` or `VALIDATION FAILED`.
- [x] Failures identify the exact table/check and values found.
- [x] Validation has been confirmed by a Delphi compile and dry run against a copied store database.

## 3. Write a persistent pump log file

**Status:** Implemented in `Pump_ASA_FB/PumpAsaFb50Main.pas`; pending Delphi compile and next pump-run confirmation.

**Risk:** High

The current log only lives in the UI memo. Each store migration should leave an audit artifact showing what was pumped, when, from which ASA database, to which FB database, and whether validation passed.

**Add:**

- Timestamped log file next to the EXE, for example:
  - `PumpAsaFb50.20260617-143012.log`
- ASA connection summary without password.
- FB connection summary without password.
- Table row counts.
- Validation results.
- Any NULL coercions.
- Final status: complete or failed.

**Done when:**

- [x] Every pump run writes a durable log even if the pump fails.
- [x] Passwords are never written to the log.
- [ ] Log-file creation has been confirmed by a Delphi compile and pump run.

## 4. Repair and validate `TABLE_KEYS`

**Status:** Accepted as-is for the current FB5 design. Row IDs now use Firebird identity columns; `TABLE_KEYS` is intentionally limited to the two ticket counters still used by the app.

**Risk:** Medium

The pump copies only `PawnTicketNo` and `LayawayTicketNo`, and the FB app still uses `TABLE_KEYS` for ticket numbers. Other former key-table uses are covered by Firebird identity columns.

**Add post-pump repair:**

- Ensure rows exist for:
  - `PawnTicketNo`
  - `LayawayTicketNo`
- Set `LAST_KEY` to at least the max matching ticket number already in `TRANSACTIONS`.
- Log old and new values.

**Done when:**

- [x] `TABLE_KEYS` is intentionally limited to the two required ticket rows.
- [x] All table row IDs use Firebird identity columns instead of `TABLE_KEYS`.
- [ ] `LAST_KEY` values cannot generate duplicate ticket numbers on first FB use. This remains covered by post-pump validation/log review and normal ticket-number testing.

## 5. Make NULL coercion visible and intentional

**Status:** Implemented in `Pump_ASA_FB/PumpAsaFb50Main.pas`; pending Delphi compile and next pump-run confirmation.

**Risk:** Medium

`ApplyNullCoercion` currently substitutes `0` or `' '` when source data is `NULL` but the FB target column is `NOT NULL`. This prevents some pump failures, but it can silently alter source data.

**Improve behavior:**

- Count coercions by table and column.
- Log a summary at the end.
- Consider replacing metadata-wide coercion with explicit per-column defaults.
- Treat unexpected NOT NULL blob/date/time/boolean NULLs as validation failures.

**Done when:**

- [x] Every coerced field is summarized by `TABLE.COLUMN` in the pump log.
- [x] Unexpected coercions are easy to investigate before cutover.
- [ ] NULL coercion summary has been confirmed by a Delphi compile and pump run.

## 6. Batch large non-image tables

**Status:** Accepted as not needed for current stores. These are small owner-operated store databases; `IMAGES_DATA` is the only table with realistic blob/memory pressure and it is already batched.

**Risk:** Medium

`PumpImagesData` is batched, but large tables such as `InventoryItems`, `Payments`, and `InventoryItemStatusLog` still use the generic full-result-set path. Very large stores could hit memory or runtime problems.

**Candidate tables:**

- `InventoryItems`
- `Payments`
- `InventoryItemStatusLog`
- `ExportLogFileDetail`

**Done when:**

- [x] Decision recorded: leave non-image tables as one-shot loads for current store sizes.
- [x] `IMAGES_DATA` remains batched.
- [ ] Revisit only if a future store has unusually large non-image tables.

## 7. Fix ASA test button connection rebuild

**Status:** Implemented in `Pump_ASA_FB/PumpAsaFb50Main.pas`; pending Delphi compile confirmation.

**Risk:** Low

`btnTestAsaClick` currently has `GetADOConnectionStr` commented out, so edited ASA connection fields may not be used by the test button.

**Fix:**

- Call `GetADOConnectionStr` at the start of `btnTestAsaClick`.

**Done when:**

- [x] Changing ASA server, database, user, or password and clicking `Test ASA` tests the edited values.
- [ ] Confirmed by Delphi compile.

## 8. Clean up operational polish

**Status:** Partially implemented in `Pump_ASA_FB/PumpAsaFb50Main.pas` and `.dfm`; docs cleanup still remains.

**Risk:** Low

These are small improvements that reduce mistakes during a stressful cutover.

**Items:**

- [x] Mask password edit controls.
- [x] Free `FNotNullCols` and `FNullCoercions` on form destroy.
- [x] Disable `Start Pump` while a pump is running.
- [x] Add a stronger confirmation showing source ASA and target FB database.
- Update `Docs/PUMP_APP_PLAN.md` status so it no longer says pump logic is TBD.
- Fix mojibake/encoding artifacts in `Docs/PUMP_APP_PLAN.md`.

**Done when:**

- The pump UI is harder to misuse.
- Docs match the current implementation.

## Recommended Implementation Order

1. Fix `IMAGES_DATA.IMAGE_DATA` schema/pump behavior.
2. Add validation and persistent logs.
3. Add `TABLE_KEYS` repair.
4. Log NULL coercions.
5. Batch large non-image tables if dry-run timing or memory proves it is needed.
6. Apply low-risk UI/docs polish.
