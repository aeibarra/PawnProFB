# Thermal receipts (80 mm): plan and tracker

Plan, started 2026-11-18. Nothing is built yet.
This file tracks every customer slip that should print on the 3-inch receipt printer.
Update the **Tracker** table as each one moves forward.

## The short version

- **Printer:** Epson **TM-T20IV**, Ethernet model. It prints 80 mm thermal paper and has an auto-cutter.
- **Six receipts** go on it: the four the stores asked for (pawn payment, layaway opening, layaway payment, sale), plus a void receipt and an end-of-day cash summary.
- **Two of them already exist, but on Letter paper:** the pawn payment receipt and the layaway receipt. They need an 80 mm layout, not just a different printer.
- **One "Receipt printer" setting** will cover all of them, so a store sets it up once.
- **Not on thermal paper:** the pawn and purchase tickets (the police form and contract) and the envelope item labels.

## Printer

| | |
|---|---|
| Chosen | Epson TM-T20IV. 203 dpi, roughly 250 mm/s, auto-cutter, ESC/POS. |
| Connection | **Ethernet** (USB + serial + Ethernet model), so every PC in a store can print to it. Resellers list it as C31CL47002. Confirm the exact part number with the seller. |
| Price | About US$184–470, depending on model and reseller (November 2026). |
| Also tested | A Rongta RP850P (80 mm, ESC/POS, cheaper) is fine as a second development printer. It is not the store standard: its Windows driver and support are weaker. |
| Paper | 80 mm rolls; about **72 mm printable** (576 dots). Thermal print fades over the years, so anything with legal or long-term value stays on laser paper. |

## How the receipts will print

- **ReportBuilder** layouts printed through the **Windows driver**, like every other report in the app. The store logo, fonts and layout stay editable in the designer.
  - Paper: 80 mm wide, and the length grows with the content (continuous roll).
  - The cut, and the cash-drawer kick, are first set in the Epson driver.
  - If the driver turns out unreliable for either, the app sends raw ESC/POS commands for just those two.
- **Printer settings** ([uPawnProIniPrinters.pas](../uPawnProIniPrinters.pas), the `AppPrinterSettings` record):
  - Today there are separate entries for the payment receipt (`PayReceiptPrinter`, `UsePaymentReceiptPrinter`) and the layaway receipt (`LayawayReceiptPrinter`). The layaway one falls back to the payment printer.
  - Add one **`ReceiptPrinter`** used by every receipt below.
  - Keep a per-receipt override only where a store really needs a different printer.
- **Reprint:** every receipt can be printed again. A reprint says **REPRINT** and its print date, so it can't be passed off as the original.
- **Language:** receipts print in English, the language of record for US stores. The multilanguage plan translates only what is shown on screen.

## Receipts

### 1. Pawn payment receipt — exists, needs the 80 mm layout

- **Today:** `TDMReports.RepPrintPayReceipt` in [ReportsDM.dfm](../ReportsDM.dfm), Letter size.
  - Printed by `TDMReports.PrintPaymentReceipt(PaymentNo, PrinterName, PrinterTray)`.
  - The client screen's Print Pay Receipt button calls it (`btnPrintPayReceiptClick`). That button shows only when `UsePaymentReceiptPrinter` is on.
- **Content:**
  - store header
  - customer
  - pawn ticket number
  - payment date
  - amount paid, split into principal and interest
  - new principal balance
  - next due date
- **To do:** an 80 mm layout, moved to the new `ReceiptPrinter` setting.

### 2. Pawn redeem receipt — new heading on receipt 1

- The final payment that pays off a pawn: the customer takes the items back.
- **Content:** what receipt 1 prints, plus a **"Redeemed – items returned"** heading and the list of items returned.
- **To do:** decide whether it is a heading on receipt 1 or its own layout. Printing it automatically when a pawn is redeemed is optional.

### 3. Layaway opening receipt — exists, needs the 80 mm layout

