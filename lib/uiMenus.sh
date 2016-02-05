#!/usr/bin/env bash
#
# Post Install Script for Ubuntu 15.10 with Gnome 3.16
#
# This file:
#  - Menus and interfaces.
#
# More info:
#  - https://github.com/oengusmacinog/ubuntu-post-install
#
# Version 1.0.0
#
# Authors:
#  - Brian Garland (http://brigarland.io)
#

# ################# Script UI/UX ###################
# ##################################################

apps_menu() {

    echo ''
    einf 'Do you want to to install everything listed? '
    echo ''
    for i in "${APPSLIST[@]}"
    do
        echo -e '\t'$i
    done
    echo ''
    einf 'Proceed? (Y)es (N)o : ' && read -s -n 1 REPLY
    echo ''
    case $REPLY in
    [Yy]* ) 
        issudo
        for i in "${APPSLIST[@]}"
        do
            install_package $i
        done
        esuc 'All Done!'
        main_menu
        ;;
    # Negative action
    [Nn]* )
        clear && main_menu
        ;;
    # Error
    * )
        clear && echo 'Sorry try again.'
        apps_menu
        ;;
    esac

}

cleanup_menu() {

    PURGED="$SCRIPT_PATH/etc/Purge.list"

    ente -hb "Let's clean up your system..."
    echo ''
    einf -b  'What would you like to do? '
    echo ''
    echo -e '\t1. Remove unused pre-installed packages?'
    echo -e '\t2. Remove old kernel(s)?'
    echo -e '\t3. Remove orphaned packages?'
    echo -e '\t4. Remove leftover configuration files?'
    echo -e '\t5. Clean package cache?'
    echo -e '\tr. Return?'
    echo ''
    einf -b  'Enter your choice below:' && read -s -n 1 REPLY
    case $REPLY in
    # Remove Unused Pre-installed Packages
    1)
        ente -hb "Removing unused pre-installed applications..."
        echo ''
        einf -lb 'Current package list:'
        echo ''
        for package in $(cat $PURGED); do 
            echo -e '\t'$package
        done
        echo ''
        einf -lb 'Proceed? (Y)es, (N)o : ' && read -s -n 1 REPLY
        echo ''
        case $REPLY in
        # Positive action
        [Yy]* )
            issudo
            sudo apt-get purge -y $(cat $PURGED)
            esuc 'Done.'
            cleanup
            ;;
        # Negative action
        [Nn]* )
            clear && cleanup
            ;;
        # Error
        * )
            clear && eerr '\aSorry, try again.'
            cleanup
            ;;
        esac
        ;;
    # Remove Old Kernel
    2)
        echo 'Removing old Kernel(s)...'
        issudo
        sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
        esuc 'Done.'
        cleanup
        ;;
    # Remove Orphaned Packages
    3)
        echo 'Removing orphaned packages...'
        issudo
        sudo apt-get autoremove -y
        esuc 'Done.'
        cleanup
        ;;
    # Remove residual config files?
    4)
        echo 'Removing leftover configuration files...'
        issudo
        sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
        esuc 'Done.'
        cleanup
        ;;
    # Clean Package Cache
    5)
        echo 'Cleaning package cache...'
        issudo
        sudo apt-get clean
        esuc 'Done.'
        cleanup
        ;;
    # Return
    [Rr]*) 
        clear && main_menu;;
    # Invalid choice
    * ) 
        clear && eerr '\aNot an option, try again.' && cleanup;;
    esac

}

