DATE=$(date '+%Y.%m.%dT%H.%M')
NAME="backup_pro_${DATE}.tar.gz"
echo "backup: $NAME"
DEST='spi@10.0.90.20:_backup_pro'
cd / && \
tar -cpzf "$NAME" \
  --exclude="/$NAME" \
  --exclude=/proc \
  --exclude=/tmp \
  --exclude=/mnt \
  --exclude=/dev \
  --exclude=/sys \
  --exclude=/run \
  --exclude=/media \
  --exclude=/var/log \
  --exclude=/var/cache/apt/archives \
  --exclude=/usr/src/linux-headers* \
  --exclude=/home/*/.cache / && \
scp ./"$NAME" "$DEST"
du -h ./"$NAME" && \
rm ./"$NAME" && 
cd - || exit 1
