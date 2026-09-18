#!/usr/bin/env bash
set -euo pipefail

# Update the system
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
    paru \
    starship \
    unzip \

# VSCodium
if command -v codium &>/dev/null; then
    echo "VSCodium is already installed."
else
    echo "Installing VSCodium"
    paru -S --needed vscodium-bin
fi

# Zed
if command -v zed &>/dev/null; then
    echo "Zed is already installed."
else
    echo "Installing Zed"
    curl -f https://zed.dev/install.sh | sh
fi

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

# Rebuild font cache
echo
echo "Updating font cache..."
fc-cache -f
