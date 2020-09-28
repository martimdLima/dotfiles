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
# | Zsh      |
# +----------+
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export ZSH="/home/mdlima/.oh-my-zsh" # Path to your oh-my-zsh installation.

# +-------+
# | ZPlug |
#---------+
export ZPLUG_HOME="$XDG_CONFIG_HOME/zplug"
export ZPLUG_REPOS="$ZPLUG_HOME/repos"
export ZPLUG_THREADS="16"
export ZPLUG_PROTOCOL="HTTPS"
export ZPLUG_FILTER="fzf-tmux:fzf:peco:percol:zaw"
export ZPLUG_LOADFILE="$ZPLUG_HOME/packages.zsh"
export ZPLUG_USE_CACHE="true"
export ZPLUG_CACHE_DIR="$ZPLUG_HOME/.cache"

# +----------+
# | Deno     |
# +----------+
export DENO_INSTALL="/home/$USER/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# +----------+
# | Tomcat   |
# +----------+
export CATALINA_HOME=/home/mdlima/apache-tomcat-9.0.38

# +----------+
# | NPM      |
# +----------+
export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"
