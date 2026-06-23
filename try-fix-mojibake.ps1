# 修复"锟斤拷"乱码
# 这种乱码是因为 UTF-8 编码被错误地用 GBK 解码
# 我们需要反向还原

$sourceDir = "d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU"

# "锟斤拷"的 Unicode 编码
# 锟 = U+949F
# 斤 = U+65A4  
# 拷 = U+8003

function Fix-Mojibake {
    param([string]$text)
    
    # 替换常见的"锟斤拷"乱码模式
    # 这些是 UTF-8 中文字符被错误用 GBK 解码的结果
    
    $replacements = @{
        '锟斤拷' = ''  # 最常见的乱码
        '锟' = ''
        '斤拷' = ''
        # 添加更多已知的乱码模式
    }
    
    $result = $text
    foreach ($key in $replacements.Keys) {
        $result = $result -replace [regex]::Escape($key), $replacements[$key]
    }
    
    return $result
}

Write-Host "修复锟斤拷乱码..." -ForegroundColor Green

$pasFiles = Get-ChildItem -Path $sourceDir -Filter "*.pas" -File

foreach ($file in $pasFiles) {
    $filePath = $file.FullName
    Write-Host "处理：$($file.Name)" -ForegroundColor Yellow
    
    try {
        # 读取文件内容
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        # 检查是否包含锟斤拷
        if ($content -match '锟斤拷') {
            Write-Host "  - 检测到锟斤拷乱码，尝试修复..." -ForegroundColor Red
            
            # 这种乱码无法完全恢复，因为信息已经丢失
            # 最好的方法是找到原始的 GB2312 文件
            
            Write-Host "  - 警告：锟斤拷乱码无法完全修复，需要原始文件" -ForegroundColor Red
        } else {
            Write-Host "  - 文件正常" -ForegroundColor Green
        }
    } catch {
        Write-Host "  - 错误：$_" -ForegroundColor Red
    }
}

Write-Host "`n完成" -ForegroundColor Green
