#!/usr/bin/env bash
set -euo pipefail

# Get location of this repo
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

VSCODIUM_CONFIG_SRC="$DOTFILES_DIR/vscodium/settings.json"

case "$(uname -s)" in
Darwin)
	VSCODIUM_CONFIG_DEST="$HOME/Library/Application Support/VSCodium/User/settings.json"
	;;
Linux)
	VSCODIUM_CONFIG_DEST="$HOME/.config/VSCodium/User/settings.json"
	;;
*)
	exit 1
	;;
esac

mkdir -p "$(dirname "$VSCODIUM_CONFIG_DEST")"
ln -sfvn "$VSCODIUM_CONFIG_SRC" "$VSCODIUM_CONFIG_DEST"

extensions=(
	albert.tabout
	EditorConfig.EditorConfig
	PKief.material-icon-theme
	usernamehw.errorlens
	zhuangtongfa.Material-theme
)

if ! command -v codium &>/dev/null; then
	echo "Warning: codium not found. Skipping extension installs." >&2
	exit 0
fi

for ext in "${extensions[@]}"; do
	codium --install-extension "$ext" --force
done
