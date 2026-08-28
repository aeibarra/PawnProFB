<#
.SYNOPSIS
  Removes image blobs left inside a converted Firebird database, after proving
  every one of them exists as a file on disk first.

.DESCRIPTION
  The Firebird version reads images from disk and never touches
  IMAGES_DATA.IMAGE_DATA, but pumps before 2026-08-28 copied the ASA blobs
  across. They are dead weight -- at Felitin's Gold, 294 MB of a 397 MB
  database -- and every backup since has carried them.

  THREE PHASES, and by default it only does the first.

    1. VERIFY   Every row holding a blob is checked against the file the app
                would read: <ImageDirectory>\yyyymm\<ImagesDataNo>.jpg, where
                yyyymm comes from CREATED. Changes nothing.

    2. CLEAR    -ClearBlobs sets IMAGE_DATA to NULL. Refuses if any file is
                missing, because for those rows the blob is the last copy.

    3. SHRINK   -Shrink does a gbak backup and restore into a NEW file. The
                UPDATE alone frees pages inside the database but does not
                return the space: Firebird reuses freed pages and never
                truncates the file. Only a restore rebuilds it compactly.

  Run VERIFY at the store, where the image folder actually exists. Running it
  against a database copy on another machine reports everything as missing,
  which is true of that machine and says nothing about the store.

.EXAMPLE
  .\Clear-ImageBlobs.ps1
  .\Clear-ImageBlobs.ps1 -ClearBlobs
  .\Clear-ImageBlobs.ps1 -ClearBlobs -Shrink
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [string] $InstallDir,
  [string] $Database,
  [string] $ImageDirectory,
  [switch] $ClearBlobs,
  [switch] $Shrink,
  [switch] $Force
)

$ErrorActionPreference = 'Stop'

function Find-FirebirdBin {
  foreach ($d in @('C:\Program Files\Firebird\Firebird_5_0',
                   'C:\Program Files\Firebird\Firebird_4_0')) {
    if (Test-Path (Join-Path $d 'isql.exe')) { return $d }
  }
  throw 'Firebird not found.'
}

function Read-Ini([string]$path) {
  $ini = @{}; $section = ''
  foreach ($line in Get-Content -LiteralPath $path) {
    $t = $line.Trim()
    if ($t -match '^\[(.+)\]$') { $section = $Matches[1]; continue }
    if ($t -match '^[;#]') { continue }
    if ($t -match '^([^=]+)=(.*)$') { $ini[($section + '.' + $Matches[1].Trim())] = $Matches[2].Trim() }
  }
  return $ini
}

$fb = Find-FirebirdBin
$isql = Join-Path $fb 'isql.exe'
$gbak = Join-Path $fb 'gbak.exe'

if (-not $InstallDir) {
  foreach ($d in @('C:\PawnPro', 'C:\Pawn', 'C:\PawnProFB')) {
    if (Test-Path (Join-Path $d 'PawnPro.ini')) { $InstallDir = $d; break }
  }
}
if (-not $InstallDir) { throw 'PawnPro.ini not found. Pass -InstallDir.' }
$cfg = Read-Ini (Join-Path $InstallDir 'PawnPro.ini')

$dbHost = if ($cfg['CONNECTION_FB.host']) { $cfg['CONNECTION_FB.host'] } else { '127.0.0.1' }
$dbPort = if ($cfg['CONNECTION_FB.port']) { $cfg['CONNECTION_FB.port'] } else { '3050' }
$dbUser = if ($cfg['CONNECTION_FB.user']) { $cfg['CONNECTION_FB.user'] } else { 'sysdba' }
if (-not $Database)       { $Database       = $cfg['CONNECTION_FB.database'] }
if (-not $ImageDirectory) { $ImageDirectory = $cfg['IMAGE_STORAGE.ImageDirectory'] }
if (-not $Database)       { throw 'No database in PawnPro.ini and none passed.' }
if (-not $ImageDirectory) { throw 'No [IMAGE_STORAGE] ImageDirectory in PawnPro.ini and none passed.' }

