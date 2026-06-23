@echo off
chcp 65001 >nul
cd /d "%~dp0"

REM Fix all ReadString calls in LanguageFunc.pas
powershell -Command "$content = Get-Content 'LanguageFunc.pas' -Raw; $content = $content -replace '(:\\w+)\\s*:=\\s*ReadString\\(', '$1 := string(ReadString('; $content = $content -replace ',\\s*([^)]+)\\);', ', $1));'; $content | Out-File 'LanguageFunc.pas' -Encoding Default"

echo Fixed LanguageFunc.pas
pause
