@echo off
chcp 65001 >nul
echo Converting FatekPLC.pas from GB2312 to UTF-8...

powershell -Command "& {$enc = [System.Text.Encoding]::GetEncoding('GB2312'); $content = [System.IO.File]::ReadAllText('FatekPLC.pas', $enc); [System.IO.File]::WriteAllText('FatekPLC.pas', $content, [System.Text.Encoding]::UTF8); Write-Host 'Converted FatekPLC.pas to UTF-8'}"

echo Done!
pause
