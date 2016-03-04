#!/usr/bin/env bash
#
# OS X Script Start
#
# This file:
#  - Functions for the installation processes
#
# More info:
#  - https://github.com/oengusmacinog/os-catalyst
#
# Version 1.0.0
#
# Authors:
#  - Brian Garland (http://brigarland.io)
#

osx-dependencies() {

	if ! cmd_exists 'brew'; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi

    print_result $? 'Homebrew'

    if ! "$(brew cask search chrome)"; then
    	printf "\n" | ruby -e "$(brew cask search chrome)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi

    print_result $? 'Cask'
}

# Apt-Get Installation
# ##################################################
# Usage:
#    install_package [dpkg name] [opt title str]
# ##################################################
osx_function() {
	
	gosudo()

	# Set computer name (as done via System Preferences → Sharing)
	sudo scutil --set ComputerName $machine_name
	sudo scutil --set HostName $machine_name
	sudo scutil --set LocalHostName $machine_name
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $machine_name

	# Set standby delay to 24 hours (default is 1 hour)
	sudo pmset -a standbydelay 86400

	# Disable the sound effects on boot
	sudo nvram SystemAudioVolume=" "

	# Enable menubar transparency
	defaults write com.apple.universalaccess reduceTransparency -bool false

	# Set highlight color to green
	defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

	# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
	# all wallpapers are in `/Library/Desktop Pictures/`.
	cp -rf "$SCRIPT_PATH/opt/graphics/wallpaper/*" "$HOME/Library/Desktop Pictures/"
	rm -rf ~/Library/Application Support/Dock/desktoppicture.db
	sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
	case $usr_wallpaper in
        teksyndicate) usr_wallpaper='teksyndicate_1.png';;
        *) :;;
    esac
	sudo ln -s "/Library/Desktop Pictures/$usr_wallpaper" "/System/Library/CoreServices/DefaultDesktop.jpg"

	# Set language and text formats
	defaults write NSGlobalDomain AppleLanguages -array "en"
	defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
	defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
	defaults write NSGlobalDomain AppleMetricUnits -bool false

	# Set the timezone; see `sudo systemsetup -listtimezones` for other values
	sudo systemsetup -settimezone "America/Los Angeles" > /dev/null

	# Disable auto-correct
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	# Stop iTunes from responding to the keyboard media keys
	launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

	# General > check the box next to Use dark menu bar and Dock
	### Desktop & Screen Saver > click the plus sign in the bottom left corner and navigate to <mark>~/Library/wallpaper</mark> to add the set from OS Catalyst
	# Dock > check the box next to Minimize windows into application icon
	# Dock > check the box next to Automatically hide and show the Dock
	# Mission Control > check the box next to Group windows by application
	# Mission Control > select As Overlay from the Dashboard dropdown menu
	# Security & Privacy > select 1 minute from the Require password after sleep or screen saver begins dropdown menu
	# Keyboard > Key Repeat toward Fast (all the way to the right)
	# Keyboard > Delay Until Repeat toward Short (all the way to the right)
	# Keyboard > Modifier Keys... button > Switch the Commmand and Option keys.
	# Mouse > uncheck the box next to Scroll direction: natural
	# Mouse > Tracking speed toward Fast (all the way to the right)
	# Mouse > Scrolling speed toward Fast (all the way to the right)
	# Mouse > Double-Click speed toward Fast (all the way to the right)
	# Sharing > Rename your computer something unique so it can be recognized on the network
	# Users & Groups > select an avatar if you choose (if you want to set your own you will have to add it to your iCloud photos)
	# App Store > uncheck the box next to Download newly available updates in the background
	# App Store > uncheck the box next to Install system data files and security updates
	# App Store > select Require After 15 minutes from the Purchase and In-app Purchases dropdown menu
	# App Store > select Save Password from the Free Downloads dropdown menu
	# Time Machine > turn it on
	# Time Machine > check the box next to Show Time Machine in menu bar
	# Accessibility > Display tab > uncheck the box next to Shake mouse pointer to locate
	# Accessibility > Mouse & Trackpad tab > uncheck the box next to Spring-loading delay
}