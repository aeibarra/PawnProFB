# Late-Payment Report (Report01) — Performance Test

Measures how the realigned report scales, since it now loops **per active pawn**
(two DB round-trips each) instead of a single SQL proc. Uses a real medium-large
store DB as the load.

## The sample: Kendalle store DB

`C:\ProjectsGIT\PawnPro\DB\Kendalle\PAWNDATA.FDB` (68.9 MB). Measured 2026-07-18:

| Metric | Value |
|---|---|
| Customers | 9,785 |
| Transactions (all) | 29,148 |
| **Active pawns** (`TRAN_TYPE='P'`, `TRAN_STATUS='A'`) | **22,147** ← loop size |
| Active pawns with amount + rate (will accrue) | 22,051 |
| Active pawns older than 2 months | 22,147 (all) |
| Payment rows (whole DB) | 3 |
| `PAYMENTS.TRANSACTION_NO` indexed? | Yes (`FK_PAYMENTS_TRANSACTIONS`) |

**Read this as a worst case, not a typical store.** Two data-quality quirks in
this copy make it a stress ceiling:

- **Every transaction is `TRAN_STATUS='A'`** — nothing was ever closed (a pump
  artifact). A real store closes most pawns, so its *active* count is far lower.
  Here the report must process all 22,147.
- **Essentially no payments** (3 rows). So almost every active pawn accrues
  interest with nothing paid → **~22,000 of them come back "late"**, and the
  report both loops 22k times *and* renders ~22k rows.

That is exactly the ceiling worth measuring: max loop iterations **and** max
render. A realistic store (say 300–2,000 active pawns) will be far faster, but if
22k is acceptable, anything smaller is safe.

Even the max `Months Late = 100` filter keeps ~15k rows here (most pawns are 10+
years old), so the threshold can't be used to shrink the render — use the
instrumentation below to separate the phases instead.

## Step 0 — fix the progress-throttle bug first (it dominates timing)

In `BuildLateList` the intended every-5th-row progress update is broken:

```pascal
if (clnLatePawn.RecNo mod 5) = 0 then
  lblProgress.Caption := ... ; Update;   // <-- Update; runs EVERY row
```

The `Update;` is a separate statement, so a **full-form repaint fires on every
iteration** — 22,000 repaints. Fix it (also repaint only the label, and throttle
harder for a big loop):

```pascal
if (clnLatePawn.RecNo mod 250) = 0 then
begin
  lblProgress.Caption := clnLatePawn.RecNo.ToString + ' of ' +
                         clnLatePawn.RecordCount.ToString;
  lblProgress.Update;          // repaint just the label, ~90 times total
end;
```

Without this fix you are timing GDI repaints, not the algorithm.

## Step 1 — add phase timing (temporary)

`uses System.Diagnostics;` then in `PrintReport`, wrap the three phases:

```pascal
var swOpen, swBuild, swRender: TStopwatch;

swOpen := TStopwatch.StartNew;
clnLatePawn.Close;
clnLatePawn.Open;                      // spLatePawn fetch of all active pawns
swOpen.Stop;

swBuild := TStopwatch.StartNew;
BuildLateList(LateMonths);             // the per-pawn N+1 loop
swBuild.Stop;

// ... title caption ...
swRender := TStopwatch.StartNew;
RepLatePawn.DeviceType := PrnPreview[Preview];
RepLatePawn.Print;                     // two-pass render
swRender.Stop;

ShowMessage(Format(
  'Active pawns: %d'#13'Open: %d ms'#13'BuildLateList: %d ms'#13'Render: %d ms',
  [clnLatePawn.RecordCount, swOpen.ElapsedMilliseconds,
   swBuild.ElapsedMilliseconds, swRender.ElapsedMilliseconds]));
```

## Step 2 — run

1. Point a test `PawnPro.ini` at the Kendalle DB and launch the app.
2. Open **Pawn with late payments**, set **Months Late = 1**, click **Preview**.
3. Record the three phase times from the message box. Run 2–3 times (first run is
   cold cache; later runs show warm steady-state).

## What to expect and watch

- **`BuildLateList` is the number that matters.** It runs `2 × 22,147 ≈ 44,000`
  indexed queries (`qryTran` by PK + `qryPay` by FK). Even at a few tenths of a ms
  each this is seconds; if it dominates, the N+1 pattern is the bottleneck.
- **Render is two-pass** (`PassSetting = psTwoPass`, needed for "Page X of Y"), so
  ~22k rows are laid out twice. Expect this to be the second-largest cost.
- **Open** should be modest (one query, 22k small rows).

## The optimization this test justifies

If `BuildLateList` is slow, collapse the per-pawn round-trips (~44k) to two total:

1. **Eliminate `qryTran`** — add `TRAN_INTEREST` to `spLatePawn`'s SELECT (and a
   matching CDS field). Amount and pawn date are already in the pipeline. No
   per-pawn rate lookup needed.
2. **Eliminate per-pawn `qryPay`** — one bulk query
   `SELECT TRANSACTION_NO, PAY_DATE, PAY_INTEREST, PRINC_BALANCE FROM PAYMENTS
   WHERE ... ORDER BY TRANSACTION_NO, PAY_DATE`, walked in sync with the pawn loop
   (both ordered by transaction), feeding each pawn's slice to the engine.

That takes the loop from ~44,000 queries to ~2, and should move `BuildLateList`
from seconds to well under a second. Re-run the test after the change to confirm.

## Acceptance guidance

There's no hard SLA, but as a yardstick on this 22k worst case: a total under
~3–5 s is comfortable for an on-demand report; several tens of seconds means ship
the bulk-query optimization before the next stores rely on it. Whatever the
number, a real store (hundreds–low-thousands of active pawns) scales down roughly
linearly from here.
