#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

source "$DOTFILES_DIR/scripts/lib.sh"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"

mkdir -p "$CONFIG_DEST"

# Symlink files in dotfiles/config/ to ~/.config/
link_files "$CONFIG_SRC" "$CONFIG_DEST"

# Symlink files in dotfiles/home/ to ~/
link_files "$DOTFILES_DIR/home" "$HOME"

# Set Git username and email
if command -v git &>/dev/null; then
    read -rp "Setup Git now? (y/n): " confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        read -rp "Username: " username
        read -rp "Email: " email

        git config --file "$DOTFILES_DIR/config/git/config.local" \
            user.name "$username"

        git config --file "$DOTFILES_DIR/config/git/config.local" \
            user.email "$email"

        git config --file "$DOTFILES_DIR/config/git/config.local" \
            user.signingKey "$HOME/.ssh/id_ed25519.pub"
    fi
fi

# Install extensions if VSCodium is installed
if command -v codium &>/dev/null; then
    read -rp "Install VSCodium extensions now? (y/n): " confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        bash "$DOTFILES_DIR/vscodium/extensions.sh"
    fi
fi
