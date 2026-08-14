# PawnProFB Security Plan

Last updated: 2026-08-14

This document captures the incremental security plan for the Firebird 5 version
of PawnProFB. The goal is to improve production security in small steps, verify
each step in real stores, and avoid changing too many moving parts at once.

## Guiding principles

- Keep changes small enough to test safely in production.
- Prefer one security improvement at a time, then observe behavior before adding
  the next layer.
- Avoid storing database passwords in plain text.
- Do not put real passwords in SQL scripts, batch files, source files, logs, or
  checked-in INI files.
- For the first security rounds, continue using the Firebird `SYSDBA` account.
  App-specific Firebird users and roles can come later.

## Current basic model

PawnProFB currently connects to Firebird through `[CONNECTION_FB]` in
`PawnPro.ini`.

The current first-round model is:

- Firebird user remains `SYSDBA`.
- `PawnPro.ini` stores the password as `password_enc=`.
- `password_enc` is encrypted using Windows DPAPI through
  `COMMON\DPAPIUtils.pas`.
- The plain `password=` key is legacy only and should not remain in production
  INI files.
- If `password_enc` is missing or cannot be decrypted, PawnProFB asks for the
  database password.
- After a successful Firebird connection, PawnProFB writes a fresh
  `password_enc` value and removes any plain `password=` key.

DPAPI is currently used with machine scope. This means a `password_enc` value is
valid on the workstation that created it, but normally cannot be copied to a
different workstation and decrypted there. That behavior is intentional. If an
INI file is copied to another workstation, PawnProFB should prompt once for the
database password and then rewrite `password_enc` for that workstation.

## Step 1 status: INI password encryption

Step 1 is the main application behavior:

- Read `password_enc` first.
- If decrypt succeeds, use it.
- If decrypt succeeds and legacy `password=` also exists, remove `password=`
  after a successful database connection.
- If only legacy `password=` exists, use it once, then write `password_enc` and
  remove `password=` after a successful database connection.
- If no usable password exists, prompt for the Firebird database password.
- If the user cancels the prompt, close PawnProFB.

This gives a safe migration path for existing stores because their current
plain `password=` entry can be converted automatically after a successful
connection.

## Step 2 status: first-install setup provisioning

The intended production installation flow uses the `PawnProSetup` app from a USB
memory stick after Firebird has been installed.

The `PawnProSetup` app is the first-run provisioning tool. Its job is to:

1. Copy the files needed to run PawnProFB to the install folder.
2. Create or update `PawnPro.ini`.
3. Connect to the local or remote Firebird server using the current `SYSDBA`
   password.
