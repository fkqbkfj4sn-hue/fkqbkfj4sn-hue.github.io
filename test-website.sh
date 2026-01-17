#!/bin/bash
echo "=== 网站功能完整性测试 ==="
echo "测试时间: $(date)"
echo ""

# 测试所有主要页面
pages=("index.html" "research.html" "research-timeline.html" "historical-archive-index.html" "test-page.html")
for page in "${pages[@]}"; do
    echo "测试: $page"
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://fkqbkfj4sn-hue.github.io/$page")
    if [ "$status" = "200" ]; then
        echo "  ✅ 状态码: $status (成功)"
    else
        echo "  ❌ 状态码: $status (失败)"
    fi
done

echo ""
echo "=== 文件链接测试 ==="

# 测试关键文件下载
files=("assets/pdfs/2007年07月_农户个体决策与农民经济组织的内生性.pdf" 
       "2-2015-初步接触《资本论》中马克思建立的链模型/2015-初步接触《资本论》中马克思建立的链模型.pdf")

for file in "${files[@]}"; do
    # 对URL进行编码
    encoded_file=$(echo "$file" | sed 's/ /%20/g')
    echo "测试文件: $file"
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://fkqbkfj4sn-hue.github.io/$encoded_file")
    if [ "$status" = "200" ]; then
        echo "  ✅ 状态码: $status (文件可访问)"
    else
        echo "  ❌ 状态码: $status (文件不可访问)"
    fi
done

echo ""
echo "=== 测试完成 ==="
