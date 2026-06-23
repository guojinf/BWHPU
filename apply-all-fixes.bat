@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo 1. Converting files to UTF-8...
powershell -Command "$enc = [System.Text.Encoding]::GetEncoding('GB2312'); $files = Get-ChildItem -Filter *.pas; foreach ($file in $files) { $content = [System.IO.File]::ReadAllText($file.FullName, $enc); [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8) }"

echo 2. Fixing unit references...
powershell -Command "(Get-Content 'ParaSet.pas' -Encoding UTF8) -replace ',math,', ',System.Math,' | Set-Content 'ParaSet.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'SPComm.pas' -Encoding UTF8) -replace 'Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs', 'Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs' | Set-Content 'SPComm.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'SPComm.pas' -Encoding UTF8) -replace 'Classes\.AllocateHWnd', 'AllocateHWnd' | Set-Content 'SPComm.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'SPComm.pas' -Encoding UTF8) -replace 'Classes\.DeallocateHWnd', 'DeallocateHWnd' | Set-Content 'SPComm.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'FatekPLC.pas' -Encoding UTF8) -replace ',AnsiStrings;' | Set-Content 'FatekPLC.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'FatekPLC.pas' -Encoding UTF8) -replace 'AnsiStrings\.' | Set-Content 'FatekPLC.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^  Classes$', '  System.Classes' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^ ,SysUtils', ' ,System.SysUtils' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^  ,windows;', '  ,Winapi.Windows;' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'ModbusUtils.pas' -Encoding UTF8) -replace '^  SysUtils;', '  System.SysUtils;' | Set-Content 'ModbusUtils.pas' -Encoding UTF8"

echo 3. Fixing Format function calls in FatekPLC.pas...
powershell -Command "(Get-Content 'FatekPLC.pas' -Encoding UTF8) -replace \"Format\('%.4x',\\[HYFunc\\]\)", \"Format('%.4x', [Cardinal(HYFunc)])\" | Set-Content 'FatekPLC.pas' -Encoding UTF8"

echo Done!
pause
