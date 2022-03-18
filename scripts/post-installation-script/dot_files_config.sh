#!/bin/sh

# CONFIG=/.config/
# DOT_LOCAL=./local/
# DOT_SPACEVIM=/.SpaceVim.d/
# DOT_TMUX=/.tmux/
#dialog --title Information[!] --msgbox "This is an information message." 10 50
#dialog --title Information[!] --msgbox "This is an information message 2." 10 50

CWD=`pwd`

NAME=$USER
HOME_DIR="/home/mdlima/Documents/test/"
DOT_FILES_REPO="https://github.com/martimdLima/dotfiles.git"
REPO_BRANCH="master"

cd $HOME_DIR

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
}

putgitrepo "$DOT_FILES_REPO" "$HOME_DIR" "$REPO_BRANCH"

rm -f "/home/mdlima/Documents/test/README.md"

# make git ignore deleted LICENSE & README.md files
git update-index --assume-unchanged "$HOME_DIR/README.md"