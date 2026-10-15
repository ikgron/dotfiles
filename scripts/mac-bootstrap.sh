#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    VSCODIUM_CONFIG_SRC="$DOTFILES_DIR/vscodium/settings.json"
    VSCODIUM_CONFIG_DEST="$HOME/Library/Application Support/VSCodium/User/settings.json"

    # Symlink VSCodium settings
    mkdir -p -- "$(dirname "$VSCODIUM_CONFIG_DEST")"
    ln -sfv -- "$VSCODIUM_CONFIG_SRC" "$VSCODIUM_CONFIG_DEST"

    # Apply system preferences and set dock
    bash "$DOTFILES_DIR/macos/defaults.sh"

    # Switch to using brew-installed bash as default shell
    if ! grep -Fq "$(brew --prefix)/bin/bash" /etc/shells; then
        echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
        chsh -s "$(brew --prefix)/bin/bash"
    fi

    echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."

else
    echo "Unsupported OS: $OS"
    exit 1
fi

: '
To use Touch ID for sudo:
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo nano /etc/pam.d/sudo_local

Uncomment:
auth sufficient pam_tid.so
'
