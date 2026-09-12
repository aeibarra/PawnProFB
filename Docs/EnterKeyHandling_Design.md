# Enter on the Clients screen, and the card scanner

Design note and deferred work.
Written 2026-09-11, after the current version shipped. **Not yet validated
against a real PDF417 reader** — see "Before changing anything".

## Why this is delicate

`TfrmClients` is the one form where a **barcode reader types into the same
keyboard queue as the operator.** A driver's licence scan is among the most
important workflows in the store, and it arrives as ordinary keystrokes. Any code
that intercepts keys on this form is standing in the scanner's path.

That is the whole reason this document exists: the Enter behaviour is easy, the
constraint is not.

## How it works today

`btnSearch` used to carry `Default = True`. A default button claims Enter for the
entire form, so a focused Add, Edit or Print button did nothing at all. `btnSearch`
is a Raize `TRzBitBtn`, and it does not hand the default over to a focused stock
button the way VCL buttons do among themselves.

The flag was removed and both behaviours are now decided in `FormKeyDown`:

| focus | Enter does |
|---|---|
| a button | clicks that button |
| anything inside `GroupBox1` (the search fields) | runs the search |
| mid-scan | nothing |

with the Enter **character** swallowed in `FormKeyPress` to stop Windows sounding
its default beep.

### Three guards, and why each exists

1. **Runs after the card-scan block, never before.** `#13` is part of the
   magnetic scanner's own end-of-scan detection — it counts three newlines before
   posting `sx_ProcessCardScanning`. Eating Enter earlier breaks card scanning.

2. **Skipped while `ScanningCard` or `ScanningPDF417Barcode` is set.**

3. **`ScannerBurstGapMs = 40`.** The scan flags are *not sufficient on their own*.
   A licence payload opens `@` CR LF `ANSI `, so **a CR arrives before
   `ScanningPDF417Barcode` is ever set.** Without a timing test that CR presses
   whatever button has focus, in the middle of a scan. Under the old arrangement
   it landed on `btnSearch` and merely re-ran the search; with the flag gone it
   could land on Delete.

## What is wrong with it

It re-implements in code something the VCL already does natively, and pays for
that by intercepting keystrokes on the one form where a scanner is typing.

`ScannerBurstGapMs` is a heuristic. A sluggish reader or a laggy moment flips it
one way; an unusually fast typist the other. Nothing about it is deterministic,
and it guards a workflow that must not fail.

It also only fixes this one form. Any other form with the same Raize-default
arrangement has the same dead Enter and would need the same code again.

## The better version

**Make `btnSearch` a stock `TBitBtn`, restore `Default = True`, and delete every
line of the Enter handling** — the `FormKeyDown` block, the `FormKeyPress`
swallow, `FLastKeyTick` and `ScannerBurstGapMs`.

`TButton.CMFocusChanged` already does exactly what is wanted:

- focus moves to a `TButton` → that button becomes active, the default stands down
- focus moves to anything else → the default button takes over again

So Enter on a focused Add clicks Add, and Enter in a search box runs the search.
Native, and with **no key interception at all**: no timing constant, no CR
hazard, no interaction with the scanner whatsoever. Less code than today.

**Cost:** the Search button loses its Raize appearance and will sit a little
differently beside its neighbours. That is the only trade, and it is a judgement
about looks.

## Before changing anything

### 1. Confirm the diagnosis — five minutes, no scanner needed

The claim that `TRzBitBtn` is the culprit is **inferred, not proven**. Raize
ships as DCUs here, so the source could not be read. The evidence fits — with
`Default = True` on that Raize button Enter went to it regardless of focus, and
removing the flag made focused buttons work at once — but it was never
demonstrated.

`btnExit` on this form is already a stock `TBitBtn`. Put `Default = True` on it
temporarily, focus the Add button, press Enter:

- **Add fires** → diagnosis confirmed. Stock buttons do hand over the default,
  the Raize one was the problem, and the native route will work. Proceed.
- **Exit fires instead** → the diagnosis is wrong. Stock buttons behave no
  differently here, the code earns its place, and this document is obsolete
  except for the scanner notes below.

### 2. Then test with a real reader

A scanner has to be bought for this; it cannot be checked by reasoning. Whichever
version is in place, verify:

- a licence scan populates the client fields
- **nothing else fires during a scan** — no search, no dialog, above all no Delete
- Enter still works afterwards in each search field and on a focused button
- a magnetic-stripe card still scans (a separate path, three newlines)

If the reader turns out slower than assumed and Enter stops responding right
after a scan, `ScannerBurstGapMs` is the single constant to lower — but that
symptom is itself a reason to prefer the native version, which has no such
number.

## Scanner facts worth keeping

Learned while tracing this, and not obvious from the code:

- `GetLastSevenReadChars` keeps only characters **>= #32**. Control characters
  never form part of the `'@ANSI '` header it matches, so swallowing a `WM_CHAR`
  cannot break header detection.
- The constant is `'@ANSI '`, but the real AAMVA header is `@` CR LF `ANSI ` —
  the control characters are dropped by the rule above. **This is why a CR
  reaches the form before any scan flag is set.**
- Two independent paths share `FormKeyDown`/`FormKeyPress`: magnetic stripe
  (`ScanningCard`, `CardHeader`, three-newline terminator) and PDF417
  (`ScanningPDF417Barcode`, `ProcessKeyForPDF417barcodeScan`). Both must keep
  seeing their characters.
- `ProcessKeyForPDF417barcodeScan` consumes keys (`Key := #0`) only once
  `ScanningPDF417Barcode` is true; before that it only accumulates.
