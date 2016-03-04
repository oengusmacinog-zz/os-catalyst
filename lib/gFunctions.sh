#!/usr/bin/env bash

# ##################################################
# Library of functions that check for information
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 2, 2015 - v1.0.0  - Library Created
#
# ##################################################

# No Sudo
# ##################################################
# Run a command as the user even if the script is
# executed by the root user
#
# Usage:
#    nosudo "command -o arguments"
# ##################################################
nosudo() {

	if is_sudo; then
		edbg "Running as \$SUDO_USER"
		sudo -u $SUDO_USER $@
	else
		edbg "Running normal under $USER"
		$@
	fi

}

# Go Sudo
# ##################################################
# Ask for the admin password upfront and keep-alive:
# update existing `sudo` time stamp until `.osx` has
# finished.
#
# Usage:
#    nosudo "command -o arguments"
# ##################################################

gosudo() {

	sudo -v

	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

}

# Check for dependencies
# ##################################################
# Check for dependencies and install if needed
#
# Usage:
#    check_dependencies [type] [package package ...]
#    check_dependencies dpkg git curl autoconf 
# ##################################################
check_dependencies() {

	local dependency_type=$1 && shift

	case $dependency_type in

        dpkg)
			for name in "$@"; do
		        dpkg_not_installed $name &&	install_package $name || true
		    done
            ;;

        * )
            die 'Dependencies Configured incorrectly: ' "$@"
            ;;

    esac
	:
}


# Remove a file or directory without error by checking it exists
safe_rm() {

	for name in "$@"; do
        if [[ -f "$name" ]]; then
			rm --force "$name"
		fi

		if [[ -d "$name" ]]; then
			rm --recursive --force "$name"
		fi
    done	

}

# Escape a string
# ##################################################
# Usage:
#    var=$(escape "String")
# ##################################################
# escape() { 

# 	echo "${@}" | sed 's/[]\.|$(){}?+*^]/\\&/g'

# }

printspc() {
	for (( c=0; c<"$1"; c++ )); do
		echo hello
	done
}

# readFile
# ##################################################
# Function to read a line from a file.
#
# Most often used to read the config files saved in my etc directory.
# Outputs each line in a variable named $result
# ##################################################
read_file() {
	unset ${result}
	while read result
	do
		echo ${result}
	done < "$1"
}

print_array_keys() {

    local arr_str="$( declare -p $@ )"
    eval "declare -A ASS_ARR=${arr_str#*=}"

    echo "${!ASS_ARR[@]}"

}

# Text Transformations
# ##################################################
ltrim() {
  # Removes all leading whitespace (from the left).
  local char=${1:-[:space:]}
    sed "s%^[${char//%/\\%}]*%%"
}

rtrim() {
  # Removes all trailing whitespace (from the right).
  local char=${1:-[:space:]}
  sed "s%[${char//%/\\%}]*$%%"
}

trim() {
  # Removes all leading/trailing whitespace
  # Usage examples:
  #     echo "  foo  bar baz " | trim  #==> "foo  bar baz"
  ltrim "$1" | rtrim "$1"
}

# lspace() {
#   # Removes all leading whitespace (from the left).
#   local char=${1:-[:space:]}
#   sed "s%^[${char//%/\\%}]*%%"
# }

# rspace() {
#   # Removes all trailing whitespace (from the right).
#   local char=${1:-[:space:]}
#   sed "s%[${char//%/\\%}]*$%%"
# }
