#!/usr/bin/env bash

set -eo pipefail

# Install Homebrew if it isn't already
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi
eval "$(/opt/homebrew/bin/brew shellenv bash)"

echo "Updating Homebrew..."
brew update
brew upgrade

brew install bash

# Switch to using brew-installed bash as default shell
if ! grep -Fq "$(brew --prefix)/bin/bash" /etc/shells; then
    echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
    chsh -s "$(brew --prefix)/bin/bash"
fi

echo "Installing everything from Brewfile"
brew bundle --file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Brewfile"

[[ -d /Applications/LibreWolf.app ]] && xattr -dr com.apple.quarantine /Applications/LibreWolf.app

brew cleanup
brew analytics off

echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."
