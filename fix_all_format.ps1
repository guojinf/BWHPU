# 修复所有剩余的 Format 调用

$content = Get-Content 'FatekPLC.pas' -Encoding UTF8 -Raw

# 修复所有 [REG_Num] 和 [CheckSum]
$content = $content -replace "\[REG_Num\]\)\+ADDR", "[Integer(REG_Num)])+ADDR"
$content = $content -replace "\[REG_Num\]\)\)\+ADDR", "[Integer(REG_Num)]))+ADDR"
$content = $content -replace "\[CheckSum\]\]\);", "[Integer(CheckSum)]);"

Set-Content 'FatekPLC.pas' $content -Encoding UTF8

Write-Host "All Format calls fixed"
