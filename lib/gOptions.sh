#!/usr/bin/env bash

# ##################################################
# Library of functions that pertain to options
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 22, 2015 - v1.0.0  - Library Created
#
# ##################################################

# Parse options for use
# ##################################################
# Use at the beginning of a function you want to
# pass options. Pass the '$@' positional parameter.
#
# Usage:
#    get_options $@
# ##################################################
get_options() {

    local datowner=$1
    # Iterate over options breaking -ab into -a -b when needed and --foo=bar into
    # --foo bar
    optstring=h
    unset options
    while (($#)); do
        case $1 in
            # If option is of type -ab
            -[!-]?*)
                # Loop over each character starting with the second
                for ((i=1; i < ${#1}; i++)); do
                    c=${1:i:1}

                    # Add current char to options
                    options+=("-$c")

                    # If option takes a required argument, and it's not the last char make
                    # the rest of the string its argument
                    if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
                        options+=("${1:i+1}")
                        break
                    fi
                done
                ;;
            # If option is of type --foo=bar
            --?*=*) options+=("${1%%=*}" "${1#*=}") ;;
            # add --endopts for --
            --) options+=(--endopts) ;;
            # Otherwise, nothing special
            *) options+=("$1") ;;
        esac
        shift
    done

    case $datowner in
        ekho)
            # echo "${a[@]:1}"
            EKHO_STR=("${options[@]:1}")
            ;;
        var)
            VAR_STR=("${options[@]:1}")
            ;;
        *) 
            OPT_STR=("${options[@]}")
            ;;
    esac
    
    unset options

}

set_options() {

    local opt_act=$@

    case $opt_act in

        echoex)
            set -- "${EKHO_STR[@]}"

            while [[ $1 = -?* ]]; do
                case $1 in
                    -i) ee_type_flags[icon]=true ;;
                    -d) ee_type_flags[dark]=true ;;
                    -l) ee_type_flags[light]=true ;;
                    -b) ee_type_flags[bold]=true ;;
                    -u) ee_type_flags[underline]=true ;;
                    -n) ee_type_flags[newline]=false ;;
                    -f) ee_type_flags[forcelegacy]=true ;;
                    *) : ;;
                esac
                shift
            done

            EKHO_STR=$@
            ;;
        
        layout)
            set -- "${OPT_STR[@]}"

            while [[ $1 = -?* ]]; do
                case $1 in
                    -c|--clear)
                        clear
                        ;;
                    --c|--color)
                        shift
                        OPT_ARR[color]=$1
                        ;;
                    --content)
                        shift
                        OPT_STR=$@
                        return
                        ;;
                    -n)
                        NEWLINE_STR=''
                        ;;
                    --header)
                        shift
                        OPT_ARR[header]=$1
                        ;;
                    --spaces)
                        shift
                        if [ $1 -gt 0 ]; then
                            for (( i=1; i<=$1; i++ )); do
                                INDENT_STR="$INDENT_STR "
                            done
                        fi
                        ;;
                    --tabs)
                        shift
                        if [ $1 -gt 0 ]; then
                            for (( i=1; i<=$1; i++ )); do
                                INDENT_STR="$INDENT_STR\\t"
                            done
                        fi
                        ;;
                    --title)
                        shift
                        OPT_ARR[title]=$1
                        ;;
                    -b) 
                        OPT_ARR[bold]=true
                        ;;
                    -u) 
                        OPT_ARR[underline]=true
                        ;;


                    *)
                        :
                        ;;
                esac
                shift
            done

            OPT_STR=$@
            ;;
        var)
            set -- "${VAR_STR[@]}"

            while [[ $1 = -?* ]]; do
                case $1 in

                    -c|--clear)
                        clear
                        ;;

                    -n)
                        NEWLINE_STR=''
                        ;;

                    --header)
                        shift
                        VAR_ARR[header]=$1
                        ;;

                    --spaces)
                        shift
                        if [ $1 -gt 0 ]; then
                            for (( i=1; i<=$1; i++ )); do
                                INDENT_STR="$INDENT_STR "
                            done
                        fi
                        ;;

                    --tabs)
                        shift
                        if [ $1 -gt 0 ]; then
                            for (( i=1; i<=$1; i++ )); do
                                INDENT_STR="$INDENT_STR\\t"
                            done
                        fi
                        ;;

                    --title)
                        shift
                        VAR_ARR[title]=$1
                        ;;

                    -b) 
                        VAR_ARR[bold]=true
                        ;;

                    -u) 
                        VAR_ARR[underline]=true
                        ;;

                    *)
                        :
                        ;;
                esac
                shift
            done

            VAR_STR=$@
            ;;

        debug)
            set -- "${OPT_STR[@]}"
            
            while [[ $1 = -?* ]]; do
                case $1 in
                    -a|--array)
                        DEBUG_ARR[variation]='arr'
                        ;;
                    -v|-variable)
                        DEBUG_ARR[variation]='var'
                        ;;
                    -f|--function)
                        DEBUG_ARR[inside]='func'
                        ;;
                    --p|--parameter)
                        shift
                        DEBUG_ARR[isparam]=$1
                        ;;
                    *)
                        :
                        ;;
                esac
                shift
            done

            OPT_STR=$@
            ;;

        -?*)
            :
            ;;

        *)
            :
            ;;

    esac

    # OPT_STR=$@
    
}

reset_options() {

    case $1 in

        echoex)
            ee_type_flags[icon]=false
            ee_type_flags[dark]=false
            ee_type_flags[light]=false
            ee_type_flags[bold]=false
            ee_type_flags[underline]=false
            ee_type_flags[newline]=true
            ee_type_flags[forcelegacy]=false

            ee_icon_str=''
            ee_bold_str=''
            ee_ul_str=''
            ee_color_str=''
            ee_nl_str=''

            EKHO_STR=()
            ;;
        
        layout)
            OPT_STR=()
            OPT_ARR[title]=''
            OPT_ARR[bold]=''
            OPT_ARR[underline]=''
            OPT_ARR[color]=''
            OPT_ARR[header]=''
            ;;

        var)
            VAR_STR=()
            VAR_ARR=()
            ASS_ARR=()
            ;;

        debug)
            DEBUG_ARR=()
            ;;
        *)
            :
            ;;

    esac

    INDENT_STR=''
    NEWLINE_STR="\n"

}
