# About ARR Stack

Arr Stack provides a full media server with all elements interconnected to automate tasks such as select films, automatically download, get subtitles, manage storage ando more

## Docks

It is higly recommended to read the docs in order to understand what services are doing

[Justificacion of use known DNS over VPN](https://wiki.servarr.com/en/vpn)
[Setup folder structure for docker containers. SEE PERMISSIONS](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/) 
[Useful guide on first run](https://github.com/automation-avenue/arr-new)

## Services description

- `Gluetun` VPN Client used to avoid own phisical IP usage on torrent downloads
- `QBitTorrent` torrent client for p2p downloads
- `SABnzbd` manages file downloading
- `Radarr` automates management on video library
- `Sonarr` automates management on tv series
- `Prowlarr` connects radarr/sonnar with qbittorrent and sabnzdb
- `Jellyfin` media server that provides de UI to see the content

## Setup main directories

First, create a non-sudo user to run the stack and avoid compromising other resources

```bash
sudo groupadd -g 1005 mediaserver
sudo useradd -u 1005 -g 1005 -r -s /bin/false mediaserver
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
sudo mkdir -p /mnt/SSD2/media-server/{torrents/{tv,movies,music},media/{tv,movies,music}}
sudo apt install tree
tree /mnt/SSD2/media-server
sudo chown -R mediaserver:mediaserver /mnt/SSD2/media-server
sudo chmod -R a=,a+rX,u+w,g+w /mnt/SSD2/media-server
ls -ln /mnt/SSD2/media-server
```

Create a folder to storage services config generated on first time

```bash
sudo mkdir -p /mnt/SSD2/media-server-config/{radarr,sonarr,lidarr,bazarr,prowlarr,qbittorrent,jellyfin}
sudo chown -R mediaserver:mediaserver /mnt/SSD2/media-server-config
sudo chmod -R a=,a+rX,u+w,g+w /mnt/SSD2/media-server-config
ls -ln /mnt/SSD2/media-server-config
```