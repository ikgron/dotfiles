#!/usr/bin/env bash
# make sure to run homebrew/install.sh and homebrew/brew.sh first if on mac

# get location of this file
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"

for dir in "$CONFIG_SRC"/*/; do
  dirname=$(basename "$dir")
  echo "symlinked $dirname"
  mkdir -p "$CONFIG_DEST/$dirname"
  ln -sf "$CONFIG_SRC/$dirname"/* "$CONFIG_DEST/$dirname/"
done

# symlink files in home/ to ~
for file in "$DOTFILES_DIR/home/".*; do
  if [[ -f "$file" ]]; then
    ln -sf "$file" "$HOME/$(basename "$file")"
    echo "symlinked $(basename "$file")"
  fi
done

echo -e "\n Git setup: \n git config --global user.name username \n git config --global user.email email \n"

git config --global include.path "~/.delta.gitconfig"

if [[ "$OS" == "Darwin" ]]; then
  # install vscodium extensions, set dock, source ~/.bash_profile, set system preferences
  bash "$DOTFILES_DIR/vscodium/install.sh"
  bash "$DOTFILES_DIR/macos/dock.sh"
  source "$HOME/.bash_profile"
  bash "$DOTFILES_DIR/macos/defaults.sh" # run this last since it ends the script

elif [[ "$OS" == "Linux" ]]; then
  source "$DOTFILES_DIR/debian/install.sh"

else
  echo "$OS is invalid."
  exit 1
fi
