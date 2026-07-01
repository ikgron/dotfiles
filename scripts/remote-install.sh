#!/usr/bin/env bash
set -euo pipefail

SOURCE="https://codeberg.org/parser/dotfiles"
TARBALL="$SOURCE/archive/refs/heads/main.tar.gz"
TARGET="$PWD/dotfiles"

is_executable() {
    type "$1" >/dev/null 2>&1
}

mkdir -p "$TARGET"
echo "Installing dotfiles..."

# Try curl first to skip xcode popup when running on a fresh macOS device
if is_executable "curl"; then
    curl -#L "$TARBALL" | tar -xzv -C "$TARGET" --strip-components=1 --exclude='.gitignore' --exclude='assets/*'

elif is_executable "git"; then
    git clone "$SOURCE" "$TARGET"

else
    echo "No curl or git available. Aborting."
    exit 1
fi
