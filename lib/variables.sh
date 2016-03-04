#!/usr/bin/env bash

# ##################################################
# Configuration variables
#
# VERSION 1.0.0
#
# HISTORY:
#
# * February 4, 2016 - v1.0.0  - File Created
#
# ##################################################

# Get Configuration File
# ##################################################
if [ -f "${SCRIPT_PATH}/etc/os-catalyst.cfg" ]; then
	source "${SCRIPT_PATH}/etc/os-catalyst.cfg"
else
	echo "Please find the file os-catalyst.cfg and add a reference to it in this script. Exiting."
	exit 1
fi

# Check OS Info
# ##################################################
case $OSTYPE in
	linux-gnu)
		declare -r OS_ID=$(lsb_release -si)
		case $OS_ID in
			Ubuntu)

				declare -r LIST_PATH="$SCRIPT_PATH/etc/Linux/Ubuntu"

				declare -r OS_NAME=$(lsb_release -sc)
				declare -r OS_VER=$(lsb_release -sr)
				declare -r OS_FULL=$(lsb_release -sd)

				# Gnome 3
				declare -r GEXT_PATH="$HOME/.local/share/gnome-shell/extensions"
				readarray GEXTLIST < "$LIST_PATH/GnomeExtensions.list"

				;;
			*) edie installnotsupported 'Linux';;
		esac
	;;
	darwin) 
		einf 'This is OSx'
		for core_file in "${SOURCE_PATH}"/osx/*.sh; do
			if [ -e "${core_file}" ]; then
				source "$core_file"
			fi
		done
		;;
esac

readarray APPSLIST < "$LIST_PATH/App.list"
readarray DIRLIST < "$LIST_PATH//Directories.list"
readarray PURGELIST < "$LIST_PATH//Purge.list"
