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

remove_repo() {
	case $1 in
		*Partners*|*partners*)
			edie runassudo

			if repo_l_installed "## deb http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner"; then
			    emes actneg 'Canonical Partners' '' 'Repository' 'Removing'
			    sed -i "s/deb http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner/## deb http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner/g" /etc/apt/sources.list
			    sed -i "s/deb-src http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner/## deb-src http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner/g" /etc/apt/sources.list
				progress_spinner $!
				econ check repo_l_not_installed "## deb http:\/\/archive.canonical.com\/ubuntu $OS_NAME partner"
			else
				emes infneg 'Canonical' 'Partners' 'repository'
			fi
			;;
		*Numix*|*numix*)
			if repo_installed "$1"; then
				emes actneg 'Numix' '' 'PPA' 'Removing'
				rm "/etc/apt/sources.list.d/numix-ubuntu-ppa-${OS_NAME}.list"
	    		rm "/etc/apt/sources.list.d/numix-ubuntu-ppa-${OS_NAME}.list.save"
	    		progress_spinner $!
	    		econ check repo_not_installed numix
			else
	    		emes infneg 'Numix repository'
			fi
            ;;
		* )
			emes actneg "$1 repository" 'currently not supported' '' "I\'m sorry,"
			eerr -i
	        ;;
	esac
}
