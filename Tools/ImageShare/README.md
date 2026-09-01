# Image share — multi-workstation stores

Two scripts for the one step that has no good manual answer: letting the
workstations read the image folder on the DB host.

Single-workstation stores need none of this. Images sit on the local disk and
nothing crosses the network.

## The problem

PawnPro reads images over SMB from the UNC the DB host publishes in
`APP_STATE['IMAGE_SHARED_PATH']` — at Kendale, `\\KJINC2\PawnImages\`. Reaching
it needs a username and password.

**A Windows Hello PIN is not one.** A PIN is a local sign-in method that never
leaves the machine, so a workstation signed in with a PIN has nothing to hand the
server. The share prompts, and the clerk is asked for a password they have very
likely never typed.

Matching local accounts on every machine works in theory and rots the first time
someone changes a password. So: one account whose only job is this share, stored
once per workstation in Credential Manager.

## On the DB host, elevated

```
.\Set-ImageShareServer.ps1
```

Creates a non-administrator `PawnShare` account, generates a strong password and
shows it once, creates the share if missing, and grants both share and NTFS
permission. It reads the image folder from `PawnPro.ini` unless told otherwise.

Idempotent: an existing account keeps its password unless `-ResetPassword` is
given, and an existing share has its permissions corrected rather than recreated.

**Record the password before closing the window.** It is displayed once and
never stored anywhere by the script.

## On each workstation

```
.\Set-ImageShareClient.ps1 -Server KJINC2
```

Stores the credential, then proves it end to end: reachable on port 445,
connects, lists the `yyyymm` folders, and reads an actual `.jpg` — because
connecting, listing and reading fail separately and for different reasons.

Nothing needs setting in PawnPro itself; it takes the path from the database.

`-Test` checks an existing setup without changing it. `-Remove` clears the stored
credential.

## Credential Manager is per Windows profile

Where every clerk shares one generic login — as at Kendale — running it once per
machine is enough. Where each clerk has their own Windows account, it has to run
under each of them.

## When it still will not work

The client script separates the causes, which is most of the value:

| symptom | cause |
|---|---|
| cannot reach port 445 | name resolution, network, or the server's firewall — not a password |
| connects, cannot list | share permission allows it, NTFS permission denies it |
| lists, cannot read a file | NTFS permission too tight on the files themselves |
| refuses the credential | wrong password, no share permission, or a blank password — which Windows blocks over the network regardless of permissions |

Share permission and NTFS permission are two separate gates and both apply. A
share open at one and closed at the other is the usual reason this looks
correctly configured and still refuses.
