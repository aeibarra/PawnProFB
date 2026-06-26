# Firebird 5 Backup Migration Session

Date: 2026-04-28

## Focus

Migrating PawnPro backup processes from SQL Anywhere/ADO to Firebird 5/FireDAC.

## Files Involved

- `BackupDB.pas`
- `BackupDB.dfm`
- `PawnDM.pas`
- `PawnMain.pas`
- `C:\ProjectsGIT\COMMON\Nvv.FB5.DBA.pas`

## Current State

The manual backup screen uses an async `TTask` so the UI does not appear frozen during database and image backup.

The "backup when closing application" flow in `PawnMain.FormCloseQuery` also runs the backup work in a `TTask`. The app still waits for the backup before closing, but the progress form can repaint while the work runs.

Both backup paths now use worker-owned `TFDConnection` instances configured by `DM.ConfigureFBConnectionFor`.

The file-image backup now has a weekly background audit. On application launch,
after image storage is initialized, `DM.StartImageBackupAuditIfDue` starts a
lowest-priority worker only when:

- `[IMAGE_STORAGE] StorageMode=FILE`
- the configured image folder and backup image folder both exist
- today is Tuesday or Wednesday
- `[IMAGE_BACKUP] LastAuditWeek` is not the current `yyyy-ww` value

The audit waits briefly after startup, walks `IMAGES_DATA`, rebuilds the
expected source and backup paths from `CREATED` + `IMAGES_DATA_NO`, then
compares file size and SHA-256 hash. If the backup file is missing or differs,
it deletes the matching row from `IMAGES_DATA_BACKUP`; the normal image backup
will then copy that image again. `LastAuditWeek` is written only after the
audit loop finishes.

## FireDAC / Firebird 5 Backup Helpers

- `DM.BackupDatabaseToFileWithConnection`
- `DM.BackupImagesToFolderWithConnection`
- `DM.StartImageBackupAuditIfDue`
- `DM.LogBackupWithConnection`
- Shared Firebird Services API helper: `TFB5DBA.BackupDatabase`

## Important Notes

- `TFB5DBA.BackupDatabase` lives in `C:\ProjectsGIT\COMMON\Nvv.FB5.DBA.pas`.
- It uses FireDAC `TFDIBBackup`, not `gbak`.
- Manual backup and close-time backup should avoid `ConnDB`, `TADOQuery`, and SQL Anywhere backup syntax.
- `BACKUP_HISTORY`, `BACKUP_SETTINGS`, `IMAGES_DATA`, and `IMAGES_DATA_BACKUP` are the Firebird tables involved in this flow.
- Backup files are written as timestamped `.fbk` files using the `PawnPro` filename prefix.
- The image audit uses a worker-owned `TFDConnection`; it must not use `DM.ConnFB` or shared query components from the thread.
- The audit is intentionally throttled with a small sleep per image to reduce disk pressure during store hours.

## Verify Next

- Compile in Delphi 13.
- Test manual backup from the backup screen.
- Test "Do backup when closing application".
- Confirm `.fbk` file creation.
- Confirm image backup copies files.
- Confirm `IMAGES_DATA_BACKUP` is updated.
- Confirm weekly audit marks missing or mismatched backup images by removing rows from `IMAGES_DATA_BACKUP`.
- Confirm `[IMAGE_BACKUP] LastAuditWeek` is updated only after a completed audit.
- Confirm `BACKUP_HISTORY` receives the written backup file path.
- Confirm failure messages are useful if backup path, image path, or Firebird connection settings are invalid.
