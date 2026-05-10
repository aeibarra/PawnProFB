# Layaway (`EnterLayaway.pas`, `PaymentLayaway.pas`, `ConfirmCloseLayaway.pas`)

**Purpose:** Manage layaway transactions from the Layaway tab in the client
transaction area. A layaway reserves inventory items for a customer, records
principal-only payments against the layaway total, and later either closes as
released/sold or cancels back to available inventory.

**Entry points:**
- New/Edit Layaway - `SearchClient.AddEditLayaway(NewRow)` creates
  `TfrmEnterLayaway` and edits the current `DM.qryTransactions` row.
- Add/Edit Payment - `SearchClient.AddEditPayments(NewRow)` opens
  `TfrmPaymentLayaway` when the active transaction tab is Layaway.
- Close Layaway button - `SearchClient.btnCloseLayawayClick`.
- Close Layaway popup menu - `SearchClient.mnuCloseLayawayClick`, which now
  reuses the same close flow as the button.
- Re-Open Layaway popup menu - `SearchClient.mnuReOpenLayawayClick`.

**Exit modes:**
- Save layaway - posts `DM.qryTransactions`.
- Save payment - posts `DM.qryPayments`, updates transaction balances, and may
  close the layaway if paid in full and the clerk chooses to release items.
- Cancel layaway - marks the transaction inactive/canceled and returns items to
  for-sale inventory. It does not create refund records or print a receipt.
- Close layaway - marks the transaction inactive/closed and sets layaway item
  `SOLD_DATE`.

---

## Core rules

### Transaction identity

- Layaway transactions use `TRAN_TYPE = TranLayaway` (`'L'`).
- New layaways receive the next ticket number from `LayawayTicketNo`.
- New layaways default maturity to one month from today and interest to zero.
- Active layaways use `TRAN_STATUS = 'A'`.
- Closed or canceled layaways use `TRAN_STATUS = 'I'`.
- `TRAN_CLOSE_REASON` values used by layaway:
  - `0` = Open
  - `5` = Layaway closed/released
  - `6` = Layaway canceled/returned

### Amount, tax, and balance

- Layaway subtotal is stored in `TRAN_PAWN_AMOUNT`.
- Sales tax is stored in `TRAN_SALES_TAX`.
- Layaway total is the calculated field `cTotalSalesAmount`:
  `TRAN_PAWN_AMOUNT + TRAN_SALES_TAX`.
- On save, `PRINC_BALANCE` is recalculated as:
  `cTotalSalesAmount - sum(PAY_AMOUNT)`.
- New layaways have no payments, so initial balance equals the layaway total.
- Editing an existing layaway amount/tax recalculates principal balance using
  existing payments.

### Items

- Items added while the selected transaction is a layaway get:
  - `INV_ITEM_STATUS = 'L'`
  - `LAYAWAY_DATE = Now`
- Active layaway items display as `Layaway`.
- Closed/released layaway items keep `INV_ITEM_STATUS = 'L'` and receive
  `SOLD_DATE`, so they display as sold/closed.
- Canceled layaway items are returned to inventory:
  - `INV_ITEM_STATUS = 'S'`
  - `LAYAWAY_DATE = null`
  - `SOLD_DATE = null`
  - `FORSALE_DATE = current_date`
- Returned canceled items display as `For Sale`.

### Item total warning

- When saving layaway items, the app compares the sum of item `UNIT_PRICE`
  values against `TRAN_PAWN_AMOUNT`.
- The comparison is against the layaway subtotal, not the subtotal plus tax.
- If item prices exceed the layaway amount, the clerk gets a warning and may
  choose whether to continue.

---

## Payment rules

### Layaway payment form

- Payments entered from the Layaway tab use `PaymentLayaway.pas`, not the pawn
  payment form.
- Layaway payments are principal-only:
  - `PAY_PRINCIPAL = PAY_AMOUNT`
  - `PAY_INTEREST = 0`
  - `INTEREST_BALANCE = 0`
