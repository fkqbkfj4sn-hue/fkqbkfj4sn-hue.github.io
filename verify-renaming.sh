#!/bin/bash

echo "========================================"
echo "网站名称修改验证工具"
echo "验证所有HTML文件中的名称一致性"
echo "========================================"
echo ""

OLD_NAME="剩余劳动价值论研究数字中心"
NEW_NAME="剩余劳动价值论之数字实验中心"

echo "1. 检查是否还有旧名称残留..."
echo "----------------------------------------"
if grep -r "$OLD_NAME" *.html 2>/dev/null; then
    echo "❌ 发现旧名称残留！"
    echo "请检查以上文件并进行修改。"
else
    echo "✅ 未发现旧名称残留。"
fi
echo ""

echo "2. 检查新名称的使用情况..."
echo "----------------------------------------"
echo "包含新名称的文件列表："
grep -l "$NEW_NAME" *.html 2>/dev/null
echo ""

echo "3. 检查关键位置..."
echo "----------------------------------------"

# 检查页面标题
echo "页面标题检查："
for file in *.html; do
    if grep -q "<title>" "$file" 2>/dev/null; then
        title=$(grep -o '<title>[^<]*</title>' "$file" | sed 's/<title>//;s/<\/title>//')
        if echo "$title" | grep -q "$NEW_NAME"; then
            echo "✅ $file: 标题包含新名称"
        else
            echo "⚠️  $file: 标题可能需要更新"
        fi
    fi
done
echo ""

# 检查版权信息
echo "版权信息检查："
for file in *.html; do
    if grep -q "©.*吴忠明" "$file" 2>/dev/null; then
        if grep -q "©.*$NEW_NAME" "$file"; then
            echo "✅ $file: 版权信息已更新"
        else
            echo "⚠️  $file: 版权信息可能需要更新"
        fi
    fi
done

echo ""
echo "========================================"
echo "验证完成！"
echo "========================================"
