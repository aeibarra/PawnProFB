<#
.SYNOPSIS
    Re-imports the LeadsOnline ticketWS SOAP proxy (LeadsOnlineWS.pas) from the
    live WSDL.

.DESCRIPTION
    LeadsOnline serve their contract as two documents that import each other:

      ticketWS.asmx?wsdl        types, messages, portType, service -- no binding
      ticketWS.asmx?wsdl=wsdl0  the binding -- imports the first one back

    WSDLImp.exe follows both edges of that cycle and emits the service interface
    and its entire InvRegistry registration block twice in one unit, which does
    not compile. This script breaks the cycle by merging the two into a single
    acyclic document before importing, then verifies the result before it is
    allowed to overwrite LeadsOnlineWS.pas.

    It also reports any change to the operation list or the enumerations against
    the previously fetched copy, so a schema revision is visible rather than
    silently absorbed.

    LeadsOnlineWS.pas is importer output and must never be hand-edited. Anything
    that needs adjusting belongs in uLeadsOnlineClient.pas.

.PARAMETER Endpoint
    Which host to read the contract from. Both serve identical schemas -- only
    soap:address differs, and that is overridden at runtime by
    uLeadsOnlineClient -- so this changes nothing but provenance. Default:
    Sandbox.

.PARAMETER WsdlImp
    Path to WSDLImp.exe. Default: the highest RAD Studio version installed.

.PARAMETER SkipFetch
    Merge and import from the WSDL copies already in PawnDocs\LeadsOnlineDocs
    instead of going to the network. Use to reproduce a past import exactly.

.EXAMPLE
    .\Tools\RefreshLeadsOnlineWSDL.ps1

.EXAMPLE
    .\Tools\RefreshLeadsOnlineWSDL.ps1 -Endpoint Production
#>

