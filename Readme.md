# About ARR Stack & Immich

Arr Stack provides a full media server with all elements interconnected to automate tasks such as select films, automatically download, get subtitles, manage storage ando more.

[Inmich](https://immich.app/) is an Open Source solution for content sharing as images and videos. Self hosted, allows multiple users creation and manage their access to the server. It uses by default a Postgres and Valkey databases to handle relationships and caching

Available on [IOS](https://apps.apple.com/us/app/immich/id1613945652) and [Android](https://play.google.com/store/apps/details?id=app.alextran.immich&hl=en)

For first time config of services [check this small guide](./First-config.md)

## Docs

It is higly recommended to read the docs in order to understand what services are doing

[Justification of usage known DNS over VPN](https://wiki.servarr.com/en/vpn)

[Setup folder structure for docker containers. SEE PERMISSIONS](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/)

[Useful guide on first run](https://github.com/automation-avenue/arr-new)

## Services description

- `QBitTorrent` torrent client for p2p downloads
- `Radarr` automates video library management
- `Sonarr` automates tv series management
- `Lidarr` automates music management
- `Bazzarr` automates subtitle downloading
- `Prowlarr` connects radarr/sonnar with qbittorrent and sabnzdb
- `Flaresolverr` automatically solves Cloudflare captchas
- `Jellyfin` media server that provides de UI to see the content
- `Jellyseer` download automation centralized on this server for every content

## Setup main directories

[This script](./setup.sh) automates user and dirs creation. Service accounts are created to run containers so avoid root usage

## Tailscale for remote access