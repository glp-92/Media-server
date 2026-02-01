# About Media Server

Multiple services running on docker compose on single node to provide streaming experience to user. Keep in mind that P2P downloads can be unsafe so be sure that downloaded content is scanned and isolated

## Services description

- `Gluetun` VPN Client used to avoid own phisical IP usage on torrent downloads
- `QBitTorrent` torrent client for p2p downloads
- `SABnzbd` manages file downloading
- `Radarr` automates management on video library
- `Sonarr` automates management on tv series
- `Prowlarr` connects radarr/sonnar with qbittorrent and sabnzdb
- `Jellyfin` media server that provides de UI to see the content

## Setup main directories

```bash
mkdir -p /mnt/media/ssd1/data/{downloads/{torrents,usenet},media/{movies,tv}}
mkdir -p /mnt/media/ssd1/docker_configs/{gluetun,qbittorrent,sabnzbd,radarr,sonarr,prowlarr,jellyfin}
```