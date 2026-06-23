@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo 正在转换所有 Pascal 文件为 UTF-8 编码...

$files = Get-ChildItem -Path . -Filter *.pas -Recurse
foreach ($file in $files) {
    Write-Host "Converting: $($file.Name)"
    $content = Get-Content $file.FullName -Encoding Default
    $content | Out-File $file.FullName -Encoding UTF8
}

echo 转换完成！
pause
