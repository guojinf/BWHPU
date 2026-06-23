# 批量修复中文乱码文件
# 将 GB2312/GBK 编码的文件转换为 UTF-8 with BOM

$sourceDir = "d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU"

Write-Host "开始修复文件编码..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# 获取所有 .pas 文件
$pasFiles = Get-ChildItem -Path $sourceDir -Filter "*.pas" -File

$successCount = 0
$failCount = 0

foreach ($file in $pasFiles) {
    $filePath = $file.FullName
    Write-Host "`n处理：$($file.Name)" -ForegroundColor Yellow
    
    try {
        # 读取原始字节
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        
        # 尝试使用 GBK 编码解码 (GB2312 的超集)
        $gbkEncoding = [System.Text.Encoding]::GetEncoding(936)  # GBK/GB2312
        $content = $gbkEncoding.GetString($bytes)
        
        # 检查是否包含"锟斤拷"乱码
        if ($content -match '锟斤拷') {
            Write-Host "  - 包含乱码字符，尝试其他编码..." -ForegroundColor Red
            
            # 尝试 GB18030
            $gb18030 = [System.Text.Encoding]::GetEncoding(54936)
            $content = $gb18030.GetString($bytes)
            
            if ($content -match '锟斤拷') {
                Write-Host "  - GB18030 也无法正确解码" -ForegroundColor Red
                $failCount++
                continue
            }
        }
        
        # 检查是否包含中文
        if ($content -match '[\u4e00-\u9fa5]') {
            Write-Host "  - 检测到中文字符" -ForegroundColor Green
        }
        
        # 保存为 UTF-8 with BOM
        $utf8WithBom = New-Object System.Text.UTF8Encoding $true
        [System.IO.File]::WriteAllText($filePath, $content, $utf8WithBom)
        
        Write-Host "  ✓ 转换成功" -ForegroundColor Green
        $successCount++
        
    } catch {
        Write-Host "  ✗ 处理失败：$_" -ForegroundColor Red
        $failCount++
    }
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "处理完成!" -ForegroundColor Green
Write-Host "成功：$successCount, 失败：$failCount" -ForegroundColor Green
