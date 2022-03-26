#!/bin/bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

if [ ! -d "$SCRIPTS_DIR" ]; then
	mkdir $SCRIPTS_DIR
fi

curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v1/setup.sh > $SCRIPTS_DIR/setup.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v1/post_install.sh > $SCRIPTS_DIR/post_install.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v1/dot_files_config.sh > $SCRIPTS_DIR/dot_files_config.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/v1/colors.sh > $SCRIPTS_DIR/colors.sh

. $SCRIPTS_DIR/setup.sh