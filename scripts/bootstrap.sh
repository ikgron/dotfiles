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
read -rp "Setup Git now? (y/n): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    read -rp "Username: " username
    read -rp "Email: " email

    git config --file "$DOTFILES_DIR/config/git/config.local" user.name "$username"
    git config --file "$DOTFILES_DIR/config/git/config.local" user.email "$email"
    git config --file "$DOTFILES_DIR/config/git/config.local" user.signingKey ~/.ssh/id_ed25519.pub
fi

if [[ "$os" == "Linux" ]]; then
    # Symlink vscode/settings.json
    mkdir -p "$HOME/.config/VSCodium/User"
    ln -sfv "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/VSCodium/User/settings.json"

    # Install Debian apps and vscode extensions
    bash "$DOTFILES_DIR/debian/install.sh"
    bash "$DOTFILES_DIR/vscode/extensions.sh"

    # Copy debian/config/* to ~/.config/
    cp -afv "$DOTFILES_DIR/debian/config/." "$HOME/.config/"

elif [[ "$os" == "Darwin" ]]; then
    # Symlink vscode/settings.json
    mkdir -p "$HOME/Library/Application Support/VSCodium/User"
    ln -sfv "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"

    # Install vscode extensions and set system preferences and dock
    bash "$DOTFILES_DIR/vscode/extensions.sh"
    bash "$DOTFILES_DIR/macos/defaults.sh"
    echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."

else
    echo "Unsupported OS: $os"
    exit 1
fi
