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

## FireDAC / Firebird 5 Backup Helpers

- `DM.BackupDatabaseToFileWithConnection`
- `DM.BackupImagesToFolderWithConnection`
- `DM.LogBackupWithConnection`
- Shared Firebird Services API helper: `TFB5DBA.BackupDatabase`

## Important Notes

- `TFB5DBA.BackupDatabase` lives in `C:\ProjectsGIT\COMMON\Nvv.FB5.DBA.pas`.
- It uses FireDAC `TFDIBBackup`, not `gbak`.
- Manual backup and close-time backup should avoid `ConnDB`, `TADOQuery`, and SQL Anywhere backup syntax.
- `BACKUP_HISTORY`, `BACKUP_SETTINGS`, `IMAGES_DATA`, and `IMAGES_DATA_BACKUP` are the Firebird tables involved in this flow.
- Backup files are written as timestamped `.fbk` files using the `PawnPro` filename prefix.

## Verify Next

- Compile in Delphi 13.
- Test manual backup from the backup screen.
- Test "Do backup when closing application".
- Confirm `.fbk` file creation.
- Confirm image backup copies files.
- Confirm `IMAGES_DATA_BACKUP` is updated.
- Confirm `BACKUP_HISTORY` receives the written backup file path.
- Confirm failure messages are useful if backup path, image path, or Firebird connection settings are invalid.
