#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

source "$SCRIPTS_DIR"/colors.sh

DOT_REPO_GITHUB_HTTPS="https://github.com/martimdLima/dotfiles.git"
#DOT_REPO_GITHUB_SSH="git@github.com:martimdLima/dotfiles.git"
#DOT_REPO_GITLAB_HTTPS="https://gitlab.com/mdLima0/dotfiles.git"
#DOT_REPO_GITLAB_SSH="git@gitlab.com:mdLima0/dotfiles.git"
REPO_BRANCH="master"

welcome() {
  printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "##############################################"
  printf "%s\n" "#      DotHelper Dotfiles Configuration      #"     
  printf "%s\n" "##############################################"
  printf "${RESETS}\n%s" ""

  printf "\n\a%s" "${BOLD}${FG_GREEN}Dotfiles configuration started${RESETS}"
  echo
}

goodbye() {
  echo "${BOLD}${FG_GREEN}Dotfiles configuration ended${RESETS}"
}

# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
procrepo() { 
  cd "$HOME" || exit 
  
  #dialog --infobox "Downloading and installing config files..." 4 60
  [ -z "$3" ] && branch="master" || branch="$REPO_BRANCH"
  dir=$(mktemp -d)
  [ ! -d "$2" ] && mkdir -p "$2"
  chown "$NAME":wheel "$dir" "$2"
 
  # >> /dev/null redirects standard output (stdout) to /dev/null, which discards it.
  # 2>&1 redirects standard error (2) to standard output (1), which then discards it as well since standard output has already been redirected.  
  echo "${BOLD}${FG_YELLOW}Cloning Repository${RESETS}"
  echo
  sudo -u "$NAME" git clone --recursive -b "$branch" --depth 1 --recurse-submodules "$1" "$dir" >/dev/null 2>&1
  echo
  
  echo "${BOLD}${FG_YELLOW}Copying Files${RESETS}"
  echo 
  sudo -u "$NAME" cp -rfT "$dir" "$2"
  echo

  exec zsh
}

config_dotrepo() {
  git clone --bare $DOT_REPO_GITHUB_HTTPS "$HOME"/.dotfiles
  
  function config {
     /usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
  }

  mkdir -p .config-backup

  config checkout >/dev/null 2>&1

  CHECKS_OUT=$?

  if [[ $CHECKS_OUT == 0 ]]; then
    echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} .config-backup/{}
  fi;

  config checkout | zsh
  config config status.showUntrackedFiles no | zsh
}


welcome

# Download and setup dotfiles
#procrepo "$DOT_REPO_GITHUB_HTTPS" "$HOME" "$REPO_BRANCH"
config_dotrepo

goodbye