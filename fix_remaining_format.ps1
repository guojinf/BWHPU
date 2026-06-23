# 修复剩余的 Format 调用

# 读取文件
$content = Get-Content 'FatekPLC.pas' -Encoding UTF8 -Raw

# 修复剩余的 Format 调用
$content = $content -replace "Format\('%.2x',\[FUNCode\]\)\);", "Format('%.2x',[Integer(FUNCode)]));"
$content = $content -replace "Format\('%.2x',\[REG_Num\]\]\)\+ADDR", "Format('%.2x',[Integer(REG_Num)])+ADDR"
$content = $content -replace "Format\('%.2x',\[CheckSum\]\]\);", "Format('%.2x',[Integer(CheckSum)]);"

# 写入文件
Set-Content 'FatekPLC.pas' $content -Encoding UTF8

Write-Host "Remaining Format calls fixed"
