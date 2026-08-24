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
company with a single location gets store-level credentials automatically. The
store id is the same number for the FTP feed and the API — it does not change
when a store switches channel.

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

Scheduled. Credentials not yet issued.

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
| **Store ID** | not yet recorded — read `STORE.LEADS_STORE_ID` from their database |
| **API user name** | not yet issued |
| **Endpoint** | production, once live |

### Cutover

| | |
|---|---|
| **SOAP build installed** | not yet |
| **Stations** | single workstation |

### Before installing

- Run `Tools/StoreSurvey/PreCutover_Survey.sql` and save the baseline.
- Read `LEADS_STORE_ID` from the survey and quote it when requesting credentials.
- Check `AUTO_BACKUP_WHEN_CLOSE_APP` and where `BACKUP_PATH` points.

---

## 3. Ricardo Joyeria

Scheduled. Credentials not yet issued.

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
| **Store ID** | not yet recorded — read `STORE.LEADS_STORE_ID` from their database |
| **API user name** | not yet issued |
| **Endpoint** | production, once live |

### Cutover

| | |
|---|---|
| **SOAP build installed** | not yet |
| **Stations** | single workstation |

### Before installing

- Run `Tools/StoreSurvey/PreCutover_Survey.sql` and save the baseline.
- Read `LEADS_STORE_ID` from the survey and quote it when requesting credentials.
- Check `AUTO_BACKUP_WHEN_CLOSE_APP` and where `BACKUP_PATH` points.

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
