#!/bin/bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

if [ ! -d "$SCRIPTS_DIR" ]; then
	mkdir $SCRIPTS_DIR
fi

curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_init.sh > $SCRIPTS_DIR/dothelper_init.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_install.sh > $SCRIPTS_DIR/dothelper_install.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v2/dothelper_config.sh > $SCRIPTS_DIR/dothelper_config.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh > $SCRIPTS_DIR/colors.sh

. $SCRIPTS_DIR/dothelper_init.sh