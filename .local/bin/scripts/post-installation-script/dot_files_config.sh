#!/bin/sh

CWD=`pwd`
NAME=$USER

DOT_REPO_GITHUB_HTTPS="https://github.com/martimdLima/dotfiles.git"
DOT_REPO_GITLAB_HTTPS="https://gitlab.com/mdLima0/dotfiles.git"

#https://gitlab.com/mdLima0/dotfiles.git
REPO_BRANCH="master"

source <(curl -s https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh)

intro() {
  echo "${BOLD}${FG_GREEN}Dotfiles configuration started${RESETS}"
  echo
}

outro() {
  echo "${BOLD}${FG_GREEN}Dotfiles configuration ended${RESETS}"
}

# function called by trap
catchctrlplusc() {
    goodbye
    exit
}

# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
putgitrepo() { 
  cd $HOME
  #dialog --infobox "Downloading and installing config files..." 4 60
  [ -z "$3" ] && branch="master" || branch="$REPO_BRANCH"
  dir=$(mktemp -d)
  [ ! -d "$2" ] && mkdir -p "$2"
  chown "$NAME":wheel "$dir" "$2"
  # >> /dev/null redirects standard output (stdout) to /dev/null, which discards it.
  # 2>&1 redirects standard error (2) to standard output (1), which then discards it as well since standard output has already been redirected.
  echo "${FG_YELLOW}Cloning Repository${RESETS}"
  sudo -u "$NAME" git clone --recursive -b "$branch" --depth 1 --recurse-submodules "$1" "$dir" >/dev/null 2>&1
  echo
  echo "${FG_YELLOW}Copying Files${RESETS}" 
  sudo -u "$NAME" cp -rfT "$dir" "$2"
  echo

  exec zsh

 if ! config checkout; then 
  mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
  config checkout
  config config --local status.showUntrackedFiles no
fi
  #clear
}

cleanup() {
    echo "${FG_YELLOW}${RUL}Cleaning up${RESETS}"
    echo

    # Remove README.md
    rm -f "$HOME/README.md"
    rm -f "$HOME/.zshrc"
    rm -f "$HOME/.zsh_history"
    rm -rf "$HOME/.zcompdump-*"

    # make git ignore deleted README.md file
    git update-index --assume-unchanged "$HOME/README.md"
}

# check if git exists
if ! command -v git &> /dev/null; then
  intro
  echo "${BOLD}${RED}$Git wasn't detected in the system. Please install git to procceed${RESETS}"
  exit 1
fi

trap catchctrlplusc SIGINT

intro

# Download dotFiles
putgitrepo "$DOT_REPO_GITHUB_HTTPS" "$HOME" "$REPO_BRANCH"

cleanup

outro