4. Change the Firebird `SYSDBA` password to the new store password.
5. Test a fresh Firebird connection using the new password.
6. Write the new password to `PawnPro.ini` as DPAPI `password_enc`.
7. Ensure no plain `password=` key remains in `PawnPro.ini`.
8. For single-workstation installs, set Firebird `RemoteBindAddress = localhost`
   in `firebird.conf` so the server listens on loopback only (LAN machines
   cannot reach it). For multi-workstation installs, disable that restriction so
   the server listens on all interfaces (Firebird's default when unset).
9. Create/update the Firebird database alias in `databases.conf`:
   `PAWNDATA = <database path>\PAWNDATA.FDB`.

Expected files copied by setup include:

- `PawnProFB.exe`
- `fbclient.dll`
- `libsodium.dll` — **load-time dependency of `PawnProFB.exe`** (backup
  encryption, see "Encrypted database backups" below). The app will not start
  without it in the install folder, so setup copies it next to `PawnProFB.exe`.
- `plugins\chacha.dll`, `plugins.conf`, `firebird.msg` — the Firebird wire
  encryption client files (see "Wire encryption" below)
- a blank or seeded `PAWNDATA.FDB` — copied **only for local-DB installs**, and
  to the aliased database path (the `databases.conf` location), not the install
  folder. A client/workstation does not receive a local copy. An existing
  database is never overwritten.

`PawnPro.ini` is created or updated by setup instead of copied with a plain
password.

### Wire encryption

Firebird 5 defaults to `WireCrypt = Required`, so a client must be able to
negotiate an encrypted wire protocol or the server rejects the connection
("connection rejected by remote interface"). The strong ChaCha cipher ships as a
plugin, so the setup copies `plugins\chacha.dll` (the cipher), `plugins.conf`
(maps the ChaCha64 plugin name to it), and `firebird.msg` (readable server error
text) next to `fbclient.dll`. This folds in the standalone
`CopyFbClientCrypto.bat`, which is kept only as a manual fallback.

These files are copied for every install; they are harmless for a local/loopback
install and required for any client that connects to a remote host.

The setup app should ask for:

- Install folder
- Firebird host, usually `localhost`
- Firebird port, usually `3050`
- Database path, for example `C:\Pawn\PAWNDATA.FDB`
- Current `SYSDBA` password, usually `masterkey` on a fresh Firebird install
- New `SYSDBA` password
- Whether this is a single-workstation or multi-workstation installation

The Firebird password change can be issued through FireDAC after connecting with
the current valid `SYSDBA` password:

```sql
ALTER USER SYSDBA SET PASSWORD 'new-password';
```

In Delphi, the setup app executes the command through FireDAC using an escaped
literal with `QuotedStr(NewPassword)`.

Important: this password change affects the Firebird server/security database,
not only one PawnPro `.FDB` file.

`RemoteBindAddress` is a Firebird server configuration setting. Changing it
requires editing the local Firebird `firebird.conf` and restarting the Firebird
Server service before the new setting takes effect.

Note: do **not** use `RemoteAccess = false` for the standalone lockdown. Firebird
treats every TCP/IP connection — including `localhost` — as remote, so
`RemoteAccess = false` would also reject PawnPro's own `localhost:3050`
connection. `RemoteBindAddress = localhost` blocks LAN machines while still
allowing the local app to connect over TCP.

The generated production INI should use the alias as the database value:

```ini
[CONNECTION_FB]
database=PAWNDATA
```

The physical database path remains in Firebird's `databases.conf`.

## Step 2 implementation phases

The setup work is implemented in small pieces:

1. Update `PawnProSetup` so newly created INI files use `password_enc` instead
   of plain `password=`.
2. Add a connection test using current `SYSDBA` password.
3. Add a controlled "Change SYSDBA Password" action.
4. After password change, reconnect with the new password.
5. Only after that successful reconnect, write `password_enc=` and remove
   `password=`.
6. Add simple status logging in the setup UI, but never log passwords.

This keeps each failure point understandable:

- Copy failed: no security changes made.
- Current password wrong: no security changes made.
- Password change failed: INI remains unchanged.
- New password works: INI is updated with DPAPI encryption.

## Password generation

For early pilots, it is acceptable for the installer/admin to enter the new
password manually.

Later, the setup app should support generating a strong password and showing it
once for the installer to record in the customer password manager. The generated
password should then be saved only as DPAPI `password_enc` in `PawnPro.ini`.

## Vendor public-key recovery (libsodium / SealedBox)

`libsodium.dll` and `COMMON\SealedBox.pas` provide public/private-key
encryption used in two places:

- **Password recovery envelope** (`recovery.dat`): the setup app embeds a vendor
  public key and seals the store password into `recovery.dat`; the private key
  remains offline with the vendor; a recovery tool decrypts it if the customer
  loses the database password.
- **Encrypted database backups** (see below): the same vendor keypair seals each
  backup's data key.

Both share one vendor keypair. The public half is embedded via
`SetupVendorPublicKey.inc`; the secret half (`vendor_secret.key`) lives only on
the offline vendor vault USB and is never shipped or committed (`*.key` is
git-ignored). Because backups now depend on it, `libsodium.dll` is a **shipped,
required** runtime file (not optional): the main app will not launch without it.

## Encrypted database backups

The in-app backup (`TDM.RunBackup`, DB menu) produces a Firebird `.fbk` via the
Services API (`TFB5DBA.BackupDatabase`) and then **encrypts it at rest** so the
plaintext — which contains client PII/SSN — never lingers on disk, a USB, or a
backup folder.

Scheme (hybrid envelope, `COMMON\Nvv.Crypto.FileEnvelope.pas`):

1. A random per-backup data key encrypts the `.fbk` with libsodium
   XChaCha20-Poly1305 secretstream (chunked/streaming; each chunk is
   authenticated, so tampering/truncation fails on restore).
2. That data key is sealed to the embedded vendor **public** key via
   `SealedBox`. Only the offline `vendor_secret.key` can open it.
3. Output is `PawnPro_<ts>.fbk.enc`; the plaintext `.fbk` is securely deleted;
   the 7 newest `.enc` are retained.

Properties:

- The store never handles a key or password. Encryption is automatic and uses
  only the embedded public key (harmless if extracted from the EXE).
- One vendor keypair works for all stores.
- Kill-switch: `[BACKUP] EncryptBackups=0` restores legacy plaintext backups
  (default/missing = ON).

**Restore (vendor only):** on the store's PC (remote or via the vault USB), from
a folder holding `vendor_secret.key` + `libsodium.dll` + `PawnProDecrypt.exe`:

```
PawnProDecrypt.exe  PawnPro_<ts>.fbk.enc  PAWNDATA.fbk
gbak -c -user sysdba -password <pw>  PAWNDATA.fbk  localhost:C:\DB\PAWNDATA.FDB
```

`Tools\PawnProDecrypt` reads `vendor_secret.key` and derives the public key from
it if `vendor_public.key` is absent, so the secret-only vault works as-is. See
`Tools\HOW_TO_RECOVER_FROM_BACKUP.txt`.

Caveats: gbak must write a plaintext `.fbk` before it is encrypted+deleted (a
brief on-disk window). Image-folder backups remain plaintext (out of scope for
now). Losing `vendor_secret.key` makes **all** stores' backups unrecoverable —
keep the vault USB backed up.

This machinery is not required for the Step 1 / Step 2 password work, which only
uses Windows DPAPI.

## Third-party credential encryption (LeadsOnline)

Planned, not yet implemented. This section is the agreed design.

**Priority: worth doing, but not first.** Two things temper the urgency, and both
should be weighed before this work is scheduled ahead of anything else:

- The `.fbk`-in-transit case cited below as motivation is **already closed** by
  the encrypted backups described in the previous section. The honest residual is
  narrower than the list suggests: a support technician handed a `.fdb` copy. A
  store employee with a SQL console is sitting at a PC that also holds the EXE,
  and is therefore outside the boundary this scheme creates at all.
- A live database credential remains committed in this repository's history and
  needs rotating. That is a broader exposure than anything in this section, it is
  a task rather than a design, and it should be cleared first.

### Scope

The LeadsOnline credentials on the single-row `STORE` table, stored in plain text
today:

- `LEADS_ONLINE_USER_NAME` `VARCHAR(50)` — FTP user
- `LEADS_ONLINE_PASSWORD` `VARCHAR(50)` — FTP password
- `LEADS_ONLINE_API_USER` `VARCHAR(50)` — SOAP user
- `LEADS_ONLINE_API_PASSWORD` `VARCHAR(255)` — SOAP password

`LEADS_ONLINE_FTP_ADDRESS`, `LEADS_STORE_ID`, `LEADS_ONLINE_EXPORT_METHOD` and
`LEADS_ONLINE_USE_SANDBOX` are configuration rather than secrets and stay in
plain text.

All four credentials move into a single encrypted payload column; the four
columns above are dropped once conversion is proven. See "Design".

### What this does and does not protect

These are credentials the app must recover in **cleartext** in order to use them
— it hands them to the FTP client and to the SOAP header. No key handling changes
that. The boundary this design creates is:

> Holding the `.fdb`, or a `.fbk`, is not sufficient to read the credentials.
> Reading them requires the **database password**, or the offline **vendor
> secret key**, or a running PawnPro on a workstation that already has the
> password.

That is the right boundary because the realistic exposures for this data are all
database-only: a support technician handed a database copy, a `.fbk` handed to
someone for diagnosis, a stolen file. It is **not** user-level authorization, and
the plan should never be described to customers as if it were — see "The hard
boundary" below.

Blast radius if the credentials leak: submission access to one store's
LeadsOnline police reporting. Real, but bounded.

### The hard boundary

PawnPro has no application login and no permissions model. **Anyone who can run
PawnPro on a workstation that can reach the database can cause it to decrypt
these credentials**, and so can anything running with that user's rights,
including malware or anyone reading process memory.

This design protects *data at rest* — database files, backups, copies in transit.
It does not and cannot create user-level authorization. Every claim made about it
must stay inside that line.

### Rejected alternatives

- **A symmetric key embedded in `PawnProFB.exe`** (the previous design in this
  document, superseded 2026-08-14). It needed no provisioning, which was its whole
  appeal, but the boundary it produced was "attacker needs the `.fdb` *and* the
  EXE" — and the EXE ships to every store and is not a secret in any meaningful
  sense. It also offered no revocation, and committing a symmetric key to a
  git-ignored `.inc` is one mistake away from permanent exposure in history. The
  envelope design below achieves a real second factor for comparable effort.
- **Firebird's built-in `ENCRYPT()` / `DECRYPT()`** (available in FB4+, so
  present in FB5). The key travels as a statement parameter, which puts it in
  `MON$STATEMENTS` and any trace session — next to the ciphertext it protects.
  It also offers no AEAD mode, so ciphertext would be unauthenticated. It buys
  nothing over encrypting client-side, because the key has to live in the
  application either way.
