#!/usr/bin/env bash
#
# Common Description of whole program that is in all shared files.
# This will say the same thing in other library files.
#
# This file:
#     - What this file specifically does
#
# More info:
#     - https://github.com/oengusmacinog/bash-script-foundation
#
# Version 1.0.0
#
# HISTORY:
#
# * November 23, 2015 - 1.0.0 - Library Created
#
# Authors:
#     - Brian Garland (http://brigarland.io)
#
# #####################################################################

# ########################## Script UI/UX #############################
# #####################################################################



# ########################## Library UI/UX ############################
# #####################################################################

# Seeking Confirmation
# #####################################################################
# Asks questions of a user and then does something with the answer.
# y/n are the only possible answers.
#
# USAGE:
# seek_confirmation "Ask a question"
# if is_confirmed; then
#   some action
# else
#   some other action
# fi
#
# Credt: https://github.com/kevva/dotfiles
# #####################################################################

# Ask the question
function seek_confirmation() {
  echo ""
  input "$@"
  if [[ "${force}" == "1" ]]; then
    notice "Forcing confirmation with '--force' flag set"
  else
    read -p " (y/n) " -n 1
    echo ""
  fi
}

# Test whether the result of an 'ask' is a confirmation
function is_confirmed() {
  if [[ "${force}" == "1" ]]; then
    return 0
  else
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
  fi
}

function is_not_confirmed() {
  if [[ "${force}" == "1" ]]; then
    return 1
  else
    if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
      return 0
    fi
    return 1
  fi
}


# Skip something
# ------------------------------------------------------
# Offer the user a chance to skip something.
# Credit: https://github.com/cowboy/dotfiles
# ------------------------------------------------------
function skip() {
  REPLY=noskip
  read -t 5 -n 1 -s -p "${bold}To skip, press ${underline}X${reset}${bold} within 5 seconds.${reset}"
  if [[ "$REPLY" =~ ^[Xx]$ ]]; then
    notice "  Skipping!"
    return 0
  else
    notice "  Continuing..."
    return 1
  fi
}


# help
# ------------------------------------------------------
# Prints help for a script when invoked from the command
# line.  Typically via '-h'.  If additional flags or help
# text is available in the script they will be printed
# in the '$usage' variable.
# ------------------------------------------------------

function help () {
  echo "" 1>&2
  input "   ${@}" 1>&2
  if [ -n "${usage}" ]; then # print usage information if available
    echo "   ${usage}" 1>&2
  fi
  echo "" 1>&2
  exit 1
}

# pauseScript
# -----------------------------------
# A simple function used to pause a script at any point and
# only continue on user input
# -----------------------------------

function pauseScript() {
  seek_confirmation "Ready to continue?"
  if is_confirmed; then
    info "Continuing"
  fi
}
