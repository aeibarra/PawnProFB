# Pawn Information  (`EnterTransactions.pas`)

**Purpose:** Add or edit a single transaction row (Pawn / Purchase / Layaway).
A second mode lets the user create a *new* transaction by copying items from
one of the customer's previous pawns (the "items-to-select" panel at the
bottom of the form is shown only in this mode).

**Entry points:**
- Plain Add/Edit — `SearchClient.AddEditTransaction(NewTransaction)` builds the
  form and calls `ShowModal`. Caller sets `NewRow`. Copy-mode stays off.
- Copy items from previous pawn — `SearchClient.btnNewWithCopyItemsClick`
  builds the form and calls `frmEnterTransaction.PrepareForCopyItems(
  SourceCustNo, SourceTransactionNo)` which sets the source IDs and forces
  `NewRow := true`. The form then shows the items grid and pre-loads
  `clnItemsToSelect` with the customer's previous items.

**Exit modes:**
- `mrOK` — `qryTransactions.Post`; in copy mode, also inserts new rows into
  `INVENTORY_ITEMS` (one per checked item) and clones their `STONES` rows.
  All three operations run inside a single FB transaction.
- `mrCancel` — `qryTransactions.Cancel`; nothing is committed.

---

## Controls and rules

### `btnRecalcIntSameDayCreated` — "Re-Calc Interest"

- **When visible:** editing an existing Pawn that was created **today**. Hidden
  for new transactions, non-Pawn types, and any transaction created on a
  previous day. Expression:
  `not NewRow and TRAN_TYPE = TranPawn and TRAN_DATE = Date`.
- **What it does:** calls `edPawnAmountExit(nil)` which recomputes
  `TRAN_INTEREST` and `INTEREST_BALANCE` from the current `TRAN_PAWN_AMOUNT`
  using `DM.CalcInterest`.
- **Why:** if the clerk corrects the pawn amount the same day they wrote the
  ticket, the interest needs to follow. Hiding the button on later days
  prevents accidentally rewriting historical interest that's already on a
  printed customer ticket — that would create a discrepancy between the paper
  and the database.
- **Edge cases:** none — same code path as the new-pawn flow. If the user has
  also entered payments earlier in the day, the recalc still ignores them
  (this is consistent with `edPawnAmountExit`'s behavior).

### `RzMenuButton1` (drop-down "...") — interest-recalculation menu

Appears next to the `Interest %` edit. Two items:

#### Item 1 (`First1`) — "Calculate interest base on Principal and interest balance"

- **When usable:** any time the form is open, but only meaningful when both
  `TRAN_PAWN_AMOUNT` and `INTEREST_BALANCE` are populated (otherwise raises a
  divide-by-zero).
- **What it does:** back-derives the interest **rate** from the dollar amounts:
  `TRAN_INTEREST := INTEREST_BALANCE / TRAN_PAWN_AMOUNT * 100`.
- **Why:** legacy ASA rows where the rate column was blank but the dollar
  interest amount was correct. This is the "I know what they paid, what
  percentage was that?" tool.
- **Edge cases:** **divide-by-zero if `TRAN_PAWN_AMOUNT` is null/0.** No guard
  in the handler today. Acceptable because in practice this only runs on
  legacy rows that always have a pawn amount, but worth knowing.

#### Item 2 (`Second1`) — "Recalc interest balance on new interest"

- **When usable:** Pawn transactions only (`TRAN_TYPE = TranPawn`) with a
  populated `TRAN_PAWN_AMOUNT`. Other types are silently no-op'd.
- **What it does:** forward-recalculates the **dollar interest balance** from
  the current rate, principal, and elapsed months. Uses
  `DM.LastPaymentForTransaction` to find the most recent payment and
  `MonthsBetween(today, lastPay)` for elapsed time. If no payment yet,
  elapsed = 0. Principal source: `TRAN_PAWN_AMOUNT` for new transactions,
  `PRINC_BALANCE` for existing ones. Final value:
  `INTEREST_BALANCE := DM.CalcNextInt(Amount, rate/100, MonthsSinceLastPay)`.
- **Why:** rate changes after some payments have already been posted (e.g.
  legal cap changed, customer renegotiated). This recomputes what the customer
  *now* owes in interest, accounting for time elapsed since last activity.
- **Also fired automatically from:** `edInterest.OnExit` when `NewRow` and
  `IntChanged` are both true — i.e., a clerk who tabs out of the rate field
  during ticket creation gets the same recalc without opening the menu.

---

## Cross-form dependencies

- **Reads** `DM.qryTransactions` (current row), `DM.qryStore`
  (`DEFAULT_PAWN_INTERESTRATE` for new pawns), `DM.qryCustomers.cCustAge`
  (under-age warning).
- **Writes** new rows to `INVENTORY_ITEMS` and `STONES` in copy-items mode.
  After save, parent `SearchClient` re-opens its `qryInvItems` to reflect them.
- **Sets** `DM.ReCalcMaturity := true` on FormCreate, `false` on FormDestroy.
  This flag controls how `qryTransactions`'s OnCalcFields recomputes
  `TRAN_MATURITY`. Keep it tightly scoped to this form.
- `pnSelectItemsToCopy` visibility and `clnItemsToSelect.Active` are gated
  on `CopyItemsMode` (private function = `FCopySourceCustNo > 0`). Any new
  control that reads `clnItemsToSelect` must guard `Active` first — see
  `dbGridItemsCellClick` etc. for the pattern.

## Open questions / known weirdness

- **`First1` divide-by-zero** noted above. Adding a guard would be a one-line
  change, but I want to verify the handler is never legitimately called with
  zero-amount rows before doing so.
- **`Second1` ignores the case where the new rate is *lower* than the current
  rate and the customer has overpaid interest.** It just rewrites
  `INTEREST_BALANCE`; any over/underpayment reconciliation is a separate
  policy decision the clerk has to think about. Document this in any future
  user manual.
- **`btnGetPawnAddingAllItemCost`** sums `frmClients.qryInvItems.UnitCost`
  across rows but doesn't set focus back to the input — minor UX gap.
