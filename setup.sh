#!/bin/bash
set -e
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

: "${ROOT_MEDIA_FOLDER:?Error: ROOT_MEDIA_FOLDER undefined on .env}"
: "${ROOT_CONFIG_FOLDER:?Error: ROOT_CONFIG_FOLDER undefined on .env}"
: "${PUID:?Error: PUID undefined on .env}"
: "${PGID:?Error: PGID undefined on .env}"

SERVICE_USER="mediaserver"
SERVICE_GROUP="mediaserver"

echo "[INFO] Creating service user/group: $SERVICE_USER ($PUID:$PGID)"
if ! getent group "$SERVICE_GROUP" >/dev/null; then
    sudo groupadd -g "$PGID" "$SERVICE_GROUP"
else
    echo "[INFO] Group $SERVICE_GROUP already exists"
fi
if ! id "$SERVICE_USER" >/dev/null 2>&1; then
    sudo useradd -u "$PUID" -g "$PGID" -r -s /usr/sbin/nologin "$SERVICE_USER"
else
    echo "[INFO] User $SERVICE_USER already exists"
fi

echo "[INFO] Adding current user to group $SERVICE_GROUP"
sudo usermod -aG "$SERVICE_GROUP" "$(whoami)"

echo "[INFO] Creating media folder structure in $ROOT_MEDIA_FOLDER"
sudo mkdir -p "$ROOT_MEDIA_FOLDER"/{torrents/{tv,movies,music},media/{tv,movies,music}}
echo "[INFO] Creating config folder structure in $ROOT_CONFIG_FOLDER"
sudo mkdir -p "$ROOT_CONFIG_FOLDER"/{radarr,sonarr,lidarr,bazarr,prowlarr,qbittorrent,jellyfin}

echo "[INFO] Setting ownership and permissions"
sudo chown -R "$PUID:$PGID" "$ROOT_MEDIA_FOLDER" "$ROOT_CONFIG_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_MEDIA_FOLDER" "$ROOT_CONFIG_FOLDER"

echo "[INFO] Done."
echo "[INFO] Ownership:"
ls -ln "$ROOT_MEDIA_FOLDER"
ls -ln "$ROOT_CONFIG_FOLDER"