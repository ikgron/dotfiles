#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
os="$(uname)"

CONFIG_SRC_LINUX="$DOTFILES_DIR/linux/config"
CONFIG_DEST="$HOME/.config"

if [[ "$os" == "Linux" ]]; then
    mkdir -p "$CONFIG_DEST"
    shopt -s dotglob nullglob
    # Symlink folders and files in config/ to ~/.config/
    for item in "$CONFIG_SRC_LINUX"/*; do
        ln -sfvn "$item" "$CONFIG_DEST/$(basename "$item")"
    done
    shopt -u dotglob nullglob

    # Symlink VSCodium settings
    mkdir -p "$HOME/.config/VSCodium/User"
    ln -sfv \
        "$DOTFILES_DIR/vscode/settings.json" \
        "$HOME/.config/VSCodium/User/settings.json"

    # Symlink udev hwdb rules
    mkdir -p /etc/udev/hwdb.d
    ln -sfv \
        "$DOTFILES_DIR/linux/system/udev/hwdb.d/99-keyboard.hwdb" \
        "/etc/udev/hwdb.d/99-keyboard.hwdb"

    # Reload udev hwdb
    sudo systemd-hwdb update
    sudo udevadm control --reload-rules
    sudo udevadm trigger --subsystem-match=input

    # Symlink wireplumber config
    mkdir -p "$HOME/.config/wireplumber/wireplumber.conf.d"
    ln -sfv "$DOTFILES_DIR/linux/wireplumber/wireplumber.conf.d/51-audio.conf" \
        "$HOME/.config/wireplumber/wireplumber.conf.d/51-audio.conf"

    # Restart wireplumber
    systemctl --user restart wireplumber

else
    echo "Unsupported OS: $os"
    exit 1
fi
