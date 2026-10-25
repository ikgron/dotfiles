#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

source "$DOTFILES_DIR/scripts/lib.sh"
shared_setup "$DOTFILES_DIR"

# Apply system preferences and set dock
read -rp "Apply macOS defaults now? (y/n): " confirm
	if [[ "$confirm" =~ ^[Yy]$ ]]; then
		bash "$DOTFILES_DIR/macos/defaults.sh"
	fi

# Switch to using brew-installed bash as default shell
BREW_BASH="$(brew --prefix)/bin/bash"
if ! grep -Fqx "$BREW_BASH" /etc/shells; then
    echo "$BREW_BASH" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$BREW_BASH" ]]; then
    chsh -s "$BREW_BASH"
fi

echo "Run 'source ~/.bash_profile' or open a new terminal to reload your shell."

: '
To use Touch ID for sudo:
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo nano /etc/pam.d/sudo_local

Uncomment:
auth sufficient pam_tid.so
'
