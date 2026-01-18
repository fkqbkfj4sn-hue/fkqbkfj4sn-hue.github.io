#!/bin/bash

# 安全自动保存脚本 - 不会删除文件，不会创建 nul
# 跨平台兼容

echo "========================================"
echo "       RESEARCH WORK - SAFE MODE"
echo "========================================"
echo ""
echo "Starting SAFE auto-save system..."
echo "This script will NOT delete any files."
echo "Press Ctrl+C to stop."
echo ""
echo "========================================"
echo "🧠 科研工作自动保存系统 (安全模式)"
echo "========================================"
echo "📁 工作目录: $(pwd)"
echo "🔄 开始自动保存（每5分钟一次）..."
echo "========================================"

# 跨平台时间戳函数
get_timestamp() {
    # 尝试多种方法获取时间戳
    if command -v powershell >/dev/null 2>&1; then
        powershell -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"
    elif command -v python >/dev/null 2>&1; then
        python -c "import datetime; print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))"
    elif command -v node >/dev/null 2>&1; then
        node -e "console.log(new Date().toISOString().replace('T', ' ').substr(0, 19))"
    else
        # 最后的方法
        date "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "unknown-time"
    fi
}

# 清理 nul 文件
clean_nul_files() {
    if [ -f "nul" ] || [ -f "NUL" ]; then
        echo "⚠️  发现特殊文件，正在清理..."
        # 尝试不同方法删除
        rm -f nul NUL 2>/dev/null
        cmd //c "del \\.\\nul" 2>/dev/null 2>&1
        cmd //c "del \\.\\NUL" 2>/dev/null 2>&1
    fi
}

# 备份重要文件
backup_scripts() {
    timestamp=$(get_timestamp | tr ' :' '__')
    mkdir -p backups
    
    for script in *.sh; do
        if [ -f "$script" ] && [ "$script" != "safe-auto-save.sh" ]; then
            cp "$script" "backups/${script}.backup.${timestamp}" 2>/dev/null
        fi
    done
}

# 主循环
counter=0
while true; do
    counter=$((counter + 1))
    
    # 每次循环前清理
    clean_nul_files
    
    # 获取时间戳
    timestamp=$(get_timestamp)
    
    echo ""
    echo "[$timestamp] 第 $counter 次检查..."
    
    # 定期备份
    if [ $((counter % 12)) -eq 0 ]; then  # 每小时备份一次
        echo "[$timestamp] 💾 定期备份脚本..."
        backup_scripts
    fi
    
    # 检查 Git 状态
    changes=$(git status --porcelain 2>/dev/null)
    
    if [ -n "$changes" ]; then
        echo "[$timestamp] 📝 发现更改..."
        
        # 显示更改摘要
        echo "$changes" | head -5 | while read line; do
            echo "    $line"
        done
        
        if [ $(echo "$changes" | wc -l) -gt 5 ]; then
            echo "    ... 还有更多更改"
        fi
        
        # 添加文件（使用安全重定向）
        git add . > /dev/null 2>&1
        
        # 提交
        if git commit -m "自动保存: $timestamp" > /dev/null 2>&1; then
            echo "[$timestamp] ✅ 更改已保存"
        else
            echo "[$timestamp] ❌ 提交失败"
            # 显示详细错误
            git status
        fi
    else
        echo "[$timestamp] 📭 无更改"
    fi
    
    # 显示下一次检查时间
    next_time=$(date -d "5 minutes" "+%H:%M" 2>/dev/null || echo "未知")
    echo "[$timestamp] ⏰ 下次检查: $next_time"
    
    # 等待5分钟
    echo "等待5分钟..."
    for i in {1..300}; do
        sleep 1
        # 每60秒显示一个点
        if [ $((i % 60)) -eq 0 ]; then
            echo -n "."
        fi
    done
    echo ""
done
