#!/usr/bin/env bash
set -euo pipefail

extensions=(
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
