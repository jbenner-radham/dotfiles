#!/usr/bin/env zsh

# Based upon: https://mths.be/macos
# Additional settings from:
#  - https://gitlab.com/dnsmichi/dotfiles/-/blob/main/.macos
#  - https://medium.com/@laclementine/dotfile-for-mac-efe082ad0d6a
#  - https://github.com/sapegin/dotfiles/blob/master/setup/osx.sh

# You can view the current settings with `defaults read`.

print '\nThis script will apply system settings and as a precaution will' \
  'close "System Settings" if it is open.\n'

if ! read -q '_input?Do you wish to proceed? Press (Y/y) to continue: '; then
  print
  exit
fi

print

# Close any open System Setting panes, to prevent them from overriding settings
# we’re about to change. We could use `killall`, but it returns 1 if no
# instances are open.
osascript -e 'tell application "System Settings" to quit'

###############################################################################
# Menu Bar                                                                    #
###############################################################################

# Disable Siri
# sudo defaults write com.apple.Siri StatusMenuVisible -bool false
# sudo defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Show battery percentage
# sudo defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Show bluetooth icon
# sudo defaults -currentHost write com.apple.controlcenter Bluetooth -int 18

# Show volume icon
# sudo defaults -currentHost write com.apple.controlcenter Sound -int 18

###############################################################################
# System                                                                      #
###############################################################################

# Enable Firewall
# /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
# /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
# defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 1
# defaults write NSGlobalDomain InitialKeyRepeat -int 10

###############################################################################
# Energy saving                                                               #
###############################################################################

# Enable lid wakeup
# sudo pmset -a lidwake 1

# Sleep the display after 15 minutes
# sudo pmset -a displaysleep 15

# Disable machine sleep while charging
# sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
# sudo pmset -b sleep 5

# Set standby delay to 24 hours (default is 1 hour)
# sudo pmset -a standbydelay 86400

# Never go into computer sleep mode
# sudo systemsetup -setcomputersleep Off > /dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Set screenshots save location
local -r screenshots_dir="${HOME}/Pictures/Screenshots"
mkdir -p "${screenshots_dir}"
defaults write com.apple.screencapture location -string "${screenshots_dir}"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
# defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Allow quitting via ⌘ + Q; doing so will also hide desktop icons
# defaults write com.apple.finder QuitMenuItem -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
# defaults write com.apple.finder NewWindowTarget -string "PfDe"
# defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
# defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
# defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
# defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
# defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
# defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
# chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
# sudo chflags nohidden /Volumes

# Disable the warning before emptying the Trash
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Remove Dropbox’s green checkmark icons in Finder
# file=/Applications/Dropbox.app/Contents/Resources/check.icns
# [ -e "$file" ] && mv -f "$file" "$file.bak"
# unset file

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
# defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Minimize windows into their application’s icon
# defaults write com.apple.dock minimize-to-application -bool true

# Show only open applications in the Dock
# defaults write com.apple.dock static-only -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Misc                                                                        #
###############################################################################

# Check spelling as you type
defaults write -g CheckSpellingWhileTyping -boolean true

# Enable continuous spell checking everywhere (don't know what it means)
defaults write -g WebContinuousSpellCheckingEnabled -boolean true

# Disable Notification Center
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
# defaults write com.apple.Safari UniversalSearchEnabled -bool false
# defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
# defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
# defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
# defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
# defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Warn about fraudulent websites
# defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
# defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
# defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
# defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
# defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Enable “Do Not Track”
# defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
# defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# iTerm2                                                                      #
###############################################################################

# Specify the preferences directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${XDG_CONFIG_HOME:-${HOME}/.config}/iterm2"

# Tell iTerm2 to use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Don’t display a confirmation prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Disk Utility                                                                #
###############################################################################

# Enable the debug menu
# defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

print '\nAll potentially affected applications are about to be killed.\n'

if ! read -q '_input?Do you wish to proceed? Press (Y/y) to continue: '; then
  print '\n\nSettings applied. You may need to restart your system for all of' \
    'them to take affect.'
  exit
fi

for process in 'cfprefsd' 'SystemUIServer'; do
  killall "${process}"
done

for app in 'Dock' 'Finder' 'Safari'; do
  osascript -e "tell application \"${app}\" to quit"
done

# if [[ "${TERM_PROGRAM}" = 'iTerm.app' ]]; then
#   print 'You may have to restart iTerm to apply any setting changes.'
# else
#   osascript -e 'tell application "iTerm2" to quit'
# fi

print '\n\nSettings applied. A system restart may be required for them' \
  'to take affect.'
