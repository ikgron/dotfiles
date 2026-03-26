#!/usr/bin/env bash

HOMEBREW_DIR="$(dirname "${BASH_SOURCE}")"

# save homebrew’s installed location
BREW_PREFIX=$(brew --prefix)

brew install bash

# switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
  chsh -s "${BREW_PREFIX}/bin/bash"
fi

brew update

# install everything from Brewfile
brew bundle --file="$HOMEBREW_DIR/Brewfile"

brew upgrade
brew cleanup

# remove quarantine from librewolf installed via homebrew
xattr -dr com.apple.quarantine /Applications/LibreWolf.app 