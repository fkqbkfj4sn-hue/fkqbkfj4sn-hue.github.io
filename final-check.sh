#!/bin/bash

echo "=== 最终系统状态确认 ==="
echo ""

echo "1. 桌面状态:"
echo "----------------"
ls -la "/c/Users/wzm/Searches/Desktop/"*.bat 2>/dev/null || echo "没有找到.bat文件"
echo ""

echo "2. Git仓库状态:"
echo "----------------"
cd "/c/Users/wzm/Searches/Desktop/fkqbkfj4sn-hue.github.io"
pwd
git status --short
echo ""

echo "3. 脚本状态:"
echo "----------------"
echo "start-research.sh: $(test -f start-research.sh && echo '✅ 存在' || echo '❌ 不存在')"
echo "end-research.sh: $(test -f end-research.sh && echo '✅ 存在' || echo '❌ 不存在')"
echo ""

echo "=== 结论 ==="
if [ -f "/c/Users/wzm/Searches/Desktop/开始科研工作.bat" ] && \
   [ -f "/c/Users/wzm/Searches/Desktop/结束科研工作.bat" ] && \
   [ -f "start-research.sh" ] && \
   [ -f "end-research.sh" ]; then
    echo "✅ 系统配置正确！"
    echo ""
    echo "🎉 你现在可以："
    echo "   早上双击：开始科研工作.bat"
    echo "   晚上双击：结束科研工作.bat"
else
    echo "⚠️  系统可能有问题，请检查上述输出"
fi
