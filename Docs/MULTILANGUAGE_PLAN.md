# Multi-Language (English / Spanish) Plan

**Status: DEFERRED — planned, not started.**

Roadmap position — this is **third** in the queue:

1. Full deployment (current focus)
2. LeadsOnline RESTful API (replaces the current CSV/FTP export)
3. **Multi-language (this document)**

No code has been written for this. The document exists so the design survives until item 3 comes up.

> **Re-validate before starting.** Every line number and count below was measured on `main` at 2026-07-14 (commit `41f0894`). Deployment and the LeadsOnline REST work both land first, so treat the specifics as a map, not as gospel — re-grep before editing.
>
> **The LeadsOnline REST rewrite (item 2) directly overlaps §4 of this plan.** Today the police export reads `J_*_DESC` straight from the base tables, which is *why* translated dropdowns can't leak into the upload. Whatever replaces it must preserve that property. If the REST client ends up sourcing jewelry descriptions from the `clnJ*` memtables instead of the base tables, it will start uploading Spanish to law enforcement. **Read §4 before designing the REST payload** — it is cheap to keep the base-table read then, and expensive to discover later.

---

## Context

PawnProFB is en-US only, top to bottom — there is **zero** existing localization infrastructure (0 `resourcestring`, no ITE, no gettext, no TsiLang, no `Language` key in any ini). The store needs the on-screen UI available in Spanish so staff can work in their stronger language.

Decisions taken (scoping, 2026-07-14):

- **English + Spanish, switchable at runtime** (no restart) — cashiers share workstations across shifts.
- **Everything printed stays English** — all reports, receipts, the Florida statutory pawn form, and the LeadsOnline police export remain untouched.
- **Daily-use forms first** — the screens cashiers touch constantly; admin/setup/maintenance screens come later.

The "printed stays English" decision is worth appreciating: it removes the single largest and riskiest cost centre. The reporting surface is ~415 static captions compiled into ReportBuilder DFMs with no runtime template mechanism, concentrated in the **`FLORIDA PAWNBROKER TRANSACTION FORM`** — a state-statute-mandated document carrying Truth-in-Lending and perjury-affidavit boilerplate, with one variant that overlays *pre-printed English stationery* and so cannot be translated by construction. Keeping print English sidesteps all of it, plus the pixel-overflow problem in fixed-layout `TppLabel` bands.

Note the app is **already bilingual by hand in places** — `ReportsDM.dfm` carries `'NO DEVOLUCIONES - NO REFUNDS'` and `'Sign / Firma:'`. That confirms Spanish is the target and that bilingual print has precedent, should the "print stays English" decision ever be revisited.

Intended outcome: a UI that flips between English and Spanish from a menu, with translations shipped as **editable data files next to the EXE** — so a wording fix does not require a rebuild.

## Architecture

Five text surfaces, each with a single chokepoint. The whole design is: **English text is the key; translation happens only at the display boundary; nothing that is compared, stored, or exported ever changes.**

| Surface | Volume | Seam |
|---|---|---|
| DFM captions/hints/grid titles | ~900 captions (631 unique), 148 grid titles, 21 hints | Runtime component walker |
| Pascal literals | ~120 dialog/exception calls + 143 runtime `Caption :=` | Manual `Tr()` wrap |
| DB lookup descriptions | ~55 rows across 6 `J_*` tables | `TDM.LoadLookupMemTable` |
| Derived item status | 7 constants + 2 stray literals | `TField.OnGetText` |
| Reports / police export / receipts | ~415 captions | **Excluded by class filter** |

### 1. `uPawnLang.pas` — new unit, project root

Follows the existing `PawnGlobal` singleton-plus-ini convention.

```pascal
TLangManager = class
  procedure SetLanguage(const Code: string);          // 'en' | 'es'
  function  Tr(const S: string; const Ctx: string = 'ui'): string;
  procedure TranslateForm(AForm: TComponent);          // walk + register
  property  CurrentLang: string read FLang;
end;

function Tr(const S: string; const Ctx: string = 'ui'): string;  // global shortcut
var Lang: TLangManager;
```

**English-source-as-key**, not symbolic keys. This is what makes the DFM walker possible at all (it reads `Caption = 'Search'` and looks up `'Search'`), keeps call sites readable as `Tr('Search')`, and gives automatic fallback to English on any missing entry. Homograph collisions ("Close" the verb vs. the adjective) are resolved with the context argument.

Storage: `Lang\en.json` + `Lang\es.json` beside the EXE, loaded via `System.JSON` (already used in `PawnMain.pas`, so no new dependency):

```json
{ "_name": "Español",
  "ui":     { "Search": "Buscar", "&First Name:": "&Nombre:" },
  "status": { "Pawned": "Empeñado", "For Sale": "En Venta" },
  "lookup": { "Ring": "Anillo", "Bracelet": "Brazalete" } }
```

Shipping translations as data rather than compiled resources is the main reason to prefer this over Delphi's ITE (which also cannot switch at runtime, and cannot touch DB text at all) or dxgettext (aging third-party dependency; its `.po` tooling would need to run in the build). At 41 forms the manager is ~300 lines — smaller than the integration cost of either alternative.

