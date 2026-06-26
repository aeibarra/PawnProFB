# Plan: operate FB5 as disk-first image storage

**Status:** updated decision. FB5 will run stores in file-image mode by default,
but the DB-image code path stays in place for now as a fallback/future option.

**Goal:** every normal FB5 store stores item/customer-ID images as files under
the configured `ImageDirectory`. The pluggable `DATABASE`/`FILE` switch remains
available in code, but new/default FB5 configuration should be `FILE`.

**Why:** file storage keeps Firebird backups smaller and avoids BLOB cache
pressure. Keeping the DB path dormant costs less right now than deleting it,
and gives us a recovery option if a future deployment needs centralized image
storage again.

## Key fact about the schema (don't get this wrong)

**`IMAGES_DATA` table must stay** even in disk-only mode. The row is the
file's *locator*:
- `IMAGES_DATA_NO` (IDENTITY) → becomes the filename
- `CREATED` → becomes the YYYYMM folder
- `IMAGE_TYPE_NO` + `IMAG_REF_TO_ROW_NO` → links to the customer or item

Without the row, `GetImageFilePath` can't reconstruct the path. The only
column to drop in Phase 3 is the `IMAGE_DATA` BLOB. The metadata stays.

`IMAGES_DATA_BACKUP` is used by the file-image backup tracker and by the weekly
backup audit. Keep it while file-image backups are active.

`IMAGES_TYPES` is referenced by category lookups - keep.

## Current FB5 implementation notes

- `TfrmPawnMain.InitializeImageStorage` defaults blank/missing `StorageMode` to
  `FILE`.
- **The settings dialog (`frmImagesStorageSettings`) now offers FILE only.** The
  "Store in database" radio is disabled/unchecked in `FormShow`; any save writes
  `StorageMode=FILE`, so an old `DATABASE` ini self-corrects on the next save.
  The DB *read* backend stays bound at startup (see below) so the option is
  retired from the UI without deleting the code path.
- The procedure pointers `GetImageProc`, `SaveImageProc`, and `DeleteImageProc`
  still bind either the file or database backend. Do not remove them yet.
- `TDM.StartImageBackupAuditIfDue` launches after image storage initialization.
  It runs only Tuesday or Wednesday and only once per week, tracked by
  `[IMAGE_BACKUP] LastAuditWeek`.
- The audit compares source image files with backup image files by file size and
  SHA-256 hash. Missing or mismatched backups are marked for recopy by deleting
  the row from `IMAGES_DATA_BACKUP`.
- `IMAGES_DATA.IMAGE_DATA` must allow `NULL` so file-mode stores can keep image
  metadata rows without storing BLOB bytes.
- **Save validation** in `frmImagesStorageSettings.btnSaveClick`:
  - *Hard* — the local `ImageDirectory` must be non-blank and must exist; the
    dialog offers to create it (`ForceDirectories`). Save is blocked otherwise,
    since the folder is now the only home for images.
  - *Soft* — the shared UNC path is sanity-checked for a `\\` prefix only (no
    reachability probe, to avoid false negatives); the user may save anyway.
- After a successful save the dialog shows a notice and calls
  `Application.Terminate`, because image paths/backends are bound once at
  startup — a restart is required to apply them.

## Multi-workstation shared image path (APP_STATE)

For stores with more than one PC, the image folder lives on a share the
database-host PC owns, and every workstation must read/write the same folder.
This is coordinated through the general-purpose `APP_STATE` key/value table
(key `IMAGE_SHARED_PATH`, constant `AppStateKeyImageSharedPath`):

- **DB-host PC (`IsLocalDatabase = True`):** the admin types the UNC path
  (`\\server\share`) into the "Secondary Workstation Shared Image Path" box and
  saves. Only this PC sees the box and is allowed to write `APP_STATE`. Its own
  `ImageDirectory` stays the local path (e.g. `F:\PawnImages`).
- **Workstation (`IsLocalDatabase = False`):** `InitializeImageStorage` reads
  `IMAGE_SHARED_PATH` at startup and copies it into the workstation's local ini
  `ImageDirectory`. The box is hidden; nothing to type.
- Access goes through `DM.GetAppStateText` / `DM.SetAppStateText`, which call the
  `SPS_APP_STATE` / `SPU_APP_STATE` stored procedures. Both call sites are
  wrapped in `try/except` so startup and save stay non-fatal if the `APP_STATE`
  migration has not been applied yet.

## Order of operations

### Phase 0 — harden the migration tab BEFORE running it on real data

The ASA migration code (`TDM.ExportAllImagesToFolder`) and its FB5 twin
do NOT verify the file after writing. Several smaller gaps to close first:

1. **Add post-write verification.** Before incrementing `ExportCount`, reopen
   the just-written file and either compare byte-length to `ImageStream.Size`
   or compute MD5 on both sides. On mismatch, raise → caught by the per-image
   try/except, recorded in `ErrorMessage`, file NOT counted as exported.
