# LeadsOnline `ticketWS` WSDL — provenance and re-import recipe

`../../LeadsOnlineWS.pas` is WSDL importer output and must never be hand-edited.
This folder holds the input it was generated from, so the regeneration is
reproducible.

| File | What it is |
|---|---|
| `ticketWS_sandbox.wsdl` | fetched verbatim from `https://w3apisandbox.leadsonline.com/ticketWS.asmx?wsdl` |
| `ticketWS_sandbox_wsdl0.wsdl` | fetched verbatim from the same URL with `?wsdl=wsdl0` — the binding document the first one imports |
| `LeadsOnlineWS.wsdl` | the two above merged into one document; **this is what WSDLImp is run against** |
| `../leadsonline.wsdl` | the retired 2025-07-09 copy, kept only for diffing |

Sandbox and production serve byte-identical schemas — the only difference is the
`soap:address` host — so importing from either produces the same proxy. The
endpoint is chosen at runtime by `uLeadsOnlineClient`, not by the import.

## Why the merge step exists

The two documents import **each other**: the root declares the types, messages,
portType and service and imports `?wsdl=wsdl0` for the binding; `wsdl0` declares
the binding and imports the root back for the portType. `WSDLImp.exe` walks that
cycle and emits the service interface and its whole `InvRegistry` registration
block **twice** in one unit, which does not compile.

Merging removes the cycle.

## Re-importing

Run the script. Do not do this by hand.

```
.\Tools\RefreshLeadsOnlineWSDL.ps1                        # sandbox
.\Tools\RefreshLeadsOnlineWSDL.ps1 -Endpoint Production
.\Tools\RefreshLeadsOnlineWSDL.ps1 -SkipFetch             # re-merge what is on disk
```

It fetches both documents, merges them, runs `WSDLImp.exe` (found automatically
in `<RAD Studio>\bin`), and overwrites `LeadsOnlineWS.pas` — but only after the
generated unit passes its checks: exactly one `ticketWSSoap` declaration, exactly
one `InvRegistry` registration, and all eight operations present. The duplicate
counts are what the cycle produces, so a failed merge stops the script instead of
reaching the compiler. Output is written UTF-8 **with** BOM, CRLF, per
`.editorconfig`.

The merge itself is mechanical: delete the root's `<wsdl:import>`, splice
`wsdl0`'s `<wsdl:binding>` in ahead of `<wsdl:service>` (dropping its
`<wsp:PolicyReference/>`, which only asserts HTTPS transport), and rewrite the
`i0:` prefix as `tns:` — both bind `http://www.leadsonline.com/`, so that is a
rename, not a change of meaning. `WSDLImp` has no unit-name switch: the unit is
named after the input file, which is why the merged copy is `LeadsOnlineWS.wsdl`.

The script prints any change to the operation list or the enumerations against
the previously fetched copy, so a schema revision announces itself. The
2026-04-30 revision added `ImageType.Pdf` and six `ImageCategory` members
(`Vehicle`, `VehicleLicense`, `Document`, `Check`, `CashCard`,
`ProfessionalLicense`) over the 2025 copy; the eight operation names have not
changed.

After a re-import, rebuild `PawnProFB` and smoke-test — a proxy that compiles is
not a proxy that works.

## Smoke-testing a change

`Tools\LeadsOnlineProbe.dproj` builds a console tool that calls `CheckLogin`
through `uLeadsOnlineClient` with no database and no UI:

```
LeadsOnlineProbe <storeId> <userName> <password> [--production] [--xml]
```

Credentials are arguments, never a file — this repository is public.
