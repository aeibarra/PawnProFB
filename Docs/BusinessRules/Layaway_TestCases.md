# Layaway Manual Test Cases

These cases validate the current Layaway business rules in `SearchClient`, `EnterLayaway`, `PaymentLayaway`, `ConfirmCloseLayaway`, and `PawnDM`.

Assumptions for expected values:

- Store sales tax is `7%`.
- Test client exists or is created before starting.
- Test layaway subtotal is `$100.00`.
- Expected sales tax is `$7.00`.
- Expected layaway total is `$107.00`.
- Layaway transaction type is `TRAN_TYPE = 'L'`.
- Active transaction status is `TRAN_STATUS = 'A'`.
- Inactive transaction status is `TRAN_STATUS = 'I'`.
- Layaway close reason values:
  - `0` = Open
  - `5` = Layaway closed/released
  - `6` = Layaway canceled/returned

## Quick Field Reference

Use these fields when verifying with SQL or grids:

```sql
select
  transaction_no,
  tran_type,
  tran_status,
  tran_close_reason,
  tran_pawn_amount,
  tran_sales_tax,
  princ_balance
from transactions
where transaction_no = :transaction_no;

select
  payment_no,
  transaction_no,
  pay_amount,
  pay_principal,
  pay_interest,
  princ_balance,
  interest_balance
from payments
where transaction_no = :transaction_no
order by payment_no;

select
  inv_item_no,
  inv_item_status,
  unit_price,
  layaway_date,
  forsale_date,
  sold_date
from inventory_items
where transaction_no = :transaction_no
order by inv_item_no;
```

## TC-LAY-001: Create New Layaway. Result Ok

Steps:

1. Open Client Search.
2. Select or create a client.
3. Go to the Layaway tab.
4. Click New Layaway.
5. Enter amount `$100.00`.
6. Save.

Expected UI:

- New layaway appears in the Layaway grid.
- Layaway ticket number is assigned.
- Balance shows `$107.00`.

Expected database:

```text
TRAN_TYPE = 'L'
TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
TRAN_PAWN_AMOUNT = 100.00
TRAN_SALES_TAX = 7.00
PRINC_BALANCE = 107.00
```

## TC-LAY-002: Add Item Within Layaway Amount. Result Ok

Steps:

1. Select the layaway from TC-LAY-001.
2. Add one item.
3. Set unit price `$80.00`.
4. Save.

Expected UI:

- Item saves without warning.
- Item status displays as Layaway.

Expected database:

```text
INV_ITEM_STATUS = 'L'
UNIT_PRICE = 80.00
LAYAWAY_DATE is not null
SOLD_DATE is null
FORSALE_DATE is null
```

## TC-LAY-003: Add Item Exceeding Layaway Amount

Steps:

1. Select the layaway from TC-LAY-001.
2. Add or edit items so total item price exceeds `$100.00`.
3. Example: existing item `$80.00`, add second item `$30.00`.
4. Save.

Expected UI:

- App warns that item prices exceed the layaway amount.
- If user selects No, item is not saved.
- If user selects Yes, item is saved.

Expected database if user selects Yes:

```text
Total UNIT_PRICE for layaway items = 110.00
TRAN_PAWN_AMOUNT remains 100.00
PRINC_BALANCE remains 107.00 unless payments changed
```

## TC-LAY-004: Add Partial Payment. Result Ok


Steps:

1. Select an active layaway with total `$107.00`.
2. Click Add Payment.
3. Enter payment `$20.00`.
4. Save.

Expected UI:

- Payment appears in payment grid.
- Layaway remains active.
- Balance becomes `$87.00`.

Expected database:

```text
PAY_AMOUNT = 20.00
PAY_PRINCIPAL = 20.00
PAY_INTEREST = 0.00
PAYMENTS.PRINC_BALANCE = 87.00
PAYMENTS.INTEREST_BALANCE = 0.00

TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
TRANSACTIONS.PRINC_BALANCE = 87.00
```

## TC-LAY-005: Add Second Partial Payment. Result Ok.

Steps:

1. Select the same active layaway.
2. Add payment `$30.00`.
3. Save.

Expected UI:

- Total paid is `$50.00`.
- Balance becomes `$57.00`.

