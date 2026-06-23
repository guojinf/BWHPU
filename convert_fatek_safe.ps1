# 安全地转换 FatekPLC.pas 文件编码

# 读取 GB2312 编码的文件
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$lines = [System.IO.File]::ReadAllLines('FatekPLC.pas', $enc)

# 转换每一行
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    # 修复 Format 函数参数
    $line = $line -replace "Format\('%.2x',\[PLCID\]\)", "Format('%.2x',[Integer(PLCID)])"
    $line = $line -replace "Format\('%.2x',\[FUNCode\]\)", "Format('%.2x',[Integer(FUNCode)])"
    $line = $line -replace "Format\('%.2x',\[REG_Num\]\)", "Format('%.2x',[Integer(REG_Num)])"
    $line = $line -replace "Format\('%.4x',\[HYFunc\]\)", "Format('%.4x',[Cardinal(HYFunc)])"
    $line = $line -replace "Format\('%.2x',\[CheckSum\]\)", "Format('%.2x',[Integer(CheckSum)])"
    
    $lines[$i] = $line
}

# 写入 UTF-8 with BOM 编码的文件
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines('FatekPLC.pas', $lines, $utf8WithBom)

Write-Host "FatekPLC.pas converted to UTF-8 with BOM and Format parameters fixed"
