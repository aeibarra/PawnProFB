# Driver license PDF417 scanning reference

Original analysis: 2026-09-13. The implementation described below has since been repaired. See the current implementation notes immediately below; the original analysis is retained as historical context. Recheck the source before modifying behavior; line numbers can change.

See [comparison with official Florida and AAMVA documentation](DriverLicense_PDF417_Official_Comparison.md) for verified field-format differences, illustrative failure cases, and recommended fix priorities.

## Current implementation after repairs (2026-09-13)

- `DrvLic_AAMVA.pas` now owns the UI-independent parser, `TDriverLicenseInfo`, and typed `EDriverLicenseBarcode` errors. The original root `DrvLic_PDF417Parsing.pas` aliases those types, retains the keyboard capture and magnetic-stripe helpers, and delegates PDF417 parsing to the new unit. `PawnProFB.dpr` explicitly includes both root units.
- Raw parsing validates the AAMVA header, numeric directory, contiguous offsets and lengths, subfile types, and terminators. Only the `DL`/`ID` subfile supplies customer data. Fields are separated by LF, not arbitrary tag substrings; unknown fields are skipped, duplicates rejected, and the final field is read correctly.
- Keyboard header capture preserves control characters. Explicit compatibility paths reconstruct CRLF/CR-delimited output, omitted header controls, and the documented separator-free Florida version-09 layout. Reconstructed subfile sizes must match the original directory. The repository's existing flattened reference scan was checked successfully without printing personal data.
- Flattened Florida recovery uses required successor tags and documented order. Embedded `DAD` in names/addresses no longer splits them. Ambiguous boundaries, unfamiliar flattened layouts, incomplete scans, missing required values, invalid dates/sex/height, and inconsistent directories fail before populating or searching.
- Values are trimmed and uppercased; `NONE`/`UNAVL` are normalized. Sex 9 maps to the application's existing `N` (N/A); centimeters convert correctly; country selects date order. Header metadata and name-truncation indicators are retained. Output records are initialized and remain empty on failure.
- All three forms use buffer character counts and two unchanged timer checks. They show a retry warning on parse failure, reset their scan state, and do not apply partial results. The reader dialog no longer requires a particular number of PDF417 lines. Its manual test button no longer leaks a scan list.
- `frmClients` still searches by first/last name and keeps existing extra search filters. Customer entry still applies the shared result to the same customer fields. The magnetic-stripe parser and separate test project's old parser copy were not redesigned.
- Compiled regressions and a repeatable runner live in `Tools/Tests/DriverLicenseParserTests.dpr` and `RunDriverLicenseParserTests.ps1`. They use the public Florida calibration sample and fictional variations. All 760 checks passed with range/overflow checking, including keyboard capture and every truncated raw-sample prefix. The full Win64 Debug application build passed with output under ignored `Units/BarcodeTests`, with only the existing third-party SVG hint. Physical scanner/UI tests remain necessary.

Separator-free input is inherently ambiguous. The fallback supports the documented Florida layout rather than pretending to decode arbitrary flattened AAMVA data. Preserving scanner field separators is preferable, especially for other jurisdictions or newer layouts.

## Historical analysis before repairs

## Purpose and source files

`TfrmClients` is implemented in `SearchClient.pas`, with its form settings in `SearchClient.dfm`. Scanning a license on this screen searches for a customer by first and last name; it does not update the customer's identification details.

The shared scanner capture and parser are in the root `DrvLic_PDF417Parsing.pas`. `PawnProFB.dpr` references this root unit. There is also a copy under `DriverLicense_Barcode_Scan`, alongside a separate barcode parsing test project; do not confuse that copy with the application's active unit.

## Capture and completion flow

1. The scanner supplies decoded barcode text as keyboard input. This code does not decode a PDF417 image.
2. `SearchClient.dfm` sets `KeyPreview = True`. `TfrmClients.FormKeyPress` calls the scan handlers only when `SearchFieldFocused` is true or a magnetic/PDF417 scan is already underway. `SearchFieldFocused` checks for an edit control directly within `gbSearch`, including `edPhone`.
3. `ProcessKeyForPDF417barcodeScan` in the shared parser watches for `@ANSI `. `GetLastSevenReadChars`, despite its name, retains a six-character printable rolling header; control characters do not contribute. Header comparison is case insensitive.
4. On detection, the handler sets the hourglass cursor, resets `LastDataCount`, enables the supplied timer (`TimerForScan` on `frmClients`), sets `ScanningPDF417Barcode`, clears `ScanData`, and seeds it with `@ANSI `.
5. Subsequent characters are appended to `ScanData` (`TList<char>`) and consumed by setting `Key := #0`. Initial header characters are not all consumed by this logic.
6. `TimerForScan` runs every 500 ms. `TimerForScanTimer` compares the current buffer size with `LastDataCount`. When the count is unchanged between checks, it restores the cursor, clears the scanning flag, disables the timer, calls `ProcessAndShowBarcodeData`, and then calls `btnSearchClick(nil)`.
7. `ProcessAndShowBarcodeData` calls `ParseScanBarcodeData`, populates the form from the resulting record, and clears the buffer. There is no local exception handler around parsing in this routine.

