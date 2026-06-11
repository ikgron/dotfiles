#!/usr/bin/env bash
set -eo pipefail
# This should work with any Debian based system

# Update, upgrade, and install apps
sudo apt update && sudo apt upgrade -y

sudo apt install -y eza gamemode ghostty git-delta starship unzip

# Recommended Zed install
curl -f https://zed.dev/install.sh | sh

# Install FiraCode Nerd Font for user only
mkdir -p ~/.local/share/fonts/FiraCode
wget -P ~/.local/share/fonts/FiraCode https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip

# Unzip, delete archive, and refresh font cache
unzip ~/.local/share/fonts/FiraCode/FiraCode.zip -d ~/.local/share/fonts/FiraCode/
rm ~/.local/share/fonts/FiraCode/FiraCode.zip
fc-cache -fv

# https://gitlab.com/Schwarzer_Kater
# https://github.com/DavidoTek/ProtonUp-Qt
# https://github.com/VirusAlex/elden-proton
# https://github.com/PaulCombal/SamRewritten
