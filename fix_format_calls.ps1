# 修复 FatekPLC.pas 中所有 Format 调用

$content = Get-Content 'FatekPLC.pas' -Encoding UTF8 -Raw

# 修复所有 Format 调用
$content = $content -replace "Format\('%.2x',\[PLCID\]\)", "Format('%.2x',[Integer(PLCID)])"
$content = $content -replace "Format\('%.2x',\[FUNCode\]\)", "Format('%.2x',[Integer(FUNCode)])"
$content = $content -replace "Format\('%.2x',\[REG_Num\]\)", "Format('%.2x',[Integer(REG_Num)])"
$content = $content -replace "Format\('%.2x',\[CheckSum\]\)", "Format('%.2x',[Integer(CheckSum)])"

Set-Content 'FatekPLC.pas' $content -Encoding UTF8

Write-Host "All Format calls fixed"
