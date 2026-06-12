#!/usr/bin/env bash
set -eo pipefail

COMPUTER_NAME="ThinkPad"

osascript -e 'tell application "System Settings" to quit'

# Ask for administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `defaults.sh` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Set computer name
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Finder
# allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# show hidden files/folders by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Dock
if command -v dockutil &>/dev/null; then
    dockutil --no-restart --remove all

    dockutil --no-restart --add "/System/Applications/Apps.app"
    dockutil --no-restart --add "/System/Applications/System Settings.app"
    dockutil --no-restart --add "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
    dockutil --no-restart --add "/Applications/LibreWolf.app"
    dockutil --no-restart --add "/Applications/Mullvad Browser.app"
    dockutil --no-restart --add "/System/Applications/Music.app"
    dockutil --no-restart --add "/Applications/Zed.app"
    dockutil --no-restart --add "/Applications/Ghostty.app"
    dockutil --no-restart --add "/Applications/Bitwarden.app"
    echo "Dock set"
else
    echo "Warning: dockutil not installed."
fi

# Kill affected apps
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" &>/dev/null
done
