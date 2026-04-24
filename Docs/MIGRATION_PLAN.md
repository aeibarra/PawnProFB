# PawnPro — SQL Anywhere 16 → Firebird 5 Migration Plan

Status: **planning / pre-work**
Last updated: 2026-04-22

This document captures the migration strategy agreed during the initial brainstorm. It is the primary hand-off artifact — a future Claude Code session (or any developer) should be able to read this, pick up context, and continue the work without needing the original conversation.

---

## 1. Goal

Migrate the PawnPro Delphi VCL application from **SAP SQL Anywhere 16** (via ADO / `SAOLEDB.12`) to **Firebird 5** (via FireDAC), including a data-pump tool used on every customer store to convert their live database.

The SQL Anywhere version must remain buildable and shippable throughout the migration, because stores switch over one at a time.

---

## 2. Key decisions

| Area | Decision | Reason |
|---|---|---|
| Data access layer | **FireDAC** (native) | Best Firebird support; ships with Delphi 10.3+; avoids ADO/ODBC friction. No mature Firebird OLE DB provider. |
| Pump app | **Separate standalone Delphi app** | Repeatable, auditable per-store; keeps main app migration scope small. |
| Pump data access | **FireDAC on both sides** (`TFDPhysASADriverLink` for SA source, `TFDPhysFBDriverLink` for FB target) | One component model, `TFDBatchMove` handles blobs/batching/progress. |
| Source layout | Main app stays where it is; pump app under `Migration/PumpApp/`; FB schema scripts under `Migration/Schema/` | One repo, everything travels together. |
| Cutover form | **New folder copy** of the whole project once FB version is proven | Lets SA and FB coexist on a workstation (separate `PawnPro.ini`, separate DB). Branches alone aren't enough. |
| Schema migrations (FB) | **Rewrite** `CheckForMissingDBChanges()` fresh, guard with `RDB$RELATIONS` / `RDB$RELATION_FIELDS` lookups | Keeps the `UPDB` command-line upgrade flow intact. |
| Key generators | **Keep** `fn_GetNextKey` pattern (rewritten as PSQL) | Minimizes app-side churn; continuity of existing keys is critical. |
| Identifiers | All unquoted in SQL | Keeps Firebird case-insensitive; matches SA behavior. |

---

## 3. Prerequisites (must finish before main-app migration starts)

- [ ] **FB5 schema DDL** complete in `Migration/Schema/` — tables, constraints, indexes, sequences, stored procs rewritten in PSQL, reference data seeds.
- [ ] **New `CheckForMissingDBChanges()`** for FB5, for future schema bumps.
- [ ] **Pump app** working end-to-end against a dev copy of a real store's SA database, with:
  - Table manifest in FK-safe order
  - `TFDBatchMove` loop with per-table progress
  - Image-storage mode detection (`DATABASE` vs `FILE`)
  - Key-generator (`NextKeys` or equivalent) post-step that sets counters ≥ MAX of referencing tables
  - Validation pass (row counts, numeric/date MIN/MAX/SUM, blob spot-checks)
  - Per-store log file output
- [ ] **Smoke-test script** written (see §8).
- [ ] **Baseline backup** of a real store's SA database set aside for repeatable pump testing.

---

## 4. Main-app migration sequence

Work top-down. **Compile and smoke-test after every phase boundary.** Do not let the branch sit broken for days.

### Phase 1 — Foundation (no UI work yet)

1. Add `TFDConnection` + `TFDPhysFBDriverLink` to `TDM`. Build FB connection string in `GetConnectionStr` (read from `[CONNECTION]` section of `PawnPro.ini`). Prove `.Open` works against the empty FB DB. ADO stays in place during this phase.
2. Port `OpenSQLStatement` / `ExecSQLStatement` in `PawnGlobal.pas` to FireDAC. These are chokepoints — once ported, most dynamic-SQL call sites start working without further changes.
3. Port stored-proc wrappers: `fn_GetNextKey`, `spu_Connecting`, `spi_GoldPrice`, `CalcInterest`, `GetPawnMaturityDate`, etc. (Requires FB-side procs to exist already.)
4. Port `BackupDatabase` → `gbak` shell-out or `TFDIBBackup`.

### Phase 2 — Data modules

5. **`TDM` datasets**, smallest risk first:
   - Lookups: `qryStore`, `qryItemStatus`
   - `qryCustomers`
   - `qryTransactions`, `qryInvItems`, `qryPayments` (master/detail)
6. **`TDMReports`** — read-only, easier to validate.
7. **`TDM_LeadsOnline`** — export queries.

### Phase 3 — Forms

8. `TfrmPawnMain` — shell form, proves DMs are wired correctly end-to-end.
9. Client search / customer entry — high reuse, many forms launch them as children.
10. Pawn-transaction lifecycle (per CLAUDE.md): `EnterTransactions` → `ChangePawnItemsStatus` → `EnterPayment` → `PawnChangeStatus`.
11. Reports forms.
12. Admin / settings forms.

### Phase 4 — Cleanup

13. Remove `TADOConnection`, `SAOLEDB.12` references, unused `MidasLib` bits (if any become unused), `SAOLEDB`-specific config. Strip unused ADO-era imports.

---

## 5. Division of labor (Claude ↔ developer)

