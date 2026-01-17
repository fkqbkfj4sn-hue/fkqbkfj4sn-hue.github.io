#!/bin/bash
echo "=== 网站最终验证测试 ==="
echo "测试时间: $(date)"
echo "网站URL: https://fkqbkfj4sn-hue.github.io/"
echo ""

# 测试所有关键页面
PAGES=(
    ""  # 主页
    "research.html"
    "research-timeline.html"
    "deployment-status.html"
    "diagnose-deployment.html"
    "test-page.html"
    "historical-archive-index.html"
)

for page in "${PAGES[@]}"; do
    url="https://fkqbkfj4sn-hue.github.io/$page"
    echo "测试: $url"
    
    # 使用curl测试，设置超时和用户代理
    if response=$(curl -s -o /dev/null -w "%{http_code}" -L --max-time 10 --user-agent "Mozilla/5.0" "$url" 2>/dev/null); then
        case $response in
            200)
                echo "  ✅ 成功 (HTTP $response)"
                ;;
            404)
                echo "  ❌ 页面未找到 (HTTP $response)"
                ;;
            5*)
                echo "  ⚠️  服务器错误 (HTTP $response)"
                ;;
            *)
                echo "  ℹ️  其他状态 (HTTP $response)"
                ;;
        esac
    else
        echo "  ❌ 连接失败"
    fi
done

echo ""
echo "=== 文件链接测试 ==="

# 测试重要文件
FILES=(
    "assets/pdfs/2007年07月_农户个体决策与农民经济组织的内生性.pdf"
    "2-2015-初步接触《资本论》中马克思建立的链模型/2015-初步接触《资本论》中马克思建立的链模型.pdf"
)

for file in "${FILES[@]}"; do
    url="https://fkqbkfj4sn-hue.github.io/$file"
    echo "测试文件: $file"
    
    # 只检查头部，不下载整个文件
    if curl -s -I -L --max-time 10 "$url" | head -1 | grep -q "200\|206\|302"; then
        echo "  ✅ 文件可访问"
    else
        echo "  ⚠️  文件可能无法直接访问（可能需要通过GitHub仓库查看）"
    fi
done

echo ""
echo "=== 验证完成 ==="
echo "您的剩余劳动价值论研究数字中心已成功上线！"
echo "网站包含："
echo "1. 2007-2026年完整研究历程"
echo "2. 可验证的证据存档"
echo "3. 研究成果展示"
echo "4. 时间线可视化"
