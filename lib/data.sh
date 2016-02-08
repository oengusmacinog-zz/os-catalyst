#!/usr/bin/env bash

# ##################################################
# Temporary data storage in array till better
# solution comes along.
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 25, 2015 - v1.0.0  - File Created
#
# ##################################################

# ############### Library Globals ##################
# ##################################################

declare -Ax TITLE_INFO=([curl]='Curl' [dtrx]='Do The Right Extraction (dtrx)' [git]='Git' [sublime-text]='Sublime Text:3' [google-chrome-stable]='Google Chrome' [rabbitvcs-nautilus-3.0]='RabbitVCS' [mysql-workbench]='MySQL Workbench' [filezilla]='Filezilla Client' [tasksel]='Tasksel' [spotify-client]='Spotify' [geary]='Geary' [gimp]='GNU Image Manipulation Program (GIMP)' [rar]='RAR' [unrar]='UNRAR' [chromium-browser]='Chromium' [autoconf]='Autoconf' [libgcrypt11]='LGPL crypto library:for:Spotify' [slack-desktop]='Slack Desktop')

readonly -A TITLE_INFO

declare -Ax LINK_INFO=([libgcrypt11]='https://launchpad.net/ubuntu/+archive/primary/+files/libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb' [slack-desktop]='https://slack-ssb-updates.global.ssl.fastly.net/linux_releases/slack-desktop-1.2.4-amd64.deb' [sublime-text]='https://download.sublimetext.com/sublime-text_build-3083_amd64.deb')

readonly -A LINK_INFO

declare -ax PHP_MODS=('php5-json' 'php5-curl' 'php5-gd' 'php5-mcrypt')

readonly -A PHP_MODS

declare -Ax GNOME_EXT_IDS=([simple-dock]='815' [applications-menu]='6' [clipboard-indicator]='779' [remove-dropdown-arrows]='800' [autohide-battery]='595' [do-not-disturb-button]='964' [impatience]='277' [no-topleft-hot-corner]='118' [dash-to-dock]='307' [appmenu-regular-icons]='970')
