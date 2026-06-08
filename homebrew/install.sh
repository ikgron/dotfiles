#!/usr/bin/env bash

set -e

# Install Homebrew if it isn't already
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv bash)"
else
    echo "Homebrew is already installed."
    eval "$(/opt/homebrew/bin/brew shellenv bash)"
fi

echo "Updating Homebrew..."
brew update
brew upgrade

brew install bash

# Switch to using brew-installed bash as default shell
if ! fgrep -q "$(brew --prefix)/bin/bash" /etc/shells; then
    echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
    chsh -s "$(brew --prefix)/bin/bash"
fi

echo "Installing everything from Brewfile"
brew bundle --file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Brewfile"

xattr -dr com.apple.quarantine /Applications/LibreWolf.app

brew cleanup
brew analytics off

exec bash
