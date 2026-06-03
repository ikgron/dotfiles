#!/usr/bin/env bash
# Make sure to run macos/homebrew_install.sh first if on mac

# Get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"

# Create ~/.config if it doesn't exist
mkdir -p "$CONFIG_DEST"

# Symlink folders & files in config/ to ~/.config/
for dir in "$CONFIG_SRC"/*/; do
    # Remove trailing slash
    dirname=$(basename "$dir")

    ln -sfn "$CONFIG_SRC/$dirname" "$CONFIG_DEST/$dirname"

    echo "Symlinked directory: $dirname"
done

# Symlink files in home/ to ~ (files with or without a `.` in front)
for file in "$DOTFILES_DIR/home/".* "$DOTFILES_DIR/home/"*; do
    if [[ -f "$file" ]]; then
        ln -sf "$file" "$HOME/$(basename "$file")"
        echo "symlinked $(basename "$file")"
    fi
done

# Set git username and email
read -rp "Setup Git now? (y/n): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    read -rp "Username: " username
    read -rp "Email: " email
    
    git config --global user.name "$username"
    git config --global user.email "$email"
    git config --global gpg.format ssh
    git config --global user.signingKey ~/.ssh/id_ed25519.pub
    git config --global commit.gpgSign true
fi

git config --global include.path "~/.global.gitconfig"

if [[ "$(uname)" == "Linux" ]]; then
    bash "$DOTFILES_DIR/debian/install.sh"
    exit

elif [[ "$(uname)" == "Darwin" ]]; then
    # Source ~/.bash_profile, set system preferences and dock
    source "$HOME/.bash_profile"
    bash "$DOTFILES_DIR/macos/defaults.sh" # Run this last since it ends the script
    exit # Just for uniformity

else
    echo "$(uname) is invalid."
    exit 1
fi
