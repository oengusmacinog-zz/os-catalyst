#!/usr/bin/env bash

# ##################################################
# Echo Expansion Messages for Commandline UI
#
# VERSION 1.0.0
#
# HISTORY:
#
# * February 4, 2016 - v1.0.0  - Project Initialization
#
# ##################################################

# Installation Not Supported
# ##################################################
# Run a command as the user even if the script is
# executed by the root user
#
# Usage:
#    nosudo "command -o arguments"
# ##################################################
edie() {

	# Avoid undefined error by checking a value
	# was passed to the function
	if is_empty $1; then
		die 'NO STRING PASSED TO DIE!!!'
	fi

	case $1 in
		installnotsupported)
			shift
			eerr -nb "This installation of "
			ewar -nb "$1"
			eerr -nb " is not supported"
			ewar -b "!"
			einf -bn "Have a wonderful day "
			einf -bl "☺"
			safe_exit
			;;
		runassudo)
			if is_not_sudo; then
				eerr -nb "This command must be run by the "
				ewar -nb "root"
				eerr -nb " user"
				ewar -b "!"
				einf -n "Please run the command again "
				esuc -bn "with"
				einf -bl " 'sudo'"
				safe_exit
			fi
			;;
		runasuser)
			if is_sudo; then
				eerr -nb "This command must me run by the "
				ewar -nb "user"
				eerr -nb " not root"
				ewar -b "!"
				einf -n "Please run the command again "
				ewar -bdn "without"
				einf -bl " 'sudo'"
				safe_exit
			fi
			;;
		*)
			shift
			echo $@
			local str="${@:-UNKNOWN ERROR!!!}"
			echo $str
			die $str
			;;
	esac

}


# echoMessage
# ##################################################
# Usage:
#    emes [message title] "message to print"
# ##################################################
emes() {

    case $1 in
        mkdir)
            eart -n --c=043 "Creating "
            if [[ "$2" == *\/* ]]; then
                eart -bn --c=047 "${2##*/}"
            else
                eart -bn --c=047 "$2"
            fi
            eart -n --c=055  " directory in "
            [[ "$2" == *\/* ]] && eart -n --c=220 "${2%/*}" || eart -n --c=220 'Home'
            eart -n --c=055 " directory"
            ekho -dn "..."
            ;;
        actpos)
            [ -n "$2" ] && eart -dn --c=120 "$2 "|| 'Installing'
            [ -n "$3" ] && eart -bn --c=047 "$3" || true
            [ -n "$4" ] && eart -n --c=055 " $4" || true
            [ -n "$5" ] && eart -n --c=220 " $5" || true
            [ -n "$6" ] && eart -n --c=055 " $6" || true
            ekho -dn "..."
            ;;
        actneg)
            
            [ -n "$5" ] && eart -n --c=124 "$5 " || true
            [ -n "$2" ] && eart -bn --c=214 "$2" || true
            [ -n "$3" ] && eart -n --c=124 "$3" || true
            [ -n "$4" ] && eart -bn --c=111 " $4" || true
            ekho -dn "..."
            ;;
        infpos)
            [ -n "$2" ] && eart -bn --c=047 "$2" || eart -bn --c=047 "This program"
            [ -n "$4" ] && eart -n --c=220 " $4" || true
            [ -n "$5" ] && eart -n --c=047 " $5" || true
            [ -n "$3" ] && eart -n --c=121 " $3 " || eart -n --c=121 " is already installed "
            esuc -i
            ;;
        infneg)
            ewar -ni
            if [[ "$2" != "" ]]; then
                eart -bn --c=047 "$2"
            else
                eart -bn --c=047 "This program"
            fi
            if [[ "$3" != "" ]]; then
                eart -n --c=121 " $3 "
            else
                eart -n --c=121 " is not installed on this machine "
            fi
            esuc -i
            ;;
        extrapos)
            [ -n "$5" ] && eart -n --c=226 " $5" ||  eart -n --c=226 "    ⮱  "
            [ -n "$4" ] && eart -n --c=055 " $4" || true
            [ -n "$2" ] && eart -dn --c=120 "$2 " || 'Installing '
            [ -n "$3" ] && eart -bn --c=047 "$3" || true
            [ -n "$6" ] && eart -n --c=121 " $6" || true
            ekho -n "..."
            ;;
        config)
            # eart -n --c=202 "⚙ "
            [ -n "$3" ] && eart -n --c=104 "$3 " || eart -n --c=104 'Configuring '
            [ -n "$2" ] && eart -bn --c=047 "$2" || eart -b --c=047 'an application'
            [ -n "$4" ] && eart -n --c=104 " $4" || true
            ekho ":"
            # eart -n --c=202 " ⚙\n"
            ;;
        extraconf)
            # [ -n "$5" ] && eart -n --c=226 " $5" ||  eart -n --c=226 "    ⮱  "
            eart -n --c=202 "    ⚙  "
            [ -n "$4" ] && eart -n --c=055 " $4" || true
            [ -n "$2" ] && eart -dn --c=120 "$2 " || 'Installing '
            [ -n "$3" ] && eart -bn --c=047 "$3" || true
            [ -n "$6" ] && eart -n --c=121 " $6" || true
            ekho -n "..."
            ;;
         config-single)
            [ -n "$3" ] && eart -n --c=104 "$3 " || eart -n --c=104 'Configuring '
            [ -n "$2" ] && eart -bn --c=047 "$2" || eart -b --c=047 'an application'
            [ -n "$4" ] && eart -n --c=104 " $4" || true
            eart --c=202 " ⚙"
            ;;
        header)
            eart --c=077 '\n============================================================'
            eart --c=077 -n '=== '
            [ -n "$2" ] && eart -n --c=202 "$2 " || true
            [ -n "$3" ] && eart -bun --c=214 "$3" || true
            [ -n "$4" ] && eart -n --c=202 " $4" || true
            [ -n "$5" ] && eart --c=077 "$5" || eart --c=077 ' ============='
            eart --c=077 '============================================================'
            ;;
        debug)
            eerr -bnd "🐞  "
            ewar -dn "debug: "
            ;;
        * )
            ekho $@
            ;;
    esac

}