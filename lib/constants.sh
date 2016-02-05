#!/usr/bin/env bash

# ##################################################
# Read only variables for library
#
# VERSION 1.0.0
#
# HISTORY:
#
# * October 31, 2015 - v1.0.0  - File Created
#
# ##################################################

# ############### Library Globals ##################
# ##################################################

# Script Name
# ##################################################
# Will return the name of the script being run
# ##################################################
declare -r SCRIPT_NAME="$(basename $0)"                                    # Set Script Name variable
declare -r SCRIPT_BASE_NAME="$(basename ${SCRIPT_NAME} .sh)"               # Strips '.sh' from scriptName

# Timestamps
# ##################################################
# Prints the current date and time in a variety of
# formats:
# ##################################################
declare -r NOW=$(date +"%m-%d-%Y %r")                                      # Returns: 06-14-2015 10:34:40 PM
declare -r DATE_STAMP=$(date +%Y-%m-%d)                                    # Returns: 2015-06-14
declare -r HOUR_STAMP=$(date +%r)                                          # Returns: 10:34:40 PM
declare -r TIME_STAMP=$(date +%Y%m%d_%H%M%S)                               # Returns: 20150614_223440
declare -r TODAY=$(date +"%m-%d-%Y")                                       # Returns: 06-14-2015

# This Host
# ##################################################
# Will print the current hostname of the computer
# the script is being run on.
# ##################################################
declare -r THIS_HOST=$(hostname)

# Versions
# ##################################################
# Will print the current version of a specific
# application
# ##################################################

declare -r UB_CODENAME=$(lsb_release -sc)
declare -r UB_OSNAME=$(lsb_release -si)
declare -r UB_RELEASE=$(lsb_release -sr)
declare -r UB_FULLID=$(lsb_release -sd)

declare -r GS_VERSION=$(gnome-shell --version | sed 's/.* //')

# Color Palette
# ##################################################
# Colors Could be 2, 8, 16, 88 and 256 are common
# values
# ##################################################
declare -r T_BLUE="$(tput setaf 32)"
declare -r T_BLUE_DK="$(tput setaf 12)"
declare -r T_CYAN="$(tput setaf 6)"
declare -r T_BLUE_LG="$(tput setaf 4)"
declare -r T_PURPLE="$(tput setaf 171)"
declare -r T_PURPLE_DK="$(tput setaf 141)"
declare -r T_PURPLE_LT="$(tput setaf 13)"
declare -r T_PURPLE_LG="$(tput setaf 5)"
declare -r T_YELLOW="$(tput setaf 184)"
declare -r T_YELLOW_LT="$(tput setaf 226)"
declare -r T_ORANGE="$(tput setaf 172)"
declare -r T_YELLOW_LG="$(tput setaf 3)"
declare -r T_RED="$(tput setaf 124)"
declare -r T_RED_DK="$(tput setaf 124)"
declare -r T_RED_LT="$(tput setaf 196)"
declare -r T_RED_LG="$(tput setaf 1)"
declare -r T_GREEN="$(tput setaf 056)"
declare -r T_GREEN_DK="$(tput setaf 043)"
declare -r T_GREEN_LT="$(tput setaf 060)"
declare -r T_GREEN_LG="$(tput setaf 2)"
declare -r T_WHITE="$(tput setaf 231)"
declare -r T_WHITE_DK="$(tput setaf 250)"
declare -r T_WHITE_LT="$(tput setaf 256)"
declare -r T_WHITE_LG="$(tput setaf 7)"
declare -r T_BOLD="$(tput bold)"
declare -r T_UL="$(tput smul)"
declare -r RESET="$(tput sgr0)"

# PATHS
# ##################################################
declare -r APT_SRCLIST_PATH='/etc/apt/sources.list.d'

declare -r APPDIR_PATH="$HOME/Applications"
declare -r CODEDIR_PATH="$HOME/Code"
declare -r PROJDIR_PATH="$HOME/Projects"
declare -r SCRIPTDIR_PATH="$HOME/Scripts"
declare -r LOCALHOSTDIR_PATH="$HOME/www"

declare -r COMPOSER_PATH='/usr/local/bin'
declare -r ESPRESSO_PATH="$HOME/Applications/espresso"

# ################ Script Globals ##################
# ##################################################

declare -r FULLNAME="Brian Garland"
declare -r EMAIL="brian@efelle.com"

declare -r LOCAL_DB_HOST="localhost"
declare -r LOCAL_DB_USER="root"
declare -r LOCAL_DB_PASS=""

# ################ Get File Data ###################
# ##################################################

readarray APPSLIST < "$SCRIPT_PATH/etc/App.list"
readarray DIRLIST < "$SCRIPT_PATH/etc/Directories.list"
readarray REPOLIST < "$SCRIPT_PATH/etc/Repositories.list"
readarray DEBLIST < "$SCRIPT_PATH/etc/DebPackages.list"
readarray GEXTLIST < "$SCRIPT_PATH/etc/GnomeExtensions.list"