config_menu() {
    echo ''
    einf -b  'What would you like to do? '
    echo ''
    echo '1. Set preferred application-specific settings?'
    echo '2. Show all startup applications?'
    echo '3. Disable system crash dialogs (apport)?'
    echo 'r. Return'
    echo ''
    einf -b  'Enter your choice:' && read -s -n 1 REPLY
    case $REPLY in
    # GSettings
    1)
        # Font Sizes
        echo 'Setting font preferences...'
        gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font true
        gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Medium 11'
        gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
        gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11'
        gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
        gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'

        gsettings set org.gnome.desktop.interface clock-format '12h'
        gsettings set org.gnome.desktop.interface clock-show-date true #Clock Shows Date
        gsettings set org.gnome.desktop.interface clock-show-seconds false
        gsettings set org.gnome.desktop.background picture-uri 'http://remusjuncu.com/posts/tek/teksyndicate_1.png'

        gsettings set org.gnome.desktop.notifications show-in-lock-screen false
        gsettings set org.gnome.desktop.notifications show-banners true

        gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close' #Windows have min & close buttons, no max button shown
        
        gsettings set org.gnome.desktop.sound input-feedback-sounds false
        gsettings set org.gnome.desktop.sound event-sounds true
        gsettings set org.gnome.desktop.wm.preferences audible-bell true

        # Controls
        gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
        gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'menu'
        gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
        gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'minimize'
        gsettings set org.gnome.desktop.wm.preferences resize-with-right-button false

        gsettings set org.gnome.desktop.interface toolbar-style 'both-horiz'
        gsettings set org.gnome.desktop.interface toolbar-icons-size 'large'

        gsettings set org.gnome.desktop.interface buttons-have-icons false
        gsettings set org.gnome.desktop.interface cursor-blink true

        gsettings set org.gnome.desktop.interface menus-have-icons false

        gsettings set org.gnome.desktop.interface menubar-accel 'F10'
        gsettings set org.gnome.desktop.interface cursor-size 24


        # GNOME Preferences
        echo 'Setting GNOME app preferences...'
        gsettings set org.gnome.nautilus.preferences sort-directories-first true

        # Done
        echo "Done."
        config_menu
        ;;
    # Startup Applications
    2)
        echo 'Changing display of startup applications...'
        issudo
        sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop
        cd
        esuc 'Done.'
        config_menu
        ;;
    # Disable Apport
    3)
        echo 'Disabling apport crash dialogs...'
        issudo
        sudo sed -i "s/enabled=1/enabled=0/g" /etc/default/apport
        cd
        esuc 'Done.'
        config_menu
        ;;
    # Return
    [Rr]*) 
        clear && main_menu;;
    # Invalid choice
    * ) 
        clear && eerr '\aNot an option, try again.' && config_menu;;
    esac
}

customize_menu() {

    echo ''
    einf -b 'What would you like to do? '
    echo ''
    echo '1. Gnome Terminal Profile Configuration'
    echo '2. Gnone Theme'
    echo '3. Powerline'
    echo '4. Sublime Text 3 Configuration'
    echo '5. Configure system?'
    echo 'r. Return'
    echo ''
    einf -b 'Enter your choice :' && read -s -n 1 REPLY
    case $REPLY in
        1) clear && config_gnome_terminal;; ##Gnome Terminal Profile Configuration
        2) clear && config_gnome_theme;;
        3) 
            clear 
            install_package powerline
            ;;
        4) clear && config_sublime;; ##Sublime Text 3 Configuration
        5) clear && config_menu;; # System Configuration
        [Rr]*) clear && main_menu;; # Return
        * ) clear && eerr '\aNot an option, try again.' && customize_menu;; # Invalid choice
    esac                                                
}

debs_menu() {

    echo ''
    einf -b 'Do you wanto to install everything listed? '
    echo ''
    echo 'libgcrypt11 (Required by Spotify)'
    echo 'Slack Desktop'
    echo ''
    einf -b 'Proceed? (Y)es or (C)ustomize: ' && read -s -n 1 REPLY
    case $REPLY in
    # Install All Repositories
    [Yy]* )
        clear
        issudo 
# GET DEBS FROM FILE
        esuc 'All Done!'
        main_menu
        ;;
    # Install RVM dependencies
    [Cc]* ) 
        einf -b "What would you like to do?"
        echo ""
        echo '1.) Install libgcrypt11 (Required by Spotify)'
        echo '2.) Install Slack Desktop'
        echo ""                                                  
        einf -b 'Enter your choice :' && read -s -n 1 REPLY
        case $REPLY in
            1) 
                clear
# GET DEB FROM FILE
                apt_update
                main_menu
                ;;
            2) 
                clear
# GET DEB FROM FILE
                apt_update
                main_menu
                ;;
            * ) clear && eerr '\aNot an option, try again.' && debs_menu;;
        esac
        ;;
    # Return
    [Rr]*) 
        clear && main_menu;;
    # Error
    * )
        clear && echo 'Sorry try again.' && debs_menu
        ;;
    esac

}

repos_menu() {
    echo ''
    einf -b 'Do you wanto to install everything listed? '
    echo ''
    echo 'Google Chrome PPA'
    echo 'Numix PPA'
    echo 'Sublime Text 3 PPA'
    echo 'Yorba PPA'
    echo 'RabbitVCS PPA'
    echo 'Gimp PPA'
    echo 'NodeJA Repo'
    echo 'Spotify Repo'
    echo ''
    einf -b 'Proceed? (Y)es or (C)ustomize: ' && read -s -n 1 REPLY
    case $REPLY in
    # Install All Repositories
    [Yy]* )
        clear 
