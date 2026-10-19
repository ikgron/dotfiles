#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew if it isn't already
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed."
fi
eval "$(/opt/homebrew/bin/brew shellenv bash)"

brew analytics off
brew update
brew upgrade

echo "Installing everything from Brewfile"
brew bundle --file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Brewfile"

[[ -d /Applications/LibreWolf.app ]] && xattr -dr com.apple.quarantine /Applications/LibreWolf.app

brew cleanup

echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."
