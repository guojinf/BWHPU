@echo off
chcp 65001 >nul
echo Converting Pascal files from GB2312 to UTF-8...

powershell -Command "& {$enc = [System.Text.Encoding]::GetEncoding('GB2312'); $files = Get-ChildItem -Filter *.pas; foreach ($file in $files) { $content = [System.IO.File]::ReadAllText($file.FullName, $enc); [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8); Write-Host ('Converted: ' + $file.Name) }}"

echo Done!
pause
