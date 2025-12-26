#!/bin/bash

VSCODIUM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

 # install extensions from Codefile
 while IFS= read -r extension; do
  if [[ ! -z "$extension" ]]; then
    codium --install-extension "$extension" --force
  fi
done < "$VSCODIUM_DIR/Codefile"
