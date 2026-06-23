# 完整修复 FatekPLC.pas 文件

# 使用 GB2312 编码读取文件
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$content = [System.IO.File]::ReadAllText('FatekPLC.pas', $enc)

# 1. 修复单元命名空间
$content = $content -replace 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,AnsiStrings;', 'Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VarDef,typeDef,SPComm,System.AnsiStrings;'

# 2. 修复 Format 函数参数 - 使用更精确的替换
$content = $content -replace "\[HYFunc\]\)\); //", "[Cardinal(HYFunc)])); //"
$content = $content -replace "\[PLCID\]\)\+Format", "[Integer(PLCID)])+Format"
$content = $content -replace "\[FUNCode\]\)\+Format", "[Integer(FUNCode)])+Format"
$content = $content -replace "\[FUNCode\]\)\)\+ADDR", "[Integer(FUNCode)]))+ADDR"
$content = $content -replace "\[REG_Num\]\]\)\+ADDR", "[Integer(REG_Num)])+ADDR"
$content = $content -replace "\[CheckSum\]\]\);", "[Integer(CheckSum)]);"

# 3. 写入 UTF-8 with BOM 编码的文件
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText('FatekPLC.pas', $content, $utf8WithBom)

Write-Host "FatekPLC.pas fixed successfully"
