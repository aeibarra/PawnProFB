# PawnProFB Security Plan

Last updated: 2026-07-01

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

## Future security rounds

Possible later improvements:

- Create a Firebird app user instead of connecting as `SYSDBA`.
- Add Firebird roles and least-privilege grants.
- Add an application audit log for sensitive actions.
- Encrypt or otherwise protect third-party credentials such as
  `STORE.LEADS_ONLINE_PASSWORD`.
- Add a setup/security health check that reports plain `password=` entries,
  missing `password_enc`, or default Firebird password usage.

These should be implemented only after the basic DPAPI and setup provisioning
flow has been tested in production.