### 2. The component walker — where "print stays English" is enforced

`TranslateForm` recurses `Component.Components`, reading/writing published `string` properties (`Caption`, `Hint`) via `System.TypInfo`, plus the special cases: `TDBGrid.Columns[i].Title.Caption`, `TComboBox/TListBox.Items`, `TField.DisplayLabel`.

Two rules carry the design:

- **Skip any component whose class name starts with `'Tpp'`.** ReportBuilder objects (328 `TppLabel`, 260 `TppDBText`) live in the same `Components` array as the VCL controls, so this one filter keeps every report, receipt, and the statutory police form in English *automatically* — including the 693 `Tpp*` components inside `SearchClient.dfm`, whose VCL half we do want translated. The decision is enforced structurally, not by discipline.
- **Snapshot originals on first walk.** Switching es→en→es must re-key off the English source, so each form gets a `TFormTranslator` created with the form as `Owner` (auto-freed, auto-unregistered) holding the original values. `SetLanguage` iterates live translators and re-applies from the snapshot.

Hook is one explicit line in each in-scope form's `FormCreate` — predictable, and only ~10 forms in phase 1. (`Screen.OnActiveFormChange` would give global coverage in one line but fires at unpredictable times; not worth it.)

### 3. Item status — display/key split, **not** an enum refactor

`PawnGlobal.pas:43-49` defines `PawnItemStatus_Pawned = 'Pawned'` etc. These English strings are simultaneously display text *and* comparison keys: produced into the `cStatus` calculated field by `TDM.GetItemStatus` (`PawnDM.pas:2195-2229`) and `SearchClient.pas:1648-1689`, then compared back at `SearchClient.pas:2152` and `:2161`, and used for grid row colouring via `SameText` in `GetPawnStatusColor` (`PawnGlobal.pas:1234-1245`).

**Treat the existing English strings as opaque codes. Never translate the value — translate only where it is painted.**

- `cStatus` keeps returning `'Pawned'`. Every comparison and every colour lookup keeps working, untouched.
- Add `OnGetText` to the `cStatus` field: `Text := Tr(Sender.AsString, 'status')`. `DisplayText` becomes Spanish; `AsString` stays English.
- `SearchClient.pas:1732` custom-draws with `Column.Field.AsString` — change **that one word** to `DisplayText`. The colour lookup on the line above keeps `AsString`.

An earlier review called a full status-enum refactor a prerequisite. Recommended against: it is a wide, risky change to the core lifecycle of an app in production, and it buys nothing the `OnGetText` seam does not. The codebase already routes the status value to a key-consumer and a text-consumer on adjacent lines; they simply both read `AsString` today. The project already uses `OnGetText` in 11 places, so this is an established idiom here.

Also add constants for the two literals that bypass the constant set today — `'Sold / Close'` (`PawnDM.pas:2211`) and `'Purchase'` (`:2224`), the latter having no `PawnStatusColors` entry at all.

Related trap: `ITEM_STATUS.STATUS_DESC` seeds a **second, parallel status vocabulary** (`'Pawn'`, `'Redeem'`, `'Scrap'`) that is not the same wording as the `PawnItemStatus_*` constants (`'Pawned'`, `'Redeemed'`, `'Melted'`). Do not merge them while translating — they are separate surfaces that happen to look similar.

### 4. DB lookup text — no schema change

> **This section is the one the LeadsOnline REST work (item 2) can silently break. See the warning at the top.**

The 6 `J_*` tables are code-keyed on `CHAR(1)`; FKs store the code, never the text. `TDM.LoadLookupMemTables` (`PawnDM.pas:713-732`) funnels every lookup through one `LoadLookupMemTable(memtable, SQL)` call.

Translate the `*_DESC` column **in the memtable after load**, via the `lookup` context. Field names are unchanged, so all 15 `TDBLookupComboBox` bindings keep working. Then set `IndexFieldNames` on the desc column so Spanish entries sort alphabetically in Spanish (the SQL `ORDER BY` sorts English).

Critically, `LeadsOnlineDM` selects `J_STYLE_DESC` / `J_METAL_DESC` / `J_STONE_DESC` / `J_SHAPE_DESC` straight from the **base tables** into the police upload (`LeadsOnlineDM.dfm:53-54, 502-504`). Because only the memtable copies are translated, the export stays English with no special handling. This is also why the `*_DESC` columns must never be translated in place.

Store-added rows (`CUST_FIELD = true`, editable via `MaintenanceJewle`) simply have no translation entry and fall back to English. A `LOOKUP_I18N` side table would allow per-store translation, but it costs a 4-part schema change (migration script + schema.sql + full-deploy regen + `uDBMigrations` Step); defer until there is demand.

Also never translate `EXPORT_FORMAT.DATA_FIELD_CAPTION` — those are wire field names (`cust_nm_last`, `pledgor_statement`). Only `DATA_FIELD_DESC` is display text.

### 5. Required fix: de-dup keyed on translated text

