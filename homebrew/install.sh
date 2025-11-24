#!/usr/bin/env bash

# abort on error
set -e

# check if homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed..."
fi

# check for intel or silicon
if [[ "$(uname -m)" == "arm64" ]]; then
  # silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname -m)" == "x86_64" ]]; then
  # intel
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "$(uname -m) is invalid"
fi

# save homebrew’s installed location
BREW_PREFIX=$(brew --prefix)

brew install bash
# switch to using homebrew's bash as default
if ! grep -Fxq "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells >/dev/null
fi

if [[ "$SHELL" != "${BREW_PREFIX}/bin/bash" ]]; then
  chsh -s "${BREW_PREFIX}/bin/bash"
  exec "${BREW_PREFIX}/bin/bash" -l
fi

brew update

# install brews from Brewfile
brew bundle --file="$DOTFILES_DIR/install/Brewfile"

# install casks from Caskfile
brew bundle --file="$DOTFILES_DIR/install/Caskfile" --cask

# install extensions from Codefile
while IFS= read -r extension; do
  if [[ ! -z "$extension" ]]; then
    codium --install-extension "$extension" --force
  fi
done <"$DOTFILES_DIR/install/Codefile"

brew upgrade
brew cleanup
