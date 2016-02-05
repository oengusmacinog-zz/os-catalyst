#!/usr/bin/env bash

# ##################################################
# Echo Expansion Library for Commandline UI
#
# VERSION 1.0.0
#
# HISTORY:
#
# * October 31, 2015 - v1.0.0  - Project Initialization
#
# ##################################################

# Variables
# ##################################################

# Echo Expansion Type Flags
declare -A ee_type_flags=([icon]=false [dark]=false [light]=false [bold]=false [underline]=false [newline]=true [forcelegacy]=false)

# Echo Expansion strings to print
declare ee_icon_str=''
declare ee_bold_str=''
declare ee_ul_str=''
declare ee_color_str=''
declare ee_nl_str=''
declare ee_type_str=''

# Shared Functions
# ##################################################

set_ee_icon() {

    if [[ "${ee_type_flags[icon]}" = true ]]; then
        ee_icon_str=$1
    else
        ee_icon_str=''
    fi

}

set_ee_bold() {

    if [[ "${ee_type_flags[bold]}" = true ]]; then
        ee_bold_str=$T_BOLD
    else
        ee_bold_str=""
    fi

}

set_ee_ul() {

    if [[ "${ee_type_flags[underline]}" = true ]]; then
        ee_ul_str=$T_UL
    else
        ee_ul_str=""
    fi

}

set_ee_color () {

    if [[ "${ee_type_flags[dark]}" = true ]]; then
        ee_color_str=$3
    elif [[ "${ee_type_flags[light]}" = true ]]; then
        ee_color_str=$2
    else
        if [[ "${ee_type_flags[forcelegacy]}" = true ]]; then
            ee_color_str=$4
        else    
            ee_color_str=$1
        fi
    fi

}

set_ee_newline() {

    if [[ "${ee_type_flags[newline]}" = true ]]; then
        ee_nl_str="\n"
    else
        ee_nl_str=""
    fi

}

# Internal Executables
# ##################################################    

ekho() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_bold
    set_ee_ul
    set_ee_color $T_WHITE $T_WHITE_LT $T_WHITE_DK $T_WHITE_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex
            
}

einf() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_bold
    set_ee_ul
    set_ee_color $T_BLUE $T_CYAN $T_BLUE_DK $T_BLUE_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex

}

ente() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_bold
    set_ee_ul
    set_ee_color $T_PURPLE $T_PURPLE_LT $T_PURPLE_DK $T_PURPLE_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex

}

ewar() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_icon "⚠ "
    set_ee_bold
    set_ee_ul
    set_ee_color $T_YELLOW $T_YELLOW_LT $T_ORANGE $T_YELLOW_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$ee_icon_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex

}

esuc() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_icon "✔ "
    set_ee_bold
    set_ee_ul
    set_ee_color $T_GREEN $T_GREEN_LT $T_GREEN_DK $T_GREEN_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$ee_icon_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex

}

eerr() {

    get_options ekho $@
    set_options echoex
    set -- "${EKHO_STR}"

    set_ee_icon "✘ "
    set_ee_bold
    set_ee_ul
    set_ee_color $T_RED $T_RED_LT $T_RED_DK $T_RED_LG
    set_ee_newline

    printf "$ee_bold_str$ee_ul_str$ee_color_str$ee_icon_str$EKHO_STR$RESET$ee_nl_str"

    reset_options echoex

}

eart() {
    get_options $@
    set_options layout
    set -- "${OPT_STR}"

    # earr 'OPT_STR'

    [ -n "${OPT_ARR[bold]}" ] && local eart_bold_str=$T_BOLD || local eart_bold_str=''
    [ -n "${OPT_ARR[underline]}" ] && local eart_ul_str=$T_UL || local eart_ul_str=''
    local eart_color_str="$(tput setaf ${OPT_ARR[color]})"

    printf "$eart_bold_str$eart_ul_str$eart_color_str$@$RESET$NEWLINE_STR"

    reset_options layout
}

nbsp() {
    printf ' '
}



