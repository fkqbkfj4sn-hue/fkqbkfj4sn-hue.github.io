#!/bin/bash

echo "========================================"
echo "     RESEARCH WORK LAUNCHER"
echo "========================================"

# 设置环境
cd "$(dirname "$0")"

# 清理可能存在的 nul 文件
echo "1. 清理环境..."
rm -f nul NUL 2>/dev/null

# 备份当前脚本
echo "2. 备份当前状态..."
mkdir -p backups
timestamp=$(date +"%Y%m%d_%H%M%S" 2>/dev/null || echo "backup")
cp -f run-research.sh "backups/run-research.$timestamp.sh" 2>/dev/null

# 检查重要文件是否存在
echo "3. 检查重要文件..."
important_files=("auto-save.sh" "quick-check.sh" "verify-changes.sh")
for file in "${important_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "   ⚠️  缺少: $file"
        # 尝试从 Git 恢复
        if git checkout HEAD -- "$file" 2>/dev/null; then
            echo "   ✅ 已从 Git 恢复"
        fi
    else
        echo "   ✅ $file 存在"
    fi
done

# 禁用有问题的 auto_fixed.sh
if [ -f "auto_fixed.sh" ]; then
    echo "4. 检查 auto_fixed.sh..."
    if grep -q "> nul" auto_fixed.sh || grep -q "rm.*\.sh" auto_fixed.sh; then
        echo "   ⚠️  发现危险命令，禁用此脚本"
        mv auto_fixed.sh auto_fixed.sh.DISABLED
        echo "   ✅ 已禁用: auto_fixed.sh -> auto_fixed.sh.DISABLED"
    fi
fi

# 启动安全脚本
echo "5. 启动安全自动保存..."
echo "========================================"
chmod +x safe-auto-save.sh
./safe-auto-save.sh
