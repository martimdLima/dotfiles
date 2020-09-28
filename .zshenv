#!/bin/zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# +-----------+
# | Android   |
# +-----------+
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export ANDROID_AVD_HOME="$XDG_DATA_HOME"/android/
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME"/android

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

# +-------------+
# | libdice     |
# +-------------+
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"

# +----------+
# | Java     |
# +----------+
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# +-------------+
# | Node.js     |
# +-------------+
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# +-------------+
# | MySQL       |
# +-------------+
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

# +----------+
# | Zsh      |
# +----------+
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
#export ZSH="/home/mdlima/.oh-my-zsh" # Path to your oh-my-zsh installation.

# +-------+
# | ZPlug |
#---------+
export ZPLUG_HOME="$XDG_CONFIG_HOME/zplug"
export ZPLUG_REPOS="$ZPLUG_HOME/repos"
export ZPLUG_THREADS="16"
export ZPLUG_PROTOCOL="SSH"
export ZPLUG_FILTER="fzf-tmux:fzf:peco:percol:zaw"
export ZPLUG_LOADFILE="$ZPLUG_HOME/packages.zsh"
export ZPLUG_USE_CACHE="true"
export ZPLUG_CACHE_DIR="$ZPLUG_HOME/.cache"
export ZPLUG_LOG_LOAD_SUCCESS="true"
export ZPLUG_LOG_LOAD_FAILURE="true"
export ZPLUG_BIN="$ZPLUG_HOME/bin"

# +----------+
# | Deno     |
# +----------+
export DENO_INSTALL="/home/$USER/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# +----------+
# | Tomcat   |
# +----------+
export CATALINA_HOME="/home/mdlima/apache-tomcat-9.0.38"

# +----------+
# | NPM      |
# +----------+
export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"

# +-----------------+
# | XAuthority      |
# +-----------------+
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# +-----------------+
# | XInit           |
# +-----------------+
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

# +-----------+
# | WGet      |
# +-----------+
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
