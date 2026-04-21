#!/usr/bin/env bash

VSCODIUM_DIR="$(dirname "${BASH_SOURCE}")"

# Install extensions from Codefile
while IFS= read -r extension; do
  if [[ ! -z "$extension" ]]; then
    codium --install-extension "$extension" --force
  fi
done <"$VSCODIUM_DIR/Codefile"