#GET ALL REPOS
        apt_update
        main_menu
        ;;
    # Install RVM dependencies
    [Cc]* ) 
        einf -b "What would you like to do?"
        echo ""
        echo '1.) Install Google Chrome PPA'
        echo '2.) Install Sublime Text 3 PPA'
        echo '3.) Install Numix PPA'
        echo '4.) Install Yorba PPA'
        echo '5.) Install RabbitVCS PPA'
        echo '6.) Install Gimp PPA'
        echo '7.) Install NodeJA Repo'
        echo '8.) Install Spotify Repo'
        echo 'r ) Return to main Menu'
        echo ""                                                  
        einf -b 'Enter your choice :' && read -s -n 1 REPLY
        case $REPLY in
            1) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            2) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            3) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            4) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            5) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            6) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            7) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            8) 
                clear
#GET REPO
                apt_update
                main_menu
                ;;
            * ) 
                clear
                eerr '\aNot an option, try again.'
                repos_menu
                ;;
        esac
        ;;
    # Return
    [Rr]*) 
        clear && main_menu;;
    # Error
    * )
        clear && echo 'Sorry try again.' && repos_menu
        ;;
    esac
}

# System Upgrade
# ##################################################
upgrade_menu() {

    einfo "\nProceed with system upgrade? (Y)es, (N)o : " 
    read -s -n 1 REPLY

    case $REPLY in
    # Positive action
    [Yy]* )
        # Update repository information
        echo 'Updating repository information...'
        einf 'Requires root privileges:'
        sudo apt-get update
        # Dist-Upgrade
        echo 'Performing system upgrade...'
        sudo apt-get dist-upgrade -y
        esuc 'Done.'
        main_menu
        ;;
    # Negative action
    [Nn]* )
        clear
        main_menu
        ;;
    # Error
    * )
        clear && eerr '\aSorry, try again.'
        upgrade
        ;;
    esac

}

# Just Do It - Setup Up Everything
# ##################################################
justdoit() {

    clear
    
    justdoit_graphic

    repos_graphic
    
    export DEBIAN_FRONTEND=noninteractive
    
    # Repositories
    for i in "${REPOLIST[@]}"; do
        install_repo $i
    done
    apt_update

    apps_graphic

    # Apt-Get Installations
    for i in "${APPSLIST[@]}"; do
        install_package $i
    done

    # Restricted Extras
    install_codecs

    # Deb Installations
    for i in "${DEBLIST[@]}"; do
        install_deb $i
    done

    gnome_graphic

    config_gnome_theme

    # Make Directories
    for i in "${DIRLIST[@]}"; do
        make_directory $i
    done

    # Install LAMP Server with Tasksel
    install_lamp

    apache_graphic

    # Install Apache Mods   
    install_apachemods

    php_graphic

    # Install PHP Mods
    install_phpmods

    # Install Composer
    install_composer

    # Install Espresso
    install_espresso

    # Install Sublime Package Control and Configure
    install_sublime_pc

    # Configure Git
    # configGit $FULLNAME $EMAIL

    # Have a nice day with your new computer message
    #end_graphic

}

main_menu() {
    # Title
    open_graphic

    echo ""
    einf -b "What would you like to do?"
    echo ""
    echo -e "\tX. I don't want to think about this,\n\t\tjust do it!"
    echo -e "\t1. Perform system update & upgrade?"
    echo -e "\t2. Install New Repositores and Keys"
    echo -e "\t3. Install Applications from App.list"
    echo -e "\t4. Install Debian Packages"
    echo -e "\t5. Install Ubuntu Restricted Extras?"
    echo -e "\t6. Customize system?"
    echo -e "\t7. Cleanup the system?"
    echo -e "\tq. Quit?"
    echo ""                                                  
    einf -b "Just enter your choice below to get started" && read -s -n 1 REPLY
    case $REPLY in
        [Xx]* ) clear && justdoit;;
        1) upgrade;;
        2) clear && repos_menu;;
        3) clear && apps_menu;;
        4) clear && debs_menu;;
        5) clear && install_codecs;;
        6) clear && customize_menu;;
        7) clear && cleanup;;
        [Qq]* ) echo '' && exit 99;;
        * ) clear && eerr '\aNot an option, try again.' && main_menu;;
    esac
}

# ################# Library UI/UX ##################
# ##################################################

demo_menu() {
    # Title
    demo_graphic -c open

    echo ""
    einf -ln "Welcome to my "
    ewar -nb "Bash Foundation"
    einf -l " demo!"
    echo ""
    echo -e "\t1. Echo Expansion Base"
    echo -e "\t2. Echo Expansion Advanced Formatting"
    echo -e "\tq. Quit?"
    echo ""                                                  
    einf -l "Just enter a selectionthat looks good to get started. Enjoy!" && read -s -n 1 REPLY
    case $REPLY in
        1) 
            echo "Menu 1"
            ;;
        2) 
            echo "Menu 2"
            ;;
        [Qq]* ) 
            echo ''
            safe_exit
            ;;
        * ) clear
            eerr "\aI'm sorry. That is not an option available"
            eerr "Please, try again."
            demo_menu
            ;;
    esac
}