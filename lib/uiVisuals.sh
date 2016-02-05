#!/usr/bin/env bash

# ##################################################
# Library of functions to create command line visuals
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 2, 2015 - v1.0.0  - Library Created
#
# ##################################################

# Courtesy of http://fitnr.com/showing-file-download-progress-using-wget.html
download() {

    local url=$1

    echo -n "    "
    wget -P /tmp --progress=dot $url 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s, \.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    esuc -i
    
}

spinner() {

    local strcolor=$(tput setaf 231)

    case $2 in

        halfdime)
            local delay=0.10
            local spinstr=("⬖⬘⬗⬙")
            local unilen=4
            strcolor=$(tput setaf 231)
            ;;

        clock)
            local delay=0.10
            local spinstr=("🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚🕛")
            local unilen=12
            strcolor=$(tput setaf 120)
            ;;

        ctcircle)
            local delay=0.15
            local spinstr=("🞅🞆🞇🞈🞉🞈🞇🞆")
            local unilen=5
            strcolor=$(tput setaf 231)
            ;;

        hfcircle)
            local delay=0.15
            local spinstr=("◐◑◒◓")
            local unilen=4
            strcolor=$(tput setaf 231)
            ;;

        qtsquare)
            local delay=0.10
            local spinstr=("◰◱◲◳")
            local unilen=4
            strcolor=$(tput setaf 231)
            ;;

        qtcircle)
            local delay=0.15
            local spinstr=("◴◵◶◷")
            local unilen=4
            strcolor=$(tput setaf 231)
            ;;

        moon )
            local delay=0.10
            local spinstr=("🌑🌒🌓🌔🌕🌖🌗🌘")
            local unilen=8
            mooncolor=("$(tput setaf 255)" "$(tput setaf 250)" "$(tput setaf 245)" "$(tput setaf 240)" "$(tput setaf 235)" "$(tput setaf 240)" "$(tput setaf 245)" "$(tput setaf 250)")
            ;;

        * )
            local delay=0.10
            local spinstr='|/-\'
            local unilen=1
            strcolor=$(tput setaf 231)
            ;;

    esac
    local pid=$1
    local anim=0

    if [ "$2"=="moon" ]; then
        colori=0
        while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
            anim=$(( (anim+1) %$unilen ))
            strcolor="${mooncolor[$colori]}"
            colori=$(( (colori+1) %8 ))
            printf " $strcolor${spinstr:$anim:1}$RESET "
            sleep $delay
            printf "\b\b\b"
            tput el

        done
    else
        while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
            anim=$(( (anim+1) %$unilen ))
            
            printf " $strcolor${spinstr:$anim:1}$RESET "
            sleep $delay
            printf "\b\b\b"
            tput el
        done
    fi

}




progress_spinner() {
    
    spinner $1 clock
    wait $1

}


