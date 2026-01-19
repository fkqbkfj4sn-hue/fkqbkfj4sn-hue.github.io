#!/bin/bash

echo "📝 记录科研心得"
echo "=============="

# 创建心得目录
mkdir -p research-summaries

# 生成文件名
FILENAME="research-summaries/$(date +'%Y-%m-%d').md"

echo "心得将保存到: $FILENAME"
echo ""
echo "请输入今日心得（按 Ctrl+D 结束输入）："
echo "----------------------------------------"

# 创建文件头
echo "# $(date +'%Y年%m月%d日') 科研心得" > "$FILENAME"
echo "" >> "$FILENAME"
echo "**记录时间**: $(date +'%H:%M:%S')" >> "$FILENAME"
echo "" >> "$FILENAME"

# 输入内容
cat >> "$FILENAME"

echo "----------------------------------------"
echo "✅ 心得已保存！"
echo ""
echo "内容预览："
echo "----------------------------------------"
cat "$FILENAME"
echo "----------------------------------------"

# 添加到Git
git add "$FILENAME"
git commit -m "添加科研心得: $(date +'%Y-%m-%d')"

echo ""
echo "🎉 完成！心得已保存并提交"
