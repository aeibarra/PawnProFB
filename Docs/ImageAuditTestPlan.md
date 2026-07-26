# Image Backup Audit — Test Plan

Validates the isolated weekly image-backup audit before it is re-enabled in
stores (phase 2). Everything here runs at a desk against a scratch database; the
audit's normal Tue/Wed schedule makes it untestable otherwise.

**Test scaffolding is compile-time only.** Enable it by uncommenting the define
in `AuditTestMode.inc`; disable it and the code is not compiled at all. Verified:
with the define off the Win64 Release build is byte-identical to the build
without any test code (17,961,976 code / 2,402,732 data).

---

## 1. Setup

### 1.1 Environment

| Requirement | Where | Notes |
|---|---|---|
| `StorageMode=FILE` | `PawnPro.ini` `[IMAGE_STORAGE]` | The audit exits immediately in DATABASE mode. |
| `ImageDirectory=<source>` | `PawnPro.ini` `[IMAGE_STORAGE]` | Must exist. |
| `BACKUP_IMAGES_PATH` | `BACKUP_SETTINGS` table | Must be set **and the directory must exist**, or the audit silently declines. |
| `FastMM_FullDebugMode64.dll` | beside the EXE | App will not start without it while `MMDEBUG` is on. |
| `PawnProFB.map` | beside the EXE | Only needed to resolve a captured trace. |

Use a **copy** of a store database. The audit issues
`DELETE FROM IMAGES_DATA_BACKUP`, which is how it flags an image for re-backup —
harmless, but not something to do to live data.

