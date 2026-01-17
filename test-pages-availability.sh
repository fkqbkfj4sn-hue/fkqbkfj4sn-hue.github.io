#!/bin/bash
echo "=== GitHub Pages可用性测试 ==="
echo "测试时间: $(date)"
echo ""

URLS=(
    "https://fkqbkfj4sn-hue.github.io/"
    "https://fkqbkfj4sn-hue.github.io/deployment-status.html"
    "https://fkqbkfj4sn-hue.github.io/diagnose-deployment.html"
    "https://fkqbkfj4sn-hue.github.io/test-page.html"
)

for url in "${URLS[@]}"; do
    echo "测试: $url"
    # 尝试获取HTTP状态码
    if status_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url" 2>/dev/null); then
        case $status_code in
            200|201|202|203|204|205|206)
                echo "  ✅ 状态码: $status_code"
                ;;
            3*)
                echo "  🔄 重定向: $status_code"
                ;;
            4*)
                echo "  ⚠️  客户端错误: $status_code"
                ;;
            5*)
                echo "  ❌ 服务器错误: $status_code"
                ;;
            *)
                echo "  ❓ 未知状态: $status_code"
                ;;
        esac
    else
        echo "  ❌ 连接失败 (可能仍在部署中)"
    fi
done

echo ""
echo "=== 测试完成 ==="
echo "注意: 如果所有页面都返回连接失败，请等待5-10分钟再试。"
echo "GitHub Pages首次部署可能需要较长时间。"
