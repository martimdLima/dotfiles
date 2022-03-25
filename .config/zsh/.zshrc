source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc
colorscript random

# -> SSH Initialization
init_ssh_agent

# -> Tmux Initialization
init_tmux

# -> Powerline10K
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
init_p10k

# -> Node Version Manager  Initialization
init_nvm

# -> Zsh global options
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

# History
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

ZSH_THEME="powerlevel10k/powerlevel10k" # Set name of the theme to load

# Plugins 
plugins=(git
  zsh-syntax-highlighting        # enables highlighting of commands whilst they are typed at a zsh promp
  zsh-autosuggestions            # suggests commands as you type based on history and completions
  zsh-completions                # new completion scripts that are not available in Zsh yet
  fzf-zsh-plugin                 # enables using fzf to search your command history and do file searches            
  autojump                       # a faster way to navigate your filesystem
  copypath                       # Copies the path of given directory or file to the system clipboard
  copyfile                       # Puts the contents of a file in your system clipboard so you can paste it anywhere
  copybuffer                     # binds the ctrl-o keyboard shortcut to a command that copies the text that is currently typed to the buffer
  dirhistory                     # This plugin adds keyboard shortcuts for navigating directory history and hierarchy
  cp
  ag                             # code searching tool similar to ack, with a focus on speed
  aliases                        # creates helpful shortcut aliases for many commonly used commands
  colored-man-pages              # adds colors to man pages
  nvm                            # adds autocompletions for nvm
  )

source $ZSH/oh-my-zsh.sh

# +----------------+
# | PowerLevel10k  |
#------------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh