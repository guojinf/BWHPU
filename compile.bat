@echo off
REM 编译 HPU 项目生成 HPU.exe
SET DELPHI_PATH=C:\Program Files (x86)\Embarcadero\Studio\23.0
SET CONFIG=Debug

echo ========================================
echo 编译 HPU 项目
echo 配置：%CONFIG%
echo ========================================

cd /d "%~dp0"

echo 清理旧文件...
del /Q "Win32\%CONFIG%\*.exe" 2>nul
del /Q "Win32\%CONFIG%\*.dcu" 2>nul

echo 开始编译...
"%DELPHI_PATH%\bin\dcc32.exe" -B -DDEBUG -EWin32\%CONFIG% -NWin32\%CONFIG% -LEWin32\%CONFIG% -V -GD HPU.dpr

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo 编译成功!
    echo ========================================
    if exist "Win32\%CONFIG%\HPU.exe" (
        echo 已生成：Win32\%CONFIG%\HPU.exe
    )
) else (
    echo ========================================
    echo 编译失败! 错误码：%ERRORLEVEL%
    echo ========================================
)

pause
