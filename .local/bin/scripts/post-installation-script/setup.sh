#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh)

# Updating Mirros and downloading dialog
echo "${BOLD}Updating Mirrors${RESETS}"
sudo pacman -Sy

#if ! which dialog &> /dev/null; then
# echo "Installing Dialog"
# sudo pacman -S dialog
#fi

# check if dialog exists
if ! command -v dialog &> /dev/null; then
  echo "Can't work without Dialog. Dialog must be installed to procceed."
  printf "Would you like to install Dialog? (y/N)"
  read -r install
  [ "$(tr '[:upper:]' '[:lower:]' <<< "$install")" = "y" ] && sudo pacman -S dialog
 # exit 1
fi

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