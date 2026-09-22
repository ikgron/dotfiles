#!/usr/bin/env bash
set -euo pipefail

# Update system
sudo pacman -Syu --noconfirm

# Install apps
sudo pacman -S --needed --noconfirm \
    btop \
    curl \
    eza \
    fastfetch \
    fontconfig \
    gamemode \
    ghostty \
    git-delta \
    gnupg \
    librewolf \
    proton-vpn-gtk-app \
    starship \
    unzip \
    vscodium \
    zed

# Fonts
FONTS=("FiraCode" "JetBrainsMono")
FONT_DIR="$HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

for FONT_NAME in "${FONTS[@]}"; do

    if find "$FONT_DIR/$FONT_NAME" \
        -type f \
        \( -name '*.ttf' -o -name '*.otf' \) \
        -print -quit 2>/dev/null | grep -q .; then

        echo "$FONT_NAME already installed."
        continue
    fi

    echo "Downloading $FONT_NAME Nerd Font..."

    mkdir -p "$FONT_DIR/$FONT_NAME"

    curl -fL \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_NAME.zip" \
        -o "/tmp/$FONT_NAME.zip"

    unzip -q -o \
        "/tmp/$FONT_NAME.zip" \
        -d "$FONT_DIR/$FONT_NAME"

    rm -f "/tmp/$FONT_NAME.zip"

    echo "$FONT_NAME installed."
done

fc-cache -f

# Change shell to bash (CachyOS defaults to fish)
BASH_PATH="$(command -v bash)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

if [[ "$CURRENT_SHELL" != "$BASH_PATH" ]]; then
    chsh -s "$BASH_PATH"
fi