- Payment save updates both the payment row's `PRINC_BALANCE` and the parent
  transaction's `PRINC_BALANCE`.
- Editing a payment recalculates balance as:
  `current total paid - original payment amount + edited payment amount`.

### Paid in full

- If a payment brings the layaway balance to exactly zero, the clerk is asked:
  - close layaway and release items
  - leave layaway open
- If the clerk closes, `DM.LaywayClosePayoffBalance(..., false)` marks the
  layaway inactive/released and stamps `SOLD_DATE` on layaway items.
- If the clerk leaves it open, the layaway remains active with zero balance and
  items remain reserved as layaway.

### Overpayment

- If a payment makes the balance negative, the app warns the clerk.
- If the clerk continues, the payment is saved and transaction balance becomes
  negative.
- This is current behavior; policy may later decide to block overpayments.

### Inactive layaways

- Once a layaway is inactive, payment add/edit/delete is blocked.
- The user must reopen a closed/released layaway before changing payments.
- Canceled layaways cannot be reopened, so their payment history is locked.

---

## Close, cancel, and reopen

### Close/release

Close/release means the customer completed the layaway or the store intentionally
released the items.

- Sets `TRAN_STATUS = 'I'`.
- Sets `TRAN_CLOSE_REASON = LayawayCloseReasonClosedReleased` (`5`).
- Sets `PRINC_BALANCE = 0`.
- Sets `SOLD_DATE = current_timestamp` for layaway items.
- The item grid is refreshed after close so item status updates immediately.
- If the layaway still has a balance and the clerk chooses payoff, the app
  creates a final payment for the remaining balance before closing.

### Cancel

Cancel means the customer is not completing the layaway and the store returns
the items to inventory. Store policy currently says refund is optional, no fee
is tracked, no refund transaction is created, no report entry is created, and no
receipt prints.

- Sets `TRAN_STATUS = 'I'`.
- Sets `TRAN_CLOSE_REASON = LayawayCloseReasonCanceledReturned` (`6`).
- Sets `PRINC_BALANCE = 0`.
- Keeps existing payment rows as history.
- Does not create refund or fee rows.
- Returns items to for-sale inventory with `INV_ITEM_STATUS = 'S'`.
- The transaction and item grids are refreshed after cancel.

### Reopen

- Reopen is allowed only for closed/released layaways, as an error-correction
  tool.
- Reopen is disabled for canceled layaways.
- Reopen sets:
  - `TRAN_STATUS = 'A'`
  - `TRAN_CLOSE_REASON = 0`
  - `PRINC_BALANCE = cTotalSalesAmount - sum(PAY_AMOUNT)`
  - layaway item `SOLD_DATE = null`

---

## Cross-form dependencies

- **Reads/writes** `DM.qryTransactions` and `DM.qryPayments`.
- **Reads/writes** `SearchClient.qryInvItems` through item entry and grid
  refresh paths.
- **Uses** `DM.GetTotalPaid` to calculate layaway balance from payment history.
- **Uses** `DM.RecalcLayawayPBalance` after deleting active layaway payments.
- **Uses** `DM.LaywayClosePayoffBalance` to close/release layaways.
- **Uses** `DM.CancelLayaway` to cancel and return items to inventory.
- **Uses** `DM.ReactivateLayway` to reopen closed/released layaways.

## Open questions / known weirdness

- Overpayment is still allowed after warning and can create a negative
  `PRINC_BALANCE`.
- Cancel does not track whether the store refunded the customer. This matches
  the current store feedback, where refund is optional and not reported by the
  app.
- Close/cancel reason values share `TRAN_CLOSE_REASON` with pawn reasons. Values
  `5` and `6` are reserved for layaway-specific outcomes.
- Procedure names still use the legacy spelling `Layway...`; behavior is
  correct, but names could be cleaned up later with a compatibility pass.

