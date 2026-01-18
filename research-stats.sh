#!/bin/bash

# ========================================
# 科研工作统计脚本
# ========================================

echo "========================================"
echo "📊 科研工作统计"
echo "========================================"

# 1. 今日工作统计
TODAY=$(date +"%Y-%m-%d")
echo "📅 今日 ($TODAY) 统计:"
echo "----------------------------------------"

# 今日提交次数
TODAY_COMMITS=$(git log --since="$TODAY 00:00:00" --until="$TODAY 23:59:59" --oneline | wc -l)
echo "提交次数: $TODAY_COMMITS"

# 今日更改文件数
TODAY_FILES=$(git log --since="$TODAY 00:00:00" --until="$TODAY 23:59:59" --name-only --pretty=format: | sort | uniq | grep -v "^$" | wc -l)
echo "更改文件数: $TODAY_FILES"

# 2. 本周工作统计
echo ""
echo "📅 本周统计:"
echo "----------------------------------------"

# 本周提交次数
WEEK_COMMITS=$(git log --since="$(date -d "last monday" +"%Y-%m-%d")" --oneline | wc -l)
echo "提交次数: $WEEK_COMMITS"

# 3. 自动保存系统状态
echo ""
echo "⚙️  系统状态:"
echo "----------------------------------------"

if [ -f ".research_auto_save.pid" ]; then
    PID=$(cat ".research_auto_save.pid")
    if kill -0 "$PID" 2>/dev/null; then
        echo "自动保存系统: ✅ 运行中 (PID: $PID)"
    else
        echo "自动保存系统: ❌ 进程不存在 (残留PID文件)"
    fi
else
    echo "自动保存系统: ❌ 未运行"
fi

if [ -f ".research_start_time.txt" ]; then
    START_TIME=$(cat ".research_start_time.txt")
    echo "开始时间: $START_TIME"
    
    # 计算已工作时间
    START_SECONDS=$(date -d "$START_TIME" +%s 2>/dev/null || echo "0")
    NOW_SECONDS=$(date +%s)
    
    if [ "$START_SECONDS" != "0" ]; then
        WORK_SECONDS=$((NOW_SECONDS - START_SECONDS))
        WORK_HOURS=$((WORK_SECONDS / 3600))
        WORK_MINUTES=$(( (WORK_SECONDS % 3600) / 60 ))
        echo "已工作时间: ${WORK_HOURS}小时${WORK_MINUTES}分钟"
    fi
fi

# 4. 工作日志
if [ -f "research-work-log.txt" ]; then
    echo ""
    echo "📖 工作日志摘要:"
    echo "----------------------------------------"
    tail -5 research-work-log.txt
fi

echo ""
echo "========================================"
echo "💡 提示:"
echo "  ./start-research.sh - 开始工作"
echo "  ./end-research.sh   - 结束工作"
echo "========================================"