**Developer does (in the Delphi IDE):**
- Drops FireDAC components on forms / DMs (or uses Change Class on simple cases).
- Wires `Connection` property to the new `TFDConnection`.
- Migrates persistent fields — easiest is delete + re-add so field types match FB's reported metadata.
- Saves the `.dfm` so it's IDE-clean.

**Claude does (in code/text):**
- All SQL string rewrites — inline in `.pas` and inside `SQL.Strings` blocks in `.dfm` (TOP→FIRST, ISNULL→COALESCE, date functions, proc call syntax, etc.).
- Interface declarations (`qryFoo: TADOQuery` → `TFDQuery`), class references, event handler signatures.
- Helper-function rewrites in `PawnGlobal.pas`.
- PSQL rewrites for stored procs (separate `.sql` output, applied via `isql`).
- Bulk find/replace patterns across many files.

**Together (pair):**
- The first DM port and first form port — establishes the template. Surfaces the FireDAC properties that actually matter for this app (`FetchOptions`, `CachedUpdates`, `LiveDataWindow`, etc.).
- Any dataset with master/detail, calculated fields (`c*` prefix), or lookup fields — FireDAC has nuances worth pairing on.

---

## 6. Codebase-specific gotchas

- **Image storage mode** (`[IMAGE_STORAGE] StorageMode` = `DATABASE` or `FILE`). The three procedure pointers `GetImageProc` / `SaveImageProc` / `DeleteImageProc` in `PawnGlobal` are bound in `TfrmPawnMain.FormShow`. Both paths must work under FireDAC; the pump must handle both modes correctly (BLOBs in `DATABASE` mode; file-folder copy in `FILE` mode).
- **Key generator continuity.** After pumping, the `NextKeys` (or equivalent) table must hold values ≥ `MAX()` of every referenced table. Recompute as a post-pump step or new records will collide.
- **Calculated fields are app-side.** `c*`-prefixed fields (`qryStorecCity` etc.) live in `OnCalcFields` handlers — never migrate them as database columns and never write to them.
- **Status values differ by table kind.** Transaction status is `Char` (`'A'`/`'I'`); pawn-item status is `String` (`'Pawned'`/`'Redeemed'`/…). Don't conflate.
- **Charset.** SA is likely Windows-1252 or similar; FB DB should be created as `UTF8`. FireDAC converts automatically if both connections declare their charset; verify with a customer who has accented characters before cutover.
- **Locked vs editable controls.** `Tag=0` means editable (toggled by `EnableDisableContr`); `Tag≠0` means locked/skipped. Preserve this convention across form edits.
- **Dialog style.** Use `uPawnDialogs` (`PawnInfo` / `PawnWarn` / `PawnError` / `PawnConfirm`), not raw `MessageDlg`.
- **`..\COMMON\` sibling.** `GLbUtils`, `IDNumCalc`, `Nvv.IO.CSV.*`, `SelectedItemsInGridClass` live outside this repo. The pump app and any migrated copy must preserve the relative path.

---

## 7. Ops / deployment changes

- `BackupDatabase` — SA `dbbackup` → `gbak` shell-out or `TFDIBBackup`.
- Connection config in `PawnPro.ini` `[CONNECTION]` — rebuild fields (server, path or alias, user, role). Keep backward-compatible key names if possible so shared install scripts don't fork.
- No more `SAOLEDB.12` OLE DB provider registration on deployment targets.
- Firebird 5 server install (or embedded `fbclient.dll` deployment) required on each workstation/server.
- Consider **embedded Firebird** for single-station installs — simpler install, no service to manage.
- `AppCompress.bat` (UPX) continues to work unchanged.

---

## 8. Smoke-test script (placeholder — fill in before Phase 1)

Manual test sequence to run after every phase boundary. Without an automated test suite, this is the safety net.

1. Launch app, verify connection to FB DB succeeds.
2. Log in.
3. Search existing customer, open record, verify data + image display correctly.
4. Create a new customer.
5. Create a new pawn transaction with 2+ items.
6. Take a partial payment on an existing pawn.
7. Change an item status to Redeemed.
8. Default a pawn — verify new `InventoryItems` row created with `InvItemStatus='S'` and `InvOriginalItemNo` set.
9. Print a receipt / item label.
10. Run one of each major report.
11. LeadsOnline export generates expected file.
12. Backup database — verify file written.

Expected outcome for each step documented before Phase 1 begins, so regressions are obvious.

---

## 9. Open questions / TBD

- **Firebird edition** — server install vs embedded vs SuperServer/Classic. Depends on per-store workstation count.
- **Authentication model** — keep hardcoded `dba` / `KAKITA` pattern, switch to per-store config, or introduce Firebird roles?
- **Rollout order** — which stores pilot first? (Smallest, most cooperative, lowest transaction volume is usually right.)
- **Rollback window** — how long do we keep the SA `.db` file in cold storage after cutover? (Recommend 30+ days.)
- **SA license wind-down** — coordinate with per-store switchover schedule.

---

## 10. References

- `.github/copilot-instructions.md` — detailed agent guide with patterns, status codes, integration points.
- `CLAUDE.md` — project essentials for Claude Code sessions.
- `A_ChangesNotes.txt` — canonical table definitions and FK relationships.
- `TableKeysUpdate.sql`, `GoldPriceHistory.sql` — recent schema migrations (reference when porting).