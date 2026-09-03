# PawnPro stores

The list of every pawnshop running PawnPro: who they are, what they run, and
where each one has got to. Maintained here rather than in a phone contact group,
because the details that matter for support are not the ones a contact card
holds.

**Gaps are marked, not omitted.** A blank is a thing to go and find out, and the
missing entries below are as much a part of the record as the filled ones.

## Every store

| store | LeadsOnline | database | stations | status |
|---|---|---|---|---|
| Perez Cash Jewelry II | SOAP | FB5 | single | live 2026-08-17 |
| Lucky Jewelry | SOAP | FB5 | single | live 2026-08-24 |
| Ricardo Joyeria | SOAP | FB5 | single | live 2026-08-25 |
| Felitin's Gold | SOAP | FB5 | single | live 2026-08-28 |
| Kendale Jewelry | SOAP | FB5 | **multiple** | live 2026-09-01 |
| Gema Jewelers | CSV/FTP | ASA | single | to migrate |
| Gold Star Pawn & Jewelry | CSV/FTP | ASA | **multiple** | to migrate |
| Perez Cash Joyeria | CSV/FTP | ASA | single | to migrate |
| I Love Miami Jewelry | CSV/FTP | ASA | single | to migrate |
| A Loz Jewelry | CSV/FTP | ASA | single | to migrate |
| A1 Jewelry Loans | CSV/FTP | ASA | single | to migrate |
| Ok Jewelers | CSV/FTP | ASA | single | to migrate |
| Home of Watches & Jewels | CSV/FTP | ASA | single | to migrate |
| AJ Jewelry | **none** | ASA | single | to migrate, no LeadsOnline |

Every remaining migration is a full one: ASA to Firebird 5 **and** onto the web
service in the same visit, as Felitin's and Kendale were.

## Builds

| version | what it is |
|---|---|
| **3.37.2.0** and later | licensed ReportBuilder. The build to ship. |
| 3.37.1.x | trial ReportBuilder. What the five live stores were installed with. |

The trial engine put a message on the **report preview only**. Paper printing was
unaffected throughout, so no pawn ticket, receipt or police report ever carried a
trial mark. It was an operator annoyance on screen, not something a customer or a
detective ever saw.

That matters most for the stores still to migrate, several of which lean heavily
on the reports — they will be installed on 3.37.2.0 or later and never meet it.

Each store writes its build into `APP_STATE.APP_VERSION` at startup, and the
About box shows the version and build date, so confirming a store has actually
been updated is a look at one screen rather than a guess.

## ⚠️ Perez Cash is two stores under one owner

Both names are official, and only the second carries a number:

| official name | where | state |
|---|---|---|
| **Perez Cash Joyeria** | 3611 W Flagler St, Miami FL 33135 | still on ASA |
| **Perez Cash Jewelry II** | 15118 SW 56th St, Miami FL 33186 | live on SOAP, store id `63256`, API user `pcj15118` |

There is no "Perez Cash I". The first store simply has no number in its name, so
the two are told apart by the presence or absence of the **II**, and by address.

Same owner, two locations. Separate databases, separate PawnPro installs, and
separate LeadsOnline store ids — the store id is what distinguishes locations
within one company.

**Two consequences.**

When Perez Cash Joyeria is migrated, say in the credentials request that it is
the same owner as Perez Cash Jewelry II, store `63256`. LeadsOnline set
credentials either at company level, one user name and password shared across the
locations, or per location; they will match whatever this owner already has, and
asking up front avoids a mismatch that would only surface at the first
submission.

And "Perez Cash" alone is ambiguous in conversation. The wrong one getting a
credential change, a conversion or an exclusion sweep is the kind of mistake that
is obvious only afterwards. Use the full name, or the street.
is obvious only afterwards. Say **1** or **II**.


> **API passwords are deliberately not in this file.**
> They live in each store's own database (`STORE.LEADS_ONLINE_API_PASSWORD`) and
> in the password manager. Writing a live credential into a tracked file is the
> exact habit that put a working SYSDBA password into this repository's history
> — see `Docs/SECURITY_PLAN.md`. The user name is recorded because it identifies
> the account; the password is not, because it opens it.

Credential scope, confirmed by LeadsOnline 2026-08-14: **one API user name and
password per company**, with the **store id** distinguishing locations. A
company with a single location gets store-level credentials automatically.

## Verify the store id before the first send

