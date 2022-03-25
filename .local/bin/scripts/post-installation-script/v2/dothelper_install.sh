#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

installer_welcome() {
printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "##############################################"
  printf "%s\n" "#                                            #"
  printf "%s\n" "#        Dotfiles Configuration Setup        #"     
  printf "%s\n" "#                                            #"
  printf "%s\n" "##############################################"
  printf "${RESETS}\n%s" ""

  printf "\n\a%s" "${BOLD}${FG_GREEN}Dotfiles configuration started${RESETS}"
  echo
}

installer_goodbye() {
  echo "${BOLD}${FG_GREEN}Dotfiles configuration ended${RESETS}"
}

# Searches the package in the system, if it's found skips the installation proccess, otherwise installs the package
packexists() {
    # silence non-error output, redirects stdout to /dev/null
    pacman -Qs $1 > /dev/null
    
        PKG_EXISTS=$?
    
    if((PKG_EXISTS == 0)) 
    then
        echo "${RED}Skipping $1. $1 already installed in the system${RESET}"
    else
        echo "${GREEN}Installing $1${RESET}"

    pacman -Ss $1 > /dev/null

    PACKAGE_MAN=$?

        if((PACKAGE_MAN == 0))
        then
            sudo pacman -S $1 --needed --noconfirm
        else
            yay -S $1 --needed --noconfirm
        fi
    fi
}

instalPkgs() {
    # Checks if yay is installed, if it's not installed, install it and update Aur packages
    #echo
    #packexists yay
    echo
    echo -e "${BOLD}${FG_GREEN}==> Installing Packages${RESETS}"
    echo

    # Install packages
    for PKG in "${INIT_PKGS[@]}"; do
        packexists ${PKG}
    done

    echo
}

# Searches the directory in the system, if it's found skips the installation proccess, otherwise installs the package
direxists() {
    if [ -d "$1" ]; then
        # Take action if $DIR exists. #
        echo -e "${RED}Skipping $2 installation. $2 directory was found in the system${RESET}"
    else
        echo "${GREEN}Installing $2${RESET}"
        $3
    fi
}

fontsdl() {
    echo
    echo "${BOLD}${FG_GREEN}Installing Powerline Fonts for glyphs support${RESETS}"
    echo
    packexists noto-fonts
    packexists nerd-fonts-dejavu-complete
    packexists nerd-fonts-source-code-pro
    packexists nerd-fonts-fira-code
    packexists nerd-fonts-terminus
    packexists nerd-fonts-liberation-mono
    packexists nerd-fonts-go-mono
    packexists nerd-fonts-anonymous-pro
    packexists nerd-fonts-inconsolata
    packexists powerline-fonts
}

