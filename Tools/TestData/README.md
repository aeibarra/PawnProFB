# Test data — View Sent Tickets

Simulated LeadsOnline traffic, for exercising the **View Sent Tickets** screen
without waiting for a store to accumulate real submissions.

**Nothing here was ever sent to anyone.** These rows only make the app believe
tickets went out.

## ⚠ Never leave this in a database that goes to a store

`LEADS_SOAP_SUBMISSION` is how the app knows a transaction has been reported. A
transaction with a row here **leaves the send screen and is never offered
again**. Seed a store's live database and those transactions silently stop being
reported to law enforcement.

Use it on a development copy only, and undo it when finished.

## Seed

```
isql -i Seed_SentTickets.sql -user sysdba -password <pw> -ch UTF8 127.0.0.1/3050:PAWNDATA
```

50 submissions spread over the seven days ending on the generation date — the
screen's default range — against real transactions in the Perez Cash II
development copy.

Deliberately covers every branch the screen can render:

| | count | what it exercises |
|---|---|---|
| `Sent` | 38 | error code 0 |
| `Already sent` | 6 | codes 6 and 13 |
| `Failed` | 4 | codes 3, 4, 5, and one NULL code — a separate path |
| `Too old` | 2 | code 7 |

and all three Detail wordings for an accepted ticket: `No images` (19),
`n image(s) sent` (14), `n image(s) sent, m failed` (5).

Two rows sit on the range boundaries on purpose: `00:04:37` on the first day and
`23:52:11` on the last. The late one is the reason `SQLSent` casts
`SUBMITTED_AT` to a date — without the cast that row and every other of the
day's is excluded, because a bare upper bound means midnight. Measured on this
data: 50 rows with the cast, 43 without.

Image rows use `IMAGES_DATA_NO >= 900000` so they cannot collide with real ones,
and so the undo can find them.

## Undo

```
isql -i Unseed_SentTickets.sql -user sysdba -password <pw> -ch UTF8 127.0.0.1/3050:PAWNDATA
```

Deletes exactly the 50 transactions named in the file, and only image rows at or
above 900000. Real submissions are untouched.

## Regenerating

The transaction numbers are baked into both files. To target a different
database, pick 50 transactions that have items, a customer, and no existing
submission row, then rewrite both scripts around them.
