# PawnProFB Security Plan

Last updated: 2026-06-18

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
- a blank or seeded `PAWNDATA.FDB`

`PawnPro.ini` is created or updated by setup instead of copied with a plain
password.

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

## Existing advanced recovery idea

There is also an existing advanced design using `libsodium.dll` and
`COMMON\SealedBox.pas` to create a vendor recovery file named `recovery.dat`.

That design uses public/private key encryption:

- The setup app embeds a vendor public key.
- The setup app seals the store password into `recovery.dat`.
- The private key remains offline with the vendor.
- A separate recovery tool can decrypt `recovery.dat` if the customer loses the
  database password.

This is useful, but it is not required for the first basic security rounds.
Step 1 and Step 2 only require Windows DPAPI.

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
