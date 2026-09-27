#!/usr/bin/env bash

# Symlink files but not folders
link_files() {
    local src_root="$1"
    local dest_root="$2"

    find "$src_root" -type f -print0 |
        while IFS= read -r -d '' src_file; do
            local relative_path="${src_file#"$src_root"/}"
            local dest_file="$dest_root/$relative_path"

            mkdir -p -- "$(dirname "$dest_file")"
            ln -sfv -- "$src_file" "$dest_file"
        done
}
