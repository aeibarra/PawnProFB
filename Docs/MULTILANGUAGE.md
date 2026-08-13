# Multi-Language (English / Spanish)

**Status: DEFERRED — designed, not started.** This is the **single source of truth** for
the multilanguage feature. It absorbs and replaces the earlier `ML_Architecture_Spec.md`,
`MULTILANGUAGE_DATABASE_SPEC.md`, `MULTILANGUAGE_IMPLEMENTATION_PLAN.md`, and
`MULTILANGUAGE_PLAN.md`. The runnable DDL lives in
[`../Schema/PawnPro_FB5_Multilanguage_ReviewDraft.sql`](../Schema/PawnPro_FB5_Multilanguage_ReviewDraft.sql)
(review draft, not yet integrated); this document is the contract that SQL implements.

**Roadmap position — third, and blocked:** (1) full deployment → (2) LeadsOnline REST API
→ (3) multi-language. Do not start until deployment is stable **and** the LeadsOnline REST
work has landed and is verified to source police/export descriptions from the canonical
English base-table columns (never the translated memtables). Line numbers, form counts,
and lookup queries below were measured on `main` at `41f0894` (2026-07-14) — **re-grep
before editing.**

Target: Delphi VCL + Firebird 5 / FireDAC POS. English (`en`) + Spanish (`es`), **runtime
switchable**, extensible to more languages by inserting rows (never a schema change).

---

## Guiding invariants (do not violate)

1. **All user-visible v1 text resolves through the ML layer** — never a hardcoded DFM
   caption or call-site literal, except as a *seed*.
2. **Stored/compared DB codes are never translated.** Translating a value written to or
   matched against the database is a **data-integrity bug**, not a cosmetic one.
3. **One source of truth per value.** A value lives in exactly one place; everything else
   is a derived copy.
4. **Firebird is the per-store source of truth**; adding a language is inserts-only.
5. **No collection item is keyed by numeric position** when a stable identity exists.
6. **Missing translation = missing row**, never an empty string.
7. **English ownership depends on atom type** (see the ownership matrix); English is *not*
   duplicated into `ML_LANG_VALUES` for database lookup descriptions.
8. **Print & export stay English** — a legal constraint (§14), enforced structurally by
   the `Tpp*` filter (§16) and the base-table lookup invariant (§19).
9. **Translation content ships through the normal release migration system** (§20); there
   is no separate content-version lane.

---

# Part A — Architecture & Design

## 1. The four atom types

Every translatable (or explicitly non-translatable) string falls into exactly one:

| # | Type | Example | Authoritative *set* | Translated? | Runtime accessor |
|---|------|---------|---------------------|-------------|------------------|
| 1 | **Component property** | `frmClients.btnClientAdd.Caption` = "Add Client" | DFM / form (via RTTI) | Yes | `TranslateForm` |
| 2 | **Code literal / display constant** | `ShowMessage('Ticket not found')`; `PawnItemStatus_Pawned='Pawned'` | source (call site / const) | Yes | `_()` / `DText` |
| 3 | **Lookup table value** | `J_METALS`: `W → White Gold` | Firebird business table | Yes | `GET_LANG_TEXT` |
| 4 | **Const array set** | `PawnCloseReasons: 3 → 'Defaulted'` | Pascal source (the set) | text only | `DText` |

**Mental model:** Types 1 & 2 are developer-authored strings with no independent business
existence → their only home is the language store. Types 3 & 4 are *code→text maps* — the
code/domain is authoritative elsewhere (Firebird table for 3, Pascal source for 4) and
**only the display text is translated**.

## 2. Ownership by atom type

| Atom | Stable identity (key) | Canonical English | Non-English text |
|---|---|---|---|
| Form property | Form/component/property path | `ML_LANG_VALUES('en')`, seeded from DFM | `ML_LANG_VALUES('<lang>')` |
| Named constant / const array | Constant name or array business `Code` | `ML_LANG_VALUES('en')`, seeded from source | `ML_LANG_VALUES('<lang>')` |
| Inline message | Exact English message text | `ML_LANG_VALUES('en')`; the English is *also* the natural key | `ML_LANG_VALUES('<lang>')` |
| Database lookup description | Table name + stored row code | base-table `*_DESC` column (e.g. `ITEM_STATUS.STATUS_DESC`) | `ML_LANG_VALUES('<lang>')`; **no English lookup row** |

