#!/usr/bin/env bash
#
# Post Install Script for Ubuntu 15.10 with Gnome 3.16
#
# This file:
#  - Functions for the uninstall and clean up processes
#
# More info:
#  - https://github.com/oengusmacinog/ubuntu-post-install
#
# Version 1.0.0
#
# Authors:
#  - Brian Garland (http://brigarland.io)
#

# Apt-Get Installation
# ##################################################
# Usage:
#    remove_package [dpkg name]
# ##################################################
remove_package() {
	#Trim extra white space from end of file gatherd app names
	local pkg=$(echo "$1" | trim)

	# If better formatted names are accessable use them for messages
	[ -n "${TITLE_INFO[$pkg]}" ] && local pkg_temp=$(echo "${TITLE_INFO[$pkg]}" | trim) || local pkg_temp="$pkg"

	if [[ "$pkg_temp" != "${pkg_temp%%:*}" ]]; then
		pkg_title=$pkg_temp
	else
		pkg_title=${pkg_temp%%:*}
	fi

	set +o errexit

	if dpkg_not_installed "$pkg"; then
		emes infneg $pkg_title
		return
	fi

	emes actneg 'Removing' $pkg_title


	apt-get purge -y "$pkg" >> $TMP_DIR/temp_output.log 2>&1 &
    progress_spinner $!

    econ check dpkg_not_installed $1

	set -o errexit

}
