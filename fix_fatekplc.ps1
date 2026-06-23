# 修复 FatekPLC.pas 文件

# 1. 读取文件（GB2312 编码）
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$content = [System.IO.File]::ReadAllText('FatekPLC.pas', $enc)

# 2. 修复单元命名空间
$content = $content -replace 'Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,', 'Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,'
$content = $content -replace 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,System.AnsiStrings;', 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,System.AnsiStrings;'

# 3. 修复 Format 函数参数 - 将 Byte/DWord 转换为 Integer/Cardinal
$content = $content -replace "Format\('%.2x',\[PLCID\]\)", "Format('%.2x',[Integer(PLCID)])"
$content = $content -replace "Format\('%.2x',\[FUNCode\]\)", "Format('%.2x',[Integer(FUNCode)])"
$content = $content -replace "Format\('%.2x',\[REG_Num\]\)", "Format('%.2x',[Integer(REG_Num)])"
$content = $content -replace "Format\('%.4x',\[HYFunc\]\)", "Format('%.4x',[Cardinal(HYFunc)])"
$content = $content -replace "Format\('%.2x',\[CheckSum\]\)", "Format('%.2x',[Integer(CheckSum)])"

# 4. 写入文件（UTF-8 with BOM 编码）
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText('FatekPLC.pas', $content, $utf8WithBom)

Write-Host "FatekPLC.pas fixed and converted to UTF-8 with BOM"
