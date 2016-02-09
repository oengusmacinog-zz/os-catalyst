#!/bin/bash

# Make Directories
make_directory() {

    [ -z "$2" ] && local DIRPATH="$HOME" || local DIRPATH="$2"

    if is_dir "$DIRPATH/$1"; then
        emes infpos $1 'directory already exists'
        return
    fi

    emes mkdir $1

    nosudo mkdir -p "$DIRPATH/$1" >> $TMP_DIR/temp_output.log 2>&1 &
    progress_spinner $!
    econ check is_dir "$DIRPATH/$1"

}

config_gnome_terminal() {

    if is_sudo; then
        die "User configurations can not be run by root user"
    fi

    #Get terminal profile id for default profile
    local PROFILEID=$(gsettings get org.gnome.Terminal.ProfilesList default)

    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/foreground-color "'rgb(238,238,236)'"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/use-system-font "false"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/use-transparent-background "true"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/use-theme-colors "false"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/use-theme-transparency "false"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/font "'Ubuntu Mono 13'"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/audible-bell "false"
    dconf write /org/gnome/terminal/legacy/profiles:/:"${PROFILEID//\'}"/background-transparency-percent "3"
}

config_sublime() {
  emes config 'Configuring' 'Sublime Text' '3'


  emes extraconf 'Package Control' 'packages' 'Installing'
    wget -qP ~/.config/sublime-text-3/Installed\ Packages http://packagecontrol.io/Package%20Control.sublime-package
    st
    sleep 10
    cp "$SCRIPT_PATH/opt/sublime/Package Control.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"
    sleep 30
    esuc -i

    emes extraconf  'settings' 'Sublime Text 3' 'Configuring'
    cp "$SCRIPT_PATH/opt/sublime/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
    esuc -i
}



install_theme() {
  case $1 in
    Arc-Dark*|Arc-dark*|arc-dark*)
      emes config 'Installing' 'Arc-Dark' 'Gnome theme'

      install_package autoconf
      install_package automake
      install_package pkg-config
      install_package libgtk-3-dev
      install_package git

      nosudo git clone https://github.com/horst3180/arc-theme --depth 1
      cd arc-theme
      nosudo chmod +x autogen.sh
      nosudo ./autogen.sh --prefix=/usr
      make install
      cd ..
      rm -rf arc-theme

      econ check is_dir "/usr/share/themes/Arc-Dark"
      ;;
    *) eerr "Please Specify a Gnome theme..." && safe_exit;;
  esac
}

config_gnome_settings() {

    if is_sudo; then
        die "User configurations can not be run by root user"
    fi

    emes config 'Gnome 3' 'Adjusting' 'settings'

    emes extraconf 'Setting' 'power' '' '' 'preferences'
    gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
    # gsettings set org.gnome.settings-daemon.plugins.power active false
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'font' '' '' 'preferences'
    gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font true
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Medium 11'
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'clock' '' '' 'preferences'
    gsettings set org.gnome.desktop.interface clock-format '12h'
    gsettings set org.gnome.desktop.interface clock-show-date true #Clock Shows Date
    gsettings set org.gnome.desktop.interface clock-show-seconds false

    cp -rf "$SCRIPT_PATH/opt/graphics/wallpaper/" "$HOME/.local/share/wallpaper/"
    case $usr_wallpaper in
        teksyndicate) usr_wallpaper='teksyndicate_1.png';;
        *) :;;
    esac
    gsettings set org.gnome.desktop.background picture-uri "file://$HOME/.local/share/wallpaper/$usr_wallpaper"
    case $usr_screensaver in
        teksyndicate) usr_screensaver='teksyndicate_blue.png';;
        teksyndicate_blue|teksyndicate-blue|ts-blue) usr_screensaver='teksyndicate_blue.png';;
        *) :;;
    esac
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$HOME/.local/share/wallpaper/$usr_screensaver"
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'notification' '' '' 'preferences'
    gsettings set org.gnome.desktop.notifications show-in-lock-screen false
    gsettings set org.gnome.desktop.notifications show-banners true
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'navigation' '' '' 'preferences'
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close' #Windows have min & close buttons, no max button shown
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'sound' '' '' 'preferences'
    gsettings set org.gnome.desktop.sound input-feedback-sounds false
    gsettings set org.gnome.desktop.sound event-sounds true
    gsettings set org.gnome.desktop.wm.preferences audible-bell true
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'bindings' '' '' 'preferences'
    gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
    gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'menu'
    gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
    gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'minimize'
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button false
    gsettings set org.gnome.desktop.interface menubar-accel 'F10'
    gsettings set org.gnome.desktop.interface cursor-size 24
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'toolbar' '' '' 'preferences'
    gsettings set org.gnome.desktop.interface toolbar-style 'both-horiz'
    gsettings set org.gnome.desktop.interface toolbar-icons-size 'large'
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'interactive' '' '' 'preferences'
    gsettings set org.gnome.desktop.interface buttons-have-icons false
    gsettings set org.gnome.desktop.interface cursor-blink true
    printf ' '
    esuc -i


    emes extraconf 'Setting' 'menu' '' '' 'preferences'
    gsettings set org.gnome.desktop.interface menus-have-icons false
    printf ' '
    esuc -i

    emes extraconf 'Setting' 'Nautilus' '' '' 'preferences'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    printf ' '
    esuc -i

}

disable_error_dialogs() {

    sed -i "s/enabled=1/enabled=0/g" /etc/default/apport

}

configGit() {

    emes config Git
    git config --global user.email "$git_name"
    git config --global user.name "$git_email"
    git config --global push.default "$git_push"
    esuc -i

}
