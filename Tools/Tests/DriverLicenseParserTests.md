# Driver license parser regression tests

From the repository root:

```powershell
.\Tools\Tests\RunDriverLicenseParserTests.ps1
```

Pass `-StudioPath` if RAD Studio is installed elsewhere. The script uses Win64 Delphi with range and overflow checks, and places generated files in ignored `Units/BarcodeTests`. No database or running application is needed.

The test program compiles the production `DrvLic_AAMVA.pas` and keyboard adapter source. Fixtures use the public FLHSMV 2019 calibration sample and fictional variations, not customer scans. The reconstructed sample matches the published `DL00410249ZF02900058` directory, including the two postal padding spaces and final LF/CR in each subfile.

Coverage includes raw, flattened and CRLF/CR-transformed data; retained header/subfile line breaks; embedded field tags in names/addresses; optional and unknown fields; missing values; duplicates; sex code 9; inches/centimeters; US/Canadian dates; ID subfiles; varying license/class lengths; incorrect offsets/lengths; and every truncated prefix of the raw sample. Adapter checks cover exact capture of the input characters, header detection, the idle interval, and its reset when new characters arrive.

Application verification still requires a real keyboard scanner: scan in a `frmClients` search box, in customer entry, and in the separate reader dialog. Confirm a valid scan populates/searches correctly, a bad scan leaves existing data unchanged and displays a retry message, and a second valid scan succeeds after failure. The current customer lookup remains name-based. Do not use production customer records for editing tests.
