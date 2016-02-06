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

    emes config 'Sublime Text 3'

    # Install License Key
    # sudo -u $SUDO_USER cp $__dir__/resources/License.sublime_license $HOME/.config/sublime-text-3/Local/License.sublime_license

    # emes extraconf 'Configuring' 'Packages'
    if is_not_dir "$HOME/.config/sublime-text-3/Installed\ Packages"; then
        install_sublime_pc
    else
        # Move Package Control settings with list of Packages to the config folder
        # nosudo cp "$SCRIPT_PATH/opt/sublime/Package\ Control.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings"

        # Make an Sublime executable from the cli by making a sym link in local bin
        # ln -s "$SCRIPT_PATH/opt/sublime_text/sublime_text" "/usr/local/bin/st"

        # emes extraconf 'Running' 'Sublime Text' 'to autogenerate files'
        # Start up Sublime to install packages from 'Package\ Control.sublime-settings'
        # nosudo st

        # sleep 10

        # Preferences
        is_file "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" && cp "$SCRIPT_PATH/opt/sublime/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings" || emes infpos 'Package Preferences' 'already installed'
        # nosudo cp "$SCRIPT_PATH/opt/sublime/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

        # Custom Color Theme
        cp "$SCRIPT_PATH/opt/sublime/OensThemev2.tmTheme" "$HOME/.config/sublime-text-3/Packages/User/OensThemev2.tmTheme"
    fi

}

config_gnome_theme() {
    emes config 'Configuring' 'Gnome 3' 'Theme'
    # if is_file "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"; then
    #     emes infpos 'Package Preferences' 'already installed'
    # else
        check_dependencies dpkg 'autoconf' 'automake' 'pkg-config' 'libgtk-3-dev'
        emes extrapos 'Building' 'Arc-theme'


        # Install Arc Theme
        nosudo git clone https://github.com/horst3180/arc-theme --depth 1
        cd arc-theme
        nosudo chmod +x autogen.sh
        nosudo ./autogen.sh --prefix=/usr
        make install
        cd ..
        nosudo rm -rf arc-theme

        # Set GTK theme with gsettings
        # nosudo gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
        esuc -i
    # fi

    # if is_file "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"; then
    #     emes infpos 'Package Preferences' 'already installed'
    # else
        # Install Numic Circle Icon Theme
        install_package numix-icon-theme-circle

        #Fix Sublime_text Icon
        dpkg_installed sublime-text-installer && ln -s /usr/share/icons/Numix-Circle/48x48/apps/sublime-text.svg /usr/share/icons/Numix-Circle/48x48/apps/Sublime_text.svg || true

        # Set Icon theme with gsettings
        # nosudo gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
    # fi

    # if is_file "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"; then
    #     emes infpos 'Package Preferences' 'already installed'
    # else
        emes actpos 'Installing' 'GT3 Light Cursor'

        nosudo wget -q - http://gnome-look.org/CONTENT/content-files/106536-GT3-colors-pack.rar  >> $TMP_DIR/temp_output.log 2>&1 &

        nosudo unrar e 106536-GT3-colors-pack.rar >> $TMP_DIR/temp_output.log 2>&1 &
        tar zxf GT3.tar.gz -C /usr/share/icons >> $TMP_DIR/temp_output.log 2>&1 &
        tar zxf GT3-bronze.tar.gz -C /usr/share/icons >> $TMP_DIR/temp_output.log 2>&1 &
        tar zxf GT3-red.tar.gz -C /usr/share/icons >> $TMP_DIR/temp_output.log 2>&1 &
        tar zxf GT3-azure.tar.gz -C /usr/share/icons >> $TMP_DIR/temp_output.log 2>&1 &
        tar zxf GT3-light.tar.gz -C /usr/share/icons >> $TMP_DIR/temp_output.log 2>&1 &

        nosudo rm 106536-GT3-colors-pack.rar GT3.tar.gz GT3-bronze.tar.gz GT3-red.tar.gz GT3-azure.tar.gz GT3-light.tar.gz >> $TMP_DIR/temp_output.log 2>&1 &

        # nosudo gsettings set org.gnome.desktop.interface cursor-theme 'GT3-light' >> $TMP_DIR/temp_output.log 2>&1 &
        esuc -i
    # fi
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