- **Today:** `TDMReports.RepLayawayRcpt` in [ReportsDM.dfm](../ReportsDM.dfm), Letter size.
  - It shares its procedure with receipt 4.
  - It reads `qryLayawayRcpt` (the items) and `qryLayawayPayments` (payments, as a sub-report).
- **Content:**
  - store header
  - customer
  - layaway ticket number
  - items and prices, tax and total
  - down payment
  - balance
  - layaway terms (due date, what happens if it is not paid)
- **To do:** an 80 mm layout.

### 4. Layaway payment receipt — exists, needs the 80 mm layout

- **Today:** the same `RepLayawayRcpt`. The payment sub-report appears when the layaway has payments.
- **Content:**
  - layaway ticket number
  - this payment
  - payments so far
  - remaining balance
- **To do:** an 80 mm layout. Decide whether it lists every earlier payment or only this one plus the totals; a short slip prints only the totals.

### 5. Layaway payoff / pickup receipt — new heading on receipt 4

- The last layaway payment: the items are delivered.
- **Content:** what receipt 4 prints, plus **"Paid in full – items delivered"** and the items.
- **To do:** a heading on receipt 4 when the balance reaches 0.

### 6. Sales receipt — new

- Prints from the sale tickets saved since schema v12 (`SALES` and `SALE_LINES`, written by `TDM.CompleteSale`). These tables already store everything a reprint needs: the money as it was on the day, and each line's price, discount share and net.
- **Content:**
  - store header
  - **receipt number** (`SALE_TICKET_NO`)
  - date
  - each item: description, quantity, price
  - subtotal
  - discount (type and amount)
  - tax rate and tax
  - total
  - payment method (Cash for now)
- **Where it prints from:**
  - Complete Sale in the sale drawer ([Inventory.pas](../Inventory.pas)). Printing could be automatic, or a Print button next to the receipt number.
  - The sale ticket history screen, for reprints. This screen is still to be built.
- **To do:**
  - build the ticket history screen (list by date, using index `SALES_IDX1`)
  - build the 80 mm layout
  - add print and reprint

### 7. Void receipt — new

- Prints when a sale ticket is voided (`TDM.VoidSale`). The ticket stays in history with `SALE_STATUS = 'V'`.
- **Content:**
  - "VOID"
  - the original receipt number and date
  - items returned to stock
  - amount refunded
  - void reason
  - void date
