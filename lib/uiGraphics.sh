#!/usr/bin/env bash

# ##################################################
# Library of functions that print graphics for FluxSDK
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 5, 2015 - v1.0.0  - Library Created
#
# ##################################################

open_graphic() {
    clear
    echo ""
    ente -db "    __  ____             __         _______  ______   "
    ente -b "    / / / / /  __ _____  / /___ __  <  / __/ <  / _ \  "
    einf -db "  / /_/ / _ \/ // / _ \/ __/ // /  / /__ \_ / / // /  "
    einf -b "   \____/_.__/\_,_/_//_/\__/\_,_/  /_/____(_)_/\___/   "
    einf -bl "       Post Installation Script for Gnome 3.16        "
    echo ""
}

end_graphic() {
    clear
    echo ""
    echo ""
    echo ""
    ente -db "    __  ____             __         _______  ______   "
    ente -b "    / / / / /  __ _____  / /___ __  <  / __/ <  / _ \  "
    einf -db "  / /_/ / _ \/ // / _ \/ __/ // /  / /__ \_ / / // /  "
    einf -b "   \____/_.__/\_,_/_//_/\__/\_,_/  /_/____(_)_/\___/   "
    einf -bl "       Post Installation Script for Gnome 3.16        "
    echo ""
    esuc "                      She's Done...                    "
    echo ""
    echo ""
    echo ""
}

justdoit_graphic() {

    printf "\n\n"
    eart -b --c=202 "     d8,                                    d8b               d8,        "
    eart -b --c=202 "    \`8P                      d8P            88P              \`8P    d8P  "
    eart -b --c=202 "                          d888888P         d88                   d888888P"
    eart -b --c=202 "    d88  ?88   d8P .d888b,  ?88\'       d888888   d8888b       88b  ?88\'  "
    eart -b --c=202 "    ?88  d88   88  ?8b,     88P       d8P' ?88  d8P' ?88      88P  88P   "
    eart -b --c=202 "     88b ?8(  d88    \`?8b   88b       88b  ,88b 88b  d88     d88   88b   "
    eart -b --c=202 "     \`88b\`?88P'?8b\`?888P'   \`?8b      \`?88P'88b\`?8888P\'    d88'   \`?8b  "
    eart -b --c=202 "      )88                                                                "
    eart -bn --c=202 "     ,88P   "
    eart -b --c=053 "Welcome! You can go now... "
    eart -bn --c=202 "  \`?888P    "
    eart -b --c=053 "This is non-interactive and will take a bit. "
    eart -b --c=226 "             Ciao!"
    printf "\n\n"

}

# Setup

repos_graphic() {

    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Setting up essential '
    eart -bun --c=214 'Repositories'
    # eart -n --c=202 " x"
    eart --c=077 ' ======================'
    eart --c=077 '============================================================'

}

apps_graphic() {

    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Building '
    eart -bun --c=214 'Applications'
    # eart -n --c=202 " x"
    eart --c=077 ' =================================='
    eart --c=077 '============================================================'

}

gnome_graphic() {
    
    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Configuring '
    eart -bun --c=214 'Gnome'
    # eart -n --c=202 " x"
    eart --c=077 ' ======================================'
    eart --c=077 '============================================================'

}

lamp_graphic() {
    
    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Installing the '
    eart -bun --c=214 'LAMP'
    eart -n --c=202 " stack"
    eart --c=077 ' =============================='
    eart --c=077 '============================================================'

}

apache_graphic() {
    
    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Configuring '
    eart -bun --c=214 'Apache'
    eart -n --c=202 ' Installation'
    eart --c=077 ' ========================'
    eart --c=077 '============================================================'

}

php_graphic() {
    
    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Configuring '
    eart -bun --c=214 'PHP'
    eart -n --c=202 ' Installation'
    eart --c=077 ' ==========================='
    eart --c=077 '============================================================'

}

espresso_graphic() {
    
    eart --c=077 '\n============================================================'
    eart --c=077 -n '=== '
    eart -n --c=202 'Setting up '
    eart -bun --c=214 'Espresso'
    eart -n --c=202 ' a GUI virtual host manager'
    eart --c=077 ' ========='
    eart --c=077 '============================================================'

}

