#!/usr/bin/env bash
set -euo pipefail

if ! command -v prettier >/dev/null 2>&1 || ! command -v shfmt >/dev/null 2>&1; then
	echo "Missing dependency"
	exit 1
fi

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd

# Format supported files with Prettier.
prettier . --write --ignore-unknown

# Format shell scripts and Bash dotfiles with tabs.
find . -path './.git' -prune -o -type f \( \
	-name '*.sh' \
	-o -name '*.bash' \
	-o -name '.aliases' \
	-o -name '.bash_profile' \
	-o -name '.bashrc' \
	-o -name '.exports' \
	-o -name '.bash_prompt' \
	\) -exec shfmt -ln bash -i 0 -w {} +

echo "Formatted!"