- **To do:** an 80 mm layout, printed after a void (from the drawer's Undo Sale or from the history screen).

### 8. Purchase payout slip — new, optional

- When the store buys from a customer: a short slip with the amount paid out and the items.
- It goes **alongside** the purchase ticket (the police form), never instead of it.
- **To do:** ask the stores whether they want it.

### 9. End-of-day cash summary — new, optional

- The closing report for the cash drawer, for one day (or one shift).
- **Content:**
  - new pawn loans (money out)
  - pawn payments (principal and interest)
  - layaway payments
  - sales (and voids)
  - purchase payouts (money out)
  - **expected cash in the drawer**
- **To do:** ask the stores whether they want it. Define the day or shift boundary, and decide whether opening cash is entered.

### 10. Jewelry price tags — new, on a separate label printer

- A "barbell" tag that folds around the piece: the barcode on one side, the description and price on the other.
- This is what the Inventory screen's **Print Labels / Print One Label** buttons should do. Today they do nothing.
- **Sample:** Richard (Ricardo) sent photos on 2026-11-18. It's an EAN-13 barcode `0 000000 000079`, plus `PENDANT TEAR` / `10K 1.20 DWT .10CT` / `$$100.00`.
  - The double `$` is a bug in their label software. Don't copy it.
  - Their numbering is not PawnPro's: in Ricardo's DB, item 79 is a ring.
- **Fields:**

| Tag | PawnPro |
|---|---|
| Barcode | `INV_ITEM_BARCODE` (6 digits) |
| Description | `DESCRIPTION`, or metal + type when it's empty |
| Karat | `KT` |
| Weight | `WEIGHT` + `WEIGHT_UNIT` (DWT or g) |
| Carats | sum of `STONES.CT` for the item |
| Price | `UNIT_PRICE` |

- **Barcode:** Code 128. It is shorter than EAN-13 for 6 digits, so it fits a small tag. Scanning it should find the item in the Active Items List and the sale drawer.
- **Printer:** a thermal-transfer label printer (with a ribbon), with jewelry barbell tag stock. Direct-thermal tags fade and smudge. **Not** the TM-T20IV.
- **To do:**
  - ask Richard which label printer and tag size he uses (usually on the roll's box)
  - ask the stores whether the price prints on the tag
  - add a `TagPrinter` setting
  - build the tag layout and wire up the two buttons (selected items / one item)

## Not on the thermal printer

| Document | Why not |
|---|---|
| Pawn ticket, purchase ticket (police form) | Contract terms, signatures and full item descriptions for LeadsOnline. They belong on laser or pre-printed forms, and thermal print fades. |
| Envelope item labels (`rptEnvelopeItemLabel`) | Label stock, in their own label printer (`EnvelopeLabelPrinterName`). |
| Lists and reports (Report01, Report02, transaction lists, purchases) | Full-page reports. |

## Order of work

1. **Printer setup.** Install the TM-T20IV on the network. Set the 80 mm paper and auto-cut in the Epson driver, then test a print from Windows.
2. **The `ReceiptPrinter` setting** in [uPawnProIniPrinters.pas](../uPawnProIniPrinters.pas) and the printer settings screen.
3. **Sales receipt (6)**, together with the **ticket history + reprint** screen. This is already the next item on the roadmap.
4. **Pawn payment receipt (1)** and **layaway receipts (3, 4)** moved to 80 mm. The redeem (2) and payoff (5) headings go in at the same time.
5. **Void receipt (7).**
6. **Optional, if the stores ask:** purchase payout slip (8) and end-of-day summary (9).

## Tracker

Status: **Planned**, **In progress**, **Built** (compiles), **Tested** (printed on the TM-T20IV), **Deployed** (at a store).

| # | Receipt | Report | Status | Notes |
|---|---|---|---|---|
| — | TM-T20IV setup (driver, paper, cut) | — | Planned | Ethernet model |
| — | `ReceiptPrinter` setting | — | Planned | One setting for all receipts |
| 1 | Pawn payment receipt | `RepPrintPayReceipt` | Planned | Exists, Letter size |
| 2 | Pawn redeem receipt | (receipt 1) | Planned | Heading + items returned |
| 3 | Layaway opening receipt | `RepLayawayRcpt` | Planned | Exists, Letter size |
| 4 | Layaway payment receipt | `RepLayawayRcpt` | Planned | Exists, Letter size |
| 5 | Layaway payoff / pickup | (receipt 4) | Planned | "Paid in full" |
| 6 | Sales receipt | new | Planned | With ticket history + reprint |
| 7 | Void receipt | new | Planned | After `VoidSale` |
| 8 | Purchase payout slip | new | Optional | Ask the stores |
| 9 | End-of-day cash summary | new | Optional | Ask the stores |
| 10 | Jewelry price tags | new | Planned | Label printer, not the TM-T20IV; ask Richard for his printer and tag size |

## Open questions

- **Sale receipt:** print automatically on Complete Sale, or only with a Print button?
- **Layaway payment receipt:** list every earlier payment, or only the totals?
- **Redeem receipt:** its own layout, or a heading on the payment receipt?
- **Customer copy and store copy:** print two of any receipt? The cutter makes this easy.
- **Store header:** name, address and phone from `STORE`. Do the stores want a logo?
- **Cash drawer:** open it on every receipt, or only on cash sales and payments?
