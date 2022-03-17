source $HOME/.zplug/init.zsh

# +------------+
# | Exports    |
#--------------+
source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc
#source $HOME/.local/share/lf/icons

# +-------+
# | Tmux |
#--------+

if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# +-----+
# | ZSH |
#-------+
# Zsh global options

setopt globdots             # tab-complete dotfiles
setopt menucomplete         # tab-expand to first option immediately
setopt autocd               # change dirs without 'cd'
setopt hist_ignore_dups     # don't add duplicate cmd to hist
setopt no_autoremoveslash   # keep trailing slash after dir completion
setopt interactivecomments  # enable comments in shell commands
ZLE_REMOVE_SUFFIX_CHARS=    # keep trailing space after completion
disable r                   # remove irritating alias
zle_highlight+=(paste:none) # Don't highlight pasted text


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
)

source $ZSH/oh-my-zsh.sh

# +----------------+
# | PowerLevel10k  |
#------------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


