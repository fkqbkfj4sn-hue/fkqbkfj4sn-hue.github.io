#!/bin/bash

echo "停止所有研究脚本..."
pkill -f "safe-auto-save.sh" 2>/dev/null
pkill -f "auto_fixed.sh" 2>/dev/null

echo "清理临时文件..."
rm -f nul NUL 2>/dev/null

echo "备份当前状态..."
mkdir -p backups
if [ -f safe-auto-save.sh ]; then
    cp safe-auto-save.sh "backups/safe-auto-save.$(date +%Y%m%d_%H%M%S).sh" 2>/dev/null
fi

echo "✅ 所有脚本已停止"
echo ""
echo "要重新启动，运行: ./run-research.sh"
