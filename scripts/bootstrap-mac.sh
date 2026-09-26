#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
os="$(uname)"

if [[ "$os" == "Darwin" ]]; then
    # Symlink VSCodium settings
    mkdir -p "$HOME/Library/Application Support/VSCodium/User"
    ln -sfv \
        "$DOTFILES_DIR/vscode/settings.json" \
        "$HOME/Library/Application Support/VSCodium/User/settings.json"

    # Install VSCode extensions and set system preferences and dock
    bash "$DOTFILES_DIR/macos/defaults.sh"

    echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."
else
    echo "Unsupported OS: $os"
    exit 1
fi
