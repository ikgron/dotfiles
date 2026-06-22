#!/usr/bin/env bash
set -eo pipefail

extensions=(
    anthropic.claude-code
    EditorConfig.EditorConfig
    PKief.material-icon-theme
    usernamehw.errorlens
    zhuangtongfa.Material-theme
)

for ext in "${extensions[@]}"; do
    codium --install-extension "$ext" --force
done