#  __      _   _   _                               __                                  
# / _\ ___| |_| |_(_)_ __   __ _   /\ /\ _ __     /__\__ _ __  _ __ ___  ___ ___  ___  
# \ \ / _ \ __| __| | '_ \ / _` | / / \ \ '_ \   /_\/ __| '_ \| '__/ _ \/ __/ __|/ _ \ 
# _\ \  __/ |_| |_| | | | | (_| | \ \_/ / |_) | //__\__ \ |_) | | |  __/\__ \__ \ (_) |
# \__/\___|\__|\__|_|_| |_|\__, |  \___/| .__/  \__/|___/ .__/|_|  \___||___/___/\___/ 
#                          |___/        |_|             |_|                            


#   __                   ___                 
#  (  _ _/_/'  _  /  /  (_   _   _ _  _  _   
# __)(- / ///)(/ (__//) /___) /)/ (-_) _) () 
#            _/     /        /               

# (` _ |-|-.,_    | |    [~ _     _  _ _  
# _)(/_|_|_|||(|  |_||)  [__\|)|`(/__\_\()
#             _|     |       |            

#  __                         __                 
# (_  _|_|_. _  _   /  \ _   |_  _ _  _ _ _ _ _  
# __)(-|_|_|| )(_)  \__/|_)  |___)|_)| (-_)_)(_) 
#              _/       |         |              


# Graphic for use with demos
# ##################################################
# Usage:
#    demo_graphic [-OPTIONS] ARGUMENT
#
# Options:
#    -n          do not output the trailing newline
# ##################################################
demo_graphic() {

    get_options $@
    set_options layout
    set -- "${OPT_STR}"

    # Select Style
    case $1 in
        open)
            shift
            ewar -db "$INDENT_STR ____            _     ____                           "
            ewar -db "$INDENT_STR| __ )  __ _ ___| |__ |  _ \\  ___ _ __ ___   ___  ___ "
            ewar -db "$INDENT_STR|  _ \\ / _\` / __| \\'_ \\| | | |/ _ \\ \\'_ \` _ \\ / _ \\/ __|"
            ewar -db "$INDENT_STR| |_) | (_| \\__ \\ | | | |_| |  __/ | | | | | (_) \\__ \""
            ewar -db "$INDENT_STR|____/ \__,_|___/_| |_|____/ \___|_| |_| |_|\___/|___/"
            ;;
        contessa)
            shift
            ewar -db "$INDENT_STR  .           "
            ewar -db "$INDENT_STR _| _ ._ _  _ "
            ewar -dbn "$INDENT_STR(_](/,[ | )(_)${NEWLINE_STR}"
            ;;
        * )
            ewar -db "$INDENT_STR    _               "
            ewar -db "$INDENT_STR __| |___ _ __  ___ "
            ewar -db "$INDENT_STR/ _\` / -_) \'  \/ _ \\"
            ewar -dbn "$INDENT_STR\__,_\___|_|_|_\___/${NEWLINE_STR}"
            ;;
    esac



    

    if [[ "${OPT_ARR[title]}" != "" ]]; then
        if [[ "${OPT_ARR[header]}" = "" ]]; then
            echo -ulbn "  "
        else
            einf -lbn "  ${OPT_ARR[header]} "
        fi
        echo -ulb "${OPT_ARR[title]}\n"
    fi
                   
}

# goodbye_graphic() {
#                                   d8b  d8b                       
#                                 88P  ?88                       
#                                d88    88b                      
#  d888b8b   d8888b  d8888b  d888888    888888b ?88   d8P  d8888b
# d8P' ?88  d8P' ?88d8P' ?88d8P' ?88    88P `?8bd88   88  d8b_,dP
# 88b  ,88b 88b  d8888b  d8888b  ,88b  d88,  d88?8(  d88  88b    
# `?88P'`88b`?8888P'`?8888P'`?88P'`88bd88'`?88P'`?88P'?8b `?888P'
#        )88                                           )88       
#       ,88P                                          ,d8P       
#   `?8888P                                        `?888P'  
# }

 
                                        
