#!/bin/zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# +-------+
# | XDG   |
# +-------+
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# +----------+
# | Editor   |
# +----------+
export EDITOR="nvim"
export VISUAL="nvim"

# +----------+
# | Git      |
# +----------+
export GIT_CONFIG="XDG_CONFIG_HOME/git/config"

# +----------+
# | Zsh      |
# +----------+
export ZSH="/home/mdlima/.oh-my-zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file


# +----------+
# | Deno     |
# +----------+
export DENO_INSTALL="/home/$USER/.deno"
#export PATH="$DENO_INSTALL/bin:$PATH"

# +----------+
# | Tomcat   |
# +----------+
export CATALINA_HOME="/home/mdlima/apache-tomcat-9.0.38"

# +-----------+
# | Emacs     |
# +-----------+
export EMACS="/usr/bin/emacs"
#export PATH="/usr/bin/emacs"
