#!/bin/bash
# 每5分钟自动提交一次（仅本地）
while true; do
    if ! git diff --quiet; then
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        git add .
        git commit -m "自动保存: $timestamp" --no-verify
        echo "💾 自动保存于 $timestamp"
    fi
    sleep 300  # 5分钟
done
