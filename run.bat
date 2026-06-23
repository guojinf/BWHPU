@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Starting HPU.exe...
start "" "Win32\Debug\HPU.exe"
echo HPU.exe started!
timeout /t 2 /nobreak >nul
tasklist | findstr HPU.exe
pause
