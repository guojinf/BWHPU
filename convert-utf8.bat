@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Converting Pascal files to UTF-8...
powershell -Command "Get-ChildItem -Filter *.pas | ForEach-Object { $content = Get-Content $_.FullName -Encoding Default; $content | Set-Content $_.FullName -Encoding UTF8 }"
echo Done!
pause
