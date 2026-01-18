#!/bin/bash

# ========================================
# 科研工作启动脚本
# 早上开始工作时运行此脚本
# ========================================

echo "========================================"
echo "🌅 科研工作开始"
echo "========================================"
echo "开始时间: $(date +"%Y-%m-%d %H:%M:%S")"
echo "========================================"

# 创建进程ID文件
PID_FILE=".research_auto_save.pid"

# 检查是否已经在运行
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "⚠️  自动保存系统已经在运行 (PID: $OLD_PID)"
        echo "如果要重启，请先运行: ./end-research.sh"
        exit 1
    else
        # 进程不存在，删除旧的PID文件
        rm -f "$PID_FILE"
    fi
fi

# 清理可能的残留文件
echo "🧹 清理工作环境..."
rm -f nul NUL 2>/dev/null

# 启动自动保存脚本
echo "🔄 启动自动保存系统..."
./research-auto-save.sh &
AUTO_SAVE_PID=$!

# 保存进程ID
echo $AUTO_SAVE_PID > "$PID_FILE"
echo "✅ 自动保存系统已启动 (PID: $AUTO_SAVE_PID)"

# 创建开始时间记录
echo "$(date +"%Y-%m-%d %H:%M:%S")" > .research_start_time.txt

echo ""
echo "📝 工作说明:"
echo "1. 自动保存系统每5分钟自动提交一次"
echo "2. 所有更改会保存到本地Git仓库"
echo "3. 晚上结束时运行: ./end-research.sh"
echo ""
echo "💡 提示: 保持此终端窗口打开"
echo "========================================"
