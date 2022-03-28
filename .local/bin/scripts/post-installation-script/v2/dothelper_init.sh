#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"
source $SCRIPTS_DIR/colors.sh
source $SCRIPTS_DIR/dothelper_install.sh

logo() {
  # print dothelper logo
  printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "    ___      _   _          _       "
  printf "%s\n" "   /   \___ | |_| |__   ___| |_ __   ___ _ __ "
  printf "%s\n" "  / /\ / _ \| __| '_ \ / _ \ | '_ \ / _ \ '__|"
  printf "%s\n" " / /_// (_) | |_| | | |  __/ | |_) |  __/ |   "
  printf "%s\n" "/___,' \___/ \__|_| |_|\___|_| .__/ \___|_|   "
  printf "%s\n" "                             |_|             "
  printf "${RESETS}\n%s" ""
}

intro() {
  logo
  USERS_NAME=$LOGNAME
  printf "\n\a%s" "Hi${FG_ORANGE} $USERS_NAME ${RESETS}"
  echo
}


system_pkgs_config() {
    system_pkgs_update_and_install_menu
}

dot_files_config() {
    . $SCRIPTS_DIR/dothelper_config.sh
}

mainmenu() {
    echo -ne "
$(bold_blue_print 'MAIN MENU')
$(bold_yellow_print '1)') Update System & Install Software
$(bold_yellow_print '2)') Install dotfiles
$(bold_red_print '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        system_pkgs_update_and_install_menu
        mainmenu
        ;;
    2)
        dot_files_config
        mainmenu
        ;;
    0)
        goodbye
        ;;
    *)
        opt_fail
        ;;
    esac
}

intro

mainmenu