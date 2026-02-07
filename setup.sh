#!/bin/bash

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

: "${ROOT_MEDIA_FOLDER:?Error: ROOT_MEDIA_FOLDER no definida en .env}"
: "${ROOT_CONFIG_FOLDER:?Error: ROOT_CONFIG_FOLDER no definida en .env}"
: "${ROOT_IMAGES_FOLDER:?Error: ROOT_IMAGES_FOLDER no definida en .env}"
: "${DB_IMAGES_FOLDER:?Error: DB_IMAGES_FOLDER no definida en .env}"

echo Creating service user mediaserver 
sudo useradd -r -s /usr/sbin/nologin mediaserver
sudo usermod -aG mediaserver $(whoami)

echo Creating service user immich 
sudo useradd -r -s /usr/sbin/nologin immich
sudo usermod -aG immich $(whoami)

echo Create paths: "$ROOT_MEDIA_FOLDER" "$ROOT_CONFIG_FOLDER"

sudo mkdir -p "$ROOT_MEDIA_FOLDER"/{torrents/{tv,movies,music},media/{tv,movies,music}}
sudo apt update && sudo apt install -y tree
tree "$ROOT_MEDIA_FOLDER"
sudo chown -R mediaserver:mediaserver "$ROOT_MEDIA_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_MEDIA_FOLDER"
ls -ln "$ROOT_MEDIA_FOLDER"

sudo mkdir -p "$ROOT_CONFIG_FOLDER"/{radarr,sonarr,lidarr,bazarr,prowlarr,qbittorrent,jellyfin}
tree "$ROOT_CONFIG_FOLDER"
sudo chown -R mediaserver:mediaserver "$ROOT_CONFIG_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_CONFIG_FOLDER"
ls -ln "$ROOT_CONFIG_FOLDER"

echo Create paths: "$ROOT_IMAGES_FOLDER" "$DB_IMAGES_FOLDER"

sudo mkdir -p "$ROOT_IMAGES_FOLDER"
sudo chown -R immich:immich "$ROOT_IMAGES_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_IMAGES_FOLDER"
ls -ln "$ROOT_IMAGES_FOLDER"

sudo mkdir -p "$DB_IMAGES_FOLDER"
sudo chown -R 999:999 "$DB_IMAGES_FOLDER"
sudo chmod -R 750 "$DB_IMAGES_FOLDER"
ls -ln "$DB_IMAGES_FOLDER"
