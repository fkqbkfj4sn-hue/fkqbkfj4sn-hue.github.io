#!/bin/bash

# ========================================
# 科研工作结束脚本（支持心得输入）
# ========================================

echo "========================================"
echo "🌙 科研工作结束"
echo "========================================"
echo "结束时间: $(date +'%Y-%m-%d %H:%M:%S')"
echo "========================================"

# 进程管理文件
PID_FILE=".research_auto_save.pid"
START_TIME_FILE=".research_start_time.txt"
WORK_LOG_FILE="research-work-log.txt"
SUMMARY_FILE="research-summary-$(date +'%Y-%m-%d').md"

# 1. 停止自动保存系统
echo "⏹️  停止自动保存系统..."
if [ -f "$PID_FILE" ]; then
    AUTO_SAVE_PID=$(cat "$PID_FILE")
    kill "$AUTO_SAVE_PID" 2>/dev/null
    sleep 2
    rm -f "$PID_FILE"
fi

# 清理可能的残留进程
pkill -f "research-auto-save.sh" 2>/dev/null

# 2. 记录工作时间
if [ -f "$START_TIME_FILE" ]; then
    START_TIME=$(cat "$START_TIME_FILE")
    END_TIME=$(date +'%Y-%m-%d %H:%M:%S')
    
    # 计算工作时间
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
    fi
    
    rm -f "$START_TIME_FILE"
fi

# 3. 询问是否要输入今日心得
echo ""
echo "📝 是否要记录今日科研心得？"
read -p "输入 y 写心得，直接回车跳过: " WRITE_SUMMARY

if [[ "$WRITE_SUMMARY" == "y" || "$WRITE_SUMMARY" == "Y" ]]; then
    echo ""
    echo "========================================"
    echo "请写下今日科研心得（完成后按 Ctrl+D 保存）："
    echo "========================================"
    echo ""
    
    # 创建心得文件头
    echo "# 科研工作心得 - $(date +'%Y-%m-%d')" > "$SUMMARY_FILE"
    echo "**工作时间**: $START_TIME - $END_TIME" >> "$SUMMARY_FILE"
    echo "**工作时长**: ${WORK_HOURS}小时${WORK_MINUTES}分钟" >> "$SUMMARY_FILE"
    echo "" >> "$SUMMARY_FILE"
    echo "## 今日心得" >> "$SUMMARY_FILE"
    echo "" >> "$SUMMARY_FILE"
    
    # 让用户输入多行文本（按 Ctrl+D 结束）
    echo "请输入内容（按 Ctrl+D 结束输入）："
    echo "----------------------------------------"
    while IFS= read -r line; do
        echo "$line" >> "$SUMMARY_FILE"
    done
    
    echo "----------------------------------------"
    echo "✅ 心得已保存到: $SUMMARY_FILE"
    
    # 添加到Git
    git add "$SUMMARY_FILE"
fi

# 4. 执行最终提交
echo ""
echo "💾 执行最终提交..."
git add -A

if git diff-index --quiet HEAD --; then
    echo "📭 没有需要提交的更改"
else
    TODAY=$(date +'%Y-%m-%d')
    COMMIT_MSG="科研工作结束: $TODAY"
    
    # 如果有写心得，在提交信息中注明
    if [ -f "$SUMMARY_FILE" ]; then
        COMMIT_MSG="$COMMIT_MSG (已记录心得)"
    fi
    
    git commit -m "$COMMIT_MSG"
    echo "✅ 最终提交完成: $COMMIT_MSG"
fi

# 5. 尝试推送到远程仓库
echo ""
echo "🚀 尝试推送到远程仓库..."
if git push origin main 2>/dev/null; then
    echo "✅ 已推送到远程仓库"
else
    echo "⚠️  推送失败，请稍后手动推送"
fi

# 6. 显示今日工作报告
echo ""
echo "📊 今日工作报告:"
echo "========================================"
git log --since="$(date +'%Y-%m-%d') 00:00:00" --until="$(date +'%Y-%m-%d') 23:59:59" --oneline --no-merges
echo "========================================"

# 7. 清理临时文件
echo ""
echo "🧹 清理临时文件..."
rm -f nul NUL 2>/dev/null

# 8. 显示心得文件位置（如果创建了）
if [ -f "$SUMMARY_FILE" ]; then
    echo ""
    echo "📖 今日心得文件: $(pwd)/$SUMMARY_FILE"
    echo "----------------------------------------"
    cat "$SUMMARY_FILE"
    echo "----------------------------------------"
fi

echo ""
echo "========================================"
echo "🎉 科研工作结束，好好休息！"
echo ""
echo "窗口将在10秒后自动关闭..."
echo "（按 Ctrl+C 可以立即关闭）"
echo "========================================"

# 等待后自动关闭
sleep 10
exit 0
