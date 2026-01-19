#!/bin/bash

echo "🌙 结束科研工作"
echo "================"

# 停止自动保存
pkill -f "research-auto-save.sh" 2>/dev/null
rm -f .research_auto_save.pid

# 询问是否记录心得
read -p "📝 记录今日心得? (y/N): " note_choice
if [[ "$note_choice" == "y" || "$note_choice" == "Y" ]]; then
    echo ""
    echo "请写下今日心得（完成后按 Ctrl+D）："
    echo "----------------------------------------"
    
    NOTE_FILE="note-$(date +'%Y%m%d').txt"
    echo "# 科研心得 $(date +'%Y-%m-%d')" > "$NOTE_FILE"
    echo "" >> "$NOTE_FILE"
    
    # 读取多行输入
    while IFS= read -r line; do
        echo "$line" >> "$NOTE_FILE"
    done
    
    echo "----------------------------------------"
    echo "✅ 心得已保存"
    
    # 添加到Git
    git add "$NOTE_FILE"
fi

# 保存工作
echo ""
echo "💾 正在保存工作..."
git add -A
git commit -m "结束: $(date +'%Y-%m-%d')"
echo "✅ 工作已保存"

echo ""
echo "🎉 完成！"
echo "窗口将在3秒后关闭..."
sleep 3