Expected database:

```text
sum(PAY_AMOUNT) = 50.00
TRANSACTIONS.PRINC_BALANCE = 57.00
TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
```

## TC-LAY-006: Payment Pays In Full And Close. Result Ok.

Steps:

1. Select active layaway with balance `$57.00`.
2. Add payment `$57.00`.
3. Save.
4. When prompted, choose Close Layaway & Release Items.

Expected UI:

- Layaway becomes inactive/closed.
- Payment is saved.
- Items no longer display as open layaway.

Expected database:

```text
sum(PAY_AMOUNT) = 107.00
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 5
TRANSACTIONS.PRINC_BALANCE = 0.00

All layaway items:
INV_ITEM_STATUS = 'L'
LAYAWAY_DATE is not null
SOLD_DATE is not null
```

## TC-LAY-007: Payment Pays In Full But Leave Open. Result Ok.

Use a fresh layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add item.
3. Add payment `$107.00`.
4. When prompted, choose Leave Layaway Open.

Expected UI:

- Layaway remains active.
- Balance is zero.
- Items are still layaway/reserved.

Expected database:

```text
TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
TRANSACTIONS.PRINC_BALANCE = 0.00

INV_ITEM_STATUS = 'L'
LAYAWAY_DATE is not null
SOLD_DATE is null
```

## TC-LAY-008: Close Zero-Balance Layaway Later.  Result Ok.

Continue from TC-LAY-007.

Steps:

1. Select the zero-balance active layaway.
2. Click Close Layaway.

Expected UI:

- Layaway closes without payoff prompt.
- Items are released/sold.

Expected database:

```text
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 5
TRANSACTIONS.PRINC_BALANCE = 0.00

INV_ITEM_STATUS = 'L'
SOLD_DATE is not null
```

## TC-LAY-009: Close With Outstanding Balance And Payoff. Result Ok.

Use a fresh layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add item.
3. Add payment `$20.00`.
4. Click Close Layaway.
5. Confirm Payoff.

Expected UI:

- App creates final payment for the remaining `$87.00`.
- Layaway closes.
- Items are released/sold.

Expected database:

```text
sum(PAY_AMOUNT) = 107.00
Last payment PAY_AMOUNT = 87.00
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 5
TRANSACTIONS.PRINC_BALANCE = 0.00

INV_ITEM_STATUS = 'L'
SOLD_DATE is not null
```

## TC-LAY-010: Cancel With Outstanding Balance. Result Ok.

Use a fresh layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add item.
3. Add payment `$20.00`.
4. Click Close Layaway.
5. Choose Cancel Layaway.

Expected UI:

- Layaway becomes inactive.
- No refund/payment record is created.
- Items return to available inventory.
- No receipt prints.

Expected database:

```text
sum(PAY_AMOUNT) = 20.00
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 6
TRANSACTIONS.PRINC_BALANCE = 0.00

Former layaway items:
INV_ITEM_STATUS = 'S'
LAYAWAY_DATE is null
SOLD_DATE is null
FORSALE_DATE is not null
```

## TC-LAY-011: Canceled Layaway Cannot Reopen. Result Ok.

Continue from TC-LAY-010.

Steps:

1. Right-click canceled layaway.
2. Check popup menu.

Expected UI:

- Re-Open Layaway is disabled.

Expected database:

```text
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 6
```

## TC-LAY-012: Closed Layaway Can Reopen If Closed By Mistake

Use the closed layaway from TC-LAY-006, TC-LAY-008, or TC-LAY-009.

Steps:

1. Right-click closed layaway.
2. Choose Re-Open Layaway.

Expected UI:

- Layaway becomes active.
- Balance is recalculated from total minus payments.
- Items return to layaway/reserved state.

Expected database for fully paid layaway:

```text
TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
TRANSACTIONS.PRINC_BALANCE = 0.00

INV_ITEM_STATUS = 'L'
LAYAWAY_DATE is not null
SOLD_DATE is null
```

Expected database for closed layaway that was not fully paid:

```text
TRAN_STATUS = 'A'
TRAN_CLOSE_REASON = 0
TRANSACTIONS.PRINC_BALANCE = layaway total - sum(PAY_AMOUNT)
SOLD_DATE is null
```

