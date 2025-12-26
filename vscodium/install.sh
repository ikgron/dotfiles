#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

 # install extensions from Codefile
 while IFS= read -r extension; do
  if [[ ! -z "$extension" ]]; then
    codium --install-extension "$extension" --force
  fi
done < "$SCRIPT_DIR/Codefile"
