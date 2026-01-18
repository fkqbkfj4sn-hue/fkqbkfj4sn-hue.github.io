#!/bin/bash

# ========================================
# 科研工作结束脚本
# 晚上结束工作时运行此脚本
# ========================================

echo "========================================"
echo "🌙 科研工作结束"
echo "========================================"
echo "结束时间: $(date +"%Y-%m-%d %H:%M:%S")"
echo "========================================"

# 进程管理文件
PID_FILE=".research_auto_save.pid"
START_TIME_FILE=".research_start_time.txt"
WORK_LOG_FILE="research-work-log.txt"

# 1. 停止自动保存系统
if [ -f "$PID_FILE" ]; then
    AUTO_SAVE_PID=$(cat "$PID_FILE")
    
    if kill -0 "$AUTO_SAVE_PID" 2>/dev/null; then
        echo "⏹️  停止自动保存系统 (PID: $AUTO_SAVE_PID)..."
        kill "$AUTO_SAVE_PID"
        
        # 等待进程完全停止
        sleep 2
        
        if kill -0 "$AUTO_SAVE_PID" 2>/dev/null; then
            echo "强制停止进程..."
            kill -9 "$AUTO_SAVE_PID" 2>/dev/null
        fi
        
        echo "✅ 自动保存系统已停止"
    else
        echo "⚠️  自动保存系统未运行"
    fi
    
    # 删除PID文件
    rm -f "$PID_FILE"
else
    echo "⚠️  没有找到自动保存系统的进程记录"
fi

# 2. 记录工作时间
if [ -f "$START_TIME_FILE" ]; then
    START_TIME=$(cat "$START_TIME_FILE")
    END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    
    # 计算工作时间（简单版本）
    START_SECONDS=$(date -d "$START_TIME" +%s 2>/dev/null || echo "0")
    END_SECONDS=$(date -d "$END_TIME" +%s 2>/dev/null || echo "0")
    
    if [ "$START_SECONDS" != "0" ] && [ "$END_SECONDS" != "0" ]; then
        WORK_SECONDS=$((END_SECONDS - START_SECONDS))
        WORK_HOURS=$((WORK_SECONDS / 3600))
        WORK_MINUTES=$(( (WORK_SECONDS % 3600) / 60 ))
        
        echo "⏱️  工作时间统计:"
        echo "   开始: $START_TIME"
        echo "   结束: $END_TIME"
        echo "   时长: ${WORK_HOURS}小时${WORK_MINUTES}分钟"
        
        # 保存到工作日志
        echo "---" >> "$WORK_LOG_FILE"
        echo "日期: $(date +"%Y-%m-%d")" >> "$WORK_LOG_FILE"
        echo "开始: $START_TIME" >> "$WORK_LOG_FILE"
        echo "结束: $END_TIME" >> "$WORK_LOG_FILE"
        echo "时长: ${WORK_HOURS}小时${WORK_MINUTES}分钟" >> "$WORK_LOG_FILE"
        echo "提交次数: $(git log --since="$START_TIME" --until="$END_TIME" --oneline | wc -l)" >> "$WORK_LOG_FILE"
        echo "" >> "$WORK_LOG_FILE"
    fi
    
    # 删除开始时间文件
    rm -f "$START_TIME_FILE"
fi

# 3. 执行最终提交
echo ""
echo "💾 执行最终提交..."
git add -A

# 检查是否有更改
if git diff-index --quiet HEAD --; then
    echo "📭 没有需要提交的更改"
else
    # 获取今天的日期作为提交信息
    TODAY=$(date +"%Y-%m-%d")
    COMMIT_MSG="科研工作结束: $TODAY"
    
    git commit -m "$COMMIT_MSG"
    echo "✅ 最终提交完成: $COMMIT_MSG"
fi

# 4. 可选：推送到远程仓库
echo ""
read -p "🚀 是否推送到远程仓库? (y/n): " PUSH_CHOICE
if [[ "$PUSH_CHOICE" == "y" || "$PUSH_CHOICE" == "Y" ]]; then
    echo "正在推送到远程仓库..."
    git push origin main
    if [ $? -eq 0 ]; then
        echo "✅ 已推送到远程仓库"
    else
        echo "⚠️  推送失败，请手动检查"
    fi
else
    echo "⏭️  跳过推送，更改仅保存在本地"
fi

# 5. 生成今日工作报告
echo ""
echo "📊 今日工作报告:"
echo "========================================"
git log --since="$(date +"%Y-%m-%d") 00:00:00" --until="$(date +"%Y-%m-%d") 23:59:59" --oneline --no-merges
echo "========================================"

# 6. 清理临时文件
echo ""
echo "🧹 清理临时文件..."
rm -f nul NUL 2>/dev/null

echo ""
echo "🎉 科研工作结束，好好休息！"
echo "========================================"
