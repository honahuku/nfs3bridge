# nfs3bridge
NFS経由でS3にアクセスする  

```bash
docker build -t nfs3bridge .

docker run \
--privileged \
-p 2049:2049 \
-it --rm \
-e S3_BUCKET_NAME=hoge_bucket_name \
-e S3_ENDPOINT=https://ap-northeast-1.wasabisys.com \
-v /home/piyo/cred:/mnt/cred \
--name nfs3bridge-container nfs3bridge

sudo mount -t nfs 127.0.0.1:/mnt/s3 /mnt/nfs_share
sudo umount /mnt/nfs_share
```
