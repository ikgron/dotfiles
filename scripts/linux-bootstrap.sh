#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
OS="$(uname -s)"

source "$DOTFILES_DIR/scripts/lib.sh"

CONFIG_SRC="$DOTFILES_DIR/linux/config"
CONFIG_DEST="$HOME/.config"

if [[ "$OS" == "Linux" ]]; then
    mkdir -p "$CONFIG_DEST"

    # Symlink files in dotfiles/linux/config/ to ~/.config/
    link_files "$CONFIG_SRC" "$CONFIG_DEST"

    # Symlink VSCodium settings
    VSCODIUM_CONFIG_DEST="$CONFIG_DEST/VSCodium/User/settings.json"

    mkdir -p -- "$(dirname "$VSCODIUM_CONFIG_DEST")"
    ln -sfv \
        "$DOTFILES_DIR/vscodium/settings.json" \
        "$VSCODIUM_CONFIG_DEST"

    # Symlink udev hwdb rules
    UDEV_CONFIG_DEST="/etc/udev/hwdb.d/99-keyboard.hwdb"

    sudo mkdir -p -- "$(dirname "$UDEV_CONFIG_DEST")"
    sudo ln -sfv \
        "$DOTFILES_DIR/linux/system/udev/hwdb.d/99-keyboard.hwdb" \
        "$UDEV_CONFIG_DEST"

    # Reload udev hwdb
    sudo systemd-hwdb update
    sudo udevadm control --reload-rules
    sudo udevadm trigger --subsystem-match=input

    # Restart WirePlumber
    systemctl --user restart wireplumber

else
    echo "Unsupported OS: $OS"
    exit 1
fi
