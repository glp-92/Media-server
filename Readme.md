# About ARR Stack

Arr Stack provides a full media server with all elements interconnected to automate tasks such as select films, automatically download, get subtitles, manage storage ando more.

For first time config of services [check this small guide](./First-config.md)

## Docks

It is higly recommended to read the docs in order to understand what services are doing

[Justification of usage known DNS over VPN](https://wiki.servarr.com/en/vpn)
[Setup folder structure for docker containers. SEE PERMISSIONS](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/)
[Useful guide on first run](https://github.com/automation-avenue/arr-new)

## Services description

- `QBitTorrent` torrent client for p2p downloads
- `Radarr` automates video library management
- `Sonarr` automates tv series management
- `Lidarr` automates music management
- `Bazzar` automates subtitle downloading
- `Prowlarr` connects radarr/sonnar with qbittorrent and sabnzdb
- `Flaresolverr` automatically solves Cloudflare captchas
- `Jellyfin` media server that provides de UI to see the content

## Setup main directories

[This script](./setup.sh) automates user and dirs creation

First, create a non-sudo user to run the stack and avoid compromising other resources

```bash
sudo useradd -r -s /usr/sbin/nologin mediaserver
```

Add your user to mediaserver group in order to manage folders without sudo permission

```bash
sudo usermod -aG mediaserver $(whoami)
```

Create a `/media-server` folder which contains `/torrents` and `/media`, and inside subfolders for every type of media (tv, movies and music)

Tree visually outputs the result folder structure

Assign folder to mediaserver user and group

`a=,a+rX,u+w,g+w` => a deletes current permission; a+rX write permission but only exec permission to folders; u+w,g+w read and write group and user

```bash
sudo mkdir -p "$ROOT_MEDIA_FOLDER"/{torrents/{tv,movies,music},media/{tv,movies,music}}
sudo apt update && sudo apt install -y tree
tree "$ROOT_MEDIA_FOLDER"
sudo chown -R mediaserver:mediaserver "$ROOT_MEDIA_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_MEDIA_FOLDER"
ls -ln "$ROOT_MEDIA_FOLDER"
```

Create a folder to storage services config generated on first time

```bash
sudo mkdir -p "$ROOT_CONFIG_FOLDER"/{radarr,sonarr,lidarr,bazarr,prowlarr,qbittorrent,jellyfin}
tree "$ROOT_CONFIG_FOLDER"
sudo chown -R mediaserver:mediaserver "$ROOT_CONFIG_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_CONFIG_FOLDER"
ls -ln "$ROOT_CONFIG_FOLDER"
```

## Behind load balancer

An `Nginx.conf` file is provided in order to improve accesibility to services from browser. Keep in mind that this service should not be exposed outside home network because cybersecurity mitigations are not included.

To use on same pc is needed a new line on hosts file indicating service

```bash
sudo nano /etc/hosts
```

Add in the end of the file `127.0.0.1 stream.homeserver.local.com` as example to use Jellyfin with settings provided
