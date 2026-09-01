<#
.SYNOPSIS
  Stores the image share credential on a workstation and proves it works.
  Run ON EACH CLIENT, as the account the clerks actually use.

.DESCRIPTION
  PawnPro reads images over SMB from the UNC the DB host publishes in
  APP_STATE['IMAGE_SHARED_PATH']. Reaching it needs a username and password.

  A Windows Hello PIN is not one -- it is a local sign-in method that never
  leaves the machine. So a client signed in with a PIN has nothing to offer the
  server, and the share prompts for a password the clerk has probably never
  typed. Storing the share account in Credential Manager settles it: Windows
  supplies it automatically from then on, whoever is signed in and however.

  CREDENTIAL MANAGER IS PER WINDOWS PROFILE. Where every clerk shares one
  generic login, running this once per machine is enough. Where each clerk has
  their own Windows account, it has to run under each of them.

  Nothing here is specific to one store: it reads nothing and changes nothing
  except the stored credential.

.EXAMPLE
  .\Set-ImageShareClient.ps1 -Server KJINC2
  .\Set-ImageShareClient.ps1 -Server KJINC2 -ShareName PawnImages -Password 'xxx'
  .\Set-ImageShareClient.ps1 -Server KJINC2 -Test
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string] $Server,
  [string] $ShareName   = 'PawnImages',
  [string] $AccountName = 'PawnShare',
  [string] $Password,
  [switch] $Remove,
  [switch] $Test
)

$ErrorActionPreference = 'Stop'

$Server = $Server.TrimStart('\')
$unc    = "\\$Server\$ShareName"

Write-Host 'PawnPro image share -- workstation setup' -ForegroundColor Cyan
Write-Host ('-' * 64)
Write-Host "Server  : $Server"
Write-Host "Share   : $unc"
Write-Host "Account : $Server\$AccountName"
Write-Host "Profile : $env:USERNAME  (the credential is stored for THIS profile)"
Write-Host ''

if ($Remove) {
  & cmdkey /delete:$Server 2>&1 | Out-Null
  Write-Host "Removed the stored credential for $Server." -ForegroundColor Green
  return
}

# ---- can we see the machine at all? ------------------------------------
# Worth separating from an authentication failure: "cannot reach the server" and
# "the server refused these credentials" look identical from inside PawnPro, and
# lead to completely different places.
Write-Host 'Checking the server is reachable...' -ForegroundColor Cyan
$smb = Test-NetConnection -ComputerName $Server -Port 445 -WarningAction SilentlyContinue
if (-not $smb.TcpTestSucceeded) {
  Write-Warning "Cannot reach $Server on port 445 (file sharing)."
  Write-Warning 'That is a name-resolution, network or firewall problem, not a password one.'
  Write-Warning "Try: ping $Server    and check the server's firewall allows File and Printer Sharing."
  return
}
Write-Host "  reachable on 445 (resolved to $($smb.RemoteAddress))" -ForegroundColor Green

if (-not $Test) {
  if (-not $Password) {
    $sec = Read-Host "Password for $Server\$AccountName" -AsSecureString
    $Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                  [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
  }

  # Drop any existing entry first: cmdkey will otherwise keep the old one and
  # the failure then looks like a wrong password on the server.
  & cmdkey /delete:$Server 2>&1 | Out-Null
  & cmdkey /add:$Server /user:"$Server\$AccountName" /pass:$Password 2>&1 | Out-Null
  Write-Host 'Credential stored in Credential Manager.' -ForegroundColor Green
}

# ---- prove it ----------------------------------------------------------
Write-Host ''
Write-Host 'Testing the share...' -ForegroundColor Cyan

# Any existing session to this server would be reused and would mask a bad
# credential, so clear it before testing.
& net use $unc /delete 2>&1 | Out-Null

$ok = $false
try {
  $null = & net use $unc 2>&1
  if ($LASTEXITCODE -eq 0) { $ok = $true }
} catch { }

if (-not $ok) {
  Write-Warning "Could not connect to $unc."
  Write-Warning 'The machine is reachable, so this is authentication or permissions:'
  Write-Warning '  - wrong password (re-run the server script with -ResetPassword)'
  Write-Warning "  - the account has no share permission on '$ShareName'"
  Write-Warning '  - the account has a blank password, which Windows blocks over the network'
  return
}

Write-Host "  connected to $unc" -ForegroundColor Green

try {
  $folders = @(Get-ChildItem -LiteralPath $unc -Directory -ErrorAction Stop)
  Write-Host ("  listed {0} folder(s) -- the yyyymm folders PawnPro reads" -f $folders.Count) -ForegroundColor Green
  if ($folders.Count -gt 0) {
    $sample = $folders | Select-Object -First 3 | ForEach-Object { $_.Name }
    Write-Host ("  e.g. {0}" -f ($sample -join ', '))
  }
} catch {
  Write-Warning 'Connected to the share but could not list it.'
  Write-Warning 'Share permission allows the connection; NTFS permission denies the read.'
  Write-Warning "Grant the account Modify on the folder itself on $Server."
  return
}

# A read is what PawnPro actually does, so test a read rather than stopping at
# the listing -- the two fail separately.
$anyFile = Get-ChildItem -LiteralPath $unc -Recurse -File -Filter *.jpg -ErrorAction SilentlyContinue |
           Select-Object -First 1
if ($anyFile) {
  try {
    $null = [System.IO.File]::ReadAllBytes($anyFile.FullName)
    Write-Host ("  read a file successfully ({0})" -f $anyFile.Name) -ForegroundColor Green
  } catch {
    Write-Warning "Listed the folder but could not read $($anyFile.Name). NTFS permissions are too tight."
    return
  }
} else {
  Write-Host '  no .jpg found to read -- fine if the store has no images yet.' -ForegroundColor Yellow
}

Write-Host ''
Write-Host 'Done. This workstation can read the image share.' -ForegroundColor Green
Write-Host 'PawnPro takes the path from the database, so there is nothing to set in the app.'
