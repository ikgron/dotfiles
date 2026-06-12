#!/usr/bin/env bash
set -eo pipefail
# Make sure to run homebrew/install.sh first if on mac

# Get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"
mkdir -p "$CONFIG_DEST"

shopt -s dotglob nullglob
# Symlink folders & files in config/ to ~/.config/
for dir in "$CONFIG_SRC"/*/; do
    # Remove trailing slash
    dir_name=$(basename "$dir")

    ln -sfvn "$CONFIG_SRC/$dir_name" "$CONFIG_DEST/$dir_name"
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

    git config --file ~/.config/git/config.local user.name "$username"
    git config --file ~/.config/git/config.local user.email "$email"
    git config --file ~/.config/git/config.local user.signingKey ~/.ssh/id_ed25519.pub
fi

if [[ "$(uname)" == "Linux" ]]; then
    bash "$DOTFILES_DIR/debian/install.sh"

elif [[ "$(uname)" == "Darwin" ]]; then
    # Source ~/.bash_profile, set system preferences and dock
    source "$HOME/.bash_profile"
    bash "$DOTFILES_DIR/macos/defaults.sh"

else
    echo "$(uname) is invalid."
    exit 1
fi
