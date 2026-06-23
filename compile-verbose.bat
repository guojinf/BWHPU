@echo off
chcp 65001 >nul
SET DELPHI=C:\PROGRA~2\Embarcadero\Studio\23.0\bin\dcc32.exe
cd /d "%~dp0"
echo ========================================
echo Compiling HPU.exe (Debug)...
echo ========================================
echo.
"%DELPHI%" -B -DDEBUG -V -GD -EWin32\Debug -NWin32\Debug HPU.dpr 2>&1
echo.
echo ========================================
echo Error level: %ERRORLEVEL%
echo ========================================
if exist "Win32\Debug\HPU.exe" (
    echo SUCCESS: HPU.exe created!
    dir Win32\Debug\HPU.exe
) else (
    echo FAILED: HPU.exe not found
    echo Files in Win32\Debug:
    dir Win32\Debug\*.exe
)
pause
