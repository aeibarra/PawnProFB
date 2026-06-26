@echo off
REM ============================================================================
REM CopyFbClientCrypto.bat
REM
REM Deploys the Firebird wire-encryption client files next to fbclient.dll so a
REM workstation can satisfy the server's WireCrypt=Required and connect remotely
REM (FB5 rejects unencrypted non-loopback connections with
REM  "connection rejected by remote interface").
REM
REM Copies, relative to the target app folder:
REM     plugins\chacha.dll   <- the ChaCha cipher (the actual encryption)
REM     firebird.msg         <- readable server error text
REM     plugins.conf         <- maps the ChaCha64 plugin name to plugins\chacha.dll
REM   (optional) ICU runtime <- icudt63.dll / icudt63l.dat / icuin63.dll / icuuc63.dll
REM                             only needed if the client throws a charset /
REM                             transliteration error against the UTF8 DB
REM
REM Usage:
REM     CopyFbClientCrypto.bat [TargetFolder] [icu]
REM
REM     TargetFolder   folder that contains fbclient.dll (the app folder).
REM                    Defaults to this script's own folder.
REM     icu            add this word to also copy the 4 ICU files (~30 MB).
REM
REM Examples:
REM     CopyFbClientCrypto.bat
REM     CopyFbClientCrypto.bat "C:\Program Files\PawnPro"
REM     CopyFbClientCrypto.bat "C:\Program Files\PawnPro" icu
REM ============================================================================

setlocal

REM ---- Locate the Firebird 5 install (source of the crypto files) ------------
set "FB_DIR=C:\Program Files\Firebird\Firebird_5_0"
if not exist "%FB_DIR%\plugins\chacha.dll" (
  echo ERROR: Firebird 5 not found at:
  echo        %FB_DIR%
  echo        Edit FB_DIR in this script to point at your Firebird install.
  goto :fail
)

REM ---- Resolve the target app folder (where fbclient.dll lives) ---------------
if "%~1"=="" (
  set "TARGET=%~dp0"
) else (
  set "TARGET=%~1"
)
REM strip a trailing backslash for clean joins
if "%TARGET:~-1%"=="\" set "TARGET=%TARGET:~0,-1%"

echo.
echo Firebird source : %FB_DIR%
echo Target folder   : %TARGET%
echo.

if not exist "%TARGET%\fbclient.dll" (
  echo WARNING: fbclient.dll was NOT found in the target folder.
  echo          plugins.conf resolves plugins\ relative to fbclient.dll, so the
  echo          crypto plugin will not load unless fbclient.dll is here too.
  echo.
)

REM ---- Copy the three required files ------------------------------------------
if not exist "%TARGET%\plugins" mkdir "%TARGET%\plugins"

call :copyone "%FB_DIR%\plugins\chacha.dll" "%TARGET%\plugins\chacha.dll"  || goto :fail
call :copyone "%FB_DIR%\firebird.msg"       "%TARGET%\firebird.msg"        || goto :fail
call :copyone "%FB_DIR%\plugins.conf"       "%TARGET%\plugins.conf"        || goto :fail

REM ---- Optional ICU runtime --------------------------------------------------
if /I "%~2"=="icu" (
  echo.
  echo Copying ICU runtime ^(~30 MB^)...
  call :copyone "%FB_DIR%\icudt63.dll"  "%TARGET%\icudt63.dll"  || goto :fail
  call :copyone "%FB_DIR%\icudt63l.dat" "%TARGET%\icudt63l.dat" || goto :fail
  call :copyone "%FB_DIR%\icuin63.dll"  "%TARGET%\icuin63.dll"  || goto :fail
  call :copyone "%FB_DIR%\icuuc63.dll"  "%TARGET%\icuuc63.dll"  || goto :fail
)

echo.
echo Done. Client wire-encryption files are in place.
echo Set host=^<server name or static IP^> in PawnPro.ini and test the connection.
echo.
goto :done

REM ---- helper: copy one file with a clear pass/fail line ----------------------
:copyone
copy /Y "%~1" "%~2" >nul
if errorlevel 1 (
  echo   FAILED : %~2
  exit /b 1
)
echo   copied : %~2
exit /b 0

:fail
echo.
echo Copy did NOT complete successfully. See messages above.
endlocal
pause
exit /b 1

:done
endlocal
pause
exit /b 0
