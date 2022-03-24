#!/bin/bash

TMP_DIR=$( mktemp -d -t dothelper.XXXXXXXXXX )
trap "clean_up $tmp_dir" EXIT

curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/setup.sh > $TMP_DIR/setup.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/post_install.sh > $TMP_DIR/post_install.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/dot_files_config.sh > $TMP_DIR/dot_files_config.sh
curl -Lks https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh > $TMP_DIR/colors.sh

. setup.sh

