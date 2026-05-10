# Business Rules

One Markdown file per form (or per closely-related cluster of forms). Captures the
**non-obvious** behavior — why a rule exists, when it triggers, what state it
depends on. Captions, control positions, field types, etc. live in the DFM and
are not duplicated here.

The audience is "future me, six months from now, after I forgot why this works
the way it does."

## Naming

`<FormUnit>.md` — one per Delphi unit that has UI logic worth recording. Mirror
the `.pas` filename so jumping between the two is mechanical.

If a feature spans several forms (e.g. the pawn close-out flow touches
`PawnChangeStatus`, `EnterPayment`, and `ChangePawnItemsStatus`), put it under
the form the user starts from and link out from there.

## Template

```markdown
# <Form caption>  (`<FormUnit>.pas`)

**Purpose:** one or two sentences on what the form is for.

**Entry points:** who launches it and how (form, button, menu item). Includes
any state callers must set up before `ShowModal` (e.g. `qry.Edit`,
`PrepareForCopyItems`, parent-form selections).

**Exit modes:** what `mrOK` vs `mrCancel` mean, and any side effects that
happen on either path.

---

## Controls and rules

For each control whose behavior isn't self-evident from caption + DataField:

### `<ControlName>` — <one-line description>

- **When visible/enabled:** the conditions, plain English first then the
  expression if useful (`not NewRow and TRAN_TYPE = 'P' and TRAN_DATE = today`).
- **What it does:** the effect on the dataset / DB / other forms.
- **Why:** the reason this rule exists. *This is the part that gets forgotten.*
- **Edge cases:** anything weird (e.g. "if balance is zero, throws"; "the
  reverse-engineering only works on rows pumped from ASA where the rate field
  is null").

Skip controls that are just plain `TDBEdit` / `TDBLookupComboBox` bound to a
field with no special logic — those don't need documentation.

---

## Cross-form dependencies

If this form reads from or writes to global state that another form cares
about (e.g. `DM.ReCalcMaturity`, `frmClients.qryInvItems`), list it here so a
future maintainer doesn't break the contract.

## Open questions / known weirdness

Things you *intentionally* haven't fixed, with enough context to decide later
whether to address them. Better here than in scattered TODO comments.
```

## What NOT to put here

- Anything trivially derivable from reading the DFM (positions, fonts, colors).
- Anything trivially derivable from reading 5 lines of the .pas (a method that
  just sets `Visible := True`).
- API surface of components — that's what comments in the .pas are for.
- Step-by-step user manuals — these are for *developers*, not end users.

If you find yourself documenting how to use a control like an end user would
expect it to work, you're probably writing the wrong document.
