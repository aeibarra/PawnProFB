<#
.SYNOPSIS
  Puts wrongly-excluded transactions back into the LeadsOnline export list.

.DESCRIPTION
  "Never send these to LeadsOnline" is deliberately permanent in the UI, but the
  data is one DELETE from undo -- a mis-click on several hundred ticked rows must
  not be a one-way door. This is that undo.

  It exists because of Kendale Jewelry. All 514 exclusions there landed within
  half a second of each other, so it was one sweep, and four transactions from
  the last year sat inside the selected range. None of them had ever appeared in
  a CSV export either, so they had reached law enforcement through no channel at
  all.

  BY DEFAULT IT ONLY LISTS. Nothing changes without -Restore.

  Removing a row from LEADS_SOAP_EXCLUDED does not send anything. It puts the
  transaction back in the export screen's list, where it can be ticked and
  submitted like any other.

.EXAMPLE
  .\Restore-ExcludedTransactions.ps1
  .\Restore-ExcludedTransactions.ps1 -Restore
  .\Restore-ExcludedTransactions.ps1 -TransactionNo 31871,32132 -Restore
  .\Restore-ExcludedTransactions.ps1 -Months 24
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [string] $InstallDir,
  [string] $Database,
  [int]    $Months = 12,
  [int[]]  $TransactionNo,
  [switch] $Restore
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

$fb   = Find-FirebirdBin
$isql = Join-Path $fb 'isql.exe'

if (-not $InstallDir) {
  foreach ($d in @('C:\PawnPro', 'C:\Pawn', 'C:\PawnProFB')) {
    if (Test-Path (Join-Path $d 'PawnPro.ini')) { $InstallDir = $d; break }
  }
}
if (-not $InstallDir -and -not $Database) { throw 'PawnPro.ini not found. Pass -InstallDir or -Database.' }

