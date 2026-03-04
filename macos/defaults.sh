COMPUTER_NAME="ThinkPad"
SCREENSHOTS_FOLDER="${HOME}/Screenshots"

osascript -e 'tell application "System Settings" to quit'

# ask for administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until this script has finished
while "true"; do
  sudo -n "true"
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Computer & Host name                                                        #
###############################################################################

# set computer name
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

###############################################################################
# System                                                                      #
###############################################################################

# menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool "false"

# save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool "false"

# group windows by application
defaults write com.apple.dock "expose-group-apps" -bool "true"

# disable rich text
defaults write com.apple.TextEdit "RichText" -bool "false"

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# disable typing automatic capitalization.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool "false"

# disable typing automatic period substition a.k.a. "smart stops".
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -int 0

# disable typing automatic dash substitution e.g. "smart dashes".
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool "false"

# disable typing automatic quote substitution a.k.a. "smart quotes".
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool "false"

# disable typing automatic spelling correction a.k.a. "auto-correct".
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool "false"

# enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Trackpad, mouse, Bluetooth accessories                                      #
###############################################################################

# tap to click for this user
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool "true"
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool "false"

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
defaults write com.apple.screencapture disable-shadow -bool "true"

###############################################################################
# Finder                                                                      #
###############################################################################

# finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool "true"

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool "true"

# finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool "true"

# avoid creating .DS_Store files on network
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"

###############################################################################
# Dock                                                                        #
###############################################################################

# don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool "false"

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool "true"

# make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool "true"

# don't show recently used applications in the Dock
defaults write com.apple.dock show-recents -bool "false"

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" "SystemUIServer" "TextEdit"; do
  killall "${app}" &>/dev/null
done
