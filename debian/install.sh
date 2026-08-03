#!/usr/bin/env bash
set -euo pipefail
# This should work with any Debian based system

# Update, upgrade, and install apps
sudo apt update && sudo apt upgrade -y

sudo apt install -y --ignore-missing btop curl eza fontconfig gamemode git git-delta gpg starship unzip wget

# Ghostty
sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
sudo apt update
sudo apt install -y ghostty

# Fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install -y fastfetch

# Recommended Zed install
if ! command -v zed &>/dev/null; then
  curl -fsSL https://zed.dev/install.sh | sh
else
  echo "Zed is already installed."
fi

# Install VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
| sudo tee /etc/apt/sources.list.d/vscodium.sources

sudo apt update && sudo apt install -y codium

# Install FiraCode Nerd Font for user only
FONT_DIR="$HOME/.local/share/fonts/FiraCode"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/FiraCode.ttf" ] && ! ls "$FONT_DIR"/*.ttf &>/dev/null; then
  wget -O "$FONT_DIR/FiraCode.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
  unzip -o "$FONT_DIR/FiraCode.zip" -d "$FONT_DIR/"
  rm "$FONT_DIR/FiraCode.zip"
  fc-cache -fv
else
  echo "FiraCode Nerd Font is already installed."
fi
