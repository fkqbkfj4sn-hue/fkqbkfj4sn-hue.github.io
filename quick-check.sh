#!/bin/bash
echo "=== 快速检查修改结果 ==="
echo ""
echo "1. 检查所有文件标题是否包含新名称："
for file in *.html; do
    if grep -I -q "剩余劳动价值论之数字实验中心" "$file" 2>/dev/null; then
        echo "✅ $file: 包含新名称"
    else
        echo "⚠️  $file: 可能需要更新"
    fi
done

echo ""
echo "2. 检查index.html关键修改："
echo "   副标题:"
grep "基于《资本论》模型与世界银行数据库的科研平台" index.html && echo "✅ 副标题已更新" || echo "❌ 副标题未更新"
echo ""
echo "   研究概述:"
grep "本数字实验中心系统整理了关于剩余劳动价值论的完整研究历程" index.html && echo "✅ 研究概述已更新" || echo "❌ 研究概述未更新"

echo ""
echo "3. 检查是否有旧名称残留："
if grep -rI "剩余劳动价值论研究数字中心" *.html 2>/dev/null; then
    echo "❌ 发现旧名称残留"
else
    echo "✅ 未发现旧名称残留"
fi
