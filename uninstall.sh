#!/usr/bin/env bash
set -eo pipefail
# Removes symlinks created by bootstrap.sh.
# Only removes a symlink if it still points into this repo — never touches real files.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"

echo "Removing symlinks created by bootstrap.sh..."

shopt -s dotglob nullglob

# Remove symlinked config folders and files
for item in "$CONFIG_SRC"/*; do
    name=$(basename "$item")
    target="$CONFIG_DEST/$name"
    if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$item" ]]; then
        rm -v "$target"
    fi
done

# Remove symlinked home files
for file in "$DOTFILES_DIR"/home/*; do
    if [[ -f "$file" ]]; then
        target="$HOME/$(basename "$file")"
        if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$file" ]]; then
            rm -v "$target"
        fi
    fi
done

shopt -u dotglob nullglob

echo "Done"
