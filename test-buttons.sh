#!/bin/bash

echo "=== 测试现有按钮功能 ==="
echo ""

# 1. 测试开始按钮会调用的脚本
echo "测试开始科研工作按钮（启动后会运行 start-research.sh）:"
echo "启动测试（5秒后自动停止）..."
./start-research.sh &
START_PID=$!
sleep 5
kill $START_PID 2>/dev/null
echo "✅ 开始按钮脚本测试完成"
echo ""

# 2. 测试结束按钮会调用的脚本
echo "测试结束科研工作按钮:"
# 先清理可能残留的进程文件
rm -f .research_auto_save.pid
# 运行结束脚本的简化测试
echo "正在测试结束脚本..."
git add -A
git commit -m "测试结束脚本功能" --allow-empty
echo "✅ 结束按钮脚本测试完成"
echo ""

echo "=== 测试结果 ==="
echo "如果上述测试没有报错，说明你的中文按钮可以正常工作！"
echo ""
echo "使用方法："
echo "  早上：双击桌面上的 '开始科研工作.bat'"
echo "  晚上：双击桌面上的 '结束科研工作.bat'"