Completion is based on an idle buffer, not a required terminator or declared barcode length. The separately named `TimerScanningTimeOut` handles the magnetic-stripe path, not PDF417 completion.

`FormKeyDown` also uses `ScannerBurstGapMs = 40` to avoid treating rapid scanner Enter keystrokes as ordinary search/button activation before the PDF417 header is fully detected. Enter handling is skipped while a scan is active.

## Parsing

`ParseScanBarcodeData` builds a string from the character list and calls `ParsePDF417_US_Driver_License`.

The parser:

- Rejects input shorter than 50 characters or not beginning with `@`.
- Uppercases the entire input.
- Finds the first space and scans for recognized three-character tags.
- Uses fixed lengths for some values and `FindNextSecHeaderPosition` for variable-length values.
- Returns a `TDriverLicenseInfo` record.

| Tags | Meaning | Implementation detail |
|---|---|---|
| `DAQ` | License number | Fixed 13 characters |
| `DCS`, `DAC`, `DAD` | Last, first, middle names | Variable length |
| `DAA` | Legacy full name | Split by commas and a space |
| `DCA` | Vehicle class | Fixed 1 character |
| `DBD`, `DBB`, `DBA` | Issue, birth, expiration dates | Fixed 8 characters |
| `DBC` | Sex | `1` → `M`, `2` → `F`, `3` → `N`, otherwise empty |
| `DAU` | Height | Fixed 6 characters; numeric portion interpreted as inches when greater than 10 and converted to feet/inches |
| `DAG`, `DAI`, `DAJ` | Address, city, state | Variable length |
| `DAK` | ZIP code | Fixed 9 characters |
| `DCG` | Country | Variable length |

Other recognized tags act as boundaries but are not stored: `DDE`, `DDF`, `DDG`, `DCB`, `DCD`, `DCF`, `DCK`, and `DDK`.

`GetSecDate` interprets a date as MMDDYYYY when its first two digits are at most 12; otherwise it tries YYYYMMDD. Invalid dates return zero.

## Result on frmClients

`PopulateFieldsWithDrvLicInfo` copies only `FirstName` and `LastName` into `edFirst` and `edLast`. The completion timer then runs the normal search.

`OpenClientsQuery` uses wildcard name matching (`%name%`). Existing ticket-number and phone filters are retained, so they can restrict the scan's search results. This is not a lookup by license number.

`ActionScanCardExecute` is another entry point: it opens `TfrmDriverLicCardReader` from `CardReader.pas` modally. On `mrOK`, it copies the dialog's first and last names into the search controls and runs the search.

## Shared behavior and magnetic-stripe path

`EnterClientInfo.pas` uses the same parser. Its `PopulateFieldsWithDrvLicInfo` fills customer name, gender, height, address, city, state, ZIP, and DOB in `DM.qryCustomers`, calls `PopulateID`, and clears the customer comment. `PopulateID` puts Florida identification in `CUST_FL_DRV_LIC`; other states use the general ID fields with type `DL`. Changes to the shared parser therefore affect both searching and customer entry, as well as callers in `CardReader.pas`.

Magnetic-stripe scanning is separate: it uses `ScanningCard`, `ReadingCardBuffer`, key-pattern detection, and `ParseFL_DL`. Do not treat `ParseFL_DL` as the PDF417 parser.

## Limitations relevant to future changes

- Parsing searches for tag text rather than using declared subfile offsets, lengths, and field boundaries. A recognized tag sequence inside a name/address can be mistaken for a field.
- Hardcoded lengths can truncate or misread values with different formats.
- Variable-length extraction depends on finding a later recognized tag. Unknown tags can become part of a value; a missing following tag can produce an empty result.
- Values are not generally trimmed or stripped of control characters by the parser.
- The parser's loop end is calculated as input length minus the first-space position, so it does not scan all the way to the actual end of input.
- Validation is limited; there is no required-field completeness check before `frmClients` runs a search.
- A pause during transmission can trigger completion before the whole payload arrives.

These are observations from source inspection, not failures demonstrated with a physical scanner. No application code was changed or runtime scanner test performed during this analysis.

## Reference sample availability

The user mentioned selected driver-license text in the open editor, but that selection was not available through the session's editor context/tools. Do not assume that text was inspected.

A PDF417 sample is embedded in a comment near the start of the root `DrvLic_PDF417Parsing.pas`. `Albert_Lic.txt` contains a separate magnetic-stripe sample. Personal license data is intentionally not duplicated in this document.
