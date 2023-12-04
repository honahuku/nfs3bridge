#!/usr/bin/env bash
set -CEeuo pipefail

set -x

# credentialをコピー
cp /mnt/cred/credentials /root/.aws/

# syslogを記録する
# ログは /var/log/syslog に
rsyslogd

# S3バケットをマウント
goofys --endpoint "$S3_ENDPOINT" "$S3_BUCKET_NAME" /mnt/s3

# RPCバインドサービスの起動
/usr/sbin/rpcbind -w

# NFS-Ganeshaサービスの起動
/usr/bin/ganesha.nfsd -F -f /etc/ganesha/ganesha.conf

# コンテナが終了しないようにする
# tail -f /dev/null
