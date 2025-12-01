COMPUTER_NAME="ThinkPad"
SCREENSHOTS_FOLDER="${HOME}/Screenshots"

osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Computer & Host name                                                        #
###############################################################################

# Set computer name
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

###############################################################################
# System                                                                      #
###############################################################################

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# group windows by application
defaults write com.apple.dock "expose-group-apps" -bool "true"

# do not autogather large files when submitting a report
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false"

# disable rich text
defaults write com.apple.TextEdit "RichText" -bool "false"

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, Bluetooth accessories                                      #
###############################################################################

# Tap to click for this user
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

# require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# save screenshots to the ~/Screenshots folder
mkdir -p "${SCREENSHOTS_FOLDER}"
defaults write com.apple.screencapture location -string "${SCREENSHOTS_FOLDER}"

# save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# avoid creating .DS_Store files on network
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# set icon view
defaults write com.apple.finder "FXPreferredViewStyle" -string "icnv"

# remove trash after 30 days
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

###############################################################################
# Dock                                                                        #
###############################################################################

# show indicator for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# don't show recently used applications in the Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Software Updates                                                            #
###############################################################################

# enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true

# install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "TextEdit"; do
  killall "${app}" &>/dev/null
done