2. **Guard `Created` null.** Skip the row (record in errors) rather than
   writing it into a `189912` folder when the source timestamp is missing.
3. **Optionally: nullify the BLOB after a successful, verified export** so
   there's a single source of truth going forward. (Skip if you want a
   rollback path available — see tradeoff below.)
4. **Optionally: resume on retry.** Check `FileExists(GetImageFilePath(...))`
   at the top of the loop; if present and same size as the BLOB, count and
   skip. Lets a crashed run restart cheaply.

Items 1 and 2 are must-do. 3 and 4 are nice-to-have.

### Phase 1 — verify on a sandbox copy of one DB-mode store

1. Run the hardened export on a **copy** of one of the 3 stores.
2. Confirm:
   - All rows in `IMAGES_DATA` produce a file under `ImageDirectory`.
   - `ErrorMessage` is empty.
   - The "retrieved from disk" path on `SearchClient` (qryItemImages
     scroll loading) returns the same image for each item that previously
     came from the DB.
   - The LeadsOnline export still attaches the right images after migration
     — note that `ExportImageToPath` **raises** if a file is missing, so
     this is a stricter test than UI display.
3. **Each store: copy current `ImageDirectory` + FDB to offsite** before
   running migration on the real store. This is the only rollback path.

### Phase 2 — migrate the 3 DB-mode stores (still on ASA)

### Phase 2 — migrate the 3 DB-mode stores (still on ASA)

1. For each store, run the hardened DB→Disk migration tab. Verify a sample of
   ~20 random items and a recent police export.
2. Set `[IMAGE_STORAGE] StorageMode=FILE` in the store's `PawnPro.ini`.
3. Leave the store running for **at least a week** before the FB5 conversion.
   Real-customer use surfaces issues a verification pass won't.

### Phase 3 — convert each store to FB5 with disk-mode INI

Same FB5 deploy as the other stores. Their `PawnPro.ini` is already in disk
mode; nothing image-specific to think about during the conversion itself.

### Phase 4 — optional future cleanup (deferred)

This deletion pass is deferred. Current FB5 keeps the DB-image backend code in
place even though stores should operate in `FILE` mode. Revisit only after a
longer production period proves the fallback is unnecessary.

| Possible future cleanup | Where |
|---|---|
| Drop `GetImageProc / SaveImageProc / DeleteImageProc` procedure-pointer vars | `PawnGlobal.pas` |
| Remove the startup binding that picks DB or File backend based on `ImageStorageMode` | `TfrmPawnMain.InitializeImageStorage` |
| Call the file procs directly at every call site that goes through the pointers | grep `GetImageProc(`, `SaveImageProc(`, `DeleteImageProc(` |
| Remove `TDM.*ImageFromDatabase` / `TDM.SaveImageToDatabase` / `TDM.DeleteImageFromDatabase` / `TDM.SaveImageToDatabase_FromPath` | `PawnDM.pas` |
| Simplify `TDM.ExportImageToPath` so the FILE branch is the only path | `PawnDM.pas` |
| ~~Drop the migration tab + DB radio button, keeping only folder selection~~ **DONE** — DB radio disabled, migration tab already disabled (DB→disk conversion is handled in the ASA version before pumping to FB5) | `frmImagesStorageSettings` |
| Remove `ImageStorageMode_Database` constant and treat file as the only mode | `PawnGlobal.pas` |
| Drop the `IMAGE_DATA` BLOB column from `IMAGES_DATA`, not the metadata table | future schema migration |

### Phase 5 — refresh deploy procedure

Current deploy procedure:
- `[IMAGE_STORAGE] StorageMode=FILE` by default
- `ImageDirectory` must point to a durable local path or share
- deployment/backups must protect the image folder, not just the FDB
- keep `IMAGES_DATA_BACKUP`; it tracks which image files have already been
  copied and is also used by the weekly audit repair path

## Open risks to revisit

- **Multi-workstation stores**: the image folder must live on a share that every
  workstation can reach. *Addressed* — the DB-host PC publishes the UNC path via
  `APP_STATE.IMAGE_SHARED_PATH` and workstations adopt it at startup (see
  "Multi-workstation shared image path" above). The save path soft-validates the
  UNC format only; it does **not** prove every workstation can actually reach the
  share, so confirm reachability per workstation during rollout.
- **Image folder size growth**: 95th-percentile store will accumulate
  thousands of item pictures. Make sure the chosen `ImageDirectory` has
  enough headroom (don't put it on the system drive unless C: is large).
- **The 3 stores that already migrated must KEEP their disk folder safe**
  through both transitions (ASA→disk, then ASA→FB5). Confirm offsite backup
  is running on each before Phase 1 starts.

## What gets deleted (rough preview)

If the fallback is removed later, expect to remove several `TDM` image methods,
the procedure-pointer vars, and the migration-tab DB option. Do not remove
`IMAGES_DATA`; even in disk mode it remains the locator table.
