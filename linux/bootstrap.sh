#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

source "$DOTFILES_DIR/scripts/lib.sh"
shared_setup "$DOTFILES_DIR"

# Set variables
VSCODIUM_CONFIG_DEST="$HOME/.config/VSCodium/User/settings.json"
UDEV_CONFIG_DEST="/etc/udev/hwdb.d/99-keyboard.hwdb"
BASH_PATH="$(command -v bash)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

# Symlink VSCodium settings
mkdir -p -- "$(dirname "$VSCODIUM_CONFIG_DEST")"
ln -sfv \
	"$DOTFILES_DIR/vscodium/settings.json" \
	"$VSCODIUM_CONFIG_DEST"

# Symlink udev hwdb rules
sudo mkdir -p -- "$(dirname "$UDEV_CONFIG_DEST")"
sudo ln -sfv \
	"$DOTFILES_DIR/linux/system/udev/hwdb.d/99-keyboard.hwdb" \
	"$UDEV_CONFIG_DEST"

# Reload udev hwdb
sudo systemd-hwdb update
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=input

# Change shell to bash (CachyOS defaults to fish)
if [[ "$CURRENT_SHELL" != "$BASH_PATH" ]]; then
	chsh -s "$BASH_PATH"
	read -rp "Reboot now? (y/n): " confirm
	if [[ "$confirm" =~ ^[Yy]$ ]]; then
		sudo reboot
	fi
fi
