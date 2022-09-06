#/bin/bash

# CONFIG="~/.config/rclone/rclone.conf"
#   --config=${CONFIG} \


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX 
  sudo spctl --master-disable
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "win32" ]]; then
   # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  # ...
else
  # Unknown.
fi

DIR_PREFIX="rclone"

STORAGE_LIST=(Onedrive-hanyang Onedrive-naver Googledrive-hanyang Googledrive-gmail Dropbox-naver)

mkdir -p ${DIR_PREFIX}/cache
mkdir -p ${DIR_PREFIX}/mount

# mount storage
for name in ${STORAGE_LIST[@]}
do
  echo "mount start ${name}"
  mkdir -p ${DIR_PREFIX}/mount/${name}
  /usr/local/bin/rclone mount ${name}:/ ${DIR_PREFIX}/mount/${name} \
  --dir-cache-time=1000h \
  --log-level=ERROR  \
  --allow-other \
  --fast-list \
  --drive-skip-gdocs \
  --poll-interval=1m \
  --vfs-cache-mode=full \
  --vfs-write-back=5s \
  --bwlimit-file=16M \
  --buffer-size=16M \
  --vfs-read-chunk-size=32M \
  --vfs-read-chunk-size-limit=2048M \
  --vfs-cache-max-size=1G \
  --vfs-cache-max-age=336h \
  --vfs-read-ahead=32M \
  --log-file=${DIR_PREFIX}/rclone_mount.log \
  --cache-dir=${DIR_PREFIX}/cache \
  --timeout=1h &
  echo "mount done ${name}"
done

echo "done"

#   --allow-non-empty \
#  --rc --rc-no-auth --rc-addr 127.0.0.1:5572 \
