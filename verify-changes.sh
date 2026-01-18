#!/bin/bash

echo "=== 修改验证 ==="
echo ""

echo "1. 检查是否还有'吴忠明教授'字样："
if grep -rI "吴忠明教授" *.html 2>/dev/null; then
    echo "❌ 发现'吴忠明教授'字样残留"
else
    echo "✅ 已完全移除'吴忠明教授'字样"
fi

echo ""
echo "2. 检查研究概述："
if grep -I -q "本数字实验中心系统整理了关于剩余劳动价值论的完整研究历程" index.html; then
    echo "✅ 研究概述已更新"
    echo "   内容："
    grep "本数字实验中心系统整理了关于剩余劳动价值论的完整研究历程" index.html
else
    echo "❌ 研究概述未更新"
fi

echo ""
echo "3. 检查副标题："
if grep -I -q "基于《资本论》模型与世界银行数据库的科研平台" index.html; then
    echo "✅ 副标题已更新"
    echo "   内容："
    grep "基于《资本论》模型与世界银行数据库的科研平台" index.html
else
    echo "❌ 副标题未更新"
    echo "   当前副标题："
    grep -n "基于" index.html | grep -i "平台\|存档"
fi

echo ""
echo "4. 检查网站名称一致性："
echo "   包含'剩余劳动价值论之数字实验中心'的文件："
grep -lI "剩余劳动价值论之数字实验中心" *.html 2>/dev/null
