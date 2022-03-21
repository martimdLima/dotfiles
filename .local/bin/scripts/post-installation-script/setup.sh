#!/bin/bash

source ./colors.sh

logo() {
  # print dothelper logo
  printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "    ___      _   _          _       "
  printf "%s\n" "   /   \___ | |_| |__   ___| |_ __   ___ _ __ "
  printf "%s\n" "  / /\ / _ \| __| '_ \ / _ \ | '_ \ / _ \ '__|"
  printf "%s\n" " / /_// (_) | |_| | | |  __/ | |_) |  __/ |   "
  printf "%s\n" "/___,' \___/ \__|_| |_|\___|_| .__/ \___|_|   "
  printf "%s\n" "                             |_|             "
  printf "${RESET}\n%s" ""
}

intro() {
  logo
  USERS_NAME=$LOGNAME
  printf "\n\a%s" "Hi${BOLD}${FG_ORANGE} $USERS_NAME ${RESET}"
  echo
}

goodbye() {
  printf "\a\n\n%s\n" "${BOLD}Thanks for using dothelper. ${RESET}"
}

intro

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

			curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/post_install.sh | /bin/bash
			;;
		2)
			curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/dot_files_config.sh | /bin/bash
			;;
    esac
done

goodbye