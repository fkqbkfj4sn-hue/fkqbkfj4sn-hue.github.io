#!/bin/bash

echo "=== 验证中文按钮功能 ==="
echo ""

# 1. 检查桌面中文按钮是否存在
echo "1. 检查桌面中文按钮："
if [ -f "/c/Users/wzm/Searches/Desktop/开始科研工作.bat" ]; then
    echo "✅ 开始科研工作.bat 存在"
else
    echo "❌ 开始科研工作.bat 不存在"
fi

if [ -f "/c/Users/wzm/Searches/Desktop/结束科研工作.bat" ]; then
    echo "✅ 结束科研工作.bat 存在"
else
    echo "❌ 结束科研工作.bat 不存在"
fi

echo ""
# 2. 检查按钮内容是否指向正确的脚本
echo "2. 检查按钮指向的脚本："
if [ -f "start-research.sh" ]; then
    echo "✅ start-research.sh 存在"
else
    echo "❌ start-research.sh 不存在"
fi

if [ -f "end-research.sh" ]; then
    echo "✅ end-research.sh 存在"
else
    echo "❌ end-research.sh 不存在"
fi

echo ""
# 3. 检查是否还有英文按钮
echo "3. 检查是否还有英文按钮："
ENGLISH_FILES=$(ls "/c/Users/wzm/Searches/Desktop/"*research*.bat 2>/dev/null | wc -l)
if [ $ENGLISH_FILES -gt 0 ]; then
    echo "⚠️  还有英文按钮，需要删除："
    ls "/c/Users/wzm/Searches/Desktop/"*research*.bat 2>/dev/null
else
    echo "✅ 没有英文按钮"
fi

echo ""
echo "=== 使用说明 ==="
echo "✅ 如果上述检查都通过，说明你的系统已经配置好："
echo "   1. 早上双击：开始科研工作.bat"
echo "   2. 晚上双击：结束科研工作.bat"
echo ""
echo "❌ 如果还有问题，请手动删除桌面上英文名称的文件"
