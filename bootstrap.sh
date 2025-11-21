#!/usr/bin/env bash

# get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname)"

# copy /bash/ files into ~
rsync -av --exclude='*/' "$DOTFILES_DIR/bash/" "$HOME/"

if [[ "$OS" == "Darwin" ]]; then
  # run homebrew install.sh, add homebrew to path, set system preferences
  source "$DOTFILES_DIR/homebrew/install.sh"
  source "$DOTFILES_DIR/homebrew/path.sh"
  source "$DOTFILES_DIR/macos/defaults.sh"

# elif [[ "$OS" == "Linux" ]]; then
# 	source "$DOTFILES_DIR/linux/install.sh"

else
  echo "$OS is invalid."
  exit 1
fi

# source .bash_profile which sources everything else
source "$HOME/.bash_profile"

echo "Bootstrapping done!"