$dbHost = '127.0.0.1'; $dbPort = '3050'; $dbUser = 'sysdba'; $dbPass = $null
if ($InstallDir -and (Test-Path (Join-Path $InstallDir 'PawnPro.ini'))) {
  $cfg = Read-Ini (Join-Path $InstallDir 'PawnPro.ini')
  if ($cfg['CONNECTION_FB.host']) { $dbHost = $cfg['CONNECTION_FB.host'] }
  if ($cfg['CONNECTION_FB.port']) { $dbPort = $cfg['CONNECTION_FB.port'] }
  if ($cfg['CONNECTION_FB.user']) { $dbUser = $cfg['CONNECTION_FB.user'] }
  if (-not $Database)             { $Database = $cfg['CONNECTION_FB.database'] }
  if ($cfg['CONNECTION_FB.password_enc']) {
    try {
      Add-Type -AssemblyName System.Security
      $dbPass = [System.Text.Encoding]::UTF8.GetString(
        [System.Security.Cryptography.ProtectedData]::Unprotect(
          [Convert]::FromBase64String($cfg['CONNECTION_FB.password_enc']), $null,
          [System.Security.Cryptography.DataProtectionScope]::LocalMachine))
    } catch { }
  }
}
if (-not $Database) { throw 'No database given and none in PawnPro.ini.' }
if (-not $dbPass) {
  $sec = Read-Host "Firebird password for $dbUser" -AsSecureString
  $dbPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
              [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
}

$conn = $dbHost + '/' + $dbPort + ':' + $Database

function Invoke-Sql([string]$sql) {
  $tmp = [IO.Path]::GetTempFileName()
  $sql | Out-File $tmp -Encoding ascii
  $out = & $isql -i $tmp -user $dbUser -password $dbPass -ch UTF8 $conn 2>&1
  Remove-Item $tmp -Force -ErrorAction SilentlyContinue
  return $out
}

Write-Host 'LeadsOnline -- restore excluded transactions' -ForegroundColor Cyan
Write-Host ('-' * 66)
Write-Host "Database : $conn"

# Which rows are we talking about? Either the ones named, or every exclusion
# inside the recent window -- the same test the export screen warns on.
if ($TransactionNo) {
  $list  = ($TransactionNo -join ',')
  $where = "X.TRANSACTION_NO IN ($list)"
  Write-Host "Scope    : transactions $list"
} else {
  $where = "T.TRAN_DATE >= DATEADD(-$Months MONTH TO CURRENT_DATE)"
  Write-Host "Scope    : exclusions from the last $Months months"
}
Write-Host ''

$rows = Invoke-Sql @"
SET HEADING OFF;
SELECT T.TRANSACTION_NO || '|' || T.TRAN_DATE || '|' || TRIM(T.TRAN_TYPE) || '|' ||
       COALESCE(TRIM(T.TRAN_TICKET_NO), '?') || '|' ||
       IIF(EXISTS(SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                   WHERE D.TRANSACTION_NO = T.TRANSACTION_NO), 'yes', 'NO') || '|' ||
       IIF(EXISTS(SELECT 1 FROM LEADS_SOAP_SUBMISSION S
                   WHERE S.TRANSACTION_NO = T.TRANSACTION_NO
                     AND S.ERROR_CODE IN (0, 6, 13)), 'yes', 'no')
  FROM LEADS_SOAP_EXCLUDED X
  JOIN TRANSACTIONS T ON T.TRANSACTION_NO = X.TRANSACTION_NO
 WHERE $where
 ORDER BY T.TRAN_DATE;
"@

$found = @()
foreach ($r in $rows) {
  $t = "$r".Trim()
  if ($t -notmatch '^\d+\|') { continue }
  # Split and trim rather than matching a strict pattern: IIF(..,'yes','NO')
  # returns CHAR(3), so 'NO' arrives padded as "NO " and any \S+ pattern fails
  # on the space -- silently, reporting nothing to restore.
  $p = $t -split '\|' | ForEach-Object { $_.Trim() }
  if ($p.Count -lt 6) { continue }
  $found += [pscustomobject]@{
    TransactionNo = $p[0]
    Date          = $p[1]
    Type          = $p[2]
    Ticket        = $p[3]
    EverInACsv    = $p[4]
    AlreadySent   = $p[5]
  }
}

if ($found.Count -eq 0) {
  Write-Host 'Nothing matches. No excluded transactions in that scope.' -ForegroundColor Green
  return
}

$found | Format-Table -AutoSize | Out-String | Write-Host

# EverInACsv 'NO' is the serious column: those have reached law enforcement
# through no channel at all, whereas one already reported by the file export is
# only missing from the SOAP record.
$neverReported = @($found | Where-Object { $_.EverInACsv -eq 'NO' -and $_.AlreadySent -eq 'no' })
if ($neverReported.Count -gt 0) {
  Write-Host ("{0} of these have never been reported by ANY channel." -f $neverReported.Count) -ForegroundColor Red
  Write-Host 'Those are the ones worth sending.' -ForegroundColor Red
  Write-Host ''
}

if (-not $Restore) {
  Write-Host 'LIST ONLY. Nothing changed.' -ForegroundColor Yellow
  Write-Host 'Re-run with -Restore to put these back in the export list.'
  return
}

if (-not $PSCmdlet.ShouldProcess($conn, "Remove $($found.Count) exclusion(s)")) { return }
$ans = Read-Host ("Put {0} transaction(s) back in the export list? Type YES" -f $found.Count)
if ($ans -cne 'YES') { Write-Host 'Cancelled.'; return }

$ids = ($found.TransactionNo -join ',')
Invoke-Sql "DELETE FROM LEADS_SOAP_EXCLUDED WHERE TRANSACTION_NO IN ($ids);`r`nCOMMIT;" |
  ForEach-Object { Write-Verbose "$_" }

Write-Host ''
Write-Host ("Removed {0} exclusion(s)." -f $found.Count) -ForegroundColor Green

# Confirm against the query the export screen actually uses, rather than
# assuming the DELETE did what it looked like.
$check = Invoke-Sql @"
SET LIST ON;
SELECT COUNT(*) AS SCREEN_SHOWS
  FROM TRANSACTIONS T1
  LEFT JOIN LEADS_SOAP_SUBMISSION S ON S.TRANSACTION_NO = T1.TRANSACTION_NO
 WHERE T1.TRAN_TYPE IN ('P','U')
   AND COALESCE(T1.TRAN_CLOSE_REASON, 0) <> 1
   AND NOT EXISTS (SELECT 1 FROM LEADS_SOAP_EXCLUDED X
                    WHERE X.TRANSACTION_NO = T1.TRANSACTION_NO)
   AND ((SELECT COALESCE(MAX(IIF(LEADS_ONLINE_SKIP_CSV_SENT, 1, 0)), 0) FROM STORE) = 0
        OR NOT EXISTS (SELECT 1 FROM EXPORT_LOG_FILE_DETAIL D
                        WHERE D.TRANSACTION_NO = T1.TRANSACTION_NO))
   AND (S.ID IS NULL OR S.ERROR_CODE IS NULL
        OR S.ERROR_CODE NOT IN (0, 6, 7, 13));
"@
$check | Where-Object { "$_".Trim() -ne '' } | ForEach-Object { Write-Host "  $_" }

Write-Host ''
Write-Host 'Now in PawnPro: LeadsOnline export, Refresh, tick them, Submit.' -ForegroundColor Cyan
Write-Host 'Anything too old for LeadsOnline comes back as "Too old" and settles itself.'
