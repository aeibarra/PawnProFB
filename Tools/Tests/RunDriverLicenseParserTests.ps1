param(
    [string]$StudioPath = 'C:\Program Files (x86)\Embarcadero\Studio\37.0'
)

$ErrorActionPreference = 'Stop'
$repoPath = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$testOutput = Join-Path $repoPath 'Units\BarcodeTests'
$compilerPath = Join-Path $StudioPath 'bin\dcc64.exe'
$libraryPath = Join-Path $StudioPath 'lib\win64\release'
New-Item -ItemType Directory -Force $testOutput | Out-Null
Push-Location $repoPath
try {
    & $compilerPath -B -Q '-$R+' '-$Q+' "-U$libraryPath" "-E$testOutput" "-N0$testOutput" 'Tools\Tests\DriverLicenseParserTests.dpr'
    if ($LASTEXITCODE -ne 0) { throw 'Driver license regression tests did not compile.' }
    & (Join-Path $testOutput 'DriverLicenseParserTests.exe')
    if ($LASTEXITCODE -ne 0) { throw 'Driver license regression tests failed.' }
}
finally {
    Pop-Location
}