Worked status example (the load-bearing one):
- `INVENTORY_ITEMS.INV_ITEM_STATUS` stays the stable `CHAR(1)` code.
- `ITEM_STATUS.STATUS_DESC` stays canonical English; Spanish for a row is a `lookup` atom
  keyed by its `STATUS` code.
- Derived `PawnItemStatus_*` lifecycle labels are **not** `ITEM_STATUS` rows — they are
  Type 2 application display atoms.

## 3. Runtime resolution

**In-memory store** — one flat dictionary for the current language plus an English fallback
dictionary, loaded once at startup on the existing `TDM.LoadLookupMemTables` path (one extra
query; footprint ~0.5–1.5 MB — do not lazy-load). Load only current + English.

```pascal
GLang           : TDictionary<string,string>;   // current language
GLangFallback   : TDictionary<string,string>;   // English, for misses
GLangGeneration : Integer;                       // bumped on every language switch
```

**Resolvers** (readable-English fallback + missing-key logging):
- `TryLangText(key, out value)` → current → English fallback → false.
- `_(key)` for Type 2/4: returns the value, else `'?'+key+'?'` and logs (QA-visible). For
  English-keyed messages, a miss renders the English key itself.
- `GET_LANG_TEXT` (SQL) for Type 3 lookups — see §10.

**`TranslateForm` (RTTI walker)** recurses `Components`, applying `Caption`/`Text`/`Hint`
(plus collections: DB-grid columns, menu items, tab pages) from the dictionary by
component-path key. **Skips any component whose class starts `Tpp`** (§16). A miss leaves
the English design-time value — never blanks a control.

**Participation = opt-in by ancestry.** v1 forms descend from `TfrmBaseML`; everything still
on bare `TForm` is non-participating for free (default off, for staged rollout). `PawnMain`
uses an allowlist walk (only the nav-into-flow controls + the language switcher).

**Live switch & generation cache.** Forms translate in `DoShow`, guarded by
`FTranslatedGen <> GLangGeneration` (a counter, not a bare boolean, so a switch on an
already-open form is not missed). `SetLanguage` reloads dictionaries + lookup memtables,
increments `GLangGeneration`, and retranslates open participating forms. A freed/recreated
form re-translates on next show. Runtime-created controls must be translated at their
creation seam.

**Persistence: per terminal**, in the machine `PawnPro.ini` `[SETTINGS] Language=`; default
`en` for absent/invalid/inactive. There is no cashier-login system, so nothing finer than
per-terminal applies; the switch writes back to that ini.

## 4. Human classification passes (do first — not mechanical)

These require judgment; the tooling **surfaces candidates and asks**, never auto-decides.

1. **Constant classification.** For every `const`: stored/compared code (`'P'`,`'A'`) →
   exclude; internal key string (value == name) → exclude; display text → Type 2; display
   text that is *also* stored/compared → freeze the stored value as an opaque code and
   translate only the display copy.
2. **Lookup key+text test** (per table): pure key+text folds into the store; any extra
   business column (`CUST_FIELD`, price, flags) keeps text on the entity, overlay-translated.
3. **Participation:** identify the English-only reports/receipts and keep them
   non-participating.

## 5. Worked example — `frmClients.btnClientAdd`

1. **Extract:** the text DFM scanner reads `btnClientAdd.Caption='Add Client'` →
   `ML_LANG_OBJECTS(type='form', obj='frmClients', key='btnClientAdd.Caption')`, seed
   `ML_LANG_VALUES(en)='Add Client'`, `es` blank + NeedsReview.
2. **Translate:** editor fills `es='Agregar Cliente'`.
3. **Load:** startup flattens to dictionary key `frmClients.btnClientAdd.Caption`.
4. **Apply:** `TranslateForm(frmClients)` on show sets the caption via RTTI.
5. **Future wording change:** edit `ML_LANG_VALUES`, not the DFM.

---

# Part B — Database contract

