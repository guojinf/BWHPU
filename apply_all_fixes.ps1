# 应用所有修复

Write-Host "1. Fixing unit namespaces..."

# ParaSet.pas
(Get-Content ParaSet.pas -Encoding Default) -replace ',math,', ',System.Math,' | Set-Content ParaSet.pas -Encoding Default

# SPComm.pas
$content = Get-Content SPComm.pas -Encoding Default -Raw
$content = $content -replace 'Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs', 'Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs'
$content = $content -replace 'Classes\.AllocateHWnd', 'AllocateHWnd'
$content = $content -replace 'Classes\.DeallocateHWnd', 'DeallocateHWnd'
Set-Content SPComm.pas $content -Encoding Default

# FatekPLC.pas
$content = Get-Content FatekPLC.pas -Encoding Default -Raw
$content = $content -replace 'AnsiStrings;', 'System.AnsiStrings;'
$content = $content -replace 'AnsiStrings\.', 'System.AnsiStrings.'
$content = $content -replace "Format\('%.4x',\[HYFunc\]\)", "Format('%.4x',[Cardinal(HYFunc)])"
$content = $content -replace "Format\('%.2x',\[PLCID\]\)", "Format('%.2x',[Integer(PLCID)])"
$content = $content -replace "Format\('%.2x',\[FUNCode\]\)", "Format('%.2x',[Integer(FUNCode)])"
$content = $content -replace "Format\('%.2x',\[REG_Num\]\)", "Format('%.2x',[Integer(REG_Num)])"
$content = $content -replace "Format\('%.2x',\[CheckSum\]\)", "Format('%.2x',[Integer(CheckSum)])"
Set-Content FatekPLC.pas $content -Encoding Default

# IdModbusClient.pas
$content = Get-Content IdModbusClient.pas -Encoding Default -Raw
$content = $content -replace '^  Classes$', '  System.Classes'
$content = $content -replace '^ ,SysUtils', ' ,System.SysUtils'
$content = $content -replace '^  ,windows;', '  ,Winapi.Windows;'
Set-Content IdModbusClient.pas $content -Encoding Default

# ModbusUtils.pas
(Get-Content ModbusUtils.pas -Encoding Default) -replace '^  SysUtils;', '  System.SysUtils;' | Set-Content ModbusUtils.pas -Encoding Default

# LanguageFunc.pas
$content = Get-Content LanguageFunc.pas -Encoding Default -Raw
$content = $content -replace 'uses Windows,ComObj,Messages, SysUtils, Variants, Classes, Graphics,IniFiles,', 'uses Winapi.Windows,System.Win.ComObj,Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.IniFiles,'
$content = $content -replace ' Controls,Forms,Dialogs, ComCtrls, StdCtrls,Buttons, ExtCtrls,Menus, mmSystem,', ' Vcl.Controls,Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,Vcl.Buttons, Vcl.ExtCtrls,Vcl.Menus, Winapi.MMSystem,'
$content = $content -replace ' ActnList,', ' Vcl.ActnList,'
$content = $content -replace '  ToolWin,main', ' Vcl.ToolWin,main'
Set-Content LanguageFunc.pas $content -Encoding Default

# FileFunc.pas
$content = Get-Content FileFunc.pas -Encoding Default -Raw
$content = $content -replace 'ReadString\(', 'string(AnsiString(ReadString('
$content = $content -replace 'ReadBool\(', 'boolean(ReadBool('
Set-Content FileFunc.pas $content -Encoding Default

Write-Host "2. Converting files to UTF-8..."
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$files = Get-ChildItem -Filter *.pas
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, $enc)
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}

Write-Host "All fixes applied!"