- **DPAPI applied directly to the column values**, as Step 1 does for the INI
  password. DPAPI is machine-scoped by design (see "Current basic model"). The
  `STORE` row lives in the shared database and is read from every workstation, so
  ciphertext written on one PC could not be decrypted on another. DPAPI still has
  a role here — protecting the *database password* in the INI, which is what the
  design below ultimately derives from — but it cannot protect a shared column.
- **A DPAPI-encrypted copy of every credential for every workstation.** Removes
  the sharing problem by duplicating the data, but every password change and every
  new workstation becomes an N-way update. One key with N wrappings is the same
  idea done cleanly.
- **Native database encryption (DBCRYPT plugin).** Firebird ships only a sample
  plugin that is not real encryption; production plugins are third-party or
  commercial, and it would complicate the `TFB5DBA` backup path.

### Design

Envelope encryption: **one random 256-bit master key per store**, which encrypts
the credentials; the master key itself is then wrapped two different ways, each
answering a different question. Nothing secret is compiled into the EXE.

```
        LEADS_ONLINE_CREDENTIALS_ENC   (one AEAD payload on STORE)
                       |
                       |  XChaCha20-Poly1305
                       |
              per-store master key   (256-bit, random, never at rest in the clear)
                 /                \
   APP_STATE['CRED_MASTER_KEY_WRAP']    APP_STATE['CRED_MASTER_KEY_SEALED']
     argon2id(database password)          sealed to the vendor public key
     -> any workstation that can          -> vendor only, for disaster
        connect, with no prompting           recovery
```