Full DDL is in
[`../Schema/PawnPro_FB5_Multilanguage_ReviewDraft.sql`](../Schema/PawnPro_FB5_Multilanguage_ReviewDraft.sql).
This part is the contract that SQL must satisfy.

## 6. Naming & the natural key

Three tables, all **`ML_` prefixed and plural** so they group in DB tools and avoid the SQL
`LANGUAGE` keyword: `ML_LANGUAGES`, `ML_LANG_OBJECTS`, `ML_LANG_VALUES`. Every string column
is `CHARACTER SET UTF8 COLLATE UNICODE_CI_AI` (including FK columns and all PSQL
parameters/returns/variables).

The natural key is **`(OBJECT_TYPE, OBJ_NAME, ITEM_KEY)`** — case-preserving. `OBJECT_ID` is
an internal identity only and **must never appear in migration content or JSON**. Producers
emit the exact canonical spelling; consumers never invent aliases or normalize differently.

Allowed `OBJECT_TYPE` (do not add `msg`/`array`/`grid` — those distinctions live in
`OBJ_NAME`/`ITEM_KEY`):

| `OBJECT_TYPE` | Meaning |
|---|---|
| `form` | a form/control/collection property from a participating DFM or runtime registration |
| `literal` | an inline message, named display constant, or const-array description |
| `lookup` | a translated overlay for a database lookup description |

## 7. Key grammar

**Form keys** — `OBJ_NAME` = the DFM root object `Name` (e.g. `frmClients`); `ITEM_KEY` =
stable path:

| Form item | Canonical `ITEM_KEY` |
|---|---|
| Form title | `$form.Caption` |
| Normal component | `btnClientAdd.Caption` |
| Hint/text | `edtTicketNo.Hint`, `lblPrompt.Text` |
| DB grid column | `gridItems.Columns[cStatus].Title.Caption` (by **`FieldName`**) |
| Named menu item | `PopMnuPawnItems.Items[popmnuItemRedeemed].Caption` |
| Named tab page | `pgTransactions.Pages[TabPawnTran].Caption` |
| Static ListView col | `lvHistory.Columns[Status].Caption` |
| Static tree node | `chkTree.Nodes[Categories].Text` |

Rules: the form itself uses `$form`; component identity is its Delphi `Name`; grid columns
use `FieldName` (never `Index`, never the English title); menus/tabs use the child's Delphi
`Name` qualified by its named container; a runtime-created item without a `Name` gets a
semantic id frozen in the shared manifest; a data-driven node is **not** a form atom
(resolve via its business identity); numeric indexes are prohibited unless an item truly has
no stable identity and a reviewed manifest freezes it (scanner must report such exceptions);
captions are never identity; **extractor and runtime walker share the same key-building unit
and test vectors.**

**Literal keys:**

| Literal kind | `OBJ_NAME` | `ITEM_KEY` |
|---|---|---|
| Named constant | source unit / manifest namespace (`PawnGlobal`) | constant identifier (`PawnItemStatus_Pawned`) |
| Const array | array identifier (`PawnCloseReasons`) | stable business `Code` (`3`) |
| Inline message | reserved namespace `msg` | **exact canonical English message text** |

Inline-message English is the key (no independent stable identity exists); rewording makes a
new key + an orphan the tool reconciles via **map-to**. **A message > 255 chars cannot be
English-keyed** — promote it to a named literal with a manifest id; never silently
truncate/hash the visible English.

**Lookup keys:** `OBJ_NAME` = uppercase base table (`ITEM_STATUS`, `J_METALS`); `ITEM_KEY` =
the trimmed stored code, preserving DB case (trim `CHAR` padding before lookup); **never the
English description**.

## 8. Table design & limits

Columns and constraints per the DDL file. Length limits: `OBJECT_TYPE` 10, `OBJ_NAME` 80,
`ITEM_KEY` **255** (widened from 120 for hierarchical paths + messages), `DISPLAY_NAME` 160,
`TEXT_VALUE` 500 for v1. The scanner reports keys/values approaching a limit; an overlength
message is promoted (§7); if a real translation exceeds 500, switch `TEXT_VALUE` to
`BLOB SUB_TYPE TEXT` before importing that atom — never truncate.

