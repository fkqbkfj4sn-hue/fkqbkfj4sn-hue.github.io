#!/bin/bash
DESKTOP="/c/Users/wzm/Searches/Desktop"

# 创建开始科研工作.bat
cat > "$DESKTOP/开始科研工作.bat" << 'BAT'
@echo off
chcp 65001 > nul
color 0A
echo ========================================
echo 🌅 开始科研工作
echo ========================================
echo.
echo 正在启动科研工作系统...
echo.
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
echo 工作目录: %cd%
echo.
bash --login -i -c "./start-research.sh"
echo.
pause
BAT

# 创建结束科研工作.bat
cat > "$DESKTOP/结束科研工作.bat" << 'BAT2'
@echo off
chcp 65001 > nul
color 0A
echo ========================================
echo 🌙 结束科研工作
echo ========================================
echo.
echo 正在停止科研工作系统...
echo.
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
echo 工作目录: %cd%
echo.
bash --login -i -c "./end-research.sh"
echo.
pause
BAT2

echo "快捷方式已创建到桌面"
