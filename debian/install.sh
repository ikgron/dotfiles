#!/usr/bin/env bash
set -euo pipefail
# This should work with any Debian based system

# Update, upgrade, and install apps
sudo apt update && sudo apt upgrade -y

sudo apt install -y --ignore-missing btop curl eza fontconfig gamemode git git-delta gpg starship unzip wget

# Ghostty
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# Fastfetch
curl -Lo /tmp/fastfetch-latest.deb \
    https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb

sudo dpkg -i /tmp/fastfetch-latest.deb

rm /tmp/fastfetch-latest.deb

# Recommended Zed install
curl -fsSL https://zed.dev/install.sh | sh

# Install VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg |
    gpg --dearmor |
    sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' |
    sudo tee /etc/apt/sources.list.d/vscodium.sources

sudo apt update && sudo apt install -y codium

# Install FiraCode Nerd Font for user only
FONT_DIR="$HOME/.local/share/fonts/FiraCode"
mkdir -p "$FONT_DIR"
wget -P "$FONT_DIR" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"

# Unzip, delete archive, and refresh font cache
unzip "$FONT_DIR/FiraCode.zip" -d "$FONT_DIR/"
rm "$FONT_DIR/FiraCode.zip"
fc-cache -fv
