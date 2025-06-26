#!/bin/bash

# Variablen
BRANCH="main"

# Arbeitsverzeichnis = aktuelles Verzeichnis
CURRENT_DIR="$(pwd)"


echo "Entpacke ZIP-Datei ins aktuelle Verzeichnis..."
unzip -o openwrt-docker-build.zip

# Die entpackten Dateien liegen jetzt im Ordner: openwrt-docker-build
echo "Kopiere Dateien ins aktuelle Verzeichnis..."
cp -r openwrt-docker-build/* .

# Bereinige entpackten Ordner und ZIP
rm -rf openwrt-docker-build
rm openwrt-docker-build.zip

echo "Dateien zum Commit vormerken..."
git add .

echo "Änderungen committen..."
git commit -m "Automatisches Update: OpenWrt Docker Build Dateien integriert"

echo "Push zum Remote-Repository..."
git push origin "$BRANCH"

echo "Fertig ✅"
