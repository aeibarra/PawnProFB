# PawnProSetup

New-store provisioning utility. Rotates SYSDBA password, encrypts it via DPAPI
into `PawnPro.ini`, writes the recovery envelope, populates the single STORE row.
Four modes: **New Install**, **Add Workstation**, **Rotate Password**, **Edit Store**.

Design rationale and atomic execution order live in:
- `~\.claude\plans\hey-i-have-a-lazy-barto.md` (original design)
- `~\.claude\plans\mighty-growing-duckling.md` (resume notes + drift adjustments)

## Files

| File | Role |
| --- | --- |
| `PawnProSetup.dpr` | Project entry; lists all units. |
| `PawnProSetup.dproj` | **Must be created in Delphi** -- see below. |
| `SetupMain.pas` + `.dfm` | Mode-picker landing form. |
| `SetupNewInstall.pas` + `.dfm` | 4-page wizard: location -> store -> confirm -> done. |
| `SetupAddWorkstation.pas` + `.dfm` | Re-encrypt INI on workstation 2+. |
| `SetupRotatePassword.pas` + `.dfm` | Generate new password, update INI + recovery.dat. |
| `SetupEditStore.pas` + `.dfm` | CRUD over the STORE row, no auth changes. |
| `SetupConnection.pas` | FireDAC connect / test / ALTER USER + password generator. |
| `SetupStoreFields.pas` | STORE row read/UPSERT. |
| `SetupVendorPublicKey.inc` | Embedded vendor public key (PLACEHOLDER until real key is generated). |

Cross-project units used:
- `..\..\COMMON\DPAPIUtils.pas` -- DPAPI wrapper.
- `..\..\COMMON\SealedBox.pas` -- libsodium bindings.

## How to create `PawnProSetup.dproj`

I did NOT hand-write the `.dproj` file because it's ~1000 lines of Delphi XML
that's much easier to generate via the IDE. Either:

### Option A -- New VCL Application via the wizard (cleanest)

1. **Delphi IDE -> File -> New -> VCL Application.**
2. Immediately **File -> Save Project As -> `PawnProSetup.dproj`** in this folder.
   Delphi will also save a placeholder `Unit1.pas` + `Unit1.dfm` -- DELETE them
   from disk, then back in the IDE: Project -> Remove from Project -> remove
   Unit1.
3. **Project -> Add to Project** -- add each of the `Setup*.pas` files in this
   folder (Delphi auto-pairs the `.dfm`).
4. **Project -> Add to Project** -- add `..\..\COMMON\DPAPIUtils.pas` and
   `..\..\COMMON\SealedBox.pas`.
5. **Project -> View Source** -- replace the generated `.dpr` body with the
   contents of `PawnProSetup.dpr` in this folder (it has the right form
   create order: only `frmSetupMain` is auto-created; the others are
   instantiated on demand).
6. **Project -> Options -> Building -> Delphi Compiler -> Output directory:**
   set to `..\Deploy\` (or wherever you want the EXE). Same for the DCU
   intermediate output -> `..\Units\`.
7. Build and save the project. The generated `.dproj` is now the canonical
   project file.

### Option B -- Copy from `Pump_ASA_FB`

`..\Pump_ASA_FB\PumpAsaFb50.dproj` is structurally similar (standalone FireDAC
utility). Copy it into this folder, rename to `PawnProSetup.dproj`, and edit
the `<DCCReference>` list to point at the units in this folder plus the two
in `..\..\COMMON\`. Faster if you're comfortable with the XML.

## libsodium.dll

Required by `SealedBox.pas`. Place `libsodium.dll` (~150 KB) in the same
folder as the compiled `PawnProSetup.exe`. Get it from
https://download.libsodium.org/libsodium/releases/ (`libsodium-X.Y.Z-stable-msvc.zip`,
the `Win32\Release\v143\dynamic\libsodium.dll` or `Win64` variant matching
the target architecture).

Do **not** UPX-pack `libsodium.dll`. UPX-compressing a DLL with crypto
functions risks antivirus false positives and breaks some loader behaviors.

## Vendor keypair (one-time setup)

Before any production build:

1. Build and run `..\Tools\GenerateVendorKeypair.exe` (which also depends on
   `libsodium.dll` -- copy it next to the EXE for the run).
2. The tool produces `vendor_public.key`, `vendor_secret.key`, and
   `SetupVendorPublicKey.inc` in its working directory.
3. **Copy** the generated `SetupVendorPublicKey.inc` over the placeholder in
   this folder. Rebuild `PawnProSetup.exe`.
4. **Move** `vendor_secret.key` to your offline vault. DELETE the on-disk
   copy. NEVER commit either `.key` file (already covered by `.gitignore`).
5. `vendor_public.key` can be discarded -- it's now embedded in the EXE.

If you skip step 3, `PawnProSetup.exe` will still build and run, but
`recovery.dat` will be sealed with an all-zeros key and is non-recoverable.
The `SetupVendorPublicKey.inc` placeholder warns about this.

## Smoke test (after a fresh build)

1. Compile `..\Tools\SealedBoxTest.exe` and run it (with `libsodium.dll`
   in the same folder). Must print "All checks passed." Confirms libsodium
   loads and the bindings work.
2. Run `PawnProSetup.exe` against a sandbox Firebird DB. Pick "New Install".
   Walk the 4 pages. On Done, copy the password to your test password
   manager.
3. Open `PawnPro.ini` -- confirm `[CONNECTION_FB] password_enc=` is a long
   Base64 string and there's no `password=` line.
4. Launch the main `PawnProFB.exe` -- it should start normally and load
   the STORE row populated by the wizard.

The full verification checklist is in
`~\.claude\plans\mighty-growing-duckling.md`.