## TC-LAY-013: Payments Blocked On Inactive Closed Layaway

Use a closed/released layaway.

Steps:

1. Select inactive layaway.
2. Try Add Payment.
3. Try Edit Payment.
4. Try Delete Payment.

Expected UI:

- Add/Edit shows message: payments cannot be added or modified on inactive layaway.
- Delete shows message: payments cannot be deleted on inactive layaway.
- No payment changes occur.

Expected database:

```text
payments rows unchanged
TRANSACTIONS.PRINC_BALANCE unchanged
TRAN_STATUS remains 'I'
```

## TC-LAY-014: Payments Blocked On Canceled Layaway

Use canceled layaway from TC-LAY-010.

Steps:

1. Select canceled layaway.
2. Try Add Payment.
3. Try Edit Payment.
4. Try Delete Payment.

Expected UI:

- Payment changes are blocked.

Expected database:

```text
payments rows unchanged
TRAN_STATUS = 'I'
TRAN_CLOSE_REASON = 6
```

## TC-LAY-015: Delete Payment On Active Layaway Recalculates Balance

Use a fresh active layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add payment `$20.00`.
3. Add payment `$30.00`.
4. Delete the `$30.00` payment.

Expected UI:

- Remaining payment total is `$20.00`.
- Balance becomes `$87.00`.

Expected database:

```text
sum(PAY_AMOUNT) = 20.00
TRAN_STATUS = 'A'
TRANSACTIONS.PRINC_BALANCE = 87.00
```

## TC-LAY-016: Edit Payment On Active Layaway Recalculates Balance. Result Ok

Use a fresh active layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add payment `$20.00`.
3. Edit the payment from `$20.00` to `$30.00`.
4. Save.

Expected UI:

- Payment amount is `$30.00`.
- Balance becomes `$77.00`.

Expected database:

```text
sum(PAY_AMOUNT) = 30.00
TRANSACTIONS.PRINC_BALANCE = 77.00
```

Note: this case specifically catches a known-risk area. If balance remains `$87.00`, payment edit recalculation still needs correction.

## TC-LAY-017: Overpayment Warning. Result Ok

Use a fresh active layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add payment `$120.00`.
3. Confirm the overpayment warning.

Expected UI:

- App warns that payment is greater than balance.
- If user chooses No, payment is not saved.
- If user chooses Yes, payment is saved.

Expected database if user chooses Yes:

```text
sum(PAY_AMOUNT) = 120.00
TRANSACTIONS.PRINC_BALANCE = -13.00
```

Business review note:

- Decide later if overpayment should be blocked instead of allowed.

## TC-LAY-018: Edit Layaway Amount After Payments. Result Ok

Use a fresh active layaway.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add payment `$20.00`.
3. Edit layaway amount from `$100.00` to `$200.00`.
4. Save.

Expected UI:

- New tax is `$14.00`.
- New total is `$214.00`.
- Balance should become `$194.00`.

Expected database:

```text
TRAN_PAWN_AMOUNT = 200.00
TRAN_SALES_TAX = 14.00
sum(PAY_AMOUNT) = 20.00
TRANSACTIONS.PRINC_BALANCE = 194.00
```

Note: this case catches another known-risk area. If balance remains `$87.00`, layaway edit balance recalculation still needs correction.

## TC-LAY-019: Popup Close Matches Button Close

Use a fresh layaway with balance due.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add payment `$20.00`.
3. Right-click layaway.
4. Choose Close Layaway from popup.

Expected UI:

- Same close/cancel dialog appears as the Close Layaway button.
- User can choose Payoff, Cancel Layaway, or Cancel.

Expected database:

- If Payoff: same as TC-LAY-009.
- If Cancel Layaway: same as TC-LAY-010.
- If Cancel: no database changes.

## TC-LAY-020: Layaway Receipt Balance

Use active layaway with partial payments.

Steps:

1. Create layaway `$100.00` plus `$7.00` tax.
2. Add item.
3. Add payment `$20.00`.
4. Print Layaway Receipt.

Expected receipt:

```text
Layaway total = 107.00
Payment list includes 20.00
Balance = 87.00
```

Expected database:

```text
No transaction/payment/item changes from printing
```