Design points: `OBJECT_ID` is `GENERATED BY DEFAULT AS IDENTITY`, internal only. UNIQUE
natural key prevents duplicate atoms. `ML_LANG_VALUES` is one row per object/language (new
language = inserts only). `FK … ON DELETE CASCADE` removes an atom's values when it is
deliberately deleted. A language-first index `(LANGUAGE_ID, OBJECT_ID)` serves startup load;
the PK serves object-first access. `TEXT_VALUE` rejects empty/whitespace (missing = no row).

## 9. Timestamp & optimistic editing

`UPDATED_AT` must change on every update (including `NEEDS_REVIEW` changes) via
`TRG_ML_LANG_VALUES_BU` (BEFORE UPDATE). The **editor** does guarded updates —
`… WHERE OBJECT_ID=? AND LANGUAGE_ID=? AND UPDATED_AT=:original` — and treats a zero
row-count as a stale-write conflict (reload + reconcile, never silently overwrite).
**Production release migrations use `SPU_LANG_UPSERT` and intentionally skip the
stale-write check** (last-writer-wins is correct for an import).

## 10. Stored routine contracts

**`GET_LANG_TEXT(obj_name, item_key, lang) → varchar / NULL`** — returns the non-English
lookup overlay, else `NULL` so the caller `COALESCE`s to base English. Hardcodes
`OBJECT_TYPE='lookup'`, trims the input code. Caller pattern:
```sql
SELECT STATUS, COALESCE(GET_LANG_TEXT('ITEM_STATUS', STATUS, :LANG), STATUS_DESC) AS STATUS_DESC
  FROM ITEM_STATUS ORDER BY 2;
```
Rules: call only for small lookup loads, never per-row in large transactional queries;
English bypasses the function (base column); **police/export code always selects canonical
base English or explicit `'en'`, never the current-language memtable**.

**`SPU_LANG_UPSERT(object_type, obj_name, item_key, is_format, language_id, text_value)`** —
the production migration interface. Behavior: (1) upsert `ML_LANG_OBJECTS` by natural key,
get `OBJECT_ID` internally; (2) `IS_EXTRACTED=1` for `form`, else `0`; (3) upsert only the
requested value row, never touch other languages; (4) shipped value `NEEDS_REVIEW=0`; (5) if
an existing **English** form/literal value changes, set every existing non-English value for
that object to `NEEDS_REVIEW=1`; (6) invalid types/languages/empty rejected by
constraints/FKs; (7) idempotent under repeat. `DISPLAY_NAME` is editor metadata, outside the
migration signature.

**`SPD_LANG_DELETE(object_type, obj_name, item_key)`** — delete the matching
`ML_LANG_OBJECTS` row; values go via `ON DELETE CASCADE`; already-absent = success
(idempotent); never accepts/depends on `OBJECT_ID`. (Deleting one language's value is an
editor operation, not this proc.)

## 11. Missing / empty / review / deletion semantics

| Condition | DB representation | Runtime/editor behavior |
|---|---|---|
| Spanish missing | no `es` value row | fall back to English, report untranslated |
| Empty Spanish input | rejected; no row | atom stays untranslated |
| Missing English form/literal | no `en` value row | leave readable source/DFM seed, log missing key |
| Missing lookup overlay | no non-English row | `COALESCE` to base-table English |
| English form/literal reworded | `en` row changes | flag non-English rows `NEEDS_REVIEW=1` |
| Lookup English reworded | base table changes | tool detects baseline change, flags overlay for review |
| Source atom removed | `ML_LANG_OBJECTS` orphaned at scan | preserve until reviewed; delete only via explicit reconciler action / release migration |
| Language retired | `ML_LANGUAGES.IS_ACTIVE=0` | hide from selection, retain history |

An empty string is never an intentional translation. "Display nothing in one language" would
be a separate future feature, not overloaded missing-value semantics.

## 12. Seed policy, recovery & rollback

The one-time structure migration seeds **only** the `en` and `es` language rows. Bulk
`ML_LANG_OBJECTS`/`ML_LANG_VALUES` rows are **never hand-authored** — they come from the
scanner/editor after it exists (form/literal English from reviewed extraction; lookup
Spanish against synced codes; first content migration generated by the tool). Fresh-store
full deploy eventually carries the complete current seed; existing stores get cumulative
tool-generated content migrations (§20).

