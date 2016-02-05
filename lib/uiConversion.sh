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

# Library Specific Function
# #####################################################################
# This is where a function that is used by but not part of the script 
# lives. Generally it is best if these are not touched unless 
# developing the library itself, else the foundation might become 
# unstable
# #####################################################################
# convertsecs
# ------------------------------------------------------
# Convert Seconds to human readable time
#
# To use this, pass a number (seconds) into the function as this:
# print "$(convertsecs $TOTALTIME)"
#
# To compute the time it takes a script to run use tag the start and end times with
#   STARTTIME=$(date +"%s")
#   ENDTIME=$(date +"%s")
#   TOTALTIME=$(($ENDTIME-$STARTTIME))
# ------------------------------------------------------
function convertsecs() {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
}

# Text Transformations
# -----------------------------------
# Transform text using these functions.
# Adapted from https://github.com/jmcantrell/bashful
# -----------------------------------

lower() {
  # Convert stdin to lowercase.
  # usage:  text=$(lower <<<"$1")
  #         echo "MAKETHISLOWERCASE" | lower
  tr '[:upper:]' '[:lower:]'
}

upper() {
  # Convert stdin to uppercase.
  # usage:  text=$(upper <<<"$1")
  #         echo "MAKETHISUPPERCASE" | upper
  tr '[:lower:]' '[:upper:]'
}

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

squeeze() {
  # Removes leading/trailing whitespace and condenses all other consecutive
  # whitespace into a single space.
  #
  # Usage examples:
  #     echo "  foo  bar   baz  " | squeeze  #==> "foo bar baz"

  local char=${1:-[[:space:]]}
  sed "s%\(${char//%/\\%}\)\+%\1%g" | trim "$char"
}

squeeze_lines() {
    # <doc:squeeze_lines> {{{
    #
    # Removes all leading/trailing blank lines and condenses all other
    # consecutive blank lines into a single blank line.
    #
    # </doc:squeeze_lines> }}}

    sed '/^[[:space:]]\+$/s/.*//g' | cat -s | trim_lines
}


htmlDecode() {
  # Decode HTML characters with sed
  # Usage: htmlDecode <string>
  echo "${1}" | sed -f "${SOURCEPATH}/htmlDecode.sed"
}

htmlEncode() {
  # Encode HTML characters with sed
  # Usage: htmlEncode <string>
  echo "${1}" | sed -f "${SOURCEPATH}/htmlEncode.sed"
}


urlencode() {
  # URL encoding/decoding from: https://gist.github.com/cdown/1163649
  # Usage: urlencode <string>

  local length="${#1}"
  for (( i = 0; i < length; i++ )); do
      local c="${1:i:1}"
      case $c in
          [a-zA-Z0-9.~_-]) printf "$c" ;;
          *) printf '%%%02X' "'$c"
      esac
  done
}

urldecode() {
    # Usage: urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\x}"
}