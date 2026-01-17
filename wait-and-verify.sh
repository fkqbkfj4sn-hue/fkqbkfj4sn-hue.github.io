#!/bin/bash
echo "=== GitHub Pages 重新构建验证 ==="
echo "开始时间: $(date)"
echo "最新提交: $(git log --oneline -1)"
echo ""

# 等待GitHub Pages构建
echo "⏳ 等待GitHub Pages重新构建..."
for i in {1..6}; do
    echo "等待 $((i*30)) 秒... ($i/6)"
    sleep 30
done

echo ""
echo "=== 开始验证 ==="

# 测试主页
echo "1. 测试主页访问..."
HOME_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -L --max-time 10 "https://fkqbkfj4sn-hue.github.io/")

if [ "$HOME_STATUS" = "200" ]; then
    echo "   ✅ 主页访问成功 (HTTP 200)"
    echo ""
    echo "🎉 恭喜！您的网站现在可以正常访问了！"
    echo "🌐 请立即在浏览器中访问："
    echo "   https://fkqbkfj4sn-hue.github.io/"
    echo ""
    echo "📱 建议在不同设备上测试："
    echo "   - 电脑浏览器"
    echo "   - 手机浏览器"
    echo "   - 平板电脑"
else
    echo "   ❌ 主页访问失败 (HTTP $HOME_STATUS)"
    echo ""
    echo "⚠️  可能的原因："
    echo "   - GitHub Pages仍在构建中（请再等待5分钟）"
    echo "   - 网络连接问题"
    echo "   - 浏览器缓存问题"
    echo ""
    echo "🔧 解决方案："
    echo "   1. 等待5分钟后重试"
    echo "   2. 强制刷新浏览器 (Ctrl+F5 或 Cmd+Shift+R)"
    echo "   3. 使用无痕模式访问"
    echo "   4. 使用手机网络（4G/5G）测试"
fi

echo ""
echo "=== 备用验证方法 ==="
echo "如果直接访问仍然失败，可以："
echo "1. 查看GitHub上的文件："
echo "   https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io/blob/main/index.html"
echo "2. 检查GitHub Pages构建状态："
echo "   https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io/actions"
echo "3. 检查GitHub Pages设置："
echo "   https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io/settings/pages"
echo "4. 使用在线网站状态检查："
echo "   https://downforeveryoneorjustme.com/fkqbkfj4sn-hue.github.io"
