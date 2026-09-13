# Florida PDF417 implementation compared with official documentation

Reviewed: 2026-09-13. Scope: source review and illustrative parser-model checks; no application changes or physical scanner testing.

**Status:** The implementation was subsequently repaired. This report remains the pre-change comparison. See [current implementation notes](DriverLicense_PDF417_Reference.md#current-implementation-after-repairs-2026-09-13) for the fixes, compatibility limits, and compiled verification.

## Conclusion

The active parser recognizes the main Florida fields and suits the flattened sample embedded in its source, but it is not a complete implementation of the documented encoding structure. The highest-impact weakness is searching for field tags anywhere in the text. This can truncate names and addresses, or overwrite unrelated fields. There is also a definite sex-code mismatch: the documentation uses 9 for unspecified, while the implementation recognizes 3.

## Sources and version scope

1. [FLHSMV PDF417 calibration sheet](https://www.flhsmv.gov/pdf/newdl/fl_2dbarcodecalibration.pdf), two pages, card revision 05/01/2019, document revision 01.11.2019. Page 1 supplies a sample; page 2 describes Florida fields. The full PDF was successfully downloaded directly and its field table visually reviewed, despite the web browsing tool returning 403. A local copy is saved as `DriverLicense_Barcode_Scan/FL_2D_Barcode_Calibration_2019.pdf`.
2. Existing repository file `DriverLicense_Barcode_Scan/2016 Card Design Standard (1).pdf`. Primary sections: Annex D, D.12.2-D.12.5, Tables D.1-D.4, printed pages 50-60 (PDF pages 66-76). Header and key field tables were visually checked. This version matches the Florida sheet's stated standard.
3. [2025 AAMVA standard](https://www.aamva.org/getmedia/81af105d-8b1b-45e1-aa46-f1800a259ed1/AAMVADLIDCardDesignStandard2025.pdf), Annex D, consulted to cross-check the structural approach. This review does not assume Florida has adopted its newest version.

This is a comparison against the published 2019 Florida format, not a claim that the sheet exhaustively describes every card issued today. The code's header does not record or dispatch on the AAMVA or jurisdiction version.

## Active code

- `PawnProFB.dpr` selects the root `DrvLic_PDF417Parsing.pas`, not the copy in the barcode test project.
- Root parser: `SectionHeaders` (around line 114), `ProcessKeyForPDF417barcodeScan` (188), `GetSecDate` (316), `FindNextSecHeaderPosition` (346), and `ParsePDF417_US_Driver_License` (395).
- `SearchClient.pas`: `ProcessAndShowBarcodeData` (2033), `TimerForScanTimer` (2044), `PopulateFieldsWithDrvLicInfo` (2729), and `FormKeyPress` (2865).
- `EnterClientInfo.pas`: `PopulateFieldsWithDrvLicInfo` (157) writes parsed data to customer fields; `PopulateID` (141) trims state before choosing Florida/general ID storage.

## Findings, in recommended priority order

### 1. Field boundary recognition can corrupt otherwise valid data

AAMVA D.12.2-D.12.3 defines LF as the field separator and CR as the subfile terminator. Tags identify fields at those boundaries. The parser instead examines every three-character substring, and `FindNextSecHeaderPosition` looks for any recognized tag sequence inside values. The main scan also continues through already-extracted values.

Illustrative model results using fictional substitutions in the Florida sample:

| Input value | Current extraction | Consequence |
|---|---|---|
| Surname `MCDADAMS` | Surname `MC` | Wrong customer lookup |
| Address `123 DADLEY STREET` | Address `123 `; middle name `LEY STREET` | Address and middle name corruption during customer entry |

This problem also exists when LF separators are preserved: the algorithm does not use them to restrict recognition. If a scanner strips all separators, some payloads become ambiguous; adding more known tags cannot fully solve that ambiguity.

### 2. Header and subfile structure are not validated or used

The documented raw prefix is `@` + LF + RS + CR + `ANSI `, followed by issuer, standard version, jurisdiction version, entry count, and subfile descriptors. Each descriptor supplies a type, byte offset, and length (including its terminator).

The live helper ignores controls while detecting printable `@ANSI ` and rebuilds that shortened header in its buffer. The parser checks only minimum length and initial `@`, then finds a space. It does not validate the issuer, versions, descriptors, or declared lengths and does not isolate `DL`/`ID` from Florida's `ZF` subfile.

Consequences: incomplete input may be accepted; unrelated subfile contents can be mistaken for standard fields; end-of-input is not structurally checked. A future offset-based parser must preserve the raw bytes first, or explicitly account for a scanner's transformed output. Original offsets cannot be applied directly to the shortened buffer.

The separate `BarcodePDF417PatterDetected` helper expects `@` + CR + LF + `ANSI`, which differs from the raw standard. This is not the detector used by the direct `frmClients` capture path.

### 3. Sex code 9 is mishandled

Florida page 2 lists 1=M, 2=F, 9=X. AAMVA 2016 Table D.3 describes 9 as not specified. The code maps 1 and 2 correctly, maps 3 to `N`, and maps 9 to an empty string. Correct the input mapping while choosing an output value supported by the existing customer UI/database. Do not blindly store `X` without checking that contract.

### 4. Unknown fields are not safely skipped

Recognizing an optional field for storage is unnecessary if the application does not use it, but its boundary must still be respected. `DCU` (suffix) is absent from the tag table. In a synthetic flattened sequence `DCGUSADCUJRDCK...`, country becomes `USADCUJR` instead of `USA`.

The implementation also omits `DDA`, `DDB`, `DDD`, `DDJ`, `DDL`, and Florida-specific `ZF` elements. Some other optional tags are recognized only as boundaries. These omissions are scope limits rather than a requirement to store all license data; unsafe boundary handling is the actual parsing defect.

### 5. End-of-input handling is incorrect

`pEnd := BarcodeData.Length - p` subtracts the first-space position from an absolute end index; the loop ends at `pEnd - 1`. With the usual flattened prefix, the final seven character positions are not examined as tag endings. A terminal field can be missed.

For variable-length values, `FindNextSecHeaderPosition` returns zero when no next known tag is found. That produces an empty extraction rather than reading to a valid subfile boundary. A synthetic shortened payload ending in `...DAG123 MAIN STREETDCGUSA` yielded an empty address and no country in the model. This malformed/truncated illustration verifies failure handling, not a compliant Florida card layout.

### 6. Normalization and missing-value semantics are incomplete

With LF retained, the model extracts names/address/state/country with trailing LF. `frmClients.btnSearchClick` trims first and last names before querying, so ordinary trailing separators alone do not demonstrate a broken lookup. Customer entry initially assigns the other values directly; first/last names are trimmed later on save, and `PopulateID` trims its local state argument.

The documented `NONE` and `unavl` values are copied as ordinary text. In particular, `DADNONE` becomes the literal middle name `NONE`. That is faithful raw extraction, but application normalization should distinguish missing data from an actual name. Truncation flags are recognized but discarded, so callers cannot tell whether a name was shortened on the card.

### 7. Completion and invalid-data handling are application limitations

`TimerForScan` checks buffer growth every 500 ms. An unchanged count ends the scan without checking the declared payload length or required fields. A sufficiently long transmission pause can therefore trigger premature parsing. There is no local parse exception handling in `ProcessAndShowBarcodeData`, and buffer clearing is not in a `finally` block.

The record is not explicitly initialized with defaults for every field. Invalid date text returns zero; missing/invalid fields are not reported through a structured result. A blank or partial name can still reach the normal search. These are application robustness issues, not barcode timing requirements imposed by AAMVA.

## What matches, and what is only a portability limitation

| Area | Assessment |
|---|---|
| Main names, address and date tags | Correct identifiers; extraction needs the boundary fixes above |
| Florida license number | 13-character extraction fits the Florida sheet's stated maximum; general AAMVA DAQ is variable up to 25 characters |
| Vehicle class | One character suits Florida's sheet; general AAMVA allows a longer value |
| Issue, birth, expiration dates | Valid Florida MMDDYYYY values parse correctly; choosing date order from the first two digits is a heuristic rather than using jurisdiction metadata |
| Height | Florida inches work; general AAMVA also permits centimeters, which the code incorrectly treats as inches after stripping units |
| ZIP | Reads nine characters; AAMVA defines an 11-character field. The nine useful digits in Florida's sample are retained, so this is not evidence of lost Florida ZIP digits |
| Eye color | Its absence agrees with the Florida sheet, which explicitly omits DAY; not a Florida defect |
| Issue/expiration/class output | Parsed into the record, but not used for the `frmClients` name search |
| Magnetic stripe | Separate `ParseFL_DL` path, outside this PDF417 comparison |

## Verification and limits

Read the active Pascal source and the full Florida PDF. Extracted the local 2016 standard's relevant text and visually checked the header and principal tables. Ran a small Python transliteration of the tag table, Pascal's one-based scan bounds, fixed-length copying, and next-tag search. This is a behavioral model, not a compiled Delphi test.

The model used the public sample's printed fields in both flattened and LF-preserving forms, plus fictional substitutions. It confirmed ordinary sample name/address extraction in flattened form, retained LF in variable values, embedded-tag corruption, suffix contamination, and terminal-field loss. It did not decode the printed barcode image, reconstruct/validate its exact byte offsets, exercise VCL events, or test the physical scanner. The original user-selected editor text remains unavailable.

## Recommended implementation sequence

1. Capture a representative scanner payload with control characters visible and establish whether the scanner can preserve the documented separators.
2. Preserve raw input; parse/validate the header and subfile boundaries, then read fields by separators. Keep any legacy flattened-input fallback explicit, with known ambiguity limits.
3. Correct sex mapping, normalize field values and missing-value markers, initialize results, and report invalid/incomplete data before populating controls.
4. Add focused Delphi tests for the published sample, supported scanner output, embedded tag text, optional suffixes, missing fields, and truncated scans.
5. Verify both `frmClients` lookup and `EnterClientInfo` population because they share the parser. Keep the current name-based lookup behavior unless separately requested.

No source code changes were made as part of this review.
