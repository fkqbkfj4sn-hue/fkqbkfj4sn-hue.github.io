#!/bin/bash
# 监控特殊文件，防止问题重现

echo "启动特殊文件监控..."
echo "监控的文件：nul, NUL, con, aux, prn"
echo "按 Ctrl+C 停止监控"
echo "========================================"

while true; do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # 检查危险文件
    found_files=""
    for file in nul NUL con aux prn; do
        if [ -e "$file" ]; then
            found_files="$found_files $file"
            echo "[$timestamp] ⚠️  发现危险文件: $file"
            echo "正在删除 $file..."
            rm -f "$file"
        fi
    done
    
    if [ -n "$found_files" ]; then
        echo "[$timestamp] ✅ 已清理文件:$found_files"
    fi
    
    # 每分钟检查一次
    sleep 60
done