**Why the database password is the wrapping secret.** A workstation needs
something a stolen `.fdb` does not have. The Firebird password is exactly that:
every authorized PC holds it (DPAPI-protected in `PawnPro.ini`, decrypted at
startup via `DPAPIUnprotect` in [PawnDM.pas](../PawnDM.pas)), and it is **not
inside the database file**. Firebird keeps users in `security5.fdb` on the
server, and even there as an SRP verifier rather than plaintext.

That gives automatic provisioning with no operator involvement, in the same
spirit as `APP_STATE['IMAGE_SHARED_PATH']`: a new workstation connects — which
proves it has the password — reads the wrap, derives the key, and works. Nothing
to type, copy, or carry between machines.

It is not circular. Reading `APP_STATE` already requires connecting, so by the
time the wrap is visible, the input that opens it has necessarily been supplied.

**The ceiling this creates, stated plainly:** the credentials become exactly as
strong as the database password. argon2id makes offline guessing expensive, but a
store still running `masterkey` gains nothing from any of this. That makes the
generated-strong-password item under "Password generation" load-bearing rather
than a nicety.

**The master key is never stored locally.** It is derived at startup, held in
memory as a private `TBytes` on `TDM` for the session, and that is all.

- No second secret at rest on the workstation; the machine's footprint stays the
  single `password_enc` blob it has today.
