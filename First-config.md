# First ARR Stack Config

First, run `docker compose up` with non detached mode to see errors

## QBittorrent Downloader

First time, web UI launches with credentials provided on terminal, check it

1. `docker logs qbittorrent` => search for admin and password
2. `http://localhost:8080` => login with admin and password
3. Change web UI login => `tools` => `options` => `webui` => modify usr and password
4. Left pannel => `categories` => right click on `all` => `add category` 3 times (for films, series and music). Keep in mind that these names will have to match content managers
   - Category: `movies` / Save Path: `movies`
   - Category: `tv` / Save Path: `tv`
   - Category: `music` / Save Path: `music`
5. `Tools` => `options` => `downloads` => `saving management`
   - Default torrent management mode: `automatic`
   - When torrent category changed: `relocate torrent`
   - When default save path changed: `switch affected torrents to manual mode`
   - When category save path changed: `switch affected torrents to manual mode`
   - Default save path: `/data/torrents`
   - Check `use subcategories`
   - Check `use category paths in manual mode`
   - Copy .torrent files to: `/data/torrents/torrents-files`

## Prowlarr Indexer

First time will require to set a login => choose form (login page) authentication

1. `http://localhost:9696`
2. `Settings` => `Download clients` => `+` => choose `qbittorrent`
3. Uncheck `use ssl` as not configured
4. Host: `qbittorrent` / Port: `8080` / Username & Password: same as setted on qbittorrent
5. Click `test` to ensure connection is stablished and then `save`

## Radarr Movies Manager

First time will require to set a login => choose form (login page) authentication

1. `http://localhost:7878` or `http://movies.homeserver.local.com` if nginx configured
2. `Settings` => `Media management` => `Add root folder` => `/data/media/movies`
3. `Show advanced` => `Importing` => Check `use hardlinks instead of copy`
4. Check `delete empty movie folders during disk scan`
5. Check `import extra files` and add `srt,sub,nfo`
6. `Settings` => `Download clients` => `+` => choose qbittorrent and field form as prowlarr but :red_circle: change `category` to `movies` (must match same categories specified on qbittorrent)
7. Test and save changes
8. `Settings` => `General` => copy `API_KEY` content
9. Go to Prowlarr => `Settings` => `APPs` => `+` => `Radarr` => paste `API_KEY`
10. On prowlarr, change `prowlarr server`=> `http://prowlarr:9696` and `radarr server` => `http://radarr:7878`
11. Test and save

## Sonarr Series Manager

First time will require to set a login => choose form (login page) authentication

1. `http://localhost:8989` or `http://series.homeserver.local.com` if nginx configured
2. `Settings` => `Media management` => `Add root folder` => `/data/media/tv`
3. `Show advanced` => `Importing` => Check `use hardlinks instead of copy`
4. Check `delete empty movie folders during disk scan`
5. Check `import extra files` and add `srt,sub,nfo`
6. `Settings` => `Download clients` => `+` => choose qbittorrent and field form as prowlarr but :red_circle: change `category` to `tv` (must match same categories specified on qbittorrent)
7. Test and save changes
8. `Settings` => `General` => copy `API_KEY` content
9. Go to Prowlarr => `Settings` => `APPs` => `+` => `Sonarr` => paste `API_KEY`
10. On prowlarr, change `prowlarr server`=> `http://prowlarr:9696` and `sonarr server` => `http://sonarr:8989`
11. Test and save

## Lidarr Music Manager

First time will require to set a login => choose form (login page) authentication

1. `http://localhost:8686` or `http://music.homeserver.local.com` if nginx configured
2. `Settings` => `Media management` => `Add root folder` => `/data/media/music`
3. `Settings` => `Download clients` => `+` => choose qbittorrent and field form as prowlarr but :red_circle: change `category` to `music` (must match same categories specified on qbittorrent)
4. Test and save changes
5. `Settings` => `General` => copy `API_KEY` content
6. Go to Prowlarr => `Settings` => `APPs` => `+` => `Lidarr` => paste `API_KEY`
7. On prowlarr, change `prowlarr server`=> `http://prowlarr:9696` and `lidarr server` => `http://lidarr:8686`
8. Test and save

## Bazarr Subtitles Manager

First time will require to set a login => choose form (login page) authentication

1. `http://localhost:6767` or `http://subtitles.homeserver.local.com` if nginx configured
2. `Settings` => `Languages` => `Languages filter` => select languages for subtitles
3. `Settings` => `Languages` => `Add new profile`
   1. First field, name of profile
   2. Click `add` to aggregate languages stablished before
   3. Tested with nothing checked for every language
   4. Save
4. `Default settings` => check `Series` and `Movies` and select profile.
5. `Settings` => `Subtitles`
   1. `Subtitles options` => alongside media file
   2. `Automatic subtitles synchronization` => checked and select thresholds
6. `Settings` => `Providers` => add a provider (OpenSubtitles.com may require a login but works fine with limits)
7. Go to `Sonarr` and `Radarr` sections and enable them. Ex => `Sonarr` => address `sonarr` => port `8989` => insert API_KEY

## For finish

When all the config is done and running, it is recommended to backup `${ROOT_CONFIG_FOLDER}` to have all running in seconds if config is lost.

Run `docker compose down` and `docker compose up -d` to run detached mode and not need to keep logged in into server
