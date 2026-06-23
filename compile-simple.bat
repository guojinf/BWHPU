@echo off
chcp 65001 >nul
SET DELPHI=C:\PROGRA~2\Embarcadero\Studio\23.0\bin\dcc32.exe
cd /d "%~dp0"
echo Compiling HPU...
"%DELPHI%" -B -Q HPU.dpr
echo Done! Error level: %ERRORLEVEL%
if exist "Win32\Debug\HPU.exe" echo SUCCESS: HPU.exe created!
pause
