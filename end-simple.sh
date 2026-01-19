#!/bin/bash

echo "🌙 结束科研工作..."

# 停止自动保存
pkill -f "research-auto-save.sh" 2>/dev/null
rm -f .research_auto_save.pid .research_start_time.txt

# 保存工作
git add -A
git commit -m "结束工作: $(date +'%Y-%m-%d %H:%M')" --allow-empty

echo ""
echo "✅ 工作已保存"
echo ""
echo "窗口将在3秒后关闭..."
sleep 3