`EnterTransactions.pas:241-244` locates on `'DESCRIPTION;WEIGHT;SIZE_LENGTH;J_STYLE_DESC;J_TYPE_DESC;J_METAL_DESC'` — de-duplicating items by description text. Re-key to the code columns (`J_STYLE;J_TYPE;J_METAL`).

**This is a latent bug worth fixing on its own schedule, independent of i18n** — it does not need to wait for item 3. It becomes a live mis-dedup bug once descriptions differ by language.

### 6. Language selection & persistence

- Per-user, matching the existing window-state convention: `%LOCALAPPDATA%\PawnPro\PawnPro.ini`, `[SETTINGS] Language=es`; site default from `PawnPro.ini`.
- New constants in `PawnGlobal.pas`: `IniKeyLanguage`, `Lang_English = 'en'`, `Lang_Spanish = 'es'`.
- Menu on `PawnMain` (English / Español) → `Lang.SetLanguage(...)` → retranslate live forms, `DM.LoadLookupMemTables`, invalidate open grids.
- Init in `PawnProFB.dpr` **before** the first form is created (`frmSplash.st_Msg.Caption` at `:88` is already hardcoded there).

## Files

**New:** `uPawnLang.pas`; `Lang\en.json`, `Lang\es.json`; `Tools\LangExtract\` (script scanning DFMs for `Caption`/`Hint`/`Title.Caption` while skipping `Tpp*` objects, and `.pas` for `Tr()` calls → emits a JSON skeleton with empty values; re-runnable to find untranslated strings).

**Modified:** `PawnGlobal.pas` (constants, status literals), `PawnDM.pas` (`LoadLookupMemTable`, `GetItemStatus`, `cStatus.OnGetText`), `PawnProFB.dpr` (init), `PawnMain.pas/.dfm` (menu + walker), `EnterTransactions.pas` (de-dup re-key), `SearchClient.pas` (`:1732` `DisplayText`), `uPawnDialogs.pas` (default `Title` params, `PawnChooseLayawayCloseReason`'s ~8 command-link captions).

**Phase-1 forms** (walker line + `Tr()` wrap on literals): `PawnMain`, `SearchClient` (VCL half only), `EnterClientInfo`, `EnterTransactions`, `EnterPayment`, `Entertems`, `Inventory`, `TransactionList`, `ItemPictures`, `EditInvItem`.

**Explicitly out of scope:** all `Tpp*` report objects, `ReportsDM`, `Report01/02`, `RepPurchases`, `LeadsOnlineDM` export values, `ExportPoliceInformation`, `PawnProSetup*`, `BackupDB`, `ImagesStorageSettings`, `SetupBarcodePrinter`, `MaintenanceJewle`.

Also deferred: packaging `PawnProSetup` to deploy `Lang\*.json` alongside the EXE (same treatment `libsodium.dll` gets in `PAWNPRO_FILES`).

## Known cost: layout, not translation

Spanish runs ~20-30% longer than English, and VCL captions here are fixed-pixel with layout baked in — `'    Pawn Transactions  '` uses padding for centring, `'Customer'#13#10'Picture ID'` hard-wraps, `'Print Police Report'#13#10'F12'` embeds a shortcut. Accelerators (`'&First Name:'`) travel inside the string and can collide once translated. **Expect the per-form layout/QA pass to cost more than the translating.** This is the main reason to stage by form rather than translate everything and fix later.

## Verification

1. **Build** Win64 in Delphi 13; confirm `Lang\*.json` deploy beside the EXE.
2. **Fallback first** — start with `es.json` absent, then empty. App must run fully in English. This proves the fallback path before any translation exists.
3. **Runtime switch** — open client search, an active transaction, and item entry; switch to Español from the menu. Captions, grid headers, hints, and jewelry dropdowns all flip with no restart and no reopen. Switch back; confirm English returns exactly (proves the snapshot, not a re-read of already-translated text).
4. **Status regression** (the highest-risk area) — in Spanish, grid status cells read Spanish *and* keep their colour coding; right-click an item and confirm `popmnuItemPawned` enable/disable still matches the item's real state. Verify a Pawned, Redeemed, Defaulted, For Sale, and Sold item.
5. **Print stays English** — with the UI in Spanish, print the Florida police report (all variants per `STORE.POLICE_REPORT_TO_PRINT`), a pay receipt, and a layaway receipt. Every one must be byte-identical to its English-UI output.
6. **Export stays English** — with the UI in Spanish, run the LeadsOnline export and diff against an English-UI run. `JStyleDesc` / `JMetalDesc` / `JStoneDesc` / `JShapeDesc` must be identical. *(Adapt to whatever the REST client from item 2 looks like — the invariant holds regardless of transport.)*
7. **De-dup** — add two identical items to one transaction in each language; confirm they collapse the same way.
8. **Layout sweep** — each phase-1 form in Spanish at the store's actual resolution, checking for clipped buttons and truncated labels.

Steps 5 and 6 are the ones that must not regress: they are the legally-regulated outputs, and they are what the `Tpp*` filter and the base-table/memtable split exist to protect.
