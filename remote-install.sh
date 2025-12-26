#!/usr/bin/env bash

SOURCE="https://codeberg.org/parser/dotfiles"
TARBALL="$SOURCE/archive/refs/heads/main.tar.gz"
TARGET="$HOME/Projects/dotfiles"
TAR_CMD="tar -xzv -C "$TARGET" --strip-components=1 --exclude='{.gitignore}' --exclude='assets/*'"

is_executable() {
  type "$1" >/dev/null 2>&1
}

# try curl first to skip xcode popup when running on a fresh macOS device
if is_executable "curl"; then
  CMD="curl -#L $TARBALL | $TAR_CMD"

elif is_executable "git"; then
  CMD="git clone $SOURCE $TARGET"

elif is_executable "wget"; then
  CMD="wget --no-check-certificate -O - $TARBALL | $TAR_CMD"
fi

if [ -z "$CMD" ]; then
  echo "No git, curl or wget available. Aborting."

else
  echo "Installing dotfiles..."
  mkdir -p "$TARGET"
  eval "$CMD"
fi
