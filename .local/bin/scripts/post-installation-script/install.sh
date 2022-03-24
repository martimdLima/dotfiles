#!/bin/bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

if [ ! -d "$SCRIPTS_DIR" ]; then
	mkdir $SCRIPTS_DIR
fi

clean_up() {
  test -d "$SCRIPTS_DIR" && rm -fr "$SCRIPTS_DIR"
}

curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/setup.sh > $SCRIPTS_DIR/setup.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/post_install.sh > $SCRIPTS_DIR/post_install.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/dot_files_config.sh > $SCRIPTS_DIR/dot_files_config.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh > $SCRIPTS_DIR/colors.sh

#. $SCRIPTS_DIR/setup.sh

trap "clean_up $tmp_dir" EXIT

