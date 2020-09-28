source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc

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

# Path to your oh-my-zsh installation.
#export ZSH="/home/mdlima/.oh-my-zsh"

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
	 fzf
	 zsh-autosuggestions
)

# +----------------+
# | PowerLevel10k |
#----------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias stow='sudo STOW_DIR=/usr/local/stow /usr/bin/stow'

source /home/mdlima/.config/oh-my-zsh/oh-my-zsh.sh
