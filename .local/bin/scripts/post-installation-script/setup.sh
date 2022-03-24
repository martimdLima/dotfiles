#!/bin/bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

source $SCRIPTS_DIR/colors.sh

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

clean_up() {
  test -d "$TMP_DIR" && rm -fr "$TMP_DIR"
}

clean_up() {
  test -d "$SCRIPTS_DIR" && rm -fr "$SCRIPTS_DIR"
}

goodbye() {
  printf "\a\n\n%s\n${BOLD}Thanks for using dothelper.${RESETS}"
  #clean_up
  echo
}

# Searches the package in the system, if it's found skips the installation proccess, otherwise installs the package
packexists() {
  # silence non-error output, redirects stdout to /dev/null
  if(($1 == "yay"))
  then
    pacman -Qs $1 > /dev/null
  else
    yay -Qs $1 > /dev/null
  fi
    
    PKG_EXISTS=$?
    
    if((PKG_EXISTS == 0)) 
    then
        echo "${BOLD}${FG_RED}Skipping $1. $1 already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing $1${RESETS}"
        yay -S $1 --needed --noconfirm
    fi
}

# Updates mirros and downloads yay, git and dialog
initsetup() {

echo "${BOLD}${FG_GREEN}Updating Mirrors${RESETS}"
sudo pacman -Sy

echo "${BOLD}${FG_GREEN}Installing Yay, Git and Dialog${RESETS}"
sudo pacman -S yay --needed --noconfirm
yay -S git --needed --noconfirm
yay -S dialog --needed --noconfirm
}

initDialog() {
  # Initializes the dialog with the specifed measurements
  cmd=(dialog --separate-output --checklist "Welcome to DotHelper. Press SPACE to toggle an option on/off." 22 76 16)
  options=(
    1 "Update System & Install Software" off    # any option can be set to default to "on"
    2 "Install dotfiles" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear

  for choice in $choices
    do
    case $choice in
      1)  
        . $SCRIPTS_DIR/post_install.sh
        ;;
      2)
        . $SCRIPTS_DIR/dot_files_config.sh
        ;;
      3)
        clean_up
      ;;
      esac
  done
}

intro

initsetup

initDialog

goodbye