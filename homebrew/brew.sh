#!/usr/bin/env bash

HOMEBREW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# install everything from Brewfile
brew bundle --file="$HOMEBREW_DIR/Brewfile"

brew upgrade
brew cleanup
