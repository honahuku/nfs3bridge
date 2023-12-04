# 基本イメージ
FROM ubuntu:22.04

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    wget \
    fuse \
    nfs-ganesha \
    nfs-ganesha-vfs \
    rpcbind \
    rsyslog \
    && rm -rf /var/lib/apt/lists/*

# goofysのインストール
# s3をマウントするやつ
RUN wget https://github.com/kahing/goofys/releases/latest/download/goofys \
    && chmod +x goofys \
    && mv goofys /usr/local/bin/

# s3のマウントポイントを設定
RUN mkdir /mnt/s3

# credential用のディレクトリを作成
RUN mkdir -p /root/.aws

# NFSサーバーの設定
COPY ganesha.conf /etc/ganesha/ganesha.conf

# コンテナ起動時に実行するコマンド
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# TODO: 終了処理
