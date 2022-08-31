#/bin/bash

# CONFIG="~/.config/rclone/rclone.conf"
#   --config=${CONFIG} \

DIR_PREFIX="/HDD/rclone/"

STORAGE_LIST=(Onedrive-hanyang Onedrive-naver Googledrive-hanyang Googledrive-gmail)


# install rclone
curl https://rclone.org/install.sh | sudo bash

mkdir -p ${DIR_PREFIX}/cache
# mount storage
for name in ${STORAGE_LIST[@]}
do
  echo "mount start ${name}"
  mkdir ${DIR_PREFIX}/${name}
  rclone mount ${name}:/ ${DIR_PREFIX}/mount/${name} \
  --allow-other \
  --allow-non-empty \
  --fast-list \
  --drive-skip-gdocs \
  --poll-interval=15s \
  --vfs-cache-mode=full \
  --vfs-write-back=5s \
  --bwlimit-file=16M \
  --buffer-size=16M \
  --vfs-read-chunk-size=32M \
  --vfs-read-chunk-size-limit=2048M \
  --vfs-cache-max-size=1G \
  --vfs-cache-max-age=336h \
  --vfs-read-ahead=32M \
  --dir-cache-time=1000h \
  --log-level=ERROR  \
  --log-file=${DIR_PREFIX}/rclone_mount.log \
  --cache-dir=${DIR_PREFIX}/cache \
  --timeout=1h
  echo "mount done ${name}"
done

echo "done"

