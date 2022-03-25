#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

if [ ! -d "$SCRIPTS_DIR" ]; then
	mkdir $SCRIPTS_DIR
fi

#cd $SCRIPTS_DIR

wget -qO https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_init.sh > $SCRIPTS_DIR/dothelper_init.sh
wget -qO https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_install.sh > $SCRIPTS_DIR/dothelper_install.sh
wget -qO https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_config.sh > $SCRIPTS_DIR/dothelper_config.sh
wget -qO https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh > $SCRIPTS_DIR/colors.sh

source $SCRIPTS_DIR/dothelper_init.sh