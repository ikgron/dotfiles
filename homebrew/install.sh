#!/usr/bin/env bash

# Check if homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed..."
fi

echo "Make sure to run 'exec bash --login' after adding 'brew' to PATH"