- No cached key to go stale, no rewrap-on-mismatch logic, and no way for two
  workstations to disagree about which key is current.
- Caching would buy nothing defensively: a machine-scope DPAPI blob is readable
  by anyone holding the machine, who could equally derive the key themselves.

**Changing the database password must re-wrap, and `PawnProSetup` is the only
place that can do it reliably.** The wrap is derived from the password, so
changing the password invalidates it. It is tempting to assume a running
workstation will notice and re-wrap from its in-memory copy, but that only holds
if one happens to be running at the time — after a password change made with the
app closed, *no* machine holds the master key and the wrap can never be opened
again.

`PawnProSetup` is where this belongs because at the moment of the change it is
the one process holding **both** the old and the new password: unwrap with the
old, re-wrap with the new, write the row, in the same operation that issues
`ALTER USER SYSDBA SET PASSWORD`. If that step is skipped the failure is silent
until the next launch.

This directly affects the existing advice in
`Tools\HOW_TO_RECOVER_FROM_BACKUP.txt` to change the SYSDBA password after a
recovery — safe only once `PawnProSetup` re-wraps.
- Cost is one argon2id derivation per launch, inside a startup that already runs
  migrations, opens a connection, and loads the lookup memtables.

Do **not** reach for `CryptProtectMemory` on the in-memory copy. The database
password already sits in cleartext in `ConnFB.Params` for the life of the
connection, and the decrypted credentials themselves pass through memory on the
way to the SOAP header and the FTP client. Encrypting the master key in RAM while
its own outputs sit unprotected is theatre. `TBytes` rather than `string` is
worth it though: not reference-counted and silently copied on assignment, and it
does not surface in a `strings` dump of a crash file.

**Cipher.** libsodium `crypto_aead_xchacha20poly1305_ietf_encrypt`
(XChaCha20-Poly1305) via the already-required `libsodium.dll`, random 24-byte
nonce, in a new `COMMON\Nvv.Crypto.FieldCipher.pas`.

XChaCha rather than AES-256-GCM: libsodium's AES-GCM needs a runtime
`crypto_aead_aes256gcm_is_available()` check for AES-NI, and GCM's 96-bit nonce
carries a birthday bound that argues against random nonces. XChaCha's 192-bit
nonce makes random nonces unconditionally safe, and it is the primitive the
backup envelope already uses — one AEAD construction in the codebase, not two.

A **purpose string is passed as associated data** (`LEADS_CREDENTIALS_V1`).
Without it a ciphertext is portable: anyone with SQL write access could move a
blob somewhere it does not belong and have it decrypt cleanly into the wrong
value. Binding the purpose makes that fail authentication instead, and it costs
nothing.

**Storage: one payload, not four columns.**

```
LEADS_ONLINE_CREDENTIALS_ENC  BLOB SUB_TYPE TEXT
LEADS_ONLINE_CREDENTIALS_VER  SMALLINT
```

The payload carries the FTP and SOAP usernames and passwords together. One blob
makes the four values **atomic** — four separate encrypted columns can end up
half-converted or half-rotated after a failure — and `BLOB SUB_TYPE TEXT`
sidesteps the width arithmetic the previous design needed entirely.

`LEADS_ONLINE_FTP_ADDRESS`, `LEADS_STORE_ID`, `LEADS_ONLINE_EXPORT_METHOD` and
`LEADS_ONLINE_USE_SANDBOX` stay in plain text: configuration, not secrets. The
four plaintext credential columns are dropped once conversion is verified.

