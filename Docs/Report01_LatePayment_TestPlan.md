# Late-Payment Report (Report01) — Test Plan

Verifies the **realigned** late-payment report, which now decides lateness through
the app's own interest engine (`DM.GetInterestAndNextPaymentInfo`) instead of the
old "months since last payment date" SQL proxy.

- **Seed:** [Schema/Test/Report01_LatePayment_TestSeed.sql](../Schema/Test/Report01_LatePayment_TestSeed.sql) — 11 controlled pawns (IDs 9001–9011).
- **Definition under test:** a pawn is late when `InterestOwedToday > 0`; *Months Late* = `Ceil(overdue interest / current monthly interest)`.
- All test pawns are principal **1000 @ 10%/mo = $100/mo** interest (except T08 zero-rate and T07 principal-reduced).

## How to run

1. Deploy the blank/seed DB, then load the seed:
   ```
   isql -i Schema\Test\Report01_LatePayment_TestSeed.sql -user sysdba -password <pw> 127.0.0.1/3050:C:\DB\PAWNDATA.FDB
   ```
2. Launch PawnPro → open the **Pawn with late payments** report.
3. Run **Preview** at **Months Late = 1**, then **= 2**, then **= 3**.
4. Compare against the matrix below. Rows are identified by the customer name (`T01…T11`) and ticket (`TEST-01…`).
5. When done, run the CLEANUP block at the bottom of the seed file.

## Expected results

Predicted from the engine logic. A disagreement is a finding worth investigating
(could be a real bug **or** an error in these hand calculations — check which).

| Case | Scenario | Late? | Months Late | Interest Owed | Next Due Date |
|------|----------|:-----:|:-----------:|--------------:|---------------|
| T01 | New pawn, no payments | No | — | — | — |
| T02 | 1 mo old, no payments | **Yes** | 1 | $100.00 | ≈ pawn date + 2 mo |
| T03 | 3 mo old, no payments | **Yes** | 3 | $300.00 | ≈ pawn date + 4 mo |
| T04 | 3 mo old, interest caught up | No | — | — | — |
| T05 | Prepaid 95 days ago, still covered | **No** | — | — | — |
| T06 | Token $50 payment 2 days ago | **Yes** | 3 | $250.00 | ≈ pawn date + 4 mo |
| T07 | Principal cut 1000→500 | **Yes** | 2 | $100.00 | ≈ pawn date + 3 mo |
| T08 | Zero-interest pawn | No | — | — | — |
| T09 | Closed pawn (status ≠ A) | No (excluded) | — | — | — |
| T10 | Layaway (type ≠ P) | No (excluded) | — | — | — |
| T11 | Exactly 2 mo behind | **Yes** | 2 | $200.00 | ≈ pawn date + 3 mo |

**Rows shown by threshold:**

| Months Late = | Rows that appear |
|:---:|---|
| 1 | T02, T03, T06, T07, T11 |
| 2 | T03, T06, T07, T11  *(T02 drops)* |
| 3 | T03, T06  *(T07, T11 drop)* |

## The two cases that prove the fix

These are the whole point — the old report got them **wrong**:

- **T05 (must NOT appear).** Its last payment is ~3 months old, so the old
  "months since last payment" logic would have flagged it ~3 months late. It is
  actually current (prepaid). If T05 shows up, the report is still keying on
  payment recency, not the money — **false positive not fixed.**
- **T06 (must appear).** Its last payment is 2 days ago, so the old logic saw a
  recent payment and treated it as current. It is genuinely behind. If T06 is
  missing, the report is under-reporting real arrears — **false negative not fixed.**

## Cross-check against the app (single-source proof)

Open **T06's** pawn in the normal payment screen and confirm it reports the same
past-due interest ($250) the report shows. Because the report now calls the same
`GetInterestAndNextPaymentInfo` engine, the two must agree to the cent. Agreement
is the evidence that the report can no longer drift from the app.

## Scope reminders

- Only **active pawns** (`TRAN_TYPE='P'`, `TRAN_STATUS='A'`) — T09 (closed) and
  T10 (layaway) confirm the filter.
- Layaways have their own installment schedule and are intentionally out of scope
  (the pawn-interest engine does not model them).

## Notes / known softness

- Pawn dates are set in **days** from today to sit mid-month-band, so the engine's
  day-based `MonthsBetween` is stable regardless of the run date. Near a real
  month boundary the classification is inherently fuzzier — see T07/T11 first.
- *Next Due Date* is a calendar value (`IncMonth`), so exact dates depend on the
  run date; the matrix gives the relationship, not literal dates.
