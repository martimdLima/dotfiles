#!/bin/sh

# CONFIG=/.config/
# DOT_LOCAL=./local/
# DOT_SPACEVIM=/.SpaceVim.d/
# DOT_TMUX=/.tmux/
#dialog --title Information[!] --msgbox "This is an information message." 10 50
#dialog --title Information[!] --msgbox "This is an information message 2." 10 50

CWD=`pwd`
DOT_FILES_REPO="https://github.com/martimdLima/dotfiles.git"
REPO_BRANCH="master"
NAME=$USER
HOME_DIR="/home/mdlima/Documents/test/test3/"

SOURCE=/home/mdlima/Documents/test/test/
DESTINATION=/home/mdlima/Documents/test/test2/

cd $HOME



#putgitrepo() { # Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
#  dialog --infobox "Downloading and installing config files..." 4 60
#  [ -z "$3" ] && branch="master" || branch="$repobranch"
#  dir=$(mktemp -d)
#  [ ! -d "$2" ] && mkdir -p "$2"
#  chown "$name":wheel "$dir" "$2"
#  sudo -u "$name" git clone --recursive -b "$branch" --depth 1 --recurse-submodules "$1" "$dir" >/dev/null 2>&1
#  sudo -u "$name" cp -rfT "$dir" "$2"
#  }

#putgitrepo "$DOT_FILES_REPO" "$HOME" "$REPO_BRANCH"

#git clone --recursive --depth 1 https://github.com/martimdLima/dotfiles.git 

putgitrepo() { # Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
  dialog --infobox "Downloading and installing config files..." 4 60
  [ -z "$3" ] && branch="master" || branch="$REPO_BRANCH"
  dir=$(mktemp -d)
  [ ! -d "$2" ] && mkdir -p "$2"
  chown "$NAME":wheel "$dir" "$2"
  sudo -u "$NAME" git clone --recursive -b "$branch" --depth 1 --recurse-submodules "$1" "$dir" >/dev/null 2>&1
  sudo -u "$NAME" cp -rfT "$dir" "$2"
}

putgitrepo "$DOT_FILES_REPO" "$HOME_DIR" "$REPO_BRANCH"

rm -f "/home/mdlima/Documents/test/test3/README.md"

# make git ignore deleted LICENSE & README.md files
git update-index --assume-unchanged "/home/$NAME/README.md"