**The two `APP_STATE` rows.** Both are safe in the shared database because
neither is usable without something the database does not contain.

| key | holds | opened by |
|---|---|---|
| `CRED_MASTER_KEY_WRAP` | `LOC1:` + Base64 of salt, parameter profile, nonce and wrapped key | any workstation that can connect |
| `CRED_MASTER_KEY_SEALED` | the master key sealed to the vendor public key | `vendor_secret.key`, offline |

Both fit comfortably: the wrap is about 120 Base64 characters and the seal
(32 + 48 = 80 bytes) is 108, against `APP_STATE.VALUE_TEXT` at `VARCHAR(255)`.
**No schema change to `APP_STATE` is required.** Both are text values, so
`SetAppStateText` writes `VALUE_TEXT` and nulls the other three, honouring the
one-value-type-per-key rule.

The salt and argon2id parameters live **inside** the wrap value rather than in
rows of their own, for the same atomicity reason as the credentials payload: a
rekey is then a single-row write that either happens or does not. Split across
rows, a store can end up with a new salt beside an old wrap and simply lose the
ability to derive its key. Keeping the parameters in the row rather than fixed in
code also allows the work factor to be raised later without shipping a new EXE.

Following the existing `AppStateKeyImageSharedPath` precedent:

```pascal
AppStateKeyCredMasterKeyWrap   = 'CRED_MASTER_KEY_WRAP';
AppStateKeyCredMasterKeySealed = 'CRED_MASTER_KEY_SEALED';
```

### Recovery after total loss of a store's PC

**The normal path does not involve the vendor keypair at all.** The wrap is
derived from the database password and a salt carried inside the wrap row itself
— both survive a backup and restore. The vendor sets and knows the SYSDBA
password for every store, so restoring with the *same* password leaves the wrap
openable and the credentials intact:

```
1. PawnProDecrypt.exe  PawnPro_<ts>.fbk.enc  PAWNDATA.fbk
2. gbak -c ...  using the SAME SYSDBA password the store had before
3. Install PawnPro, enter that password once
   -> derives the master key, unwraps, LeadsOnline works
```

Nothing is re-keyed and nothing is re-typed. The rebuilt machine provisions
itself exactly like any other workstation, because from the key's point of view
nothing changed — only the hardware did. `gbak -c` needs no prior credential
either: Firebird keeps users in `security5.fdb` on the server, not inside the
`.fbk`, so the restored database adopts whatever server it is restored onto.

**`CRED_MASTER_KEY_SEALED` is therefore insurance, not the primary path.** It
covers exactly one case: a store whose recorded password turns out to be wrong or
lost. Its recovery route is:

```
PawnPro_<ts>.fbk.enc --vendor_secret.key--> PAWNDATA.fbk
                                                 |
                                    APP_STATE['CRED_MASTER_KEY_SEALED']
                                                 |
                                    --vendor_secret.key--> master key
                                                 |
                              re-wrap under the new password, write WRAP
```

Note that route **re-wraps rather than reveals** — the vendor never needs to see
the store's LeadsOnline password to restore their system.

**Write the row; do not build the tooling yet.** Writing it costs a few lines at
key-creation time, whereas adding it later means a migration pass across every
deployed store. Building the unseal-and-re-wrap tool, by contrast, can wait until
something actually needs it — and even then, re-typing the LeadsOnline
credentials into the settings form is a two-minute fallback, since LeadsOnline
reissue them on request. Cheap insurance taken now, tooling deferred.

Two properties to accept deliberately:

- **This widens what the vendor keypair unlocks.** It already opens every backup
  — and those contain all customer PII and SSN — so the marginal widening is
  small, but the vault USB becomes a root for credential recovery too.
- **Sealed boxes are anonymous, so that row is confidentiality-only.** The vendor
  *public* key is embedded in the EXE and extractable, so anyone with database
  write access could overwrite the row with a seal of their own. That reveals
  nothing and only breaks the insurance path, and it fails cleanly: a wrong
  master key fails the AEAD rather than yielding garbage.

