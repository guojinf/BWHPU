# 批量转换 Delphi 文件编码从 GB2312 到 UTF-8
# 这个脚本会检测并转换所有 .pas 文件

$sourceDir = "d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU"

# 获取所有 .pas 文件
$pasFiles = Get-ChildItem -Path $sourceDir -Filter "*.pas" -File

Write-Host "开始转换文件编码..." -ForegroundColor Green

foreach ($file in $pasFiles) {
    $filePath = $file.FullName
    Write-Host "处理文件：$($file.Name)" -ForegroundColor Yellow
    
    try {
        # 尝试以 GB2312 编码读取文件
        $gb2312Encoding = [System.Text.Encoding]::GetEncoding(936)  # GB2312/GBK
        $content = [System.IO.File]::ReadAllText($filePath, $gb2312Encoding)
        
        # 检查是否包含乱码特征字符 (替换字符)
        if ($content -contains '') {
            Write-Host "  - 检测到乱码，尝试修复..." -ForegroundColor Red
            
            # 读取原始字节
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            
            # 尝试不同的编码
            $encodings = @(
                @{ Name = "GB2312"; Encoding = [System.Text.Encoding]::GetEncoding(936) },
                @{ Name = "GBK"; Encoding = [System.Text.Encoding]::GetEncoding(936) },
                @{ Name = "GB18030"; Encoding = [System.Text.Encoding]::GetEncoding(54936) }
            )
            
            foreach ($enc in $encodings) {
                try {
                    $testContent = $enc.Encoding.GetString($bytes)
                    if ($testContent -notmatch '') {
                        Write-Host "  - 使用 $("$enc.Name") 编码成功解码" -ForegroundColor Green
                        $content = $testContent
                        break
                    }
                } catch {
                    continue
                }
            }
        }
        
        # 以 UTF-8 编码保存文件 (带 BOM)
        $utf8WithBom = New-Object System.Text.UTF8Encoding $true
        [System.IO.File]::WriteAllText($filePath, $content, $utf8WithBom)
        
        Write-Host "  - 转换成功" -ForegroundColor Green
        
    } catch {
        Write-Host "  - 处理失败：$_" -ForegroundColor Red
    }
}

Write-Host "`n所有文件处理完成!" -ForegroundColor Green