LeadsOnline confirmed the store id is the **same number for the FTP feed and the
API** — it does not change when a store switches channel. Perez Cash bore that
out: `STORE.LEADS_STORE_ID` already read `63271`, exactly what was issued.

So for every store, **check `STORE.LEADS_STORE_ID` against the id LeadsOnline
issued before sending a single ticket.** If they disagree, stop and ask. The two
possibilities are that a different id was issued for the API, or that the number
the store has been sending CSV under is wrong — and both mean tickets could land
against the wrong store's record with law enforcement. It costs one line of the
pre-cutover survey to rule out.

## How a store gets its own credentials

From LeadsOnline, 2026-08-24. Stores no longer need to go through us:

> They can email our support team at **support@leadsonline.com**. They will need
> to email **from the email address associated with the account**. They can state
> they are **using PawnPro**, and that they need their **API credentials**, and
> our support team will be able to give them what they need.

Three things have to be right or support cannot help: the request comes from the
account's own email address, it names **PawnPro**, and it asks for **API
credentials** — not a password reset, which would get them website login details
instead. Those are the words to give an owner.

**PawnPro is on their POS software list**, confirmed by LeadsOnline 2026-08-31.
New businesses signing up can now select it by name instead of describing it,
which is one less thing for a store owner to get wrong on the phone.

---

## 1. Perez Cash Jewelry II

The pilot. First store on the web service.

| | |
|---|---|
| **Legal name** | Perez Cash Jewelry II, INC. |
| **Trading name** | Perez Cash Joyeria II |
| **Address** | 15118 SW 56th Street, Miami, FL — see postcode note below |
| **Phone** | (305) 386-3338 |
| **Email** | rconcep1@comcast.net |
| **Florida police ID** | 0811 |

### LeadsOnline

| | |
|---|---|
| **Store ID** | `63271` |
| **API user name** | `pcj15118` |
| **API password** | not recorded here — see note above |
| **Endpoint** | production (`https://w3api.leadsonline.com/ticketWS.asmx`) |
| **Credentials issued** | 2026-08-17, by Russell House |
| **Legacy FTP user** | `perezcash` at `ftp.leadsonline.com` |

### Cutover

| | |
|---|---|
| **SOAP build installed** | 2026-08-17 |
| **Pilot confirmed good** | 2026-08-24, after a week of live use |
| **Week 1 result** | 14 tickets submitted, all accepted; 26 images uploaded, none failed; zero errors of any kind. See `Tools/StoreSurvey/PerezCash_WEEK1_2026-08-24.txt` |
| **Export method** | `'S'` — SOAP |
| **Skip CSV-already-sent** | on |
| **Sandbox flag** | off |

### Site notes

- **Single workstation.** No client machines, so the multi-station paths
  (shared image folder, workstation provisioning) are untested here.