[CmdletBinding()]
param(
    [ValidateSet('Sandbox', 'Production')]
    [string] $Endpoint = 'Sandbox',

    [string] $WsdlImp,

    [switch] $SkipFetch
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0

$RepoRoot = Split-Path $PSScriptRoot -Parent
$DocsDir  = Join-Path $RepoRoot 'PawnDocs\LeadsOnlineDocs'
$OutUnit  = Join-Path $RepoRoot 'LeadsOnlineWS.pas'

$RootWsdl   = Join-Path $DocsDir 'ticketWS_sandbox.wsdl'
$BindWsdl   = Join-Path $DocsDir 'ticketWS_sandbox_wsdl0.wsdl'
$MergedWsdl = Join-Path $DocsDir 'LeadsOnlineWS.wsdl'

if ($Endpoint -eq 'Sandbox') {
    $BaseUrl = 'https://w3apisandbox.leadsonline.com/ticketWS.asmx'
} else {
    $BaseUrl = 'https://w3api.leadsonline.com/ticketWS.asmx'
}

$ExpectedOperations = @(
    'CheckLogin', 'SubmitTransaction', 'UpdateTransaction', 'CheckDoNotBuy',
    'CheckDoNotBuy2', 'UploadImage', 'DeleteImage', 'SetNoTransactionDayForStore'
)

# ---------------------------------------------------------------- helpers ---

function Get-Operations([string] $Wsdl) {
    [regex]::Matches($Wsdl, '<wsdl:operation name="([^"]+)"') |
        ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
}

function Get-Enumerations([string] $Wsdl) {
    [regex]::Matches($Wsdl, 'enumeration value="([^"]+)"') |
        ForEach-Object { $_.Groups[1].Value }
}

function Write-Drift([string] $Label, $Before, $After) {
    $added   = @($After  | Where-Object { $Before -notcontains $_ })
    $removed = @($Before | Where-Object { $After  -notcontains $_ })
    if ($added.Count -eq 0 -and $removed.Count -eq 0) {
        Write-Host ("  {0}: unchanged" -f $Label)
        return
    }
    if ($added.Count -gt 0) {
        Write-Host ("  {0}: ADDED   {1}" -f $Label, ($added -join ', ')) -ForegroundColor Yellow
    }
    if ($removed.Count -gt 0) {
        Write-Host ("  {0}: REMOVED {1}" -f $Label, ($removed -join ', ')) -ForegroundColor Red
    }
}

function Save-DelphiSource([string] $Path, [string] $Text) {
    # .editorconfig: *.pas is UTF-8 *with* BOM, CRLF. RAD Studio writes it that
    # way, and matching it keeps re-imports from showing a whole-file diff.
    $Text = $Text -replace "`r`n", "`n" -replace "`n", "`r`n"
    [System.IO.File]::WriteAllText($Path, $Text, (New-Object System.Text.UTF8Encoding($true)))
}

# ------------------------------------------------------------- locate tool ---

if (-not $WsdlImp) {
    $candidates = Get-ChildItem 'C:\Program Files (x86)\Embarcadero\Studio\*\bin\WSDLImp.exe' -ErrorAction SilentlyContinue |
        Sort-Object { [double] (Split-Path (Split-Path $_.FullName -Parent) -Parent | Split-Path -Leaf) } -Descending
    if (-not $candidates) {
        throw 'WSDLImp.exe not found. Pass -WsdlImp with its full path.'
    }
    $WsdlImp = $candidates[0].FullName
}
if (-not (Test-Path $WsdlImp)) { throw "WSDLImp.exe not found at $WsdlImp" }
Write-Host "WSDLImp    : $WsdlImp"
Write-Host "Endpoint   : $BaseUrl"

# ------------------------------------------------------------------- fetch ---

$previousOperations = @()
$previousEnums = @()
if (Test-Path $RootWsdl) {
    $prev = [System.IO.File]::ReadAllText($RootWsdl)
    $previousOperations = Get-Operations $prev
    $previousEnums = Get-Enumerations $prev
}

if ($SkipFetch) {
    Write-Host 'Fetch      : skipped, using the copies already on disk'
    if (-not (Test-Path $RootWsdl)) { throw "Missing $RootWsdl" }
    if (-not (Test-Path $BindWsdl)) { throw "Missing $BindWsdl" }
} else {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $ProgressPreference = 'SilentlyContinue'
    if (-not (Test-Path $DocsDir)) { New-Item -ItemType Directory -Force $DocsDir | Out-Null }
    Write-Host "Fetching   : $BaseUrl`?wsdl"
    Invoke-WebRequest -Uri "$BaseUrl`?wsdl" -UseBasicParsing -TimeoutSec 60 -OutFile $RootWsdl
    Write-Host "Fetching   : $BaseUrl`?wsdl=wsdl0"
    Invoke-WebRequest -Uri "$BaseUrl`?wsdl=wsdl0" -UseBasicParsing -TimeoutSec 60 -OutFile $BindWsdl
}

$root = [System.IO.File]::ReadAllText($RootWsdl)
$bind = [System.IO.File]::ReadAllText($BindWsdl)

# ------------------------------------------------------------------- merge ---

# Lift the binding out of wsdl0. Its wsp:PolicyReference only asserts HTTPS
# transport, which the endpoint enforces regardless, and carrying it over would
# drag in the wsp:Policy element too -- drop it.
$m = [regex]::Match($bind, '<wsdl:binding name=.*?</wsdl:binding>', 'Singleline')
if (-not $m.Success) { throw "No <wsdl:binding> found in $BindWsdl -- their document layout changed." }
$binding = $m.Value -replace '<wsp:PolicyReference[^>]*/>', '' -replace 'type="i0:', 'type="tns:'

# Drop the root's import of wsdl0, splice the binding in ahead of the service,
# and repoint the service port at it. i0 and tns both bind
# http://www.leadsonline.com/, so the prefix swap is a rename, not a change of
# meaning.
$merged = $root -replace '<wsdl:import\s[^>]*/>', ''
$merged = $merged -replace 'binding="i0:', 'binding="tns:'
$merged = $merged -replace '(?=<wsdl:service\s)', $binding

if ([regex]::Matches($merged, '<wsdl:import').Count -ne 0) { throw 'Merge failed: an import survived.' }
if ([regex]::Matches($merged, '<wsdl:binding ').Count -ne 1) { throw 'Merge failed: expected exactly one binding.' }
if ([regex]::Matches($merged, 'i0:').Count -ne 0) { throw 'Merge failed: an unresolved i0: prefix survived.' }

[System.IO.File]::WriteAllText($MergedWsdl, $merged + "`n", (New-Object System.Text.UTF8Encoding($false)))
Write-Host "Merged     : $MergedWsdl"

# ------------------------------------------------------------ schema drift ---

Write-Host 'Schema drift vs the previous fetch:'
if ($previousOperations.Count -eq 0) {
    Write-Host '  (no previous copy to compare against)'
} else {
    Write-Drift 'operations  ' $previousOperations (Get-Operations $root)
    Write-Drift 'enumerations' $previousEnums (Get-Enumerations $root)
}

# ------------------------------------------------------------------ import ---

$temp = Join-Path ([System.IO.Path]::GetTempPath()) ("LeadsOnlineWSDL_" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force $temp | Out-Null
try {
    # The unit is named after the input file -- WSDLImp has no unit-name switch,
    # which is why the merged copy is called LeadsOnlineWS.wsdl.
    & $WsdlImp -P "-D$temp" $MergedWsdl | Write-Verbose
    $generated = Join-Path $temp 'LeadsOnlineWS.pas'
    if (-not (Test-Path $generated)) { throw 'WSDLImp produced no LeadsOnlineWS.pas.' }
    $pas = [System.IO.File]::ReadAllText($generated)

    # The cycle is the failure this script exists to prevent, so check for its
    # signature explicitly rather than trusting the merge.
    $ifaceCount = [regex]::Matches($pas, 'ticketWSSoap = interface\(IInvokable\)').Count
    if ($ifaceCount -ne 1) {
        throw "Generated unit declares ticketWSSoap $ifaceCount times (expected 1) -- the import cycle was not broken."
    }
    $regCount = [regex]::Matches($pas, 'InvRegistry\.RegisterInterface\(TypeInfo\(ticketWSSoap\)').Count
    if ($regCount -ne 1) {
        throw "Generated unit registers ticketWSSoap $regCount times (expected 1)."
    }
    if ($pas -notmatch '(?m)^unit LeadsOnlineWS;') { throw 'Generated unit is not named LeadsOnlineWS.' }
    foreach ($op in $ExpectedOperations) {
        if ($pas -notmatch "function\s+$op\(") { throw "Generated unit is missing operation $op." }
    }

    Save-DelphiSource $OutUnit $pas
    Write-Host "Wrote      : $OutUnit ($ifaceCount interface, $($ExpectedOperations.Count) operations)" -ForegroundColor Green
} finally {
    Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ''
Write-Host 'Next: rebuild PawnProFB, then smoke-test with'
Write-Host '  Tools\LeadsOnlineProbe.exe <storeId> <userName> <password>'