Firebird DDL is transactional: the structure migration runs as one transaction; failure
leaves the DB version unchanged. It is additive — recovery is roll back → fix → retry, or
(if a manual commit already happened) restore the pre-migration backup. **Never ship an
automatic down-migration that drops the language tables** — once content exists that is
destructive; removal is a separately reviewed maintenance operation with a verified backup.

---

# Part C — Scope & implementation decisions

## 13. v1 scope — the customer/transaction flow only

v1 = `SearchClient` (`TfrmClients`) and the forms it launches to create, pay, and close a
transaction. **No reports, no receipts, no setup/maintenance/inventory screens.**

**IN (whole-form walk, descend from `TfrmBaseML`):** `SearchClient`, `EnterClientInfo`,
`EnterTransactions`, `EnterLayaway`, `EnterPurchase`, `EnterPayment`, `PaymentLayaway`,
`Entertems`, `ItemPictures`, `CapturePicFromCamera`, `CardReader`, `PawnChangeStatus`,
`EditInvItem`, `ItemHistory`, `ConfirmCloseLayaway`.
**PawnMain:** allowlist walk — only nav-into-flow controls + the language switcher.
**OUT (English, v2+/never):** all `Tpp*` reports & receipts, `PoliceRptAdj`,
`TransactionList` (v2), `Inventory`, `MaintenanceJewle`, `BackupDB`, setup/export forms,
`PawnProSetup*`. Do not pull a form into v1 merely because it is reachable from one.

## 14. Print & export stay English (legal)

The Florida statutory police form and the pay/layaway receipts carry TILA + perjury
boilerplate, and one police-form variant overlays pre-printed English stationery. These are
`Tpp*` (ReportBuilder) objects and stay English on **legal** grounds (US regulatory), not
just cost. Enforced structurally by §16.

## 15. Per-type implementation specifics

- **Type 1 (forms).** Extracted by the **text DFM scanner** (§17) — *not* by instantiating
  forms (their `OnCreate` touches `DM`/camera/card-reader). Applied by `TranslateForm` +
  the `Tpp*` skip. Grid columns keyed by `FieldName`. Miss → English design-time caption.
- **Type 2 (named constants + arrays).** One **manifest unit** (`uPawnText`) is the single
  declaration point; entries **reference the real constants** (compile error if one
  vanishes); arrays **self-register** by iterating (`PawnCloseReasons` → key = `Code`).
  The `PawnItemStatus_*` constants are canonical English *derived labels*, dual-used in the
  UI (`cStatus.AsString` is compared and drives colour). Keep that value stable; translate
  only at the display seam: `cStatus.OnGetText` (`AsString` English, `DisplayText` Spanish),
  and the custom grid drawer uses `AsString` for colour, `DisplayText` for text. Also
  register the bare derived labels `'Sold / Close'`, `'Purchase'`, `'Purchased'`.
- **Type 2 (inline messages / exceptions).** `PawnInfo/Warn/Error/Confirm`, `ShowMessage`,
  `MessageDlg`, user-facing `raise`. **English-as-key** (option A): `OBJ_NAME='msg'`,
  `ITEM_KEY` = exact English (also stored as the `en` value row), ≤255 or promote to a
  semantic key. Deciding reason: the scanner auto-seeds English from the call site (a
  semantic key has none) and a miss renders readable English. Wrap the *message* at the call
  site with `_()`; wrap **chrome once** in `uPawnDialogs` (default titles, the
  `PawnChooseLayawayCloseReason` command-links). Standard OK/Yes/No are OS-localized.
  Concatenation → wrap only the literal fragment. Format → `Format(_('%0:s of %1:s'),…)`
  positional + `IS_FORMAT=1` parity. The wrapper must **not** auto-translate (breaks on
  concatenation). Exceptions wrapped **only when user-facing**. A **lint** (§17) flags raw
  literals passed to these calls that aren't `_(…)`.
