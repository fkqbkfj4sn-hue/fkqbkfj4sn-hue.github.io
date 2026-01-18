#!/bin/bash

# 科研工作自动保存系统
# 修复版本 - 跨平台兼容

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
echo "📁 工作目录: $(pwd)"
echo "🔄 开始自动保存（每5分钟一次）..."
echo "按 Ctrl+C 停止"
echo "========================================"

# 跨平台日期函数
get_timestamp() {
    if command -v powershell >/dev/null 2>&1; then
        powershell -Command "Get-Date -Format 'yyyy-MM-dd_HHmmss'"
    elif command -v date >/dev/null 2>&1; then
        date +"%Y-%m-%d_%H%M%S"
    else
        # 最后的方法：使用当前时间（Windows CMD风格）
        echo "$(echo %date%_%time% | tr -d '[:space:]' | tr '/:' '-')"
    fi
}

# 确保不创建 nul 文件
# 修复重定向，使用 /dev/null 而不是 nul
redirect_to_null() {
    # 在 Windows Git Bash 中使用 /dev/null
    > /dev/null 2>&1
}

# 主循环
while true; do
    timestamp=$(get_timestamp)
    
    # Git 自动保存
    echo "[$timestamp] 检查更改..."
    
    # 确保没有未完成的 nul 文件
    if [ -f "nul" ]; then
        echo "警告：发现 nul 文件，正在删除..."
        rm -f nul
    fi
    
    # 检查是否有更改
    if git status --porcelain | grep -q .; then
        echo "[$timestamp] 💾 发现更改，正在提交..."
        
        # 避免创建 nul 文件
        git add . > /dev/null 2>&1
        
        # 提交
        git commit -m "自动保存: $timestamp" > /dev/null 2>&1
        
        if [ $? -eq 0 ]; then
            echo "[$timestamp] ✅ 已保存更改"
        else
            echo "[$timestamp] ⚠️  提交失败"
        fi
    else
        echo "[$timestamp] 📭 无更改"
    fi
    
    # 等待5分钟（300秒）
    echo "[$timestamp] ⏳ 等待5分钟..."
    sleep 300
done
