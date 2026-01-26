#!/usr/bin/env bash

# get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname)"

# symlink files in bash/ to ~
for file in "$DOTFILES_DIR/bash/".*; do
  if [[ -f "$file" ]]; then
    ln -sf "$file" "$HOME/$(basename "$file")"
    echo " symlinked $(basename "$file")"
  fi
done

if [[ "$OS" == "Darwin" ]]; then
  # run homebrew install.sh, add homebrew to path, set dock, set system preferences
  source "$DOTFILES_DIR/homebrew/install.sh"
  source "$DOTFILES_DIR/homebrew/path.sh"
  bash "$DOTFILES_DIR/vscodium/install.sh"
  bash "$DOTFILES_DIR/macos/dock.sh"
  source "$HOME/.bash_profile"
  source "$DOTFILES_DIR/macos/defaults.sh" # source this last since it ends the script

# TODO: linux setup
# elif [[ "$OS" == "Linux" ]]; then
# 	source "$DOTFILES_DIR/linux/install.sh"

else
  echo "$OS is invalid."
  exit 1
fi

# source .bash_profile which sources everything else
source "$HOME/.bash_profile"