- **Backups** go to `E:\`, images to `E:\PawnImages`. Automatic backup on close
  is **off** — backups depend on someone remembering. 5,295 logged at cutover.
- **Image storage** is FILE mode, like every FB5 store.

### Data at cutover (2026-08-17 baseline)

Full numbers in `Tools/StoreSurvey/PerezCash_BASELINE_2026-08-17.txt`.

| | |
|---|---|
| Pawns and purchases, all time | 38,742 (oldest 2000-09-01) |
| Never in any CSV export | 13,516 |
| Multi-item tickets that would send `$0.00` | 0 |
| Customers | 10,207 |
| Questionable dates of birth | 61 (12 missing, 48 future, 1 implausible) |
| Item photos / customer ID photos | 5,691 / 44 |

The 13,516 are mostly decades older than LeadsOnline's retention window and
would be refused with error 7. They are meant to be cleared with **Never send
these to LeadsOnline** on the export grid rather than submitted.

### Open items

- **Postcode disagreement.** The store record says `Miami, FL 33186`; the
  credentials request sent to LeadsOnline said `33185`. One is wrong, and it is
  the address on their LeadsOnline account. Not yet reconciled.
- **`AUTO_BACKUP_WHEN_CLOSE_APP` is off**, and their backup drive is on site.
- 61 dates of birth are worth correcting. With no resend in version 1, anything
  already submitted keeps the value it was sent with.

---

## 2. Lucky Jewelry

Scheduled. Credentials issued 2026-08-24; not yet installed.

| | |
|---|---|
| **Name** | Lucky Jewelry |
| **Address** | 12843 SW 42 St, Suite 2, Miami, FL 33175 |
| **Phone** | (305) 392-1998 |
| **Email** | Luckysjewelry@comcast.net |
| **Florida police ID** | — |

### LeadsOnline

| | |
|---|---|
| **Store ID** | `75764` |
| **API user name** | `luckysjewelry` |
| **API password** | not recorded here — see the note at the top |
| **Credentials issued** | 2026-08-24, by Russell House |
| **Endpoint** | production, once live |

### Cutover

| | |
|---|---|
| **SOAP build installed** | not yet |
| **Stations** | single workstation |

### Before installing

- Run `Tools/StoreSurvey/PreCutover_Survey.sql` and save the baseline.
- **Confirm `STORE.LEADS_STORE_ID` already matches the store id above.** If it
  does not, stop and ask before sending anything — see the store id note at the top.
- Check `AUTO_BACKUP_WHEN_CLOSE_APP` and where `BACKUP_PATH` points.

---

## 3. Ricardo Joyeria

Scheduled. Credentials issued 2026-08-24; not yet installed.

| | |
|---|---|
| **Name** | Ricardo Joyeria |
| **Address** | 11048 W Flagler St, Miami, FL 33174 |
| **Phone** | (305) 226-6800 |
| **Email** | ricardoconcepcion921@yahoo.com |
| **Florida police ID** | — |

### LeadsOnline

| | |
|---|---|
| **Store ID** | `71184` |
| **API user name** | `ricardojoyeria` |
| **API password** | not recorded here — see the note at the top |
| **Credentials issued** | 2026-08-24, by Russell House |
| **Endpoint** | production, once live |

### Cutover

| | |
|---|---|
| **SOAP build installed** | not yet |
| **Stations** | single workstation |
| **`RemoteBindAddress`** | set to `127.0.0.1` on 2026-08-25 (was `0.0.0.0`, listening on every interface) |

### Site notes

- **Backups** to `F:\PawnBackup`, images to `F:\PawnImagesBackup`, 5,082 logged.
  **`AUTO_BACKUP_WHEN_CLOSE_APP` is ON** — the only one of the three stores where
  it is, so backups do not depend on anyone remembering.
- **`STORE_POLICE_ID` is blank.** Perez Cash has `0811`, Kendale `810`. It does
  not affect SOAP submission, but printed police reports use it — worth asking
  whether they have one.
- **This store barely photographs.** 2,441 item photos across 58,809
  transactions, 21 customer ID photos across 17,588 customers. The Photos and
  IDs columns will read 0 on nearly every row. That is their practice, not a
  fault.

### Data at cutover (2026-08-25 baseline)

Full numbers in `Tools/StoreSurvey/RicardoJoyeria_BASELINE_2026-08-25.txt`.

| | |
|---|---|
| Pawns and purchases, all time | 58,809 (oldest 1958-04-18 — a typo) |
| Never in any CSV export | 53,865 |
| ...of those, from 2020 onward | **about 95** |
| Multi-item tickets that would send `$0.00` | 0 |
| Customers | 17,588 |
| Questionable dates of birth | 62 (27 missing, 26 future, 9 implausible) |
| Item photos / customer ID photos | 2,441 / 21 |

**The 53,865 looks alarming and is not.** The CSV export log only starts around
2020, and from there it covers everything: 2024 is 716 of 716, 2023 is 898 of
900, 2026 is 359 of 360. So virtually all of the unlogged history is pre-2020 —
decades past anything LeadsOnline retains.

### Cutover plan

1. Confirm **skip CSV-already-sent is ON** before the first load. It defaults to
   on, but Lucky proved it can end up off — see that store's notes.
2. Open the export screen and **exclude everything before 2020** in one pass.
3. That leaves roughly 95 rows, of which only the 2025 and 2026 ones stand any
   chance of being accepted; the rest settle themselves as error 7.

Perez Cash needed 13,515 exclusions. This is a bigger store with a smaller job.

### Before installing

- Run `Tools/StoreSurvey/PreCutover_Survey.sql` and save the baseline. ✅ done
- **Confirm `STORE.LEADS_STORE_ID` already matches the store id above.** ✅ reads
  `71184`, matching what LeadsOnline issued.
- Check `AUTO_BACKUP_WHEN_CLOSE_APP` and where `BACKUP_PATH` points. ✅ on, `F:\`

---


---

## 4. Felitin's Gold

Live on the web service since 2026-08-28.

| | |
|---|---|
| **Name** | Felitin's Gold Inc |
| **Address** | 10719 W. Flagler St, Miami, FL 33174 |
| **Phone** | (305) 200-5236 |
| **Email** | emilio314@yahoo.com |

### LeadsOnline

| | |
|---|---|
| **Store ID** | `63256` |
| **API user name** | `felitinsgold` |
| **API password** | not recorded here — see the note at the top |
| **Credentials issued** | 2026-08-27, by Russell House |
| **Verified** | 2026-08-27, `CheckLogin` against production returned errorCode 0 |
### Cutover

| | |
|---|---|
| **Converted ASA to FB5** | 2026-08-28 |
| **SOAP live** | 2026-08-28 |
| **Schema version** | 10 |
| **Build** | v3.37.1.20, commit `0abdc65+` |
| **Images** | already on disk before conversion, so no image migration |
| **Stations** | single workstation |
| **Store id confirmed** | `63256` in their database, matching what LeadsOnline issued |

### How it went

The conversion and the SOAP cutover were done in the same visit -- the first
store where both happened together, since the other three were already on
Firebird.

There was almost nothing to send. `NEVER_IN_A_CSV` was **1**: the file export had
already reported everything else. That single ticket was submitted and came back
"already exists", meaning LeadsOnline held it too and only the CSV log had missed
recording it. The export screen shows 0, and the store reports through SOAP from
its next transaction onward.

Baseline in `Tools/StoreSurvey/FelitinsGoldInc_BASELINE_2026-08-28.txt`.

| | |
|---|---|
| Pawns and purchases, all time | 1,193 (oldest 2018-08-16) |
| Never in any CSV export | 1 |
| Multi-item tickets that would send `$0.00` | 0 |
| Customers | 599 |
| Questionable dates of birth | 5, all in the future |
| Item photos / customer ID photos | 3,012 / 0 |
| Backups | `D:\Pawn`, **auto-backup ON**, 2,553 logged |
| Florida police ID | `03337` |

### Image blobs cleared, 2026-09-01

The pump that ran here still copied the ASA image blobs, so the database came out
at **397 MB** for 1,193 transactions -- 2,991 rows carrying 294 MB the Firebird
build never reads, because it reads images from disk.

Cleaned up with `Clear-ImageBlobs.ps1 -ClearBlobs -Shrink`:

| | |
|---|---|
| before | 379 MB |
| after | **14.2 MB** |
| image rows | 3,018, all intact |
| rows still holding a blob | **0** |

Far better than the ~100 MB estimated. The blobs were very nearly the whole
database.

Stores converted from 2026-08-28 do not inherit this -- the pump no longer
copies blobs, and asks first when a store's images are not yet on disk.

---

## 5. Kendale Jewelry

Live on the web service since 2026-09-01. The largest store, and the last conversion.

Not part of the same family as the other four — keep it off shared
correspondence, and copy only its own address on anything sent to LeadsOnline.

| | |
|---|---|
| **Name** | Kendale Jewelry |
| **Address** | 15154 SW 72nd Street, Miami, FL 33193 |
| **Phone** | (305) 382-1861 |
| **Email** | kndjewelryinc@aol.com |
| **Florida police ID** | 810 |

### LeadsOnline

| | |
|---|---|
| **Store ID** | `4351` |
| **API user name** | `kendalejewelry` |
| **API password** | not recorded here — see the note at the top |
| **Credentials issued** | 2026-08-27, by Russell House |
| **Verified** | 2026-08-27, `CheckLogin` against production returned errorCode 0 |
| **Legacy FTP user** | `kndjewelry` |

### Cutover

| | |
|---|---|
| **Images to file share** | 2026-09-01, before the conversion |
| **Converted ASA to FB5** | 2026-09-01 |
| **SOAP live** | 2026-09-01 |
| **Schema version** | 10 |
| **Build** | v3.37.1.20, commit `0abdc65+` |
| **Stations** | **multiple** — the first multi-workstation FB5 store |
| **Store id confirmed** | `4351` came through the pump from the live ASA database |

### How it went

All three changes in one day, in the order planned: images to the share while
still on ASA, then the pump, then the workstations.

**The pump's blob guard did its job.** It found 7,110 images stored inside the
ASA database, said they would not be copied, and waited — 25 seconds by the log —
before "Confirmed on disk. Blobs will be skipped." That prompt existed for
exactly this store, and this is the run it was written for. All 38 post-pump
validations passed; the NULL coercion summary was empty.

| | |
|---|---|
| Customers | 9,898 |
| Transactions | 29,656 |
| Inventory items | 70,815 |
| Stones | 30,727 |
| Image rows (no blobs) | 7,110 |
| Export log detail | 71,173 |

Submissions on the day: **33 sent, 33 accepted, no errors of any kind. 33 images
uploaded, none failed.** Every day from the cutover has written equal to
reported, and the export screen shows 0.

Baseline in `Tools/StoreSurvey/KENDALEJEWELRY_BASELINE_2026-09-01.txt`.

| | |
|---|---|
| Pawns and purchases, all time | 29,656 (oldest 2008-08-07) |
| Never in any CSV export | 547 |
| Multi-item tickets that would send `$0.00` | 0 |
| Questionable dates of birth | 138 (64 missing, 67 future, 7 implausible) |
| Item photos / customer ID photos | 7,110 / 0 |
| Backups | `D:\`, images to `D:\PawnImagesBck`, 2,555 logged |

### ⚠️ Four recent transactions were excluded by mistake

`EXCLUDED_BUT_RECENT` reads **4**, and it should read 0. These were caught in the
bulk exclusion — all 514 landed within half a second of each other, so it was one
sweep, and these four sat inside the selected range:

| ticket | date | type |
|---|---|---|
| 32711 | 2025-09-19 | Pawn |
| 32934 | 2025-12-10 | Purchase |
| 32977 | 2025-12-29 | Pawn |
| 33068 | 2026-01-31 | Purchase |

**None of the four ever appeared in a CSV export either**, so as things stand
they have never reached law enforcement through any channel.

The confirmation did warn — "4 of them are from the last 12 months" — which is
easy to skim past when the same dialog is excluding 514 rows. Worth remembering
that the warning is most likely to be missed exactly when it is most needed.

To undo: delete those four rows from `LEADS_SOAP_EXCLUDED` and they reappear in
the export list. Whether to send them is a judgement call — the oldest is nearly
a year old and may come back as error 7 regardless.

### Site notes

- **`AUTO_BACKUP_WHEN_CLOSE_APP` is OFF.** The only live store where it is, and
  the one with the least experienced staff, so backups depend on someone
  remembering. Worth turning on.
- **No customer ID photos at all** (0 of 9,898 customers), so the IDs column
  reads 0 on every row.
- Backups go to `D:\` root, images to `D:\PawnImagesBck`.

### Multi-station notes — all ran in production for the first time here

- `RemoteBindAddress` was left open rather than bound to `127.0.0.1`, which is
  the inverse of the single-station stores and so the setting most easily got
  wrong from muscle memory. `PawnProSetup` handles it when "multiple
  workstations" is selected.
- The firewall needs opening on the DB host:
  `COMMON/FB-Admin/Set-FirebirdFirewallRule.ps1`, elevated. Note a shop network
  Windows has categorised as **Public** silently defeats a Private-only rule.
- `APP_STATE['IMAGE_SHARED_PATH']` publishing, WireCrypt with `chacha.dll`, and
  `PawnProSetup`'s client-install branch all ran for real for the first time
  here, and all worked.
- Only the DB host applies schema migrations; a workstation started first will
  refuse with an instruction to run the server machine first. That is by design.

## Stores still to migrate

Basic details as supplied 2026-09-02. **Phone numbers and email addresses are
missing for most**, and both are needed: the email because LeadsOnline copy the
store on a credentials request, the phone because it is how you reach them on
the day.

Station count, image location and history size are unknown for all of them, and
those are the three things that actually decide how hard a migration is — see
"What decides the order" below.

### Gema Jewelers
9864 SW 40th St, Miami, FL 33165
Phone — · Email — · LeadsOnline store id —

### Gold Star Pawn & Jewelry
10158 W Flagler St, Miami, FL 33174
Phone — · Email — · LeadsOnline store id —

**MULTI-STATION -- the only one of the nine.** Everything Kendale needed applies
here and nowhere else: images to a share before the pump, the firewall opened on
the DB host, `RemoteBindAddress` left open rather than bound to loopback, and a
credential stored on each till. Tools are in `Tools/ImageShare`, and they have
not yet been run against a real share -- Kendale was done by hand before they
existed. Worth a rehearsal in the VM first, since there is no cheaper store to
learn on.

### Perez Cash Joyeria
3611 W Flagler St, Miami, FL 33135
Phone — · Email — · LeadsOnline store id —

**Same owner as Perez Cash Jewelry II**, which is already live on SOAP with
store id 63256 and API user pcj15118. Mention that when requesting credentials,
so LeadsOnline set this one up the same way. See the warning at the top.

### I Love Miami Jewelry
5889 NW 36th St, Miami, FL 33166
Phone — · Email — · LeadsOnline store id —

### A Loz Jewelry
6145 SW 8th St, Miami, FL 33144
Phone — · Email — · LeadsOnline store id —

### A1 Jewelry Loans (Frank's store)
8150 SW 8th St #125, Miami, FL 33144
Phone (305) 967-8981 · Email — · LeadsOnline store id —

### Ok Jewelers
10601 SW 40th St, Miami, FL 33165
Phone — · Email — · LeadsOnline store id —
**Same owner as Home of Watches & Jewels.**

### Home of Watches & Jewels
1876 SW 57th Ave, Miami, FL 33155
Phone (305) 264-3359 · Email — · LeadsOnline store id —
**Same owner as Ok Jewelers.**

Two locations under one owner is the first time the company-level credential
question becomes real. LeadsOnline support both arrangements: one user name and
password shared across a company's locations, or separate credentials per
location, with the store id distinguishing them either way. Ask which they have
been set up with before requesting anything.

### AJ Jewelry
3185 W 76th St, Hialeah, FL 33018
Phone — · Email — · LeadsOnline store id — **none**

**Does not use LeadsOnline.** Still needs the ASA to Firebird 5 conversion, but
no credentials, no export configuration, and `LEADS_ONLINE_EXPORT_METHOD` stays
`'N'`. A simpler migration than the rest, and a reasonable one to convert early
for that reason.

## What decides the order

Volume is the obvious way to rank these and it is not the one that predicted
difficulty in the first five. Felitin's was small and Kendale large, and both
conversions went cleanly; Kendale's only real trouble was the image share, and
Ricardo's only real work was 53,865 unreported transactions to exclude.

Four things decide how hard a store is, none of them size:

1. **How many workstations.** The one that actually bit at Kendale. A second till
   brings the image share, the firewall, `RemoteBindAddress` left open, and
   workstation provisioning.

   KNOWN as of 2026-09-02: only **Gold Star Pawn & Jewelry** is multi-station.
   The other eight are single. So eight of the nine are Felitin's-shaped jobs --
   convert and cut over in one visit -- and exactly one is Kendale-shaped.
2. **Where the images live.** In the ASA database means an extraction step before
   the pump; already on disk means neither.
3. **How much history never reached a CSV.** Decides whether the first export
   screen offers a dozen rows or fifty thousand.
4. **How much the store leans on the reports.** Several of the nine use them
   heavily, which is part of why they were left until later. Reports are the
   likeliest part of the app to need work after a conversion, and the
   late-payment report (`Report01`) is already known to have drifted and to be
   heavily used by exactly these stores. A report-dependent store is a longer
   job than its size suggests, and the work may land after the migration rather
   than during it.

Station count is now known. Image location and CSV history are not, for any of
the nine. An ASA-side survey would answer both before anything is scheduled, and
would collect each store's existing `LEADS_STORE_ID` at the same time — enough to request every set of credentials
from LeadsOnline in one message rather than nine.

## Template for the next store

Copy the block above. The fields that actually matter for support are: store id,
API user name, cutover date, single- or multi-station, and where backups land.

Before installing, run `Tools/StoreSurvey/PreCutover_Survey.sql` against a copy
of the store's database and save the output as
`Tools/StoreSurvey/<Store>_BASELINE_<date>.txt`. It is only capturable before
the new build goes in, and store data differs sharply — Kendale has 154
multi-item `$0.00` tickets and 137 questionable dates of birth where Perez Cash
had none and 61.

---

## Open items

- **All five live stores need the executable replaced** with 3.37.2.0. They are
  on 3.37.1.20, the trial-ReportBuilder build. Preview-only, so nothing on paper
  was ever affected, but the message is there on screen until they are updated.
  Confirm each one afterwards from the About box rather than assuming the copy
  landed.

Two more, both at Kendale, both easy to lose:

- **Four recent transactions excluded by mistake**, and none was ever in a CSV
  either, so they have reached law enforcement through no channel at all. The
  fix is on the USB at `C:\TempUSB\Kendale`. See Kendale's entry.
- **`AUTO_BACKUP_WHEN_CLOSE_APP` is off** — the only live store where it is, and
  the one whose staff are least likely to remember doing it by hand.

The CSV/FTP export still exists and still works. None of the five live stores is
using it; the nine still to migrate all are.
