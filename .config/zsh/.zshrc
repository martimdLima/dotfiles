source $HOME/.zplug/init.zsh

# +------------+
# | Exports    |
#--------------+
source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc
#source $HOME/.local/share/lf/icons

# Random Color Script
colorscript random

# +-------+
# | Tmux  |
# +-------+

#if [ -z "$TMUX" ]
#then
#    tmux attach -t TMUX || tmux new -s TMUX
#fi
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t TMUX || tmux new -s TMUX; exit
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# +----------------------+
# | Node Version Manager |
#	+----------------------+
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# +-----+
# | ZSH |
#-------+
# Zsh global options

# Navigation
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
#setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt globdots             # tab-complete dotfiles
setopt menucomplete         # tab-expand to first option immediately
setopt no_autoremoveslash   # keep trailing slash after dir completion
setopt interactivecomments  # enable comments in shell commands
ZLE_REMOVE_SUFFIX_CHARS=    # keep trailing space after completion
disable r                   # remove irritating alias
zle_highlight+=(paste:none) # Don't highlight pasted text

## History
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# +---------+
# | Plugins |
#-----------+
plugins=(git
	 zsh-syntax-highlighting
	 autojump
	 cp
	 copyfile
	 zsh-autosuggestions
	 fzf-zsh-plugin
	 ag
	 aliases
	 colored-man-pages
	 nvm
)

source $ZSH/oh-my-zsh.sh

# +----------------+
# | PowerLevel10k  |
#------------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh