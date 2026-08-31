# Store survey — LeadsOnline SOAP onboarding

Read-only tooling for moving a store from the CSV/FTP export to the LeadsOnline
web service, plus the baselines already captured.

Nothing here modifies a database. Run-StoreSurvey.ps1 is meant to run against the
LIVE database at the store -- it only reads, and takes a gbak backup. The two SQL
scripts can be pointed at either the live database or a copy.

## Before the cutover

At the store, from the USB, with no arguments:

```
.\Run-StoreSurvey.ps1 -ExpectedStoreId 63256
```

It finds Firebird and PawnPro.ini itself, decrypts the database password from
`password_enc` (machine-scope DPAPI, so it only opens on that store's own PC --
no password is typed and none travels on the stick), runs the survey, takes a
`gbak` backup, and drops both into a dated folder beside the script. Passing the
store id LeadsOnline issued makes it check that against the database and shout
if they differ.

To run the SQL by hand instead:

```
isql -i PreCutover_Survey.sql -user sysdba -password <pw> \
     -ch UTF8 127.0.0.1/3050:C:\path\to\PAWNDATA.FDB
```

Answers the questions that decide whether a store is ready:

- the LeadsOnline store number to quote when requesting API credentials
- where backups land, and whether they are automatic
- how many transactions have never appeared in a CSV export — the real backlog
- multi-item tickets whose per-item amount is `$0.00`, split into "in the whole
  history" and "would actually be sent"
- customer date-of-birth problems, which cannot be corrected after sending
- stones that the mapper's inner joins would silently drop

Save the output as `<Store>_BASELINE_<date>.txt` in this folder. It is only
worth capturing *before* the new build goes in.

## After it has been running

```
isql -i Week1_Review.sql -user sysdba -password <pw> \
     -ch UTF8 127.0.0.1/3050:C:\path\to\PAWNDATA.FDB
```

Answers "did it actually work", which the survey cannot — the SOAP tables are
empty until the store starts sending. Needs schema version 10 or later.

Reports submissions by outcome, every failure that is **not** "too old"
(the read-this list), image uploads, exclusions made, what is still queued, and
whether backups continued.

**The number to watch is `STILL_TO_SEND_LAST_30_DAYS`.** It separates the
compliance-relevant backlog from old history nobody intends to send. Climbing
day over day means transactions are not going out; near zero means the channel
is working.

`EXCLUDED_BUT_RECENT` should stay 0. Anything else means someone excluded a
recent pawn, which is never reported to law enforcement.

## Baselines

| file | store | captured |
|---|---|---|
| `PerezCash_BASELINE_2026-08-17.txt` | Perez Cash Jewelry II | 2026-08-17, before the SOAP build |
| `PerezCash_WEEK1_2026-08-24.txt` | Perez Cash Jewelry II | 2026-08-24, after a week live |
| `RicardoJoyeria_BASELINE_2026-08-25.txt` | Ricardo Joyeria | 2026-08-25, before the SOAP build |
| `FelitinsGoldInc_BASELINE_2026-08-28.txt` | Felitin's Gold | 2026-08-28, after the FB5 conversion, before SOAP |

## Clearing image blobs left by an old pump

Pumps before 2026-08-28 copied the ASA image blobs into Firebird. The app never
reads them — it reads from disk — so they are dead weight. At Felitin's Gold
they are 294 MB of a 397 MB database, and every backup copies them.

```
.\Clear-ImageBlobs.ps1                  # verify only, changes nothing
.\Clear-ImageBlobs.ps1 -ClearBlobs      # null the blobs
.\Clear-ImageBlobs.ps1 -ClearBlobs -Shrink   # and rebuild the file
```

**Run the verify at the store.** It checks every blob against the file the app
would actually read — `<ImageDirectory>\yyyymm\<ImagesDataNo>.jpg` — and refuses
to clear anything if a file is missing, because for those rows the blob is the
last copy. Run against a database copy on another machine it reports everything
as missing, which is true of that machine and says nothing about the store.

`-Shrink` matters because the `UPDATE` alone does not shrink the file: Firebird
reuses freed pages and never truncates. Only a backup and restore rebuilds it
compactly. The rebuilt database is left beside the original rather than swapped
in, so the switch is yours to make with the service stopped.

Stores converted after 2026-08-28 do not need this — the pump no longer copies
blobs, and asks first when a store's images are not yet on disk.
