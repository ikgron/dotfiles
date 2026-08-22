#!/usr/bin/env bash
set -euo pipefail
# This should work with any Debian based system

# Update, upgrade, and install apps
sudo apt update && sudo apt upgrade -y

sudo apt install -y --ignore-missing btop curl eza fastfetch fontconfig gamemode ghostty git git-delta gpg starship unzip wget

# Recommended Zed install
if command -v zed &>/dev/null; then
    echo "Zed is already installed"
else
    curl -fsSL https://zed.dev/install.sh | sh
fi

# Install VSCodium
if command -v codium &>/dev/null; then
    echo "VSCodium is already installed"
else
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
    
    echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
    | sudo tee /etc/apt/sources.list.d/vscodium.sources
    
    sudo apt update && sudo apt install -y codium
fi

FONTS=("FiraCode" "JetBrainsMono")
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

for FONT_NAME in "${FONTS[@]}"; do
    if find "$FONT_DIR/$FONT_NAME" -type f \( -name '*.ttf' -o -name '*.otf' \) -print -quit 2>/dev/null | grep -q .; then
        echo "$FONT_NAME already installed."
        continue
    fi

    echo "Downloading $FONT_NAME"
    mkdir -p "$FONT_DIR/$FONT_NAME"
    curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_NAME.zip" \
        -o "/tmp/$FONT_NAME.zip"
    unzip -q -o "/tmp/$FONT_NAME.zip" -d "$FONT_DIR/$FONT_NAME"
    rm "/tmp/$FONT_NAME.zip"
done

fc-cache -f
