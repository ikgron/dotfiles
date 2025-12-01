#!/usr/bin/env bash

export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> "$HOME/.bash_profile"
