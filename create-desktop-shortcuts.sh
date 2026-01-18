#!/bin/bash

# ========================================
# 创建桌面快捷方式
# ========================================

echo "创建科研工作桌面快捷方式..."

# Windows 桌面路径
WINDOWS_DESKTOP="/c/Users/$USERNAME/Desktop"

if [ -d "$WINDOWS_DESKTOP" ]; then
    # 创建开始工作快捷方式
    cat > "$WINDOWS_DESKTOP/开始科研工作.bat" << 'BAT'
@echo off
echo ========================================
echo 🌅 开始科研工作
echo ========================================
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
bash -c "./start-research.sh"
pause
BAT

    # 创建结束工作快捷方式
    cat > "$WINDOWS_DESKTOP/结束科研工作.bat" << 'BAT2'
@echo off
echo ========================================
echo 🌙 结束科研工作
echo ========================================
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
bash -c "./end-research.sh"
pause
BAT2

    echo "✅ 快捷方式已创建到桌面:"
    echo "   1. 开始科研工作.bat"
    echo "   2. 结束科研工作.bat"
else
    echo "⚠️  未找到Windows桌面目录"
    echo "请手动创建快捷方式"
fi
