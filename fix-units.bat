@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo Fixing unit references...

REM Fix SPComm.pas
powershell -Command "(Get-Content 'SPComm.pas' -Encoding UTF8) -replace 'Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs', 'Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs' | Set-Content 'SPComm.pas' -Encoding UTF8"

REM Fix FatekPLC.pas - remove AnsiStrings
powershell -Command "(Get-Content 'FatekPLC.pas' -Encoding UTF8) -replace ',AnsiStrings;', ';' | Set-Content 'FatekPLC.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'FatekPLC.pas' -Encoding UTF8) -replace 'AnsiStrings\.', '' | Set-Content 'FatekPLC.pas' -Encoding UTF8"

REM Fix IdModbusClient.pas
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^  Classes$', '  System.Classes' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^ ,SysUtils', ' ,System.SysUtils' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"
powershell -Command "(Get-Content 'IdModbusClient.pas' -Encoding UTF8) -replace '^  ,windows;', '  ,Winapi.Windows;' | Set-Content 'IdModbusClient.pas' -Encoding UTF8"

REM Fix ModbusUtils.pas
powershell -Command "(Get-Content 'ModbusUtils.pas' -Encoding UTF8) -replace '^  SysUtils;', '  System.SysUtils;' | Set-Content 'ModbusUtils.pas' -Encoding UTF8"

echo Done!
pause
