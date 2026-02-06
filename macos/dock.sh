#!/usr/bin/env bash

dockutil --no-restart --remove all

dockutil --no-restart --add "/System/Applications/Apps.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"
dockutil --no-restart --add "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Librewolf.app"
dockutil --no-restart --add "/Applications/Mullvad Browser.app"
dockutil --no-restart --add "/System/Applications/Music.app"
dockutil --no-restart --add "/Applications/Zed.app"
dockutil --no-restart --add "/Applications/Alacritty.app"
dockutil --no-restart --add "/Applications/Bitwarden.app"

killall Dock
