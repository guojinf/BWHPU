@echo off
chcp 65001 >nul
cd /d "%~dp0"

REM Fix Format calls in FatekPLC.pas
powershell -Command "$content = Get-Content 'FatekPLC.pas' -Raw; $content = $content -replace \"Format\\('%.2x',\\[([^\\]]+)\\]\\)\", \"Format('%%.2x', [$1])\" -replace \"Format\\('%.4x',\\[([^\\]]+)\\]\\)\", \"Format('%%.4x', [$1])\"; $content | Out-File 'FatekPLC.pas' -Encoding Default"

echo Fixed Format calls in FatekPLC.pas
pause
