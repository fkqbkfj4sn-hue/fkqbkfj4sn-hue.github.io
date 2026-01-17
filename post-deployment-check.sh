#!/bin/bash
echo "=== 部署后检查 ==="
echo "1. 检查本地文件..."
ls -la *.html | wc -l
echo "个HTML文件"

echo ""
echo "2. 检查Git状态..."
git status

echo ""
echo "3. 查看最新提交..."
git log --oneline -3

echo ""
echo "4. 检查远程同步..."
git remote show origin | head -20

echo ""
echo "5. 建议的后续步骤："
echo "   - 等待5-30分钟让GitHub Pages完成部署"
echo "   - 访问 https://fkqbkfj4sn-hue.github.io/"
echo "   - 如果遇到问题，检查 https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io/settings/pages"
echo "   - 查看部署日志：https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io/actions"
