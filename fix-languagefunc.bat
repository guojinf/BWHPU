@echo off
chcp 65001 >nul
cd /d "%~dp0"

REM 修复 LanguageFunc.pas 中所有 ReadString 调用
powershell -Command @"
`$content = Get-Content 'LanguageFunc.pas' -Encoding UTF8 -Raw
`$content = `$content -replace 'Application\.Title := ReadString\(', 'Application.Title := string(AnsiString(ReadString('
`$content = `$content -replace 'msg\[i\] := ReadString\(', 'msg[i] := string(AnsiString(ReadString('
`$content = `$content -replace 'Screen\.Forms\[i\]\.Caption := ReadString\(', 'Screen.Forms[i].Caption := string(AnsiString(ReadString('
`$content = `$content -replace 'Screen\.Forms\[i\]\.Hint := ReadString\(', 'Screen.Forms[i].Hint := string(AnsiString(ReadString('
`$content = `$content -replace 'Control\.Hint := ReadString\(', 'Control.Hint := string(AnsiString(ReadString('
`$content = `$content -replace 'Strings\[k\] := ReadString\(', 'Strings[k] := string(AnsiString(ReadString('
`$content = `$content -replace 'Control\.SetTextBuf\(pchar\(ReadString\(', 'Control.SetTextBuf(pchar(string(AnsiString(ReadString('
`$content = `$content -replace 'TMenuItem\(Component\)\.Caption := ReadString\(', 'TMenuItem(Component).Caption := string(AnsiString(ReadString('
`$content = `$content -replace 'TMenuItem\(Component\)\.Hint := ReadString\(', 'TMenuItem(Component).Hint := string(AnsiString(ReadString('
`$content = `$content -replace 'TCustomAction\(Component\)\.Caption := ReadString\(', 'TCustomAction(Component).Caption := string(AnsiString(ReadString('
`$content = `$content -replace 'TCustomAction\(Component\)\.Hint := ReadString\(', 'TCustomAction(Component).Hint := string(AnsiString(ReadString('
`$content = `$content -replace 'TOpenDialog\(Component\)\.Filter := ReadString\(', 'TOpenDialog(Component).Filter := string(AnsiString(ReadString('
`$content = `$content -replace 'TOpenDialog\(Component\)\.Title := ReadString\(', 'TOpenDialog(Component).Title := string(AnsiString(ReadString('
`$content | Set-Content 'LanguageFunc.pas' -Encoding UTF8
"@

echo LanguageFunc.pas fixed!
pause
