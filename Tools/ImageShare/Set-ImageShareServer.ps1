<#
.SYNOPSIS
  Sets up the image folder share on the DB-host machine, with a dedicated
  account the workstations use to reach it. Run ON THE SERVER, elevated.

.DESCRIPTION
  Workstations read images over SMB from a UNC path the DB host publishes in
  APP_STATE['IMAGE_SHARED_PATH']. Reaching it needs a username and password.

  A Windows Hello PIN is not one. A PIN is a local sign-in method that never
  leaves the machine, so a client signed in with a PIN has nothing to hand the
  server and the share prompts -- for a password the clerk has very likely never
  typed. Matching local accounts on every machine works in theory and rots the
  first time somebody changes a password.

  So: one account whose entire job is this share. It is not an administrator, it
  is not used to sign in anywhere, and its password lives in Credential Manager
  on each workstation rather than in anyone's head.

  Idempotent. An existing account keeps its password unless -ResetPassword is
  given; an existing share has its permissions corrected rather than recreated.

.EXAMPLE
  .\Set-ImageShareServer.ps1
  .\Set-ImageShareServer.ps1 -ShareName PawnImages -ImageDirectory D:\PawnImages
  .\Set-ImageShareServer.ps1 -ResetPassword
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [string] $ShareName = 'PawnImages',
  [string] $ImageDirectory,
  [string] $AccountName = 'PawnShare',
  [string] $Password,
  [string] $InstallDir,
  [switch] $ResetPassword
)

$ErrorActionPreference = 'Stop'

function Assert-Admin {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $pr = New-Object Security.Principal.WindowsPrincipal($id)
  if (-not $pr.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Run this from an ELEVATED PowerShell (right-click > Run as Administrator).'
  }
}

function New-StrongPassword {
  # Avoids characters that get mangled when a password is retyped from a screen
  # or pasted through a console: no quotes, backslashes, or lookalikes.
  $sets = @(
    'ABCDEFGHJKLMNPQRSTUVWXYZ',
    'abcdefghijkmnopqrstuvwxyz',
    '23456789',
    '!#%+=?@'
  )
  $chars = ($sets -join '').ToCharArray()
  $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
  $bytes = New-Object byte[] 20
  $rng.GetBytes($bytes)
  # Guarantee one from each set, then fill.
  $out = foreach ($s in $sets) { $s[(Get-Random -Maximum $s.Length)] }
  $out += for ($i = 0; $i -lt 16; $i++) { $chars[$bytes[$i] % $chars.Length] }
  -join ($out | Sort-Object { Get-Random })
}

Assert-Admin

Write-Host 'PawnPro image share -- server setup' -ForegroundColor Cyan
Write-Host ('-' * 64)

# ---- where are the images? --------------------------------------------
if (-not $ImageDirectory) {
  if (-not $InstallDir) {
    foreach ($d in @('C:\PawnPro', 'C:\Pawn', 'C:\PawnProFB')) {
      if (Test-Path (Join-Path $d 'PawnPro.ini')) { $InstallDir = $d; break }
    }
  }
  if ($InstallDir -and (Test-Path (Join-Path $InstallDir 'PawnPro.ini'))) {
    foreach ($line in Get-Content (Join-Path $InstallDir 'PawnPro.ini')) {
      if ($line -match '^\s*ImageDirectory\s*=\s*(.+)$') { $ImageDirectory = $Matches[1].Trim() }
    }
  }
}
if (-not $ImageDirectory) { throw 'Could not work out the image folder. Pass -ImageDirectory.' }
if (-not (Test-Path -LiteralPath $ImageDirectory)) {
  throw "The image folder does not exist: $ImageDirectory"
}
Write-Host "Image folder : $ImageDirectory"
Write-Host "Share name   : $ShareName"
Write-Host "Account      : $AccountName"
Write-Host ''

# ---- the account -------------------------------------------------------
$existing = Get-LocalUser -Name $AccountName -ErrorAction SilentlyContinue
$showPassword = $false

