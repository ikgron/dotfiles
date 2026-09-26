#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
os="$(uname)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"
mkdir -p "$CONFIG_DEST"

shopt -s dotglob nullglob
# Symlink folders and files in config/ to ~/.config/
for item in "$CONFIG_SRC"/*; do
    ln -sfvn "$item" "$CONFIG_DEST/$(basename "$item")"
done

# Symlink folders and files in home/ to ~
for item in "$DOTFILES_DIR"/home/*; do
    ln -sfvn "$item" "$HOME/$(basename "$item")"
done
shopt -u dotglob nullglob

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

# Install VSCodium extensions if installed
if command -v codium &>/dev/null; then
    bash "$DOTFILES_DIR/vscode/extensions.sh"
fi
