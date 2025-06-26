#!/bin/bash

echo "Starte Git- und GitHub-Konfiguration..."

# Git-Username setzen
read -p "Bitte gib deinen GitHub-Username ein: " GIT_USERNAME
git config --global user.name "$GIT_USERNAME"

# Git-E-Mail setzen
read -p "Bitte gib deine GitHub-E-Mail-Adresse ein: " GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

# GitHub als Standard-Push-URL setzen (https oder ssh möglich)
read -p "Möchtest du HTTPS (1) oder SSH (2) für GitHub nutzen? [1/2]: " GIT_PROTOCOL

if [ "$GIT_PROTOCOL" == "1" ]; then
    echo "GitHub wird über HTTPS genutzt."
    git config --global url."https://github.com/".insteadOf "git@github.com:"
else
    echo "GitHub wird über SSH genutzt."
    git config --global url."git@github.com:".insteadOf "https://github.com/"
fi

# Prüfen, ob GitHub-Authentifizierung erforderlich ist
echo "Aktuelle Git-Konfiguration:"
git config --list

echo "Optional: Prüfe, ob dein SSH-Schlüssel bereits vorhanden ist..."
if [ -f ~/.ssh/id_rsa.pub ]; then
    echo "SSH-Schlüssel existiert bereits."
else
    echo "SSH-Schlüssel nicht gefunden. Generiere neuen Schlüssel..."
    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL"
    echo "Füge den folgenden SSH-Key zu GitHub hinzu:"
    cat ~/.ssh/id_rsa.pub
    echo "Link: https://github.com/settings/keys"
fi

echo "GitHub-Konfiguration abgeschlossen ✅"
