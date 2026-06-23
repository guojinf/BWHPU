# 修复 FatekPLC.pas 文件

# 使用 GB2312 编码读取文件
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$content = [System.IO.File]::ReadAllText('FatekPLC.pas', $enc)

# 1. 修复单元命名空间
$content = $content -replace 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,AnsiStrings;', 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,System.AnsiStrings;'

# 2. 修复 Format 函数参数
$content = $content -replace "Format\('%.2x',\[PLCID\]\)", "Format('%.2x',[Integer(PLCID)])"
$content = $content -replace "Format\('%.2x',\[FUNCode\]\)", "Format('%.2x',[Integer(FUNCode)])"
$content = $content -replace "Format\('%.2x',\[REG_Num\]\)", "Format('%.2x',[Integer(REG_Num)])"
$content = $content -replace "Format\('%.4x',\[HYFunc\]\)", "Format('%.4x',[Cardinal(HYFunc)])"
$content = $content -replace "Format\('%.2x',\[CheckSum\]\)", "Format('%.2x',[Integer(CheckSum)])"

# 3. 写入 UTF-8 with BOM 编码的文件
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText('FatekPLC.pas', $content, $utf8WithBom)

Write-Host "FatekPLC.pas fixed successfully"
