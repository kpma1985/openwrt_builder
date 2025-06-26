# OpenWrt Docker Build (Multi-Stage)

Dieses Repository baut OpenWrt in einem Docker-Multi-Stage-Setup und exportiert die Firmware als CI/CD-Artefakt.

## Features
✅ Multi-Stage Dockerbuild  
✅ OpenWrt v23.05.3 Support  
✅ CI/CD via GitHub Actions  
✅ Sauberer Artefakt-Export

## Lokaler Build
```bash
docker build -t openwrt-multistage .
docker run --name openwrt-export -d openwrt-multistage
docker cp openwrt-export:/build ./openwrt-build
docker stop openwrt-export
docker rm openwrt-export
```

## CI/CD
Der Workflow `.github/workflows/build.yml` baut das Image automatisch bei jedem Push.

## Anpassung
Gerätespezifische Konfigurationen können mit `make menuconfig` integriert werden.
