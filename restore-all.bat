@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo 正在恢复所有修改...
git checkout -- .
echo 恢复完成！
git status
pause
