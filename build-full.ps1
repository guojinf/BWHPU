# 编译完整的 HPU 项目（包括主程序和语言 DLL）
param(
    [Parameter()]
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Debug",
    
    [Parameter()]
    [switch]$Clean
)

$DelphiPath = "C:\Program Files (x86)\Embarcadero\Studio\23.0"
$MSBuild = "$DelphiPath\bin\MSBuild.exe"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "编译 HPU 项目（使用 MSBuild）" -ForegroundColor Cyan
Write-Host "配置：$Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($Clean) {
    Write-Host "清理旧文件..." -ForegroundColor Yellow
    Remove-Item -Path ".\Win32\$Configuration\*.exe" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path ".\Win32\$Configuration\*.dcu" -Force -ErrorAction SilentlyContinue
}

# 使用 MSBuild 编译 dproj 文件
Write-Host "开始编译..." -ForegroundColor Green
$arguments = @(
    "HPU.dproj",
    "/p:Configuration=$Configuration",
    "/p:Platform=Win32",
    "/t:Build"
)

$process = Start-Process -FilePath $MSBuild -ArgumentList $arguments -Wait -PassThru -NoNewWindow

if ($process.ExitCode -eq 0) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "编译成功!" -ForegroundColor Green
    Write-Host "输出文件:" -ForegroundColor Cyan
    if (Test-Path ".\Win32\$Configuration\HPU.exe") {
        Write-Host "  ✓ HPU.exe" -ForegroundColor Green
    }
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "编译失败！退出码：$($process.ExitCode)" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit $process.ExitCode
}
