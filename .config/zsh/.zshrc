<<<<<<< HEAD:.config/zsh/.zshrc
source $HOME/.zplug/init.zsh
source $HOME/.config/zsh/.myaliases
source $HOME/.config/zsh/.myfunc

# +------------+
# | Exports    |
#--------------+
=======
source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc
>>>>>>> 6d86e1a3707fe6a8f1f55f553e9caa024052a790:.zshrc

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

<<<<<<< HEAD:.config/zsh/.zshrc
source $ZSH/oh-my-zsh.sh

=======
>>>>>>> 6d86e1a3707fe6a8f1f55f553e9caa024052a790:.zshrc
# +----------------+
# | PowerLevel10k |
#----------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias stow='sudo STOW_DIR=/usr/local/stow /usr/bin/stow'

source /home/mdlima/.config/oh-my-zsh/oh-my-zsh.sh