Aim for **at least 60–100 images** on disk; a real store image set is better
still. The throttle is 100 ms/image in both test and production builds, so
runtime ≈ `image count × 0.1 s` — about 11 minutes for a 6.6k-image store.
Hashing is negligible by comparison (a store's images average ~54 KB).

**`IMAGES_DATA_BACKUP` must be populated before T7.** That table is the
"already backed up" ledger: the normal backup copies anything *not* listed in it,
and the audit flags a bad image by **deleting** its row. If the table is empty,
the audit's marking is a silent no-op and T7 has nothing to observe. Check it:

```sql
SELECT COUNT(*) FROM IMAGES_DATA_BACKUP;   -- must be > 0, normally ≈ IMAGES_DATA
```

If it is 0, run one full image backup from the app first — that populates the
ledger (and exercises the backup path as a bonus).

### 1.2 Enable test mode

In `AuditTestMode.inc`, change `{.$DEFINE AUDIT_TESTMODE}` to
`{$DEFINE AUDIT_TESTMODE}` and rebuild. The audit then runs on **any** day,
ignores the weekly marker, starts 2 s after the main form appears, and exposes:

- **Ctrl+Shift+A** — start an audit now
- **Ctrl+Shift+W** — arm a 30 s uninterruptible stall in the next run

### 1.3 Evidence to collect

| File | Location | What it tells you |
|---|---|---|
| `ImageBackupAudit.log` | beside the EXE | start / finish / yield / abandon, with counts |
| `PawnProFB_MemoryManager_EventLog.txt` | beside the EXE | FastMM4 catching a bad free — **must not appear** |
| `PawnPro.ini` `[IMAGE_BACKUP]` | beside the EXE | `LastAuditWeek` / `LastAuditDate` markers |
| Task Manager → Details | — | `PawnProFB.exe` must disappear on close |

Delete `ImageBackupAudit.log` between tests so each run reads cleanly.

---

## 2. Tests

### T1 — Full run completes and records the marker

1. Clear `[IMAGE_BACKUP]` `LastAuditWeek` from `PawnPro.ini`.
2. Start the app, leave it idle until the log reports completion.

**Pass:** log shows `Image audit started.`, then `work list loaded: <N> images`,
then a `progress:` line about every 60 s, then
`Image audit finished: completed=True canceled=False checked=<N> …`, where `<N>`
equals the row count of `IMAGES_DATA` with `CREATED IS NOT NULL`. `LastAuditWeek`
and `LastAuditDate` are now written.

`different=` and `errors=` are separate counts on purpose: *different* means the
two copies genuinely disagree, *errors* means the file could not be read at all.
Both are re-queued for backup, but a non-zero `errors=` points at media or
permissions, and each one is logged individually with its image number.

> **Result 2026-07-26** (Kendalle copy, 6,596 images): PASS.
> `checked=6596 missing=0 different=1 last=6596`, marker written, clean exit, no
> FastMM event log. Wall time **16 min 29 s** (~150 ms/image) — budget ~17 min
> for a store this size. Note this run predates the `errors=` split, so its
> `different=1` is ambiguous by the standard above.

**Watch for:** `checked=0` means the source or backup directory check declined
the run — recheck 1.1. `completed=False` with a non-empty `error="…"` is a real
failure; capture the text.

### T2 — Camera capture preempts a running audit ⭐

The single most important test: this is the store-facing regression the gate was
built to prevent.

1. Start the app; wait for `Image audit started.` plus ~5 s.
2. Open an item and take a picture, normally.

**Pass:** the camera opens with no warning dialog and no perceptible delay; the
picture saves. The log shows the audit finished with `canceled=True` and
`error="Yielded to an interactive image operation…"`.

**Fail:** a *"Image maintenance is finishing up"* dialog means the audit did not
release within 3 s — note what it was doing (`last=` in the log gives the image
number). A hang longer than ~3 s means the yield is not being polled.

### T3 — Marker is NOT advanced by a yield

Immediately after T2, inspect `PawnPro.ini`.

**Pass:** `LastAuditWeek` is unchanged from before T2. A yielded audit must retry
later, not mark itself done. (If T1 ran first, compare against the T1 value —
the point is that T2 did not overwrite it with the current week.)

### T4 — Audit can restart after yielding

After T2, press **Ctrl+Shift+A**.

**Pass:** log shows `TEST: manual audit trigger` followed by a fresh
`Image audit started.` This exercises the fix for the previously single-shot
controller — before it, the second run silently did nothing.

### T5 — Backup preempts the audit

1. Start the app; wait for the audit to start.
2. Run a manual backup with the image option enabled.

**Pass:** the backup proceeds and reports copied/skipped counts. The audit log
shows a yield. No *"Another image maintenance operation is running"* error.

### T6 — Capture blocks a backup (the non-preemptible direction)

1. Open the camera capture window and leave it open.
2. From another window, start a backup with images.

**Pass:** the backup reports *"A picture is being taken right now. Try the image
backup again in a moment."* — and succeeds on retry once the camera closes. This
confirms a backup does **not** interrupt an in-progress capture.

### T7 — Detection is correct

**Precondition:** `IMAGES_DATA_BACKUP` is populated (see 1.1). With the app closed:

1. **Delete** one file from the backup root (`<backup>\yyyymm\<n>.jpg`).
2. **Truncate** a second one (copy a different, smaller jpg over it).
3. Note both `IMAGES_DATA_NO` values, and confirm each currently has a row in
   `IMAGES_DATA_BACKUP`.
4. Run a full audit.

**Seed three defects, not two.** The third is the one that matters: flip a
single byte in the middle of a backup file, leaving its **size unchanged**. Only
the SHA-256 comparison can catch that; the size check passes it. Without this
case the hash arm of the audit is never exercised.

**Pass:** log reports `missing=1 different=2 errors=0`, and all three rows are
gone from `IMAGES_DATA_BACKUP`. Removing the row is what marks an image for
re-backup — a deleted row is the success signal, not a problem.

> **Result 2026-07-26: initially FAILED, and found a real defect.**
> First run reported `missing=1 different=1` — the byte-flipped image was NOT
> detected. Root cause: `SHA256OfFile` used Indy's `TIdHashSHA256`, which routes
> through `IdFIPS` and needs OpenSSL. This app does not load it, so
> `IsAvailable` was False and `HashStreamAsHex` returned an **empty string for
> every file** — silently, no exception. `SameText('','')` is True, so **every
> content comparison the audit ever performed reported "identical"**. In
> practice the audit only detected missing files and size mismatches; a
> corrupted backup image of the correct size was never caught. The defect
> predates the isolation refactor (the original `SHA256OfStream` in `PawnDM.pas`
> used the same class).
>
> Fixed by switching to `System.Hash.THashSHA2` (RTL, always available),
> verified against PowerShell `Get-FileHash` digests. An empty digest now raises
> instead of comparing equal, so this cannot fail silently again.
> `TCancellableReadStream` was deleted — chunked reads check cancellation
> directly. Re-run: `missing=1 different=2 errors=0`, ledger 6607 → 6604. PASS.
>
> **Lesson:** the size shortcut masked a totally dead hash path. Any future
> change here must keep a same-size defect in the test data.

### T8 — Clean shutdown during a run ⭐

1. Start the app; wait for `Image audit started.`
2. Close the app normally while the audit is mid-run.

**Pass:** the log's final line is `Application closing with an audit worker still
active; it will be abandoned.` or the clean-exit variant, and **`PawnProFB.exe`
disappears from Task Manager within a few seconds**. No memory-manager event log
appears.

**Fail:** a `PawnProFB.exe` with no window still listed after ~10 s is the exact
ghost-process symptom under investigation — capture the log and a process dump.

### T9 — Abandon path under a wedged worker ⭐

Forces the failure mode that an unbounded wait used to turn into a permanent
ghost process.

1. Start the app, press **Ctrl+Shift+W** (log confirms the wedge is armed).
2. Press **Ctrl+Shift+A** to start a run, wait ~3 s.
3. Close the app.

**Pass:** close takes roughly 8 seconds (5 s bounded wait + 3 s abandon), the log
records `…did not exit within 3000 ms -- abandoning it…`, and the **process
still exits**. The deliberate leak is expected and is not reported, because
FastMM leak reporting is debugger-gated.

**Fail:** the process never exits, or an access violation is logged during
shutdown.

### T10 — Locale independence of the marker

1. Switch Windows to a locale using `.` or `/` as date separator (e.g. German).
2. Run a full audit.

**Pass:** `LastAuditDate` is still written as `yyyy-mm-dd`, and log timestamps
still use `hh:nn:ss`. This guards the invariant `TFormatSettings` — note that
`:` in a Delphi format string is the *TimeSeparator placeholder*, not a literal,
so a global locale change would otherwise reach the log too.

### T11 — Idle build sanity (no audit)

Turn the define **off**, rebuild, and use the app normally for a working session:
open transactions, take pictures, run a backup, close.

**Pass:** no `ImageBackupAudit.log` is created beyond the shutdown marker line,
no memory event log, clean exit. This is the phase-1 build — the one that goes to
the stores.

---

## 3. Exit criteria for phase 2

Re-enable the audit in stores only when:

- [ ] T2, T8, T9 pass — the three that map directly to reported symptoms
- [ ] T1, T7 pass — the audit actually does its job
- [ ] No `PawnProFB_MemoryManager_EventLog.txt` produced by any test
- [ ] A full working session on the test-mode build shows acceptable performance
      under FastMM FullDebugMode (this is the risk that could get the build
      rejected by the stores)
- [ ] Test mode is **off**, the code is **removed** (§4), and the shipped build
      is rebuilt and re-verified

---

## 4. Removing the test code

1. Comment the define in `AuditTestMode.inc`; build; confirm normal behaviour.
2. `grep -rn "AUDIT_TESTMODE\|AuditTestMode.inc"` — both patterns are needed;
   the `{$I}` include lines do not contain the define name. Expected sites:
   - `AuditTestMode.inc` (the whole file)
   - `PawnMain.pas` — include directive, `uImageBackupAudit` in uses, the
     `AuditTestKeyDown` declaration and body, the `FormCreate` hookup, the
     const block in `StartImageAuditIfDue`, the day/marker bypasses, and the
     `FormShow` call
   - `uImageBackupAudit.pas` — include directive, `AuditTestWedgeNextRun`, and
     the wedge block
3. Delete every block, then the include directives, then the file itself.
4. Rebuild and confirm the code/data sizes match the pre-test-mode production
   build: **17,961,976 code / 2,402,732 data**. That number is the proof the
   scaffolding is gone.

## 5. What this plan does not cover

- Multi-workstation contention. The gate is process-local; two workstations
  auditing the same share simultaneously are not serialised against each other.
  Not a new risk (the audit only ever ran on one machine), but it is the first
  thing to revisit if the audit is ever moved to a separate executable.
- A genuinely unreachable UNC backup path mid-run. The bounded shutdown covers
  the symptom; the underlying stall is only observable via T9's simulation.
- Whether the audit's findings are *acted on* — that is the normal image backup's
  job, exercised separately.
