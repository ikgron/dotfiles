#!/usr/bin/env bash
# this should work with any debian based system

# update, upgrade, and install apps
sudo apt update && sudo apt upgrade -y

sudo apt install -y alacritty btop eza fastfetch gamemode nodejs npm starship

# recommended zed install
curl -f https://zed.dev/install.sh | sh

# install firacode nerd mono regular for user only (i don't care about the other variants)
mkdir -p ~/.local/share/fonts
wget -P ~/.local/share/fonts/ https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf
fc-cache -f


# https://gitlab.com/Schwarzer_Kater
# https://github.com/DavidoTek/ProtonUp-Qt
# https://github.com/VirusAlex/elden-proton
# https://github.com/PaulCombal/SamRewritten