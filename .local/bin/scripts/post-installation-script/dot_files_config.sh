#!/bin/sh

CWD=`pwd`
NAME=$USER
HOME_DIR="/home/mdlima"
DOT_REPO_HTTPS="https://github.com/martimdLima/dotfiles.git"
DOT_REPO_SSH="git@github.com:martimdLima/dotfiles.git"
REPO_BRANCH="master"

source ./colors.sh

intro() {
  logo
  USERS_NAME=$LOGNAME
  printf "\n\a%s" "Hi${BOLD}${FG_ORANGE} $USERS_NAME ${RESET}"
  echo
}

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

# function called by trap
catchctrlplusc() {
    goodbye
    exit
}

# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
putgitrepo() { 
  dialog --infobox "Downloading and installing config files..." 4 60
  [ -z "$3" ] && branch="master" || branch="$REPO_BRANCH"
  dir=$(mktemp -d)
  [ ! -d "$2" ] && mkdir -p "$2"
  chown "$NAME":wheel "$dir" "$2"
  # >> /dev/null redirects standard output (stdout) to /dev/null, which discards it.
  # 2>&1 redirects standard error (2) to standard output (1), which then discards it as well since standard output has already been redirected.
  sudo -u "$NAME" git clone --recursive -b "$branch" --depth 1 --recurse-submodules "$1" "$dir" >/dev/null 2>&1
  sudo -u "$NAME" cp -rfT "$dir" "$2"

 if ! config checkout; then
  mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
  config checkout
  config config --local status.showUntrackedFiles no
}

goodbye() {
  printf "\a\n\n%s\n" "${BOLD}Thanks for using dothelper. ${RESET}"
  printf "%s\n" "${BOLD}Report Bugs @ ${UL}https://github.com/Bhupesh-V/dotman/issues${RUL} ${RESET}"
}

intro

# check if git exists
if ! command -v git &> /dev/null; then
  intro
  echo "Git wasn't detected in the system. Please install git to procceed"
  exit 1
fi

trap catchctrlplusc SIGINT

cd $HOME_DIR

# Download dotFiles
putgitrepo "$DOT_REPO_SSH" "$HOME_DIR" "$REPO_BRANCH"

# Remove README.md
rm -f "/home/mdlima/Documents/test/README.md"

# make git ignore deleted README.md file
git update-index --assume-unchanged "$HOME_DIR/README.md"

goodbye

