#!/bin/bash

echo "=== 简单清理：只删除英文按钮 ==="

# 桌面路径
DESKTOP="/c/Users/wzm/Searches/Desktop"

# 要删除的文件列表
TO_DELETE=(
  "end_research.bat"
  "end_fixed.bat"
  "start_research.bat"
  "start_fixed.bat"
  "end_research.lnk"
  "end_fixed.lnk"
)

echo "正在清理桌面..."
for file in "${TO_DELETE[@]}"; do
    if [ -f "$DESKTOP/$file" ]; then
        echo "删除: $file"
        rm -f "$DESKTOP/$file"
    fi
done

echo ""
echo "✅ 清理完成！"
echo ""
echo "现在桌面上应该只有："
echo "  1. 开始科研工作.bat"
echo "  2. 结束科研工作.bat"
echo ""
echo "如果还有问题文件，请手动删除。"
