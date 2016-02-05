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

# needSudo
# ##################################################
# If a script needs sudo access, call this function
# which requests sudo access and then keeps it alive.
#
# Update existing sudo time stamp if set, otherwise
# do nothing.
# ##################################################
needSudo() {
	sudo -v
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}

# Test for sudo
# ##################################################
# Usage:
#    if is_sudo; then
#      some action
#    else
#      some other action
#    fi
# ##################################################

is_sudo() {
	if [ "${USER}" == "root" ]; then
		return 0
	fi
	return 1
}

is_not_sudo() {
	if [ "${USER}" != "root" ]; then
		return 0
	fi
	return 1
}

# Test whether a command exists
# ##################################################
# Usage:
#    if type_exists 'git'; then
#      some action
#    else
#      some other action
#    fi
# ##################################################

type_exists() {
	if [ $(type -P "$1") ]; then
		return 0
	fi
	return 1
}

type_not_exists() {
	if [ ! $(type -P "$1") ]; then
		return 0
	fi
	return 1
}

# Test debian package
# ##################################################
# Usage:
#    if dpkg_installed 'git'; then
#      some action
#    else
#      some other action
#    fi
# ##################################################

dpkg_installed() {
	if [ $(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
		return 0
	fi
	return 1
}

dpkg_not_installed() {
	if [ ! $(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
		return 0
	fi
	return 1
}

# Test for apt repository
# ##################################################
# Usage:
#    if repo_installed 'chrome'; then
#      some action
#    else
#      some other action
#    fi
# ##################################################
repo_installed() {
	if [[ -f "$APT_SRCLIST_PATH/$1" ]]; then
		return 0
	fi
	return 1
}

repo_not_installed() {
	if [[ ! -f "$APT_SRCLIST_PATH/$1" ]]; then
		return 0
	fi
	return 1
}

# Test success of last command
# ##################################################
# Usage:
#    if was_successful $?; then
#      some action
#    else
#      some other action
#    fi
# ##################################################
was_successful() {
	if test $1 -eq 0; then
        return 0
    fi
	return 1
}

was_not_successful() {
	if ! test $1 -eq 0; then
        return 0
    fi
	return 1
}

# File Checks
# ##################################################
# A series of functions which make checks against
# the filesystem. For use in if/then statements.
#
# Usage:
#    if is_file "file"; then
#       ...
#    fi
# ##################################################

is_exists() {
	if [[ -e "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_exists() {
	if [[ ! -e "$1" ]]; then
		return 0
	fi
	return 1
}

is_file() {
	if [[ -f "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_file() {
	if [[ ! -f "$1" ]]; then
		return 0
	fi
	return 1
}

is_dir() {
	if [[ -d "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_dir() {
	if [[ ! -d "$1" ]]; then
		return 0
	fi
	return 1
}

is_symlink() {
	if [[ -L "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_symlink() {
	if [[ ! -L "$1" ]]; then
		return 0
	fi
	return 1
}

is_empty() {
	if [[ -z "$1" ]]; then
		return 0
	fi
	return 1
}

is_not_empty() {
	if [[ -n "$1" ]]; then
		return 0
	fi
	return 1
}

# Test which OS the user runs
# ##################################################
#
# Arguments:
#   [$1] => 'OS to test' string
# Usage:
#    if is_os 'linux-gnu'; then
#       ...
#    fi
# ##################################################

is_os() {
	if [[ "${OSTYPE}" == $1* ]]; then
		return 0
	fi
	return 1
}

function in_array() {
    # Determine if a value is in an array.
    # Usage: in_array [VALUE] [ARRAY]
    local value=$1; shift
    for item in "$@"; do
        [[ $item == $value ]] && return 0
    done
    return 1
}

# Strings
# ##################################################

is_in_str() {
	if [ $(echo $2 | grep $1) ]; then
		return 0
	fi
	return 1
}

is_not_in_str() {
	if [ ! $(echo $2 | grep $1) ]; then
		return 0
	fi
	return 1
}
