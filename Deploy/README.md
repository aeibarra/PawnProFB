# Deploy

Output folder for the customer-shippable artifacts.

## Expected contents

| File | Source |
| --- | --- |
| `PawnPro.exe` | Built from `PawnProFB.dpr` (or the legacy ASA `c:\ProjectsGIT\PawnPro\` project during transition). |
| `PawnProSetup.exe` | Built from `..\PawnProSetup\PawnProSetup.dpr`. Mandatory for any FB5 store deploy. |
| `libsodium.dll` | **Download separately**, see below. Required by `PawnProFB.exe` (load-time dependency for backup encryption — the app will not start without it), `PawnProSetup.exe`, and `..\Tools\GenerateVendorKeypair.exe`. PawnProSetup's New Install copies it next to `PawnProFB.exe`. |
| `recovery.dat` | Generated per-store by PawnProSetup.exe New Install. Do NOT ship a single global one. |
| `PawnPro.ini` | Generated per-store by PawnProSetup.exe. Ships blank/example. |

## libsodium.dll

Get from <https://download.libsodium.org/libsodium/releases/>. Use the
`libsodium-X.Y.Z-stable-msvc.zip` release; copy the DLL matching your
target arch:

| Target | Path inside zip |
| --- | --- |
| Win32 | `libsodium\Win32\Release\v143\dynamic\libsodium.dll` |
| Win64 | `libsodium\x64\Release\v143\dynamic\libsodium.dll` |

Drop it here next to `PawnProSetup.exe`. ~150 KB.

**Do NOT UPX-pack `libsodium.dll`.** AppCompress.bat is already configured to skip it.

## What's in git

The EXE and DLL artifacts are excluded by `.gitignore` (`*.exe`, `*.dll`).
Only this README is tracked.
