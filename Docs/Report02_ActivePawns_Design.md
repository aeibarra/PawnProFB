# Report02 — "List of Active Pawns"

Design note and deferred-work record.
Analysis run 2026-09-04 against all six live FB5 store databases.

## The short version

The report's filter is **correct**. It is consistent with the way pawn status is
handled now, and needs no logic change.

The report is nevertheless unusable at four of the six stores, because most
stores have never recorded a redeem or a default. Every legacy pawn therefore
evaluates as open, and the report prints the store's entire history — 56,325
pawns at Ricardo, back to 1958.

Two separate problems, and only the first is a code change:

1. **The report has no date bound.** Fix this in the report.
2. **The old data says every pawn is open.** Fix this per store, in the data —
   **deferred until a store asks for the report.**

## How pawn status actually works

Three signals exist. Only one is authoritative.

**Authoritative — the item date columns.** `INVENTORY_ITEMS.REDEEMED_DATE` and
`DEFAULTED_DATE` are the stored lifecycle facts, written by
`TDM.UpdatePawnItemStatusAndStage`. Design origin: `InvItems_StatusLifeCycleFields.txt`.

**Derived — the pawn-level rollup.** `qryGetPawnStatusFromItems` (`PawnDM.dfm`)
reduces the items to one code:

| code | meaning | rule |
|---|---|---|
| 0 | Pawn Open | **any** item with both dates NULL |
| 2 | Redeemed | all items redeemed |
| 3 | Defaulted | all items defaulted |
| 4 | Mixed | a mix of the two |

`TDM.UpdatePawnStatusBaseOnItems` (`PawnDM.pas`) then writes that code into
`TRANSACTIONS.TRAN_STATUS` and `TRAN_CLOSE_REASON`.

**So `TRAN_STATUS = 'A'` is a maintained cache of the item dates.** The report's
`TRAN_TYPE='P' AND TRAN_STATUS='A'` is exactly the right test.

`Report_2` (Transaction Payments) uses the same test, and voids close through
`SetPawnAndItemsStatus(..., TranStatusInactive, ...)`, so they are excluded too.
Both are consistent.

### `INV_ITEM_STATUS` is not a lifecycle column

It is `'P'` on **100%** of pawn items in all six stores. Nothing ever changes it —
`UpdatePawnItemStatusAndStage` writes only the date columns. The comment on
`TDM.GetItemStatus` already calls it "an unreliable legacy char."

It is a stock class (pawn item vs. for-sale stock), not a state. Do not reach
for it as an alternative filter; there is no alternative filter.

## Why the report is unusable today

`REDEEMED_DATE` is set on **0–72 items per store**, out of tens of thousands.
Stores have not been using the close workflow. Every pumped pawn has NULL dates,
so the rollup returns 0 = Open for all of them.

The rollup runs only when someone opens or changes that transaction, so history
never corrects itself.

Measured 2026-09-04:

| store | prints as "Active" | last 6 months | over 2 yrs | over 10 yrs | oldest |
|---|---|---|---|---|---|
| Ricardo | 56,325 | 267 | 53,137 | 45,715 | 1958 |
| Perez Cash II | 34,058 | 209 | 32,964 | 27,103 | 2000 |
| Kendale | 22,558 | 327 | 21,030 | 14,751 | — |
| Lucky | 1,207 | 83 | 802 | 0 | 2021 |
| Felitin's Gold | 1,189 | 82 | 810 | 0 | — |
| Gema | 107 | 72 | 2 | 0 | 2024 |

Kendale prints every pawn it has ever written — 22,558 of 22,558.

The last-6-months column is the plausible working list: **~80–330 per store.**

### This is not a migration artifact

The pump copies `TRAN_STATUS`, `TRAN_CLOSE_REASON` and `INV_ITEM_STATUS`
unchanged (`Pump_ASA_FB/PumpAsaFb50Main.pas`). The ASA source data genuinely
looks like this. Nothing was lost in the conversion.

## Decision

Stores that do not use the statuses do not currently run this report, so nothing
is broken for anyone today. The trigger for action is a store starting to use
the statuses and then wanting the report.

- **Do now:** bound the report (part 1 below).
- **Do on demand:** clean the old data for that one store (part 2 below).

Do not run a blanket backfill across all stores ahead of a request. A store that
begins recording redeems properly will have its recent pawns correct from that
day forward; only its pre-existing rows need a decision, and that decision is the
owner's.

## Part 1 — bound the report

`Report02.pas`, `Report_1`, the `else` branch (`rbDateRange` unchecked):

```pascal
lblRep1PawnAndPurchaseTitle.Caption := 'List of Active Pawns';
qryPawnAndPurchases.SQL[Param_LineNo_qryPawnAndPurchases] :=
  'and T2.TRAN_TYPE = ''P'' and T2.TRAN_STATUS = ''A'' ';
```

There is no date restriction of any kind here.

### Requirement

The bound must be **visible and adjustable by the operator**, with a sensible
default — not a silent hardcoded cut.

A store that *does* keep its statuses correct may legitimately hold a genuinely
open pawn older than any default we pick. Silently dropping it would turn a
noisy report into a wrong one, which is worse. The operator must be able to see
what is being excluded and widen it.

### Recommended shape

Add to the active-pawns branch an age limit expressed against `TRAN_DATE`, with:

- a default of roughly 24 months, wide enough to cover a legitimately extended
  pawn and narrow enough to cut the archive;
- a control on the form to change it, and an option meaning "no limit" that
  reproduces today's behaviour exactly;
- the limit in force printed in the report header, so a short report is never
  mistaken for an empty one.

`TRAN_MATURITY` was considered instead of `TRAN_DATE`. Rejected for the default:
it is derived from the pawn terms and is not reliably populated in legacy rows,
so it would reintroduce the same "unmaintained column" failure this document is
about. `TRAN_DATE` is always present.

Apply the same treatment to `Report_2`, which has the identical unbounded branch.

## Part 2 — the old data, when a store asks

Only for the store that asks. Sequence:

1. **Measure first.** Re-run the age table above for that store alone. The
   split between the last 6 months and over 2 years is the whole conversation.
2. **Ask the owner what the old rows mean.** They are almost certainly a mix of
   redeemed and defaulted, and the store no longer knows which. That is an
   owner's judgement, not ours to assume.
3. **Set `DEFAULTED_DATE` on items past a cutoff the owner agrees to**, then let
   `UpdatePawnStatusBaseOnItems` recompute `TRAN_STATUS` — or write the
   equivalent update directly. Do not invent `REDEEMED_DATE` values: a false
   redeem is a false statement about a customer's property, while a default on a
   twenty-year-old pawn is merely the truth stated late.
4. **Back up before touching anything**, and keep the pre-change count so the
   result can be checked against it.

Note the trigger in `InvItems_StatusLifeCycleFields.txt` forbidding both dates on
one item — any backfill must respect it.

### Related

Gema deletes pawns outright after redeem or default, which is the same
underlying problem — the statuses going unused — with a worse outcome, since
there is no row left to correct. See `PawnDocs/PawnPro_Stores.md`.