$dbPass = $null
if ($cfg['CONNECTION_FB.password_enc']) {
  try {
    Add-Type -AssemblyName System.Security
    $dbPass = [System.Text.Encoding]::UTF8.GetString(
      [System.Security.Cryptography.ProtectedData]::Unprotect(
        [Convert]::FromBase64String($cfg['CONNECTION_FB.password_enc']), $null,
        [System.Security.Cryptography.DataProtectionScope]::LocalMachine))
  } catch { }
}
if (-not $dbPass) {
  $sec = Read-Host "Firebird password for $dbUser" -AsSecureString
  $dbPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
              [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
}

$conn = $dbHost + '/' + $dbPort + ':' + $Database
Write-Host 'Image blob cleanup' -ForegroundColor Cyan
Write-Host ('-' * 62)
Write-Host "Database : $conn"
Write-Host "Images   : $ImageDirectory"
if (-not (Test-Path -LiteralPath $ImageDirectory)) {
  throw "The image folder does not exist here: $ImageDirectory`nRun this at the store, or pass -ImageDirectory."
}
Write-Host ''

# ---- 1. VERIFY ---------------------------------------------------------
Write-Host 'Checking every blob against the file the app would read...' -ForegroundColor Cyan
$tmp = [IO.Path]::GetTempFileName()
@'
SET HEADING OFF;
SELECT IMAGES_DATA_NO || '|' ||
       COALESCE(SUBSTRING(CAST(CREATED AS VARCHAR(30)) FROM 1 FOR 7), 'NULL') || '|' ||
       OCTET_LENGTH(IMAGE_DATA)
  FROM IMAGES_DATA
 WHERE IMAGE_DATA IS NOT NULL
 ORDER BY IMAGES_DATA_NO;
'@ | Out-File $tmp -Encoding ascii
$rows = & $isql -i $tmp -user $dbUser -password $dbPass -ch UTF8 $conn 2>&1
Remove-Item $tmp -Force -ErrorAction SilentlyContinue

$withBlob = @()
foreach ($r in $rows) {
  $t = "$r".Trim()
  if ($t -match '^(\d+)\|([^|]+)\|(\d+)$') {
    $withBlob += ,@($Matches[1], $Matches[2].Trim(), [int64]$Matches[3])
  }
}

if ($withBlob.Count -eq 0) {
  Write-Host 'No image blobs in this database. Nothing to do.' -ForegroundColor Green
  return
}

# Three outcomes, not two. "The file exists" is not the same as "the image was
# written": ExportAllImagesToFolder builds a blob stream unconditionally, so a
# row whose IMAGE_DATA is NULL still produces a 0-byte .jpg and still counts as
# exported. An empty file passes Test-Path and is not a copy of anything, so it
# is treated as missing.
#
# A size that merely DIFFERS is a warning rather than a block: the blob is the
# frozen ASA copy, and a photo replaced through the app since the conversion
# will legitimately differ from it. The file on disk is the one the app reads,
# so it wins.
$missing  = New-Object System.Collections.ArrayList
$empty    = New-Object System.Collections.ArrayList
$differs  = New-Object System.Collections.ArrayList

foreach ($row in $withBlob) {
  $id = $row[0]; $created = $row[1]; $blobLen = $row[2]
  # CREATED comes back as 'YYYY-MM'. A NULL date resolves the way the app
  # resolves it -- through TDateTime 0, which FormatDateTime renders as 189912.
  if ($created -eq 'NULL') { $ym = '189912' } else { $ym = $created -replace '-', '' }
  $path = Join-Path (Join-Path $ImageDirectory $ym) ($id + '.jpg')

  if (-not (Test-Path -LiteralPath $path)) {
    [void]$missing.Add($path)
  } else {
    $len = (Get-Item -LiteralPath $path).Length
    if ($len -eq 0)            { [void]$empty.Add($path) }
    elseif ($len -ne $blobLen) { [void]$differs.Add(('{0}  (disk {1:N0} bytes, blob {2:N0})' -f $path, $len, $blobLen)) }
  }
}

$bad    = $missing.Count + $empty.Count
$onDisk = $withBlob.Count - $bad

Write-Host ''
Write-Host ("  rows holding a blob   : {0}" -f $withBlob.Count)
Write-Host ("  good file on disk     : {0}" -f $onDisk) -ForegroundColor Green
if ($differs.Count -gt 0) {
  Write-Host ("  size differs          : {0}  (not a problem -- see below)" -f $differs.Count) -ForegroundColor Yellow
}
if ($missing.Count -gt 0) {
  Write-Host ("  NO file on disk       : {0}" -f $missing.Count) -ForegroundColor Red
}
if ($empty.Count -gt 0) {
  Write-Host ("  file is 0 bytes       : {0}" -f $empty.Count) -ForegroundColor Red
}

if ($differs.Count -gt 0) {
  Write-Host ''
  Write-Host 'These differ in size from the blob. Expected where a photo was replaced' -ForegroundColor Yellow
  Write-Host 'after the conversion -- the file on disk is what the app reads, so it wins:' -ForegroundColor Yellow
  $differs | Select-Object -First 10 | ForEach-Object { Write-Host "    $_" }
  if ($differs.Count -gt 10) { Write-Host ("    ... and {0} more" -f ($differs.Count - 10)) }
}

if ($bad -gt 0) {
  Write-Host ''
  Write-Host 'For these rows the blob is the only copy that exists:' -ForegroundColor Red
  @($missing + $empty) | Select-Object -First 15 | ForEach-Object { Write-Host "    $_" }
  if ($bad -gt 15) { Write-Host ("    ... and {0} more" -f ($bad - 15)) }
}
Write-Host ''

if (-not $ClearBlobs) {
  Write-Host 'VERIFY only. Nothing changed.' -ForegroundColor Yellow
  if ($bad -eq 0) {
    Write-Host 'Every blob has a real file on disk. Safe to re-run with -ClearBlobs.' -ForegroundColor Green
  } else {
    Write-Host 'Extract the images again before clearing anything.' -ForegroundColor Red
  }
  return
}

# ---- 2. CLEAR ----------------------------------------------------------
if ($bad -gt 0 -and -not $Force) {
  throw ("{0} image(s) have no usable file on disk. Clearing now would destroy them. " +
         "Extract the images again first. -Force overrides, and is not the way past this." -f $bad)
}

Write-Host 'Close PawnPro on every machine before continuing.' -ForegroundColor Yellow
if (-not $PSCmdlet.ShouldProcess($conn, "Set IMAGE_DATA to NULL on $($withBlob.Count) rows")) { return }
$ans = Read-Host ("Clear {0} blob(s)? A backup first is strongly advised. Type YES" -f $withBlob.Count)
if ($ans -cne 'YES') { Write-Host 'Cancelled.'; return }

$tmp = [IO.Path]::GetTempFileName()
"UPDATE IMAGES_DATA SET IMAGE_DATA = NULL WHERE IMAGE_DATA IS NOT NULL;`r`nCOMMIT;" |
  Out-File $tmp -Encoding ascii
& $isql -i $tmp -user $dbUser -password $dbPass -ch UTF8 $conn 2>&1 | ForEach-Object { Write-Verbose "$_" }
Remove-Item $tmp -Force -ErrorAction SilentlyContinue
Write-Host 'Blobs cleared.' -ForegroundColor Green

if (-not $Shrink) {
  Write-Host ''
  Write-Host 'The file on disk has NOT got smaller yet.' -ForegroundColor Yellow
  Write-Host 'Firebird reuses freed pages but never truncates. Re-run with -Shrink,'
  Write-Host 'or do a gbak backup and restore by hand.'
  return
}

# ---- 3. SHRINK ---------------------------------------------------------
if ($Database -notmatch '[\\/]') {
  Write-Warning "database is the alias '$Database'; the file path is known only to the server. Do the backup and restore by hand."
  return
}
$stamp   = Get-Date -Format 'yyyyMMdd_HHmmss'
$fbk     = "$Database.$stamp.fbk"
$rebuilt = "$Database.$stamp.rebuilt.fdb"
$before  = (Get-Item -LiteralPath $Database).Length

Write-Host ''
Write-Host 'Backing up...' -ForegroundColor Cyan
& $gbak -b -user $dbUser -password $dbPass $conn $fbk 2>&1 | ForEach-Object { Write-Verbose "$_" }
if (-not (Test-Path $fbk)) { throw 'gbak backup failed; nothing further done.' }

Write-Host 'Restoring into a new file...' -ForegroundColor Cyan
& $gbak -c -user $dbUser -password $dbPass $fbk ($dbHost + '/' + $dbPort + ':' + $rebuilt) 2>&1 |
  ForEach-Object { Write-Verbose "$_" }
if (-not (Test-Path $rebuilt)) { throw 'Restore failed. The original is untouched.' }

$after = (Get-Item -LiteralPath $rebuilt).Length
Write-Host ''
Write-Host ('  before : {0,8:N1} MB' -f ($before / 1MB))
Write-Host ('  after  : {0,8:N1} MB' -f ($after  / 1MB)) -ForegroundColor Green
Write-Host ''
Write-Host 'The rebuilt database is NOT in place yet. Deliberately.' -ForegroundColor Yellow
Write-Host 'With PawnPro closed and the Firebird service stopped:'
Write-Host "  1. rename $Database  to  $Database.old"
Write-Host "  2. rename $rebuilt  to  $Database"
Write-Host '  3. start Firebird, open PawnPro, check a few images'
Write-Host "  4. only then delete the .old file and $fbk"
