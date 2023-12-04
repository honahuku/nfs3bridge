#!/usr/bin/env bash
set -Cu

# 最大リトライ回数
max_retries=5

# 現在のリトライ回数
retry_count=0

while [ $retry_count -lt $max_retries ]; do
    # crm status コマンドを実行
    output=$(crm status 2>&1)

    # エラーが含まれているかチェック
    if echo "$output" | grep -q "ERROR"; then
        # エラーがある場合、5秒待機
        echo "pacemaker waiting..."
        sleep 5
        # リトライ回数を増やす
        retry_count=$((retry_count+1))
    else
        # 成功した場合、スクリプトを正常終了
        echo "pacemaker is Online !!"
        exit 0
    fi
done

# リトライ回数が最大に達した場合、エラーで終了
exit 1
