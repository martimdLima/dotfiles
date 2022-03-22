#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh)

logo() {
  # print dothelper logo
  printf "${FG_SKYBLUE}%s\n" ""
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

goodbye() {
  printf "\a\n\n%s\n${BOLD}Thanks for using dothelper.${RESETS}"
}

intro

# Updating Mirros and downloading dialog
echo "${BOLD}Updating Mirrors${RESETS}"
sudo pacman -Sy

# Checks if yay is installed, if it's not installed, install it and update Aur packages
echo "Installing yay"
#pacman -Qs yay && echo "${GREEN} Yay already installed ${RESET}" || sudo pacman -S yay --noconfirm
sudo pacman -S yay --noconfirm

# Checks if dialog is installed, if it's not installed, install it and update Aur packages
echo "Installing dialog"
yay -S dialog --noconfirm
#pacman -Qs dialog && echo "${GREEN} Dialog already installed ${RESET}" || yay -S dialog --noconfirm

# check if git exists
#if ! command -v git &> /dev/null; then
#  printf "%s\n\n" "${BOLD}${FG_SKYBLUE}${DOTMAN_LOGO}${RESET}"
#  echo "Can't work without Dialog. Please install dialog to continue 😞"
#  exit 1
#fi

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