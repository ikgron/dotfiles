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

# Shared setup
shared_setup() {
	local dotfiles_dir="$1"

	mkdir -p -- "$HOME/.config"
	link_files "$dotfiles_dir/config" "$HOME/.config"
	link_files "$dotfiles_dir/home" "$HOME"

	if command -v git >/dev/null 2>&1; then
		local confirm username email
		read -rp "Setup Git now? (y/n): " confirm

		if [[ "$confirm" =~ ^[Yy]$ ]]; then
			read -rp "Username: " username
			read -rp "Email: " email

			git config --file "$dotfiles_dir/config/git/config.local" \
				user.name "$username"
			git config --file "$dotfiles_dir/config/git/config.local" \
				user.email "$email"
			git config --file "$dotfiles_dir/config/git/config.local" \
				user.signingKey "$HOME/.ssh/id_ed25519.pub"
		fi
	fi

	# Install extensions if VSCodium is installed
	if command -v codium &>/dev/null; then
		read -rp "Symlink VSCodium settings.json and install extensions now? (y/n): " confirm

		if [[ "$confirm" =~ ^[Yy]$ ]]; then
			bash "$dotfiles_dir/vscodium/vscodium.sh"
		fi
	fi
}