update() {
    printf "Would you like to update $1? (y/N)"
    read -r package
    [ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && sudo $2
}


install_zsh() {
    packexists zsh

    #direxists $HOME/.oh-my-zsh "oh-my-zsh" "sh -c $(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    if [ -d $HOME/.oh-my-zsh ]; then
        # Take action if $DIR exists. #
        echo -e "${BOLD}${FG_RED}Skipping oh-my-zsh  installation. oh-my-zsh directory was found in the system${RESETS}"
    else
        echo "${BOLD}Installing oh-my-zsh ${RESETS}"
       sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Themes
    direxists $HOME/.oh-my-zsh/custom/themes/powerlevel10k "powerlevel10k" "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    # Plugins
    direxists $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting "zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    direxists $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions "zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    direxists $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin "fzf-zsh-plugin" "git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin"
    direxists $HOME/.oh-my-zsh/custom/plugins/zsh-completions  "zsh-completions" "git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions"
    
    # Scripts
    packexists shell-color-scripts

    # Fonts
    fontsdl
}

install_tmux() {
    packexists tmux

    if [ -f "$HOME/.tmux.conf" ]; then 
        echo "${BOLD}${FG_RED}Skipping oh-my-tmux. oh-my-tmux already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing $2${RESETS}"
        cd ~
        git clone https://github.com/gpakosz/.tmux.git
        ln -s -f .tmux/.tmux.conf
        cp .tmux/.tmux.conf.local .
    fi
}

install_vim() {
    packexists vim
    direxists $HOME/.SpaceVim "SpaceVim" 'curl -sLf https://spacevim.org/install.sh | zsh'
}

install_emacs() {
    packexists emacs

    if [ -d "$HOME/.emacs.d" ]; then
        echo "${BOLD}${FG_RED}Skipping doom emacs. Doom emacs already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing doom emacs${RESETS}"
        git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
        ~/.emacs.d/bin/doom install
    fi
}

install_ides() {
    packexists atom
    packexists sublime-text-4 
    packexists visual-studio-code-bin
}

install_mongodb() {
    packexists patch
    packexists mongodb-bin

    yay -Qs mongodb > /dev/null
    PKG_EXISTS=$?

    if((PKG_EXISTS == 0)) 
    then
        echo "${BOLD}Configuring mongodb${RESETS}"
        sudo systemctl enable mongodb.service
        sudo systemctl start mongodb.service
    else
        echo "${BOLD}${FG_RED}mongodb wasn't found in the system. Couldn't configure mongodb.${RESETS}"
    fi
}

install_mariadb() {
    packexists mariadb

    yay -Qs mariadb > /dev/null
    PKG_EXISTS=$?

    if((PKG_EXISTS == 0)) 
    then
        echo "${BOLD}Configuring mariadb${RESETS}"

        # Before starting the MariaDB service, initialize the database
        sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

        # Finally, start and enable the MariaDB service
        sudo systemctl enable --now mariadb
        sudo systemctl start mysqld

        # Once the service is up, verify the status of the MariaDB service
        systemctl status mariadb

        # After installing MariaDB, run the mysql_secure_installation command to remove anonymous users, test databases, and disallow remote root login.
        sudo mysql_secure_installation
    else
        echo "${BOLD}${FG_RED}mariaDB wasn't found in the system. Couldn't configure mariaDB.${RESETS}"
    fi

    packexists dbeaver

    packexists mysql-workbench
}

install_dev_env() {
    packexists python
    packexists python-pip

    packexists jre8-openjdk
    packexists jre11-openjdk

    packexists nodejs

    packexists nvm

    nvm install v17

    packexists npm

    yay -Qs npm > /dev/null

    NPM_EXISTS=$?

    if((NPM_EXISTS == 0)) 
    then
        # Installs create-react-app"
        echo "${BOLD}Installing create-react-app${RESETS}"
        sudo npm i --global create-react-app 

        # Installs vue
        echo "${BOLD}Installing vue${RESETS}"
        sudo npm i --global vue

        update "npm" "npm install npm@latest -g"
    else
        echo "${BOLD}${FG_RED}Couldn't install create-react-app or vue, because npm is not present in the system. Please install npm to install these packages.${RESETS}"
    fi

    packexists yarn
    packexists jq
    packexists jshon
    packexists rust
    packexists ruby
    packexists cmake
}

install_virtualization_support() {
    packexists virtualbox
    packexists virtualbox-host-modules

    packexists qemu
    packexists virt-manager
    packexists virt-viewer
    packexists dnsmasq
    packexists vde2
    packexists bridge-utils
    packexists openbsd-netcat

    yay -Qs $1 > /dev/null
    
    PKG_EXISTS=$?
    
    if((PKG_EXISTS == 0)) 
    then
        sudo systemctl enable libvirtd.service
        sudo systemctl start libvirtd.service

        # Find some way to replace /etc/libvirt/libvirtd.conf with the edited version

        sudo usermod -aG libvirt mdlima
        sudo systemctl restart libvirtd.service
    else
        echo "${BOLD}${FG_RED}virt-manager wasn't found in the system. Couldn't configure virt-manager.${RESETS}"
    fi
}

install_media_support() {
    packexists nomacs                                 # Image viewer
    packexists pngcrush                               # Tools for optimizing PNG images
    packexists ristretto                              # Multi image viewer
    packexists ffmpeg
    packexists vlc
    packexists mpv
    packexists youtube-dl
    packexists youtube-viewer
}

install_office_support() {
    packexists wps-office
    packexists qpdfview
    packexists zathura
}

install_torrent_support() {
    packexists transmission-gtk
}

install_media_manipulation_support() {
    packexists gimp
    packexists graphicsmagick
}

install_games_support() {
    packexists steam
}

generate_ssh_keys() {
    echo "Generating SSH keys"
    ssh-keygen -t rsa -b 4096
}

install_browser_support() {
    packexists brave-bin
    packexists firefox
}

install_system_utils() {
    packexists lscolors                                  # Gnome calculator
    packexists galculator                                # A Rust library to colorize paths using LS_COLORS    
    packexists gparted                                   # Disk utility
    packexists neofetch                                  # Shows system info when you launch terminal          
    packexists exa
    packexists htop
    packexists lf
    packexists ueberzug
    packexists arandr
    packexists blueman
    packexists zenity                                   # Display graphical dialog boxes via shell scripts       
    packexists xlayoutdisplay                           # Display Configuration Tool    
    packexists the_silver_searcher                      # A code searching tool similar to ack
    packexists xclip                                    # copy paste and clipboard access operations from the command line interface                    
    packexists hunspell                                 # Spellcheck libraries
    packexists hunspell-pt_pt                           # Portuguese spellcheck library
    packexists hunspell-en_US                           # American English spellcheck library       
    packexists bleachbit
    packexists stacer
    packexists catfish
    packexists flameshot
    packexists rsync
    packexists timeshift
    packexists xclip
    packexists zenity
    packexists autojump
    packexists neofetch
    packexists guake
    packexists make
    packexists pkg-config
    packexists paru
    packexists variety                                  # An automatic wallpaper changer, downloader and manager.
    packexists csvkit                                   # csvkit is a suite of command-line tools for converting to and working with CSV
}

goodbye() {
    printf "\n${BOLD}${FG_GREEN}==> Perform Clean up Routine\n${RESETS}"
    printf "${BOLD}\nCleaning up orphaned packages and cache\n\n${RESETS}"
    # remove orphaned packages
    sudo pacman -Rns $(pacman -Qtdq)
    sudo pacman -Sc --noconfirm
    yay -Sc --noconfirm

    printf "\nRemove Scripts?\n${BOLD}This action will delete all the scripts used. ${RESETS}"
    printf "Do you want to continue$1? ${BOLD}(y/N)${RESETS}"
    read -r package
    [ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && clean_up

    printf "\a\n%s\n${BOLD}Thanks for using dothelper.${RESETS}"
    echo
    exit 0
}

opt_fail() { echo "Wrong option." exit 1; }

system_pkgs_update_and_install() {
    installer_welcome

    echo -ne "
$(bold_green_print 'Update System & Install Software')
$(bold_yellow_print '1)') ZSH
$(bold_yellow_print '2)') Tmux
$(bold_yellow_print '3)') Vim
$(bold_yellow_print '4)') Emacs
$(bold_yellow_print '5)') IDE's
$(bold_yellow_print '6)') MongoDB
$(bold_yellow_print '7)') MariaDB
$(bold_yellow_print '8)') Dev Env
$(bold_yellow_print '9)') Virtualization
$(bold_yellow_print '10)') Media
$(bold_yellow_print '11)') Office
$(bold_yellow_print '12)') Torrents
$(bold_yellow_print '13)') Media Manipulation
$(bold_yellow_print '14)') Games
$(bold_yellow_print '15)') System Utills
$(bold_yellow_print '16)') Browser Support
$(bold_cyan_print '17)') All
$(bold_blue_print '18)') Go Back to Main Menu
$(bold_red_print '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        install_zsh
    ;;
    2)
        install_tmux
    ;;
    3)
        install_vim
    ;;
    4)
        install_emacs
    ;;
    5)
        install_ides
    ;;
    6)
        install_mongodb
    ;;
    7)
        install_mariadb
    ;;
    8)
        install_dev_env
    ;;
    9)
        install_virtualization_support
    ;;
    10)
        install_media_support
    ;;
    11)
        install_office_support
    ;;
    12)
        install_torrent_support
    ;;
    13)
        install_media_manipulation_support
    ;;
    14)
        install_games_support
    ;;
    15)
        install_system_utils
    ;;
    16)
        install_browser_support
    ;;
    16)
        install_zsh
        install_tmux
        install_vim
        install_emacs
        install_ides
        install_mongodb
        install_mariadb
        install_dev_env
        install_virtualization_support
        install_media_support
        install_office_support
        install_torrent_support
        install_media_manipulation_support
        install_games_support
        install_system_utils
    ;;
    17)
        sub-submenu
        system_pkgs_update_and_install
        ;;
    18)
        mainmenu
        ;;
    0)
        goodbye
        ;;
    *)
        opt_fail
        ;;
    esac
}