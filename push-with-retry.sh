#!/bin/bash
MAX_RETRIES=10
RETRY_COUNT=0
WAIT_TIME=30

echo "开始推送重试机制..."

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    echo "尝试第 $((RETRY_COUNT+1)) 次推送..."
    
    # 尝试推送
    if git push origin main; then
        echo "✅ 推送成功！"
        exit 0
    else
        RETRY_COUNT=$((RETRY_COUNT+1))
        if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
            echo "❌ 达到最大重试次数 ($MAX_RETRIES)"
            echo "尝试备用方案..."
            
            # 备用方案1：使用更简单的推送
            echo "尝试轻量推送..."
            git push --thin origin main
            
            # 如果还是失败，输出错误并退出
            if [ $? -ne 0 ]; then
                echo "所有推送尝试失败。"
                exit 1
            fi
        else
            echo "推送失败，等待 ${WAIT_TIME} 秒后重试..."
            sleep $WAIT_TIME
            # 增加等待时间
            WAIT_TIME=$((WAIT_TIME * 2))
        fi
    fi
done
