#!/bin/bash

# ========================================
# 创建中文桌面快捷方式
# ========================================

echo "创建中文桌面快捷方式..."

# Windows 桌面路径
WINDOWS_DESKTOP="/c/Users/$USERNAME/Desktop"

# 如果没有USERNAME变量，尝试使用当前用户名
if [ ! -d "$WINDOWS_DESKTOP" ]; then
    WINDOWS_DESKTOP="/c/Users/$USER/Desktop"
fi

if [ -d "$WINDOWS_DESKTOP" ]; then
    echo "找到桌面目录: $WINDOWS_DESKTOP"
    
    # 创建开始工作快捷方式（使用中文）
    echo "创建 开始科研工作.bat..."
    cat > "$WINDOWS_DESKTOP/开始科研工作.bat" << 'BAT'
@echo off
chcp 65001 > nul
echo ========================================
echo 🌅 开始科研工作
echo ========================================
echo.
echo 正在启动科研工作系统...
echo.
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
echo 工作目录: %cd%
echo.
echo 请稍候...
bash --login -i -c "./start-research.sh"
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ 启动失败，请检查:
    echo 1. Git Bash 是否正确安装
    echo 2. 脚本文件是否存在
    echo 3. 查看 auto-save.log 日志
)
echo.
pause
BAT

    # 创建结束工作快捷方式（使用中文）
    echo "创建 结束科研工作.bat..."
    cat > "$WINDOWS_DESKTOP/结束科研工作.bat" << 'BAT2'
@echo off
chcp 65001 > nul
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
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ 执行过程中出现错误
    echo 请查看日志文件
)
echo.
pause
BAT2

    # 创建查看状态快捷方式
    echo "创建 查看科研状态.bat..."
    cat > "$WINDOWS_DESKTOP/查看科研状态.bat" << 'BAT3'
@echo off
chcp 65001 > nul
echo ========================================
echo 📊 科研工作状态
echo ========================================
echo.
cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
echo 工作目录: %cd%
echo.
bash --login -i -c "./research-stats.sh"
echo.
pause
BAT3

    echo ""
    echo "✅ 快捷方式已创建到桌面:"
    echo "   1. 开始科研工作.bat"
    echo "   2. 结束科研工作.bat"
    echo "   3. 查看科研状态.bat"
    echo ""
    echo "💡 使用说明:"
    echo "   早上双击 '开始科研工作.bat'"
    echo "   随时双击 '查看科研状态.bat'"
    echo "   晚上双击 '结束科研工作.bat'"
else
    echo "⚠️  未找到Windows桌面目录"
    echo "桌面路径尝试: $WINDOWS_DESKTOP"
    echo ""
    echo "请手动创建快捷方式，内容如下:"
    echo ""
    echo "开始科研工作.bat:"
    echo '  @echo off'
    echo '  cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"'
    echo '  bash -c "./start-research.sh"'
    echo '  pause'
    echo ""
    echo "结束科研工作.bat:"
    echo '  @echo off'
    echo '  cd /d "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"'
    echo '  bash -c "./end-research.sh"'
    echo '  pause'
fi