**Rotation must write both rows in one transaction.** They hold the same key.
Rotate, update the wrap, forget the seal, and the insurance now points at a key
that opens nothing — a fault nobody discovers on the day they cause it. One
routine creates and rotates the master key and writes both rows; no other code
path writes either.

### What the recovery premise now rests on

Because the primary path is "restore with the same password", the vendor's
**password record per store is now load-bearing**, in the same way the vault USB
is. Two consequences follow, and neither is cryptographic:

- **It is a concentration of risk.** Whatever holds those passwords should be
  backed up and not live solely in one person's memory or one laptop.
- **It can rot silently.** If a store's SYSDBA password is ever changed without
  the record being updated, nothing breaks and nothing complains — a running
  workstation re-wraps from its in-memory key and carries on. The stale record is
  discovered on the day it is needed, which is exactly the failure mode this
  design is trying to avoid. `PawnProSetup` is the only sanctioned way to change
  that password, so it is the natural place to make recording it a required step
  rather than a habit.

And the dominant risk sits upstream of all of this: **every path above assumes a
`.fbk.enc` exists somewhere other than the machine that died.** `TDM.RunBackup`
writes to an operator-chosen path ([BackupDB.pas](../BackupDB.pas), `edBckPath`),
and nothing stops that being a folder on the same disk. For a single-workstation
store that would make the store unrecoverable regardless of any key handling. The
same question applies to the separately-backed-up image folder. Verify the backup
destination and its off-site copy before relying on any of this.

**A failed unwrap must be non-fatal.** Migrations are fatal by design — there is
no trading on a half-migrated schema. Credentials are the opposite: a corrupted
wrap, or a store not yet provisioned, disables the LeadsOnline features with a
clear message and leaves the shop writing pawns. Decide that explicitly rather
than letting an unhandled exception decide it.

**Access seam.** Add explicit accessors on `TDM` — `GetLeadsOnlineFtpUser` /
`GetLeadsOnlineFtpPassword` / `GetLeadsOnlineApiUser` /
`GetLeadsOnlineApiPassword` and matching setters — mirroring the existing
`GetAppState*` / `SetAppState*` convention.

**The settings form must stop using data-bound controls for these four values.**
It currently binds `TRzDBEdit` straight to the persistent fields, which a single
encrypted payload makes impossible: there is no longer a field per credential to
bind to. Replace them with plain edits populated from the accessors on show and
written back through the setters on save.

That is a feature, not a cost. The obvious shortcut for the four-column design
was `OnGetText` / `OnSetText` on the persistent fields, and it is a trap:
`OnGetText` only feeds `TField.Text` and `TField.DisplayText`, while
`TField.AsString` bypasses it entirely — and `AsString` is what every current
call site uses. That combination produces working, plausible-looking edit boxes
while sending ciphertext to LeadsOnline. Moving to one payload removes the
temptation along with the possibility.

Known read sites, all `.AsString`, to be routed through the accessors:

- `ExportPoliceInformation.pas:434-435` — FTP user and password
- `LeadsOnlineSettings.pas:95-96` — API user and password
- `LeadsOnlineSoapExport.pas:469-470` — configured-check
- `LeadsOnlineSoapExport.pas:1079-1080` — API user and password

### Other writers of these columns

Encryption is not complete unless every writer participates:

- **`PawnProSetup`** writes the LeadsOnline columns during store setup and must
  encrypt through the same unit. It also owns two key duties nothing else can
  perform: creating the master key and its two `APP_STATE` rows for a new store,
  and **re-wrapping on every SYSDBA password change** — see "Changing the
  database password must re-wrap" above. It should also record the store's
  password as a required step, since the recovery path depends on that record.
- **`Pump_ASA_FB`** (`PumpAsaFb50Main.pas`) copies the credentials from the old
  ASA database in plain text. Migrating stores need either an encrypting write
  in the pump or a one-time pass afterwards.

### Related cleanup, worth doing independently