- **Type 3 (lookups).** English canonical on the base `*_DESC` column (the `J_*` tables have
  `CUST_FIELD`, so by the key+text test they keep text on the entity, overlay-translated).
  `ML_LANG_VALUES` holds only non-English. Resolve with `GET_LANG_TEXT` + `COALESCE` (§10);
  output column keeps its name so the 15 `TDBLookupComboBox` bindings are unchanged; custom
  rows fall back to base English; `ORDER BY` the resolved column sorts in-language.
- **Type 4 (arrays).** Implemented with Type 2 constants (Code-keyed, self-registering).
  Best-behaved: add is safe, reword is free (key = Code), delete is a domain decision.

## 16. The `Tpp*` filter — the print-English guarantee

Both the scanner and the runtime walker **skip any component whose class starts `Tpp`**.
ReportBuilder objects sit in the same `Components` array as VCL controls (693 inside
`SearchClient.dfm` alone), so this one symmetric rule keeps every report/receipt/police form
English **by construction**, even inside a form we otherwise translate.

## 17. Tooling — one merged three-pane app (dev/vendor only)

A separate Delphi project under `Tools/`, run where the source is; it never ships to a store.

- **Layout:** toolbar (`Scan Forms` / `Scan Literals` / `Scan Arrays` / `Sync Lookups`,
  `Export JSON`, `Generate Update`, filters) · left pane = parents grouped by atom type with
  an untranslated-count badge · middle pane = `Key | English | Spanish | flags`. Inline-edit
  Spanish; popup for long/format strings.
- **Text-based scanners** (no form instantiation): Forms → `.dfm` (skip `Tpp*`,
  non-participating); Literals → `_('…')` + lint raw user-facing dialog/exception literals;
  Arrays → parse array literals (key = `Code`); Lookups → sync codes from the dev DB,
  base-table English **read-only**.
- **Reconcile, never overwrite:** buckets new / unchanged / orphaned / untranslated /
  needs-review; **never clobber Spanish**; orphans get **map-to**, with a fuzzy
  English-similarity auto-suggest that carries Spanish forward + flags NeedsReview (this is
  how a reworded message is a two-click carry-over).
- **Validate on save:** empty, duplicate keys, positional-format parity, `&` accelerator
  collisions.
- **Share one unit with the POS** (key grammar + validation) so tool and walker cannot
  drift; scanner and runtime must generate identical keys for a form containing grids,
  menus, tabs, and `Tpp*` objects.
- **Export deterministic `en.json` / `es.json`** and commit; never hand-edit JSON and DB
  independently.

## 18. The keying principle (why only messages orphan)

**Key on whatever stable identity already exists; invent one only when none does.** Captions
have a component name, constants a constant name, lookups/arrays a `Code` — all stable, so
rewording English updates `en` in place + flags `es` NeedsReview, **no orphan**. Inline
messages have no name, so English text is the key — the only type where reword creates a new
key (handled by map-to + fuzzy).

## 19. LeadsOnline / export invariant (must not regress)

English is canonical on the base `J_*` tables, and the police export reads those base columns
directly — so it stays English **structurally**. Never route export text through
`GET_LANG_TEXT(current-lang)` or the translated memtable. **Cross-warning for roadmap item 2
(LeadsOnline REST):** whatever the new REST client sources jewelry descriptions from must
remain base-table English (or explicit `'en'`) — sourcing from the memtable would upload
Spanish to law enforcement.

## 20. Distribution & production updates

**Per store the DB is the source of truth and is shared across workstations**, so one update
propagates to every terminal natively. Authoring flow: edit in the tool → DB → `Export JSON`
→ commit (the reviewable snapshot).

**Translation changes ship as tool-generated `uDBMigrations` steps** — one batched
translation `Step<N>` per application release, bumping `CURRENT_DB_VERSION` like any schema
change (batching means per-release, never per-typo; **no separate content-version lane**).
Detection = **diff the dev DB against the last committed JSON** (git is the last-shipped
baseline). **`Generate Update` emits four artifacts** (the discipline CLAUDE.md already
requires for a schema change, automated):
1. `StepN_Translations…` Pascal → paste into `uDBMigrations.pas`.
2. `Schema/Migrations/PawnPro_FB5_LangUpdate_N.sql` — same delta as canonical SQL.
3. refreshed full `ML_LANG_*` seed in `…Schema.sql` / full-deploy (for **new** stores).
4. the new `CURRENT_DB_VERSION`.

