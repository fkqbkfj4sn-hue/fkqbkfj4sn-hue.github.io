#!/bin/bash

echo "测试桌面快捷方式..."
echo "当前用户: $USER"
echo ""

# 测试桌面路径
DESKTOP1="/c/Users/$USERNAME/Desktop"
DESKTOP2="/c/Users/$USER/Desktop"
DESKTOP3="/c/Users/wzm/Desktop"

if [ -d "$DESKTOP1" ]; then
    echo "✅ 找到桌面目录: $DESKTOP1"
    ls "$DESKTOP1/"*科研*.bat 2>/dev/null || echo "⚠️  未找到科研相关快捷方式"
elif [ -d "$DESKTOP2" ]; then
    echo "✅ 找到桌面目录: $DESKTOP2"
    ls "$DESKTOP2/"*科研*.bat 2>/dev/null || echo "⚠️  未找到科研相关快捷方式"
elif [ -d "$DESKTOP3" ]; then
    echo "✅ 找到桌面目录: $DESKTOP3"
    ls "$DESKTOP3/"*科研*.bat 2>/dev/null || echo "⚠️  未找到科研相关快捷方式"
else
    echo "⚠️  未找到桌面目录"
    echo "尝试的路径:"
    echo "  $DESKTOP1"
    echo "  $DESKTOP2"
    echo "  $DESKTOP3"
fi

echo ""
echo "测试开始科研工作脚本..."
./start-research.sh &
sleep 5
echo "停止测试..."
pkill -f "research-auto-save.sh" 2>/dev/null
rm -f .research_auto_save.pid
echo "测试完成"
