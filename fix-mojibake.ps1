# 修复乱码文件 - 尝试所有可能的中文编码
$sourceDir = "d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU"

# 需要修复的文件列表
$filesToFix = @(
    "FatekPLC.pas",
    "SPComm.pas", 
    "TypeDef.pas",
    "FileFunc.pas",
    "LanguageFunc.pas",
    "Main.pas",
    "ParaSet.pas",
    "About.pas",
    "VarDef.pas",
    "ModbusUtils.pas",
    "IdModbusClient.pas",
    "ModBusTcp_C.pas",
    "ModbusTypes.pas",
    "ModbusConsts.pas",
    "reinit.pas"
)

Write-Host "开始修复文件编码..." -ForegroundColor Green

foreach ($fileName in $filesToFix) {
    $filePath = Join-Path $sourceDir $fileName
    
    if (Test-Path $filePath) {
        Write-Host "`n处理文件：$fileName" -ForegroundColor Yellow
        
        try {
            # 读取原始字节
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            
            # 尝试不同的编码
            $encodings = @(
                @{ Name = "UTF-8 with BOM"; Encoding = [System.Text.Encoding]::GetEncoding(65001) },
                @{ Name = "GB2312"; Encoding = [System.Text.Encoding]::GetEncoding(936) },
                @{ Name = "Big5"; Encoding = [System.Text.Encoding]::GetEncoding(950) },
                @{ Name = "GB18030"; Encoding = [System.Text.Encoding]::GetEncoding(54936) }
            )
            
            $bestContent = $null
            $bestEncoding = $null
            
            foreach ($enc in $encodings) {
                try {
                    $testContent = $enc.Encoding.GetString($bytes)
                    
                    # 检查是否包含锟斤拷字符 (UTF-8 乱码特征)
                    if ($testContent -notmatch '锟斤拷') {
                        # 检查是否包含可读的中文
                        if ($testContent -match '[\u4e00-\u9fa5]') {
                            Write-Host "  - 找到正确编码：$("$enc.Name")" -ForegroundColor Green
                            $bestContent = $testContent
                            $bestEncoding = $enc.Encoding
                            break
                        }
                    }
                } catch {
                    Write-Host "  - $("$enc.Name") 解码失败" -ForegroundColor Red
                    continue
                }
            }
            
            if ($bestContent -ne $null) {
                # 以 UTF-8 with BOM 保存
                $utf8WithBom = New-Object System.Text.UTF8Encoding $true
                [System.IO.File]::WriteAllText($filePath, $bestContent, $utf8WithBom)
                Write-Host "  - 文件已修复并保存为 UTF-8 with BOM" -ForegroundColor Green
            } else {
                Write-Host "  - 未找到合适的编码，文件可能已损坏" -ForegroundColor Red
            }
            
        } catch {
            Write-Host "  - 处理失败：$_" -ForegroundColor Red
        }
    } else {
        Write-Host "  - 文件不存在：$fileName" -ForegroundColor Red
    }
}

Write-Host "`n所有文件处理完成!" -ForegroundColor Green
