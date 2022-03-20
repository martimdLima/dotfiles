#!/bin/sh

IFS=$'\n'
NL=$'\n'

CWD=`pwd`
REPO_BRANCH="master"
VERSION="v0.3.0"

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

init_check() {
  # Check wether its a first time use or not
  #if [[ -z ${DOT_REPO} && -z ${DOT_DIR} ]]; then
  if [[ -z $(grep "DOT_DIR" ~/.zshenv) && -z $(grep "DOT_REPO" ~/.zshenv)  ]]; then
    initial_setup
    goodbye
  else
    repo_check
    manage
  fi
}

initial_setup() {
  printf "\n\n%s\n" "First time use detected. Setting up ${BOLD}dothelper${RESET}"
  printf "%s\n" "...................................."
  read -p "➤ Enter dotfiles repository URL : " -r DOT_REPO
  read -p "➤ Where should I clone ${BOLD}$(basename "${DOT_REPO}")${RESET} (${HOME}/..): " -r DOT_DIR
  DOT_DIR=${DOT_DIR:-$HOME}

  if [[ -d "$HOME/$DOT_DIR" ]]; then
    printf "\n%s\r\n" "${BOLD}Calling Git ... ${RESET}"
    clone_dotrepo "$DOT_DIR" "$DOT_REPO"
    printf "\n%s\n" "Open a new terminal or source your shell config"
  else
    printf "\n%s" "[]${BOLD}$DOT_DIR${RESET} wasn't found in the system. Creating directory."
    mkdir "$HOME/$DOT_DIR"
    printf "\n%s" "[✔️ ]${BOLD}$DOT_DIR${RESET} created.${NL}"
    clone_dotrepo "$DOT_DIR" "$DOT_REPO"
    exit 1
  fi
}

clone_dotrepo (){
  # clone the repo in the destination directory
  DOT_DIR=$1
  DOT_REPO=$2

  # if downloading the repo succeeds, continue
  if git clone --recursive -b $REPO_BRANCH --depth 1 --recurse-submodules "${DOT_REPO}" "${HOME}/${DOT_DIR}"; then
    if [[ $DOT_REPO && $DOT_DIR ]]; then
      add_env "$DOT_REPO" "$DOT_DIR"
    fi
    printf "\n%s" "[✔️] dothelper successfully configured"
  else
    # invalid arguments to exit, Repository Not Found
    printf "\n%s" "[ ] $DOT_REPO Unavailable. Exiting!"
    exit 1
  fi
}

add_env() {

  [[ $(grep "DOT_DIR" ~/.zshenv) && $(grep "DOT_REPO" ~/.zshenv)  ]] && return
  
  # export environment variables
  printf "\n%s\n" "Exporting env variables DOT_DIR & DOT_REPO ..."
  
  current_shell=$(basename "$SHELL")
  if [[ $current_shell == "zsh" ]]; then
    echo -e "${NL}# +-----------+${NL}# | DotFiles  |${NL}# +-----------+${NL}export DOT_REPO=$1${NL}export DOT_DIR=$2" >> "$HOME"/.zshenv
  elif [[ $current_shell == "bash" ]]; then
    # assume we have a fallback to bash
    echo -e "${NL}# +-----------+${NL}# | DotFiles  |${NL}# +-----------+${NL}export DOT_REPO=$1${NL}export DOT_DIR=$2" >> "$HOME"/.bashrc
  else
    echo "Couldn't export ${BOLD}DOT_REPO=$1${RESET} and ${BOLD}DOT_DIR=$2${RESET}"
    echo "Consider exporting them manually."
    exit 1
  fi
  printf "\n%s" "Configuration for SHELL: ${BOLD}$current_shell${RESET} has been updated."
}

repo_check(){
  # check if dotfile repo is present inside DOT_DIR

  DOT_REPO_NAME=$(basename "${DOT_REPO}")
  # all paths are relative to HOME
  if [[ -d ${HOME}/${DOT_DIR}/${DOT_REPO_NAME} ]]; then
      printf "\n%s\n" "Found ${BOLD}${DOT_REPO_NAME}${RESET} as dotfile repo in ${BOLD}~/${DOT_DIR}/${RESET}"
  else
      printf "\n\n%s\n" "[❌] ${BOLD}${DOT_REPO_NAME}${RESET} not present inside path ${BOLD}${HOME}/${DOT_DIR}${RESET}"
      read -p "Should I clone it ? [Y/n]: " -n 1 -r USER_INPUT
      USER_INPUT=${USER_INPUT:-y}
      case $USER_INPUT in
        [y/Y]* ) clone_dotrepo "$DOT_DIR" "$DOT_REPO" ;;
        [n/N]* ) printf "\n%s" "${BOLD}${DOT_REPO_NAME}${RESET} not found";;
        * )     printf "\n%s\n" "[❌] Invalid Input 🙄, Try Again";;
      esac
  fi
}

