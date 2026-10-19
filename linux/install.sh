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
	ghostty \
	git-delta \
	librewolf \
	mullvad-browser-bin \
	openrgb \
	protonup-qt \
	proton-vpn-gtk-app \
	starship \
	steam \
	unzip \
	vesktop-bin \
	vscodium \
	zed

# Fonts
FONTS=("FiraCode")
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
