# Delphi HPU 项目调试脚本
param(
    [Parameter()]
    [switch]$Clean,
    
    [Parameter()]
    [switch]$WithBreakpoints
)

# Delphi 安装路径
$DelphiPath = "C:\Program Files (x86)\Embarcadero\Studio\23.0"
$DCC32 = "$DelphiPath\bin\dcc32.exe"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Delphi HPU 项目 - DEBUG 编译" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 清理操作
if ($Clean) {
    Write-Host "清理旧文件..." -ForegroundColor Yellow
    $outputPaths = @(
        ".\Win32\Debug\*.exe",
        ".\Win32\Debug\*.dcu",
        ".\Win32\Debug\*.map",
        ".\Win32\Debug\*.rsm",
        ".\Win32\Debug\*.tds"
    )
    foreach ($path in $outputPaths) {
        Remove-Item -Path $path -Force -ErrorAction SilentlyContinue
    }
}

# Debug 编译选项
$compilerOptions = @(
    "-B",                           # 编译所有单元
    "-W",                           # 显示警告
    "-H",                           # 生成提示
    "-DDEBUG",                      # 定义 DEBUG 符号
    "-E.\Win32\Debug",              # 输出目录
    "-N.\Win32\Debug",              # DCU 输出目录
    "-LE.\Win32\Debug",             # BPL 输出目录
    "-LN.\Win32\Debug",             # DCP 输出目录
    "-V",                           # 生成调试信息
    "-GD",                          # 生成 MAP 文件
    "-M",                           # 生成 MAP 文件
    "-L",                           # 本地符号
    "-k-MAP",                       # 链接器 MAP 选项
    "-u",                           # 输出单元信息
    "-JPHN",                        # 生成调试信息
    "-JL"                           # 行号信息
)

# 执行编译
Write-Host "开始 DEBUG 编译..." -ForegroundColor Green
Write-Host "编译器: $DCC32" -ForegroundColor Gray
Write-Host "输出目录: .\Win32\Debug\" -ForegroundColor Gray

$process = Start-Process -FilePath $DCC32 -ArgumentList ($compilerOptions + "HPU.dpr") -Wait -PassThru -NoNewWindow

if ($process.ExitCode -eq 0) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "DEBUG 编译成功!" -ForegroundColor Green
    Write-Host "输出: .\Win32\Debug\HPU.exe" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    
    # 显示调试信息
    Write-Host "`n调试文件已生成:" -ForegroundColor Cyan
    if (Test-Path ".\Win32\Debug\HPU.map") {
        Write-Host "  ✓ HPU.map (映射文件)" -ForegroundColor Green
    }
    if (Test-Path ".\Win32\Debug\*.tds") {
        Write-Host "  OK *.tds (调试符号文件)" -ForegroundColor Green
    }
    
    Write-Host "Starting program with debug mode..." -ForegroundColor Cyan
    $exePath = ".\Win32\Debug\HPU.exe"
    if (Test-Path $exePath) {
        Start-Process $exePath
        Write-Host "Program started! Use Delphi IDE F9 to debug" -ForegroundColor Yellow
    } else {
        Write-Error "Executable not found: $exePath"
    }
} else {
    Write-Host "Build failed! Exit code: $($process.ExitCode)" -ForegroundColor Red
    exit $process.ExitCode
}