Generated steps call `SPU_LANG_UPSERT` / `SPD_LANG_DELETE` on the **natural key, never the
surrogate `OBJECT_ID`**; they are idempotent and cumulative (a store several releases behind
runs the pending steps in order; new stores get the full seed). Two structural lanes stay
distinct: the one-time **`ML_LANG_*` structure** step (tables + routines) versus the
per-release **content** steps above. The JSON `_version` header is a support/About-box
marker, not the apply-trigger.

## 21. Known cost: layout, not translation

Spanish runs ~20–30% longer, and VCL captions bake layout into the string (padding for
centring, `#13#10` wraps, embedded shortcut hints, `&` accelerators). **The per-form
layout/QA pass costs more than the translating** — the reason to stage by form.

**Independent fix (ship anytime, not gated on ML):** `EnterTransactions.pas:241-244`
de-duplicates items by description text (`J_STYLE_DESC;J_TYPE_DESC;J_METAL_DESC`) — re-key to
codes (`J_STYLE;J_TYPE;J_METAL`). Becomes a live mis-dedup bug once descriptions differ by
language.

---

# Part D — Build plan

Deliver as small, gated vertical increments; each phase compiles and preserves an
English-only runtime before the next begins. **First usable slice:**
`database + runtime core + editor/scanner MVP + SearchClient/EnterClientInfo + one lookup
family + live switch`.

