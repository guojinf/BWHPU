# 读取 GB2312 编码的文件
$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$content = [System.IO.File]::ReadAllText('FatekPLC.pas', $enc)

# 写入 UTF-8 编码的文件（带 BOM）
$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText('FatekPLC.pas', $content, $utf8WithBom)

Write-Host "FatekPLC.pas converted to UTF-8 with BOM"
