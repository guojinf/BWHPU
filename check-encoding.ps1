# 检查文件实际编码
$filePath = "d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU\FatekPLC.pas"

# 读取前 100 个字节的原始数据
$bytes = [System.IO.File]::ReadAllBytes($filePath)

Write-Host "文件前 100 字节的十六进制:" -ForegroundColor Green
for ($i = 0; $i -lt [Math]::Min(100, $bytes.Length); $i++) {
    Write-Host ("{0:X2}" -f $bytes[$i]) -NoNewline
    if (($i + 1) % 16 -eq 0) {
        Write-Host ""
    } else {
        Write-Host " " -NoNewline
    }
}

Write-Host "`n`n尝试不同编码解码前 50 个字符:" -ForegroundColor Green

# 尝试不同编码
$encodings = @(
    @{ Name = "Default (ANSI)"; Encoding = [System.Text.Encoding]::Default },
    @{ Name = "UTF-8"; Encoding = [System.Text.Encoding]::UTF8 },
    @{ Name = "UTF-8 with BOM"; Encoding = [System.Text.Encoding]::GetEncoding(65001) },
    @{ Name = "GB2312 (936)"; Encoding = [System.Text.Encoding]::GetEncoding(936) },
    @{ Name = "GBK"; Encoding = [System.Text.Encoding]::GetEncoding(936) },
    @{ Name = "GB18030"; Encoding = [System.Text.Encoding]::GetEncoding(54936) },
    @{ Name = "Big5"; Encoding = [System.Text.Encoding]::GetEncoding(950) }
)

foreach ($enc in $encodings) {
    try {
        $content = $enc.Encoding.GetString($bytes, 0, [Math]::Min(200, $bytes.Length))
        # 替换换行符以便显示
        $content = $content -replace "`r`n", " " -replace "`n", " "
        # 截取前 100 个字符
        if ($content.Length -gt 100) {
            $content = $content.Substring(0, 100)
        }
        Write-Host "$($enc.Name): $content" -ForegroundColor Yellow
    } catch {
        Write-Host "$($enc.Name): 解码失败" -ForegroundColor Red
    }
}
