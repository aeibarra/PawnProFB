<#
.SYNOPSIS
  Runs the pre-cutover survey against a store's live database and collects the
  results into a folder beside this script. Meant to be run from the USB stick,
  at the store, with no arguments.

.DESCRIPTION
  Read-only against the database. Everything it writes goes into a new folder
  next to this script.

  It works out the connection for itself from the PawnPro.ini sitting beside
  PawnProFB.exe -- including the password. password_enc is protected with
  machine-scope DPAPI, so it decrypts on the store's own machine and nowhere
  else, which is why no password is typed here and none travels on the stick. If
  it cannot be read, the script asks rather than failing.

  Produces:
    <Store>_BASELINE_<date>.txt   the survey output
    <Store>_<date>.fbk            a gbak backup -- consistent by design
    <Store>_<date>.FDB            only with -IncludeRawCopy

  A raw copy of a database Firebird has open can catch a half-written page. It
  has worked every time so far, but "usually consistent" is not a property to
  rely on for the one copy carried away from a store, so gbak is the default.

.EXAMPLE
  .\Run-StoreSurvey.ps1
  .\Run-StoreSurvey.ps1 -ExpectedStoreId 63256
  .\Run-StoreSurvey.ps1 -IncludeRawCopy
#>
[CmdletBinding()]
param(
  [string] $InstallDir,
  [string] $OutputRoot,
  [int]    $ExpectedStoreId,
  [switch] $IncludeRawCopy
)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

function Find-FirebirdBin {
  foreach ($d in @(
      'C:\Program Files\Firebird\Firebird_5_0',
      'C:\Program Files\Firebird\Firebird_4_0',
      'C:\Program Files (x86)\Firebird\Firebird_5_0')) {
    if (Test-Path (Join-Path $d 'isql.exe')) { return $d }
  }
  throw "Firebird not found. Install it first."
}

function Find-PawnProIni {
  if ($InstallDir) {
    $p = Join-Path $InstallDir 'PawnPro.ini'
    if (Test-Path $p) { return $p }
    throw "No PawnPro.ini in $InstallDir"
  }
  foreach ($d in @('C:\PawnPro', 'C:\Pawn', 'C:\PawnProFB', 'C:\Program Files\PawnPro')) {
    $p = Join-Path $d 'PawnPro.ini'
    if (Test-Path $p) { return $p }
  }
  $exe = Get-ChildItem C:\ -Filter PawnProFB.exe -Recurse -Depth 3 -ErrorAction SilentlyContinue |
         Select-Object -First 1
  if ($exe) {
    $p = Join-Path $exe.DirectoryName 'PawnPro.ini'
    if (Test-Path $p) { return $p }
  }
  throw "PawnPro.ini not found. Re-run with -InstallDir <folder holding PawnProFB.exe>."
}

function Read-Ini([string]$path) {
  $ini = @{}
  $section = ''
  foreach ($line in Get-Content -LiteralPath $path) {
    $t = $line.Trim()
    if ($t -match '^\[(.+)\]$') { $section = $Matches[1]; continue }
    if ($t -match '^[;#]') { continue }
    if ($t -match '^([^=]+)=(.*)$') { $ini[($section + '.' + $Matches[1].Trim())] = $Matches[2].Trim() }
  }
  return $ini
}

function Get-IsqlValue($lines, [string]$label) {
  $row = $lines | Select-String -SimpleMatch $label | Select-Object -First 1
  if (-not $row) { return '' }
  return (($row.ToString() -replace ('^\s*' + $label + '\s+'), '')).Trim()
}

Write-Host 'PawnPro pre-cutover survey' -ForegroundColor Cyan
Write-Host ('-' * 62)

$fb  = Find-FirebirdBin
$ini = Find-PawnProIni
Write-Host "Firebird    : $fb"
Write-Host "PawnPro.ini : $ini"

$cfg      = Read-Ini $ini
$dbHost   = if ($cfg['CONNECTION_FB.host']) { $cfg['CONNECTION_FB.host'] } else { '127.0.0.1' }
$dbPort   = if ($cfg['CONNECTION_FB.port']) { $cfg['CONNECTION_FB.port'] } else { '3050' }
$database = $cfg['CONNECTION_FB.database']
$dbUser   = if ($cfg['CONNECTION_FB.user']) { $cfg['CONNECTION_FB.user'] } else { 'sysdba' }
if (-not $database) { throw 'PawnPro.ini has no [CONNECTION_FB] database entry.' }

