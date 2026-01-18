#!/bin/bash

# ========================================
# 科研工作自动保存系统 (安全版本)
# ========================================

# 工作目录
WORK_DIR="$(pwd)"

# 设置退出信号处理
cleanup() {
    echo "自动保存系统正在停止..."
    # 清理PID文件（如果存在）
    if [ -f ".research_auto_save.pid" ]; then
        rm -f ".research_auto_save.pid"
    fi
    exit 0
}

trap cleanup INT TERM EXIT

# 跨平台兼容的日期函数
get_timestamp() {
    if command -v powershell >/dev/null 2>&1; then
        powershell -Command "Get-Date -Format 'yyyy-MM-dd_HHmmss'"
    elif command -v date >/dev/null 2>&1; then
        date +"%Y-%m-%d_%H%M%S"
    else
        # 使用Bash内置功能
        printf "%(%Y-%m-%d_%H%M%S)T"
    fi
}

# 安全检查：删除可能存在的nul文件
safety_check() {
    local dangerous_files=("nul" "NUL" "con" "aux" "prn")
    for file in "${dangerous_files[@]}"; do
        if [ -f "$file" ]; then
            echo "⚠️  警告：发现危险文件 '$file'，正在删除..."
            rm -f "$file"
        fi
    done
}

# 自动保存函数
auto_save() {
    # 运行安全检查
    safety_check
    
    # 获取时间戳
    timestamp=$(get_timestamp)
    echo "[$(date +"%H:%M:%S")] ⏰ 自动保存..."
    
    # Git操作
    git add -A
    if git commit -m "自动保存: $timestamp" --allow-empty >/dev/null 2>&1; then
        echo "[$(date +"%H:%M:%S")] ✅ 保存成功"
    else
        # 没有需要保存的更改
        echo -n "."
    fi
}

# 主程序
main() {
    echo "========================================"
    echo "       RESEARCH WORK - START"
    echo "========================================"
    echo ""
    echo "Starting auto-save system..."
    echo "Please keep this window open."
    echo "Press Ctrl+C in the Bash window to stop."
    echo ""
    echo "========================================"
    echo "🧠 科研工作自动保存系统启动"
    echo "========================================"
    echo "📁 工作目录: $WORK_DIR"
    echo "🔄 开始自动保存（每5分钟一次）..."
    echo "按 Ctrl+C 停止"
    echo "========================================"
    
    # 主循环
    while true; do
        auto_save
        # 等待5分钟（300秒）
        sleep 300
    done
}

# 运行主程序
main
