source $XDG_CONFIG_HOME/zsh/.myaliases
source $XDG_CONFIG_HOME/zsh/.myfunc

# +------------+
# | Exports    |
#--------------+
#export DENO_INSTALL="/home/$USER/.deno"
#export PATH="$DENO_INSTALL/bin:$PATH"
#export CATALINA_HOME=/home/mdlima/apache-tomcat-9.0.38

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
#source $XDG_CONFIG_HOME/zplug/init.zsh

# Path to your oh-my-zsh installation.
#export ZSH="/home/mdlima/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"


zplug "b4b4r07/ultimate", as:command
zplug 'b4b4r07/zplug-doctor', as:command
zplug 'b4b4r07/zplug-cd', as:command
zplug 'b4b4r07/zplug-rm', as:command
zplug "b4b4r07/enhancd", as:command

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

# do self-manage
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
    echo
fi

zplug load

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

source $ZSH/oh-my-zsh.sh

# +----------------+
# | PowerLevel10k |
#----------------+
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias stow='sudo STOW_DIR=/usr/local/stow /usr/bin/stow'
