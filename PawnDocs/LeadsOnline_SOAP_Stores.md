# LeadsOnline SOAP — stores moved off the CSV/FTP export

The authoritative list of which pawnshops report to LeadsOnline through the web
service, and everything needed to support one without phoning someone.

Stores not listed here are still on the CSV + FTP export. Moving one is a
per-store decision: `STORE.LEADS_ONLINE_EXPORT_METHOD` is `'C'` (CSV) by
default and only becomes `'S'` (SOAP) when someone deliberately switches it on
the LeadsOnline Settings screen.

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

**PawnPro on their POS software list:** requested, not yet live. LeadsOnline are
checking with their IT team whether it can be added before deployment.

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

## Not yet on SOAP

| store | status |
|---|---|
| Kendale Jewelry | still on SQL Anywhere. Needs the ASA-to-FB5 conversion first, then SOAP. Multi-station, so it will be the first store to exercise the workstation paths. |
