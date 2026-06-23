@echo off
chcp 65001 >nul
powershell -Command "$bytes = [System.IO.File]::ReadAllBytes('FatekPLC.pas'); Write-Host 'First 50 bytes:' -ForegroundColor Green; for($i=0; $i -lt 50; $i++) { Write-Host ('{0:X2}' -f $bytes[$i]) -NoNewline; Write-Host ' ' -NoNewline }; Write-Host ''"