manage() {
  while :
  do
    printf "\n%s" "[${BOLD}1${RESET}] Show diff"
    printf "\n%s" "[${BOLD}2${RESET}] Push changed dotfiles"
    printf "\n%s" "[${BOLD}3${RESET}] Pull latest changes"
    printf "\n%s" "[${BOLD}4${RESET}] List all dotfiles"
    printf "\n%s\n" "[${BOLD}q/Q${RESET}] Quit Session"
    read -p "What do you want me to do ? [${BOLD}1${RESET}]: " -n 1 -r USER_INPUT
    # Default choice is [1], See Parameter Expansion
    USER_INPUT=${USER_INPUT:-1}
    case $USER_INPUT in
      [1]* ) show_diff_check;;
      [2]* ) dot_push;;
      [3]* ) dot_pull;;
      [4]* ) find_dotfiles;;
      [q/Q]* ) goodbye 
           exit;;
      * )     printf "\n%s\n" "[❌]Invalid Input 🙄, Try Again";;
    esac
  done
}

show_diff_check() {
  diff_check "show"
}

diff_check() {

  [[ -z $1 ]] && local file_arr

  # dotfiles in repository
  readarray -t dotfiles_repo < <( find "${HOME}/${DOT_DIR}/$(basename "${DOT_REPO}")" -maxdepth 1 -name ".*" -type f )

  # check length here ?
  for i in "${!dotfiles_repo[@]}"
  do
    dotfile_name=$(basename "${dotfiles_repo[$i]}")
    # compare the HOME version of dotfile to that of repo
    diff=$(diff -u --suppress-common-lines --color=always "${dotfiles_repo[$i]}" "${HOME}/${dotfile_name}")
    if [[ $diff != "" ]]; then
      if [[ $1 == "show" ]]; then
        printf "\n\n%s" "Running diff between ${BOLD} ${FG_ORANGE}${HOME}/${dotfile_name}${RESET} and "
        printf "%s\n" "${BOLD}${FG_ORANGE}${dotfiles_repo[$i]}${RESET}"
        printf "%s\n\n" "$diff"
      fi
      file_arr+=("${dotfile_name}")
    fi
  done

  [ ${#file_arr} == 0 ] && printf "\n%s\n" "${BOLD}No Changes in dotfiles.${RESET}";return
}

dot_push() {
  diff_check
  if [[ ${#file_arr} != 0 ]]; then
    printf "\n%s\n" "${BOLD}Following dotfiles changed${RESET}"
    for file in "${file_arr[@]}"; do
      echo "$file"
      cp "${HOME}/$file" "${HOME}/${DOT_DIR}/$(basename "${DOT_REPO}")"
    done

    dot_repo="${HOME}/${DOT_DIR}/$(basename "${DOT_REPO}")"
    git -C "$dot_repo" add -A

    echo "${BOLD}Enter Commit Message (Ctrl + d to save): ${RESET}"
    commit=$(</dev/stdin)
    printf "\n"
    git -C "$dot_repo" commit -m "$commit"

    # Run Git Push
    git -C "$dot_repo" push
  else
    return
  fi
}

dot_pull() {
  # pull changes (if any) from the remote repo
  printf "\n%s\n" "${BOLD}Pulling dotfiles ...${RESET}"
  dot_repo="${HOME}/${DOT_DIR}/$(basename "${DOT_REPO}")"
  printf "\n%s\n" "Pulling changes in $dot_repo"
  GET_BRANCH=$(git remote show origin | awk '/HEAD/ {print $3}')
  printf "\n%s\n" "Pulling from ${BOLD}${GET_BRANCH}" 
  git -C "$dot_repo" pull origin "${GET_BRANCH}"
}

find_dotfiles() {
  printf "\n"
  # while read -r value; do
  #     dotfiles+=($value)
  # done < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
  readarray -t dotfiles < <( find "${HOME}" -maxdepth 3 -name ".*" -type f )
  printf '%s\n' "${dotfiles[@]}"
}

goodbye() {
  printf "\a\n\n%s\n" "${BOLD}Thanks for using dothelper. ${RESET}"
  printf "%s\n" "${BOLD}Report Bugs @ ${UL}https://github.com/Bhupesh-V/dothelper/issues${RUL} ${RESET}"
}

# check if git exists
if ! command -v git &> /dev/null; then
  intro
  echo "Git wasn't detected in the system. Please install git to procceed"
  exit 1
fi

trap catchctrlplusc SIGINT

cd $HOME_DIR

if [[ $1 == "version" || $1 == "--version" || $1 == "-v" ]]; then
  if [[ -d "$HOME/dotfiles" ]]; then
    latest_tag=$(git -C "$HOME/dotfiles" describe --tags --abbrev=0)
    latest_tag_push=$(git -C "$HOME/dotfiles" log -1 --format=%ai "${latest_tag}")
    echo "${BOLD}dothelper ${latest_tag} ${RESET}"
    echo "Released on: ${BOLD}${latest_tag_push}${RESET}"
  else
    echo "${BOLD}dothelper ${VERSION}${RESET}"
  fi
  exit
fi

intro
init_check