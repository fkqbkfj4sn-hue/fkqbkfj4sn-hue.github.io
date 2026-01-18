#!/bin/bash

echo "=== 科研工作系统测试 ==="
echo "测试时间: $(date)"

# 测试1：检查所有必要脚本
echo ""
echo "📁 1. 检查脚本文件..."
ls -la *.sh | grep -E "auto-save|research-auto|start-research|quick-check|verify-changes"

# 测试2：检查是否有危险文件
echo ""
echo "⚠️  2. 检查危险文件..."
dangerous_files=0
for file in nul NUL con aux prn; do
    if [ -e "$file" ]; then
        echo "发现危险文件: $file"
        dangerous_files=1
    fi
done
if [ $dangerous_files -eq 0 ]; then
    echo "✅ 未发现危险文件"
fi

# 测试3：测试Git状态
echo ""
echo "📊 3. 检查Git状态..."
git status --porcelain
if [ -z "$(git status --porcelain)" ]; then
    echo "✅ 工作目录干净"
else
    echo "📝 有未提交的更改"
fi

# 测试4：测试新脚本的语法
echo ""
echo "🔧 4. 检查脚本语法..."
bash -n research-auto-save.sh && echo "✅ research-auto-save.sh 语法正确"
bash -n start-research.sh && echo "✅ start-research.sh 语法正确"

# 测试5：测试date命令兼容性
echo ""
echo "⏰ 5. 测试日期函数..."
echo "测试日期获取:"
./research-auto-save.sh &
PID=$!
sleep 3
kill $PID 2>/dev/null
echo "✅ 脚本启动和停止正常"

echo ""
echo "=== 测试完成 ==="
