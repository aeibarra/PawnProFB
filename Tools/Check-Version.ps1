<#
.SYNOPSIS
  Checks the Win64 Release version in PawnProFB.dproj agrees with itself, and
  with the built EXE. Run before deploying.

.DESCRIPTION
  The IDE writes the version in two unrelated places and does not keep them in
  step: VerInfo_MajorVer/MinorVer/Release/Build are separate elements, while
  FileVersion and ProductVersion are both buried in one VerInfo_Keys string.
  Editing version info in the IDE has repeatedly updated FileVersion and left
  ProductVersion behind -- four times between 3.37.4.2 and 3.37.6.1.

  Nothing fails when they disagree. The build succeeds, the EXE runs, and the
  About box shows one number while Windows' file properties show another. It is
  only noticed when somebody asks which build a store is on.

  Also reports whether the EXE is UPX-packed. A deployed binary is packed
  (AppCompress.bat); an unpacked one means the packaging step was missed.

.EXAMPLE
  .\Tools\Check-Version.ps1
#>
[CmdletBinding()]
param(
    [string] $Dproj = (Join-Path $PSScriptRoot '..\PawnProFB.dproj'),
    [string] $Exe   = (Join-Path $PSScriptRoot '..\PawnProFB.exe')
)

$ErrorActionPreference = 'Stop'
$ok = $true

function Fail([string]$m) { Write-Host "  FAIL  $m" -ForegroundColor Red;    $script:ok = $false }
function Pass([string]$m) { Write-Host "  ok    $m" -ForegroundColor Green }
function Note([string]$m) { Write-Host "        $m" -ForegroundColor DarkGray }

Write-Host 'PawnProFB version check' -ForegroundColor Cyan
Write-Host ('-' * 60)

[xml]$x = Get-Content -LiteralPath $Dproj

# The Win64 Release block is the one that ships. Identified by the condition
# AND by actually carrying VerInfo_Keys -- there are two groups with that
# condition and only the second holds the version, which is the kind of detail
# that makes a checker quietly pass on nothing.
$grp = $x.Project.PropertyGroup |
       Where-Object { ($_.Condition -like "*Cfg_1_Win64*") -and $_.VerInfo_Keys } |
       Select-Object -First 1
if (-not $grp) { Fail 'Could not find the Win64 Release version block.'; exit 1 }

$major = "$($grp.VerInfo_MajorVer)"
$minor = "$($grp.VerInfo_MinorVer)"
$rel   = "$($grp.VerInfo_Release)"
$bld   = "$($grp.VerInfo_Build)"
$parts = "$major.$minor.$rel.$bld"

$keys = "$($grp.VerInfo_Keys)"
$fileVer = ([regex]::Match($keys, 'FileVersion=([0-9.]+)')).Groups[1].Value
$prodVer = ([regex]::Match($keys, 'ProductVersion=([0-9.]+)')).Groups[1].Value

Write-Host "VerInfo parts  : $parts"
Write-Host "FileVersion    : $fileVer"
Write-Host "ProductVersion : $prodVer"
Write-Host ''

if ($fileVer -eq $parts) { Pass 'FileVersion matches MajorVer/MinorVer/Release/Build' }
else { Fail "FileVersion ($fileVer) does not match the parts ($parts)" }

if ($prodVer -eq $fileVer) { Pass 'ProductVersion matches FileVersion' }
else { Fail "ProductVersion ($prodVer) does not match FileVersion ($fileVer)  <-- the usual one" }

# Debug left as the default config ships a debug build to a store.
$cfg = ($x.Project.PropertyGroup | Where-Object { $_.Config -and $_.Config.'#text' } |
        Select-Object -First 1).Config.'#text'
if (-not $cfg) { $cfg = ($x.Project.PropertyGroup.Config | Select-Object -First 1) }
if ("$cfg" -eq 'Release') { Pass 'Default Config is Release' }
else { Fail "Default Config is '$cfg', not Release" }

if (Test-Path -LiteralPath $Exe) {
    $i = Get-Item -LiteralPath $Exe
    Write-Host ''
    Write-Host ("EXE            : {0:N0} bytes, built {1:yyyy-MM-dd HH:mm}" -f $i.Length, $i.LastWriteTime)
    Write-Host ("  FileVersion    : {0}" -f $i.VersionInfo.FileVersion)
    Write-Host ("  ProductVersion : {0}" -f $i.VersionInfo.ProductVersion)

    if ($i.VersionInfo.FileVersion -eq $fileVer) { Pass 'EXE matches the .dproj -- it was rebuilt after the bump' }
    else { Fail "EXE is $($i.VersionInfo.FileVersion) but the .dproj says $fileVer -- REBUILD" }

    # UPX leaves its section names in the header; a packed build is also far
    # smaller. Size alone is the reliable signal here.
    if ($i.Length -lt 12MB) { Pass 'EXE looks UPX-packed (AppCompress.bat has run)' }
    else { Fail 'EXE is NOT packed -- run AppCompress.bat before deploying' }
} else {
    Note "No EXE at $Exe -- skipped the built-binary checks."
}

Write-Host ''
if ($ok) { Write-Host 'All checks passed.' -ForegroundColor Green; exit 0 }
else     { Write-Host 'Fix the above before deploying.' -ForegroundColor Red; exit 1 }
