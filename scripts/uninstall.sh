#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
OS="$(uname -s)"

# Remove a symlink only if it points to a file in this repo (mainly for VSCodium since it's in a weird place on mac)
remove_if_linked() {
    local target="$1"
    local source="$2"
    local use_sudo="${3:-false}"

    if [[ -L "$target" ]] && [[ "$(readlink -- "$target")" == "$source" ]]; then
        if [[ "$use_sudo" == true ]]; then
            sudo rm -- "$target"
        else
            rm -- "$target"
        fi

        echo "Removed: $target"
    fi
}

# Remove symlinked files while leaving all folders and other files untouched
remove_files() {
    local src_root="$1"
    local dest_root="$2"
    local use_sudo="${3:-false}"

    [[ -d "$src_root" ]] || return 0

    find "$src_root" -type f -print0 |
        while IFS= read -r -d '' src_file; do
            local relative_path="${src_file#"$src_root"/}"
            local dest_file="$dest_root/$relative_path"

            remove_if_linked "$dest_file" "$src_file" "$use_sudo"
        done
}

# ~/.config symlinks
remove_files \
    "$DOTFILES_DIR/config" \
    "$HOME/.config"

# ~/ symlinks
remove_files \
    "$DOTFILES_DIR/home" \
    "$HOME"

case "$OS" in
    Linux)
        # Linux config files
        remove_files \
            "$DOTFILES_DIR/linux/config" \
            "$HOME/.config"

        # Linux system files
        remove_files \
            "$DOTFILES_DIR/linux/system" \
            "/etc" \
            true

        # Linux VSCodium settings
        remove_if_linked \
            "$HOME/.config/VSCodium/User/settings.json" \
            "$DOTFILES_DIR/vscodium/settings.json"
        ;;

    Darwin)
        # macOS VSCodium settings
        remove_if_linked \
            "$HOME/Library/Application Support/VSCodium/User/settings.json" \
            "$DOTFILES_DIR/vscodium/settings.json"
        ;;

    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "Done"