# echoConditional
# ##################################################
# Checks a conditional and writes the pertinant
# message based on the result
#
# Usage:
#    econ [conditional title] "message to print"
# ##################################################
econ() {

    case $1 in

        needsudo)
            if is_not_sudo; then
                ewar -id " This process requires root privileges"
                eerr -bn "Exiting..."
                ekho " Please run again as root user"
                safe_exit
            fi
            ;;

        check)
            printf ' '
            if $2 $3; then
                esuc -i
            else
                eerr -i
            fi
            ;;

        * )
            echo $@
            ;;

    esac

}

# echoVariable
# ##################################################
# Print variable name and value
# 
# Arguments:
#     [$1] => Variable name string (no arguments)
# ##################################################
evar() {
    
    get_options var $@
    set_options var
    set -- "${OPT_STR}"

    local arr_str="$@[@]"
    local arr_var=(${!arr_str})

    for key in "${!arr_var[@]}"; do
        ewar -bn "$INDENT_STR\$"
        einf -bn "$@: "
        echo "${!@}"
    done

    reset_options var

}

# svar() {

#     ewar -bn "\$"
#     einf -bn "$1: "
#     echo "$2"

# }

# echoArray
# ##################################################
# Print array name with key and value
#
# Arguments:
#     [$1] => Variable name string (no arguments)
# ##################################################
earr() {

    get_options var $@
    set_options var
    set -- "${VAR_STR}"

    local arr_str="$( declare -p $@ )"

    eval "declare -A ASS_ARR=${arr_str#*=}"

    for key in "${!ASS_ARR[@]}"; do
        # ewar -bn "$INDENT_STR\$"
        printf "$T_BOLD$T_YELLOW\$$RESET"
        # eerr -bdn $@
        printf "$T_BOLD$T_RED_DK$@$RESET"
        # einf -bn "["
        printf "$T_BOLD$T_BLUE[$RESET"
        # einf -lbn $key
        printf "$T_BOLD$T_CYAN$key$RESET"
        # einf -bn "]: "
        printf "$T_BOLD$T_BLUE]: $RESET"
        echo ${ASS_ARR[$key]}
    done

    reset_options var

}

# echoDebug
# ##################################################
# Print during a run with -d option
#
# Options:
#     -a => echoArray
#     -v => echoVariable
# Arguments:
#     [$1] => string
# ##################################################
edbg() {

    if ${debug}; then
        get_options $@
        set_options debug
        set -- "${OPT_STR}"

        emes debug

        case ${DEBUG_ARR[variation]} in

            arr)
                if [ -n ${DEBUG_ARR[inside]} ]; then
                    case ${DEBUG_ARR[inside]} in
                        func)
                            ente -n "Inside $FUNCNAME"
                            ;;
                        *)
                            :
                            ;;
                    esac
                    einf -nb " => "
                fi

                if [ -n ${DEBUG_ARR[isparam]} ]; then
                    ewar -bn "\$"
                    einf -bn "@: "
                    echo "$@"
                else
                    local arr_str="$@[@]"
                    local arr_var=(${!arr_str})

                    for key in "${!arr_var[@]}"; do
                        ewar -bn "$INDENT_STR\$"
                        eerr -bdn $@
                        einf -bn "["
                        einf -lbn $key
                        einf -bn "]: "
                        echo ${arr_var[$key]}
                    done
                fi
                
                
                ;;

            var)
                if [ -n ${DEBUG_ARR[inside]} ]; then
                    case ${DEBUG_ARR[inside]} in

                        func)
                            ente -n "Inside $FUNCNAME"
                            einf -nb " => "
                            ;;
                        *)
                            :
                            ;;

                    esac                
                fi
                
                if [ -n ${DEBUG_ARR[isparam]} ]; then
                    ewar -bn "\$"
                    einf -bn "${DEBUG_ARR[isparam]}: "
                    [ -z "$2" ] && echo "$@" || eerr "NULL"
                else
                    local arr_str="$@[@]"
                    local arr_var=(${!arr_str})
                    for key in "${!arr_var[@]}"; do
                        ewar -bn "$INDENT_STR\$"
                        einf -bn "$@: "
                        echo "${!@}"
                    done
                fi
                ;;

            * )             
                ewar -bn "debug: "
                ente $@
                ;;
                
        esac

        reset_options debug

    fi  
            
}