# password_enc is DPAPI machine-scope: it opens on this machine and no other.
$dbPass = $null
if ($cfg['CONNECTION_FB.password_enc']) {
  try {
    Add-Type -AssemblyName System.Security
    $dbPass = [System.Text.Encoding]::UTF8.GetString(
      [System.Security.Cryptography.ProtectedData]::Unprotect(
        [Convert]::FromBase64String($cfg['CONNECTION_FB.password_enc']), $null,
        [System.Security.Cryptography.DataProtectionScope]::LocalMachine))
  } catch {
    Write-Warning 'password_enc did not decrypt on this machine.'
  }
}
if (-not $dbPass -and $cfg['CONNECTION_FB.password']) { $dbPass = $cfg['CONNECTION_FB.password'] }
if (-not $dbPass) {
  $sec = Read-Host "Firebird password for $dbUser" -AsSecureString
  $dbPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
              [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
}

$conn = $dbHost + '/' + $dbPort + ':' + $database
Write-Host "Database    : $conn"
Write-Host ''

$isql = Join-Path $fb 'isql.exe'
$gbak = Join-Path $fb 'gbak.exe'

# The store name comes first: it names every output file, and reading it proves
# the connection works before anything slower is attempted.
$tmp = [IO.Path]::GetTempFileName()
"SET LIST ON;`r`nSELECT STORE_NAME, LEADS_STORE_ID FROM STORE;" | Out-File $tmp -Encoding ascii
$probe = & $isql -i $tmp -user $dbUser -password $dbPass -ch UTF8 $conn 2>&1
Remove-Item $tmp -Force -ErrorAction SilentlyContinue
if ($LASTEXITCODE -ne 0) {
  $probe | ForEach-Object { Write-Host $_ }
  throw 'Could not read the STORE table. Is Firebird running, and is the password right?'
}

$storeName = Get-IsqlValue $probe 'STORE_NAME'
$storeId   = Get-IsqlValue $probe 'LEADS_STORE_ID'
$safeName  = ($storeName -replace '[^A-Za-z0-9]', '')
if (-not $safeName) { $safeName = 'Store' }
$stamp = Get-Date -Format 'yyyy-MM-dd'

Write-Host "Store       : $storeName" -ForegroundColor Green
Write-Host "Store ID    : $storeId"

if ($PSBoundParameters.ContainsKey('ExpectedStoreId')) {
  if ("$storeId" -eq "$ExpectedStoreId") {
    Write-Host "              matches the id LeadsOnline issued ($ExpectedStoreId)" -ForegroundColor Green
  } else {
    Write-Host ''
    Write-Warning "STORE ID MISMATCH: the database says '$storeId', LeadsOnline issued '$ExpectedStoreId'."
    Write-Warning 'Do not send anything until this is settled. Tickets would be filed'
    Write-Warning "against another store's record with law enforcement."
    Write-Host ''
  }
}

if (-not $OutputRoot) { $OutputRoot = $here }
$outDir = Join-Path $OutputRoot ($safeName + '_' + $stamp)
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
Write-Host "Output      : $outDir"
Write-Host ''

# ---- survey ------------------------------------------------------------
$survey = Join-Path $here 'PreCutover_Survey.sql'
if (-not (Test-Path $survey)) { throw 'PreCutover_Survey.sql is not beside this script.' }

Write-Host 'Running the survey...' -ForegroundColor Cyan
$baseline = Join-Path $outDir ($safeName + '_BASELINE_' + $stamp + '.txt')
$out = & $isql -i $survey -user $dbUser -password $dbPass -ch UTF8 $conn 2>&1
$header = @(
  ($storeName + ' -- PRE-CUTOVER BASELINE, captured ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')),
  ('Database: ' + $conn),
  'Captured BEFORE the SOAP export was enabled. Compare later with Week1_Review.sql.',
  ('=' * 70)
)
($header + ($out | Where-Object { "$_".Trim() -ne '' })) | Out-File $baseline -Encoding utf8
Write-Host ('  -> ' + (Split-Path $baseline -Leaf))

# ---- backup ------------------------------------------------------------
Write-Host 'Backing up the database (gbak)...' -ForegroundColor Cyan
$fbk = Join-Path $outDir ($safeName + '_' + $stamp + '.fbk')
& $gbak -b -user $dbUser -password $dbPass $conn $fbk 2>&1 | ForEach-Object { Write-Verbose "$_" }
if ((Test-Path $fbk) -and ((Get-Item $fbk).Length -gt 0)) {
  Write-Host ('  -> {0}  ({1:N1} MB)' -f (Split-Path $fbk -Leaf), ((Get-Item $fbk).Length / 1MB))
} else {
  Write-Warning 'gbak did not produce a backup. Re-run with -Verbose to see why.'
}

# ---- optional raw copy -------------------------------------------------
if ($IncludeRawCopy) {
  if ($database -notmatch '[\\/]') {
    Write-Warning "database is the alias '$database', so the file path is only known to the server. Skipping the raw copy; the .fbk has everything."
  } elseif (Test-Path -LiteralPath $database) {
    Write-Host 'Copying the database file...' -ForegroundColor Cyan
    $raw = Join-Path $outDir ($safeName + '_' + $stamp + '.FDB')
    Copy-Item -LiteralPath $database -Destination $raw -Force
    Write-Host ('  -> {0}  ({1:N1} MB)' -f (Split-Path $raw -Leaf), ((Get-Item $raw).Length / 1MB))
  } else {
    Write-Warning "Database file not found at $database. Skipping the raw copy."
  }
}

Write-Host ''
Write-Host 'Done.' -ForegroundColor Green
Get-ChildItem $outDir | ForEach-Object { Write-Host ('  {0,-44} {1,8:N1} MB' -f $_.Name, ($_.Length / 1MB)) }
Write-Host ''
Write-Host 'Take this folder with you. To restore the .fbk later:' -ForegroundColor Cyan
Write-Host ('  gbak -c -user sysdba -password <pw> "' + (Split-Path $fbk -Leaf) + '" 127.0.0.1/3050:C:\path\to\RESTORED.FDB')