**Entry gates:** deployment complete & stable; LeadsOnline REST landed and verified to source
export descriptions from base-table English; branch rebased and all names/counts/line refs
re-grepped against then-current code. Re-verify (don't redesign) the three-layer status
contract.

**Phase 0 — Re-baseline & inventory.** Reconfirm the §13 form allowlist; inventory each
participating `.dfm`/`.pas` for captions/text/hints/grids/menus/tabs/runtime-created
controls, raw dialog/exception calls, display constants vs stored codes vs internal keys vs
arrays, and `Tpp*` subtrees; confirm inheritance/construction paths, lookup tables/
`CUST_FIELD`/memtable loader. Ship the independent de-dup fix (§21) with its own test. Exit:
no constant/value auto-classified without review; English print/export invariants have named
verification cases.

**Phase 1 — Firebird language foundation.** Create the three tables + `GET_LANG_TEXT` +
`SPU_LANG_UPSERT` + `SPD_LANG_DELETE`; seed `en`/`es`; update all four DB delivery paths
(new `Schema/Migrations/` script; `…Schema.sql`; regenerated full-deploy; next `Step<N>` +
`CURRENT_DB_VERSION`). Verify per §22; twice-applied is harmless; fresh vs upgraded
identical; UTF8 round-trips; procs use natural key not dev `OBJECT_ID`.

**Phase 2 — Runtime core & opt-in base form.** New units (names may change, responsibilities
must not): `uPawnLanguage` (dictionaries, resolution, missing-key log, generation,
load/switch/persist), `uPawnMLForm` (`TfrmBaseML`, `TranslateIfNeeded`, RTTI/collection
walker), `uPawnMLCommon` (shared key grammar + validation), `uPawnText` (manifest). Read
`[SETTINGS] Language=`; load current + English on the memtable path; implement `TryLangText`
/`_()`/`DText`; `TfrmBaseML` opt-in ancestry; translate-on-show via generation; walk
`Caption`/`Text`/`Hint` + VCL grids/menus + Raize tabs; grid columns by `FieldName`; skip
`Tpp*`; leave English on miss; handle runtime-created controls. Verify: no-Spanish = byte
English; `en→es→en` updates open forms; recreated forms translate on next show; non-
participating & `Tpp*` untouched.

**Phase 3 — Scanner/editor MVP.** §17, minimum usable set. Exit: unchanged rescan = no
diff; rename/reword carries Spanish via map-to (flagged); scanner and runtime keys identical
on a grids/menus/tabs/`Tpp*` form.

**Phase 4 — First vertical slice.** `SearchClient` + `EnterClientInfo` → `TfrmBaseML`;
approved `PawnMain` nav + switcher; scan/seed/translate/review; messages → `_()`, chrome via
`uPawnDialogs`; one jewelry lookup end-to-end via `GET_LANG_TEXT`+`COALESCE`. Exit: cashier
switches language mid-workflow without restart; missing Spanish → readable English; the
lookup sorts/displays in-language keeping its code; all embedded reports/print/export stay
English; Spanish layout reviewed at store resolution.

**Phase 5 — Lookup & status integration.** Resolved-language pattern for the remaining small
`J_*` startup lookups and screens showing `ITEM_STATUS.STATUS_DESC` (keyed by `STATUS`;
`INV_ITEM_STATUS` unchanged); base `*_DESC` stay English; no per-row `GET_LANG_TEXT` in large
queries; translate `PawnItemStatus_*` at the presentation seam (`OnGetText`); register
`PawnCloseReasons`/approved arrays by code and approved display constants. Exit: dropdowns
switch keeping codes; statuses display Spanish with colours/enablement intact; custom rows
fall back to English; de-dup identical in both languages.

**Phase 6 — Complete the v1 flow.** Convert remaining v1 forms in small groups (creation;
payment/closure; item support; device/support), each: ancestry → `TfrmBaseML`; scan/classify;
translate; runtime-created controls; run English-fallback/live-switch/functional/Spanish-
layout tests; review the diff before the next group. Do **not** pull in reports/receipts/
setup/maintenance/inventory/backup/export.

**Phase 7 — Release/update generation.** Extend the tool with `Generate Update` (§20).
Exit: upgrade a DB several releases behind through every cumulative step; re-run safely;
fresh-deploy and upgraded store end with identical content.

**Definition of done:** every v1 form opts in via `TfrmBaseML` with reviewed En/Es coverage;
every user-visible v1 string resolves through the ML layer or is documented English-only; DB
codes and canonical English legal/export data never pass through current-language
translation; tooling can scan/reconcile/validate/edit/export/generate repeatably; fresh and
upgraded DB paths synchronized; the full verification matrix (§22) passes.

---

# Part E — Verification

## 22. Verification matrix

**Database (structural):** apply canonical SQL to a store-DB copy, then its idempotent
equivalent again (no error/dupes); build fresh from full-deploy; compare metadata/
constraints/indexes/triggers/routines upgraded vs fresh. **(Data):** round-trip `Español`,
`¿ á é í ó ú ñ` over UTF8; duplicate natural keys rejected; invalid flags/types/empty
rejected; deleting a language in use rejected but deactivate succeeds; object delete cascades
only to its own values; differing `OBJECT_ID` across DBs doesn't affect generated updates.
**(Routine):** `GET_LANG_TEXT` returns Spanish/`NULL`; `COALESCE` gives English on miss;
`SPU`/`SPD` idempotent; English change flags Spanish review; Spanish update clears review for
that value only; stale editor update affects zero rows.

**Application (release blockers):**
1. Spanish absent/empty → a completely usable English app.
2. Live `en→es→en` on all open v1 forms, switching back exactly (proves the generation
   cache, not a re-read of already-translated text).
3. Status display changes do not alter stored state, comparisons, colours, or menu
   behavior (verify Pawned/Redeemed/Defaulted/For Sale/Sold).
4. Police forms and all receipts printed from a Spanish UI are byte-identical to English-UI
   output (all variants per `STORE.POLICE_REPORT_TO_PRINT`).
5. LeadsOnline CSV/FTP **and** REST outputs identical between Spanish and English UI for
   every legally relevant description (`JStyleDesc`/`JMetalDesc`/`JStoneDesc`/`JShapeDesc`).
6. De-dup identical in both languages.
7. Scanner/lint reports no unreviewed raw user-facing literals in v1.
8. All v1 forms pass a Spanish layout sweep at production resolution.
9. Clean Win64 compile, then manual testing against a Firebird 5 DB.

Steps 4 & 5 must not regress — the legally-regulated outputs the `Tpp*` filter (§16) and the
base-table invariant (§19) exist to protect. **Rollout:** pilot terminal/store defaulting to
English; enable Spanish deliberately; collect missing-key/layout logs; fix through the normal
DB → JSON → migration flow; then broaden.