if ($existing -and -not $ResetPassword) {
  Write-Host "Account '$AccountName' already exists; leaving its password alone." -ForegroundColor Yellow
  Write-Host 'Use -ResetPassword if the workstations need a new one.'
} else {
  if (-not $Password) { $Password = New-StrongPassword; $showPassword = $true }
  $secure = ConvertTo-SecureString $Password -AsPlainText -Force

  if ($existing) {
    if ($PSCmdlet.ShouldProcess($AccountName, 'Reset password')) {
      Set-LocalUser -Name $AccountName -Password $secure
      Write-Host "Password reset on '$AccountName'." -ForegroundColor Green
    }
  } else {
    if ($PSCmdlet.ShouldProcess($AccountName, 'Create local account')) {
      New-LocalUser -Name $AccountName -Password $secure `
        -FullName 'PawnPro image share' `
        -Description 'Used only by PawnPro workstations to read the image folder. Not for signing in.' `
        -PasswordNeverExpires -UserMayNotChangePassword | Out-Null
      Add-LocalGroupMember -Group 'Users' -Member $AccountName -ErrorAction SilentlyContinue
      Write-Host "Created '$AccountName'." -ForegroundColor Green
    }
  }
}

# A blank-password local account cannot be used over the network at all --
# Windows blocks it by policy, and the failure looks like a permissions problem.
# Nothing here can create one, but say so if an existing account has one.
if ($existing -and -not $ResetPassword) {
  Write-Host 'If the workstations still cannot connect, the existing account may have' -ForegroundColor Yellow
  Write-Host 'a blank or expired password. Re-run with -ResetPassword.' -ForegroundColor Yellow
}

# ---- the share ---------------------------------------------------------
$share = Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue
if ($share) {
  Write-Host "Share '$ShareName' already exists at $($share.Path)."
  if ($share.Path -ne $ImageDirectory) {
    Write-Warning "It points at $($share.Path), not $ImageDirectory. Fix it by hand or remove the share first."
  }
} elseif ($PSCmdlet.ShouldProcess("$ShareName -> $ImageDirectory", 'Create SMB share')) {
  New-SmbShare -Name $ShareName -Path $ImageDirectory -FullAccess $AccountName | Out-Null
  Write-Host "Created share '$ShareName'." -ForegroundColor Green
}

# Share permission and NTFS permission are two separate gates and BOTH apply.
# A share that is open at one and closed at the other is the usual reason this
# looks correctly configured and still refuses the client.
if ($PSCmdlet.ShouldProcess($ShareName, 'Grant share access')) {
  Grant-SmbShareAccess -Name $ShareName -AccountName $AccountName `
    -AccessRight Change -Force -ErrorAction SilentlyContinue | Out-Null
}
if ($PSCmdlet.ShouldProcess($ImageDirectory, 'Grant NTFS Modify')) {
  & icacls "$ImageDirectory" /grant "${AccountName}:(OI)(CI)M" /T /C /Q 2>&1 | Out-Null
}

Write-Host ''
Write-Host 'Share permissions:' -ForegroundColor Cyan
Get-SmbShareAccess -Name $ShareName | Format-Table AccountName, AccessRight, AccessControlType -AutoSize | Out-String | Write-Host

$unc = "\\$env:COMPUTERNAME\$ShareName"
Write-Host "Publish this path in PawnPro's image settings: $unc" -ForegroundColor Green
Write-Host ''

if ($showPassword) {
  Write-Host ('=' * 64) -ForegroundColor Yellow
  Write-Host 'THE PASSWORD IS SHOWN ONCE. Record it before closing this window.' -ForegroundColor Yellow
  Write-Host ''
  Write-Host "  account  : $env:COMPUTERNAME\$AccountName"
  Write-Host "  password : $Password"
  Write-Host ''
  Write-Host 'On EACH workstation, run:' -ForegroundColor Cyan
  Write-Host "  .\Set-ImageShareClient.ps1 -Server $env:COMPUTERNAME -ShareName $ShareName -Password '$Password'"
  Write-Host ('=' * 64) -ForegroundColor Yellow
} else {
  Write-Host 'On EACH workstation, run:' -ForegroundColor Cyan
  Write-Host "  .\Set-ImageShareClient.ps1 -Server $env:COMPUTERNAME -ShareName $ShareName"
  Write-Host '(it will ask for the password)'
}
