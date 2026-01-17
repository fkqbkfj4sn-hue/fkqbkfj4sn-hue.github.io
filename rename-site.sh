#!/bin/bash

echo "开始更新网站名称..."
echo "将'剩余劳动价值论研究数字中心'修改为'剩余劳动价值论之数字实验中心'"

# 修改所有HTML文件
for file in *.html; do
    if [ -f "$file" ]; then
        echo "处理文件: $file"
        # 使用sed进行替换
        sed -i 's/剩余劳动价值论研究数字中心/剩余劳动价值论之数字实验中心/g' "$file"
    fi
done

echo "修改完成！"