The credentials are exposed as ReportBuilder pipeline fields — `TppField`
entries on `DBPStoreInfo` in `SearchClient.dfm`, and `LeadsOnlinePassword` in
`ReportsDM.dfm`. They are auto-generated field lists mirroring the store query
and are not placed on any band, so nothing prints them today; but they are
droppable fields if end-user report design is ever reachable. Remove the
credential columns from the report-side store query. This is independent of
encryption and can be done first.

### Rollout

1. `Step10_LeadsOnlineCredEncryption` in `uDBMigrations.pas` adds
   `LEADS_ONLINE_CREDENTIALS_ENC` and `LEADS_ONLINE_CREDENTIALS_VER`; bump
   `CURRENT_DB_VERSION` to `10`. Patch
   `Schema/PawnPro_DB_Firebird50_Schema.sql`, add
   `Schema/Migrations/PawnPro_FB5_LeadsOnlineCredEncryption.sql`, and regenerate
   `PawnPro_FB5_NewStoreFullDeploy.sql`, per the standard schema-change process.
   The four plaintext columns are **kept** at this stage — dropping them is a
   later step, once conversion is proven in the field.
2. Add `COMMON\Nvv.Crypto.FieldCipher.pas` (AEAD wrap/unwrap, argon2id
   derivation, sealed-box escrow) and the master-key lifecycle on `TDM`: create
   on first use, derive at startup, hold as `TBytes` for the session.
3. Add the `TDM` credential accessors and route the known read sites through
   them. Rebuild the settings form's four inputs as plain edits.
4. **Convert on write, not on read.** A store with an empty
   `LEADS_ONLINE_CREDENTIALS_ENC` falls back to the plaintext columns and keeps
   working from the moment the new EXE lands. Conversion happens when the
   settings form saves, plus one deliberate pass — never as a side effect of a
   read.

   Step 1's `password_enc` rewrites on read, but that is a per-machine INI file.
   `STORE` is a single row in a shared database read from every workstation: a
   read that writes would issue an `UPDATE` from any PC that merely opens the
   settings screen, potentially inside a transaction the calling code knows
   nothing about.
5. Once stores are confirmed converted, a later migration drops the four
   plaintext columns and the report-side exposure described above.

### Upgrade path

`LEADS_ONLINE_CREDENTIALS_VER` and the `LOC1:` marker are what keep this open.
Two extensions are already foreseeable and both are additive — a new version and
a second unwrap branch, not a migration that must unwind the first scheme:

- **Device pairing instead of password-derived enrolment.** A new workstation
  writes its public key into a pending-enrolment row; an already-provisioned PC
  approves and seals the master key to it. That costs one click somewhere in the
  store, but it buys an explicit admission decision, a visible list of enrolled
  machines, and a revocation story — and it does not inherit the database
  password's strength as a ceiling. Worth adopting if a customer ever appears for
  whom "any PC that can reach the database provisions itself" is too loose.
- **A provisioned per-store key from `PawnProSetup`**, if the ceiling above ever
  becomes the binding constraint.

Note what revocation does and does not mean here. Decommissioning a machine you
still control needs nothing, because nothing was stored on it. A **stolen**
machine is different: the thief holds a DPAPI blob bound to that hardware and can
recover the database password from it, so genuine revocation means rotating the
database password — which re-keys the wrap — and, if the database itself was
taken, rotating the master key and the LeadsOnline credentials as well.

## Future security rounds

Possible later improvements:

- Create a Firebird app user instead of connecting as `SYSDBA`.
- Add Firebird roles and least-privilege grants.
- Add an application audit log for sensitive actions.
- Add device pairing as an alternative to password-derived enrolment for the
  LeadsOnline credential key — see "Upgrade path" under "Third-party credential
  encryption (LeadsOnline)", which carries the design for that round.
- Add a setup/security health check that reports plain `password=` entries,
  missing `password_enc`, or default Firebird password usage.

These should be implemented only after the basic DPAPI and setup provisioning
flow has been tested in production.
