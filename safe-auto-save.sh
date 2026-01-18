#!/bin/bash

# 安全自动保存脚本 - 不会删除文件，不会创建 nul

echo "========================================"
echo "      SAFE AUTO-SAVE SYSTEM"
echo "========================================"

# 设置环境
export GIT_CONFIG_SYSTEM=/dev/null
export GIT_CONFIG_GLOBAL=/dev/null

# 清理可能的 nul 文件
cleanup_nul() {
    if [ -f "nul" ]; then
        echo "清理: 删除 nul 文件"
        rm -f nul 2>/dev/null
        cmd //c "del \\.\\nul" 2>/dev/null || true
    fi
}

# 主循环
while true; do
    # 每次循环前清理
    cleanup_nul
    
    # 获取时间戳（跨平台）
    if command -v powershell >/dev/null 2>&1; then
        timestamp=$(powershell -Command "Get-Date -Format 'HH:mm:ss'")
    else
        timestamp=$(date +"%H:%M:%S")
    fi
    
    echo "[$timestamp] 检查Git状态..."
    
    # 检查更改
    changes=$(git status --porcelain)
    
    if [ -n "$changes" ]; then
        echo "[$timestamp] 发现更改，正在保存..."
        
        # 安全地添加文件（避免 nul）
        git add . 2>/dev/null
        
        # 提交
        if git commit -m "自动保存: $(date)" 2>/dev/null; then
            echo "[$timestamp] 保存成功"
        else
            echo "[$timestamp] 保存失败"
        fi
    else
        echo "[$timestamp] 无更改"
    fi
    
    # 等待5分钟
    sleep 300
done
