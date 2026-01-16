#!/bin/bash
echo "🚀 提交研究成果 🚀"
echo "======================================"
echo "当前修改的文件："
git status --short
echo ""
echo "请输入本次提交的说明："
read -p "> " commit_msg
echo ""
echo "正在提交：\"$commit_msg\""
echo ""
# 添加所有更改
git add .
# 提交更改
git commit -m "$commit_msg"
# 推送到GitHub
git push origin main
echo ""
echo "✅ 提交成功！"
echo "🌐 在线查看：https://fkqbkfj4sn-hue.github.io"
echo "📊 GitHub仓库：https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io"
echo "======================================"
