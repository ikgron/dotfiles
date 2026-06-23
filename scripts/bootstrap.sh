#!/usr/bin/env bash
set -eo pipefail

# Get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"
mkdir -p "$CONFIG_DEST"

shopt -s dotglob nullglob
# Symlink folders and files in config/ to ~/.config/
for item in "$CONFIG_SRC"/*; do
    name=$(basename "$item")
    ln -sfvn "$item" "$CONFIG_DEST/$name"
done

# Symlink files in home/ to ~
for file in "$DOTFILES_DIR"/home/*; do
    if [[ -f "$file" ]]; then
        ln -sfv "$file" "$HOME/$(basename "$file")"
    fi
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

if [[ "$(uname)" == "Linux" ]]; then
    # Symlink vscode/settings.json
    mkdir -p "$HOME/.config/VSCodium/User"
    ln -sfv "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/VSCodium/User/settings.json"

    # Install vscode extensions and Debian apps
    bash "$DOTFILES_DIR/vscode/extensions.sh"
    bash "$DOTFILES_DIR/debian/install.sh"

elif [[ "$(uname)" == "Darwin" ]]; then
    # Symlink vscode/settings.json
    mkdir -p "$HOME/Library/Application Support/VSCodium/User"
    ln -sfv "$DOTFILES_DIR/vscode/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"

    # Install vscode extensions, source ~/.bash_profile, set system preferences and dock
    bash "$DOTFILES_DIR/vscode/extensions.sh"
    source "$HOME/.bash_profile"
    bash "$DOTFILES_DIR/macos/defaults.sh"

else
    echo "$(uname) is invalid."
    exit 1
fi
