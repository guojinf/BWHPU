# Delphi HPU 项目编译脚本
param(
    [Parameter()]
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release",
    
    [Parameter()]
    [ValidateSet("Win32", "Win64")]
    [string]$Platform = "Win32",
    
    [Parameter()]
    [switch]$Clean,
    
    [Parameter()]
    [switch]$Run
)

# Delphi 安装路径
$DelphiPath = "C:\Program Files (x86)\Embarcadero\Studio\23.0"
$DCC32 = "$DelphiPath\bin\dcc32.exe"
$DCC64 = "$DelphiPath\bin\dcc64.exe"
$RSVars = "$DelphiPath\bin\rsvars.bat"

# 检查 Delphi 是否安装
if (-not (Test-Path $DCC32)) {
    Write-Error "未找到 Delphi 编译器。请检查安装路径: $DelphiPath"
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Delphi HPU 项目编译" -ForegroundColor Cyan
Write-Host "配置: $Configuration | 平台: $Platform" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 清理操作
if ($Clean) {
    Write-Host "清理旧文件..." -ForegroundColor Yellow
    $outputPaths = @(
        ".\$Platform\$Configuration\*.exe",
        ".\$Platform\$Configuration\*.dcu",
        ".\$Platform\$Configuration\*.map",
        ".\$Platform\$Configuration\*.rsm"
    )
    foreach ($path in $outputPaths) {
        Remove-Item -Path $path -Force -ErrorAction SilentlyContinue
    }
}

# 设置编译器选项
$compilerOptions = @(
    "-B",                           # 编译所有单元
    "-Q",                           # 安静模式
    "-W",                           # 显示警告
    "-H",                           # # 生成提示
    "-D$Configuration",             # 定义条件编译符号
    "-E.\$Platform\$Configuration", # 输出目录
    "-N.\$Platform\$Configuration", # DCU 输出目录
    "-LE.\$Platform\$Configuration",# BPL 输出目录
    "-LN.\$Platform\$Configuration" # DCP 输出目录
)

if ($Configuration -eq "Debug") {
    $compilerOptions += "-V"        # 生成调试信息
    $compilerOptions += "-GD"       # 生成 MAP 文件
}

# 选择编译器
$compiler = if ($Platform -eq "Win64") { $DCC64 } else { $DCC32 }

# 执行编译
Write-Host "开始编译..." -ForegroundColor Green
Write-Host "编译器: $compiler" -ForegroundColor Gray

$process = Start-Process -FilePath $compiler -ArgumentList ($compilerOptions + "HPU.dpr") -Wait -PassThru -NoNewWindow

if ($process.ExitCode -eq 0) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "编译成功!" -ForegroundColor Green
    Write-Host "输出: .\$Platform\$Configuration\HPU.exe" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    
    # 运行程序
    if ($Run) {
        Write-Host "启动程序..." -ForegroundColor Cyan
        $exePath = ".\$Platform\$Configuration\HPU.exe"
        if (Test-Path $exePath) {
            Start-Process $exePath
        } else {
            Write-Error "找不到可执行文件: $exePath"
        }
    }
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "编译失败! 错误码: $($process.ExitCode)" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit $process.ExitCode
}
