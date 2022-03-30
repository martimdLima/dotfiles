#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"



### => Helper installation functions

installer_welcome() {
printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "##############################################"
  printf "%s\n" "#      DotHelper System And Pkgs Setup       #"     
  printf "%s\n" "##############################################"
  printf "${RESETS}%s" ""
  echo
}

update_pkg() {
    echo -e "\n${BOLD}$1 already installed in the system. Would you like to update $1?${RESETS} ${BOLD}(Y/N)${RESETS}"
    read -r package
    echo
    [ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && yay -S "$1"
}

# Searches the package in the system, if it's found skips the installation proccess, otherwise installs the package
pkg_exists() {
    # silence non-error output, redirects stdout to /dev/null
    pacman -Qs "$1" > /dev/null
    
        PKG_EXISTS=$?
    
    if((PKG_EXISTS == 0)) 
    then
        #echo "${RED}Skipping $1. $1 already installed in the system${RESET}"
        update_pkg "$1"
    else
        echo "${GREEN}Installing $1${RESET}"

    pacman -Ss "$1" > /dev/null

    PACKAGE_MAN=$?

        if((PACKAGE_MAN == 0))
        then
            sudo pacman -S "$1" --needed --noconfirm
        else
            yay -S "$1" --needed --noconfirm
        fi
    fi
}

# Searches the directory in the system, if it's found skips the installation proccess, otherwise installs the package
dir_exists() {
    if [ -d "$1" ]; then
        # Take action if $DIR exists. #
        echo -e "${RED}Skipping $2 installation. $2 directory was found in the system${RESET}"
    else
        echo "${GREEN}Installing $2${RESET}"
        $3
    fi
}

fonts_dll() {
    echo
    echo "${BOLD}${FG_GREEN}Installing Powerline Fonts for glyphs support${RESETS}"
    echo
    pkg_exists noto-fonts
    pkg_exists nerd-fonts-dejavu-complete
    pkg_exists nerd-fonts-source-code-pro
    pkg_exists nerd-fonts-fira-code
    pkg_exists nerd-fonts-terminus
    pkg_exists nerd-fonts-liberation-mono
    pkg_exists nerd-fonts-go-mono
    pkg_exists nerd-fonts-anonymous-pro
    pkg_exists nerd-fonts-inconsolata
    pkg_exists powerline-fonts
}

scripts_cleanup() {
  test -d "$SCRIPTS_DIR" && rm -fr "$SCRIPTS_DIR"
}

system_cleanup()  {
    printf "\n\a%s" "${BOLD}${FG_GREEN}System And Pkgs setup ended${RESETS}"
    printf "\n\a%s" "${BOLD}${FG_GREEN}==> Perform Clean up Routine${RESETS}"
    printf "\n\a%s" "${BOLD}Cleaning up orphaned packages and cache${RESETS}"
    printf "\n\a"
    # remove orphaned packages
    sudo pacman -Rns "$(pacman -Qtdq)"
    sudo pacman -Sc --noconfirm
    yay -Sc --noconfirm
}

goodbye() {
    system_cleanup

    printf "\n\a%s" "Remove Scripts?\n${BOLD}This action will delete all the scripts used. ${RESETS}"
    printf "\n\a%s" "Do you want to continue$1? ${BOLD}(y/N)${RESETS}"
    read -r package
    [ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && scripts_cleanup

    printf "\a\n%s\n${BOLD}Thanks for using dothelper.${RESETS}"
    echo
    exit 0
}

opt_fail() { echo "Wrong option." exit 1; }


### => => Package installation functions
install_terminals() {
    pkg_exists guake
    pkg_exists alacritty
}

install_term_essencials() {
    pkg_exists yay
    pkg_exists curl
    pkg_exists wget
}

install_zsh() {
    pkg_exists zsh

    #dir_exists $HOME/.oh-my-zsh "oh-my-zsh" "sh -c $(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    if [ -d "$HOME"/.oh-my-zsh ]; then
        # Take action if $DIR exists. #
        echo -e "${BOLD}${FG_RED}Skipping oh-my-zsh  installation. oh-my-zsh directory was found in the system${RESETS}"
    else
        echo "${BOLD}Installing oh-my-zsh ${RESETS}"
       sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Themes
    dir_exists "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k "powerlevel10k" "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    # Plugins
    dir_exists "$HOME"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting "zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    dir_exists "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions "zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    dir_exists "$HOME"/.oh-my-zsh/custom/plugins/fzf-zsh-plugin "fzf-zsh-plugin" "git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin"
    dir_exists "$HOME"/.oh-my-zsh/custom/plugins/zsh-completions  "zsh-completions" "git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions"
    
    # Scripts
    pkg_exists shell-color-scripts

    # Fonts
    fonts_dll
}

install_git() {
    pkg_exists git
}

install_tmux() {
    pkg_exists tmux

    if [ -f "$HOME/.tmux.conf" ]; then 
        echo "${BOLD}${FG_RED}Skipping oh-my-tmux. oh-my-tmux already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing $2${RESETS}"
        cd ~ || exit
        git clone https://github.com/gpakosz/.tmux.git
        ln -s -f .tmux/.tmux.conf .
        cp .tmux/.tmux.conf.local .
    fi
}

install_vim() {
    pkg_exists vim
    dir_exists "$HOME"/.SpaceVim "SpaceVim" 'curl -sLf https://spacevim.org/install.sh | zsh'
}

install_emacs() {
    pkg_exists emacs

    if [ -d "$HOME/.emacs.d" ]; then
        echo "${BOLD}${FG_RED}Skipping doom emacs. Doom emacs already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing doom emacs${RESETS}"
        git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
        ~/.emacs.d/bin/doom install
    fi
}

install_ides() {
    pkg_exists atom
    pkg_exists sublime-text-4 
    pkg_exists visual-studio-code-bin
}

install_mongodb() {
    pkg_exists patch
    pkg_exists mongodb-bin

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
    pkg_exists mariadb

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

    pkg_exists dbeaver

    pkg_exists mysql-workbench
}

install_dev_env() {
    pkg_exists python
    pkg_exists python-pip

    pkg_exists jre8-openjdk
    pkg_exists jre11-openjdk

    pkg_exists nodejs

    pkg_exists nvm

    nvm install v17

    pkg_exists npm

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

    pkg_exists yarn
    pkg_exists jq
    pkg_exists jshon
    pkg_exists rust
    pkg_exists ruby
    pkg_exists cmake
}

install_virtualization_support() {
    pkg_exists virtualbox
    pkg_exists virtualbox-host-modules

    pkg_exists qemu
    pkg_exists virt-manager
    pkg_exists virt-viewer
    pkg_exists dnsmasq
    pkg_exists vde2
    pkg_exists bridge-utils
    pkg_exists openbsd-netcat

    yay -Qs "$1" > /dev/null
    
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
    pkg_exists nomacs                                 # Image viewer
    pkg_exists pngcrush                               # Tools for optimizing PNG images
    pkg_exists ristretto                              # Multi image viewer
    pkg_exists ffmpeg
    pkg_exists vlc
    pkg_exists mpv
    pkg_exists youtube-dl
    pkg_exists youtube-viewer
    pkg_exists obs
}

install_office_support() {
    pkg_exists libreoffice-fresh
    pkg_exists wps-office
    pkg_exists qpdfview
    pkg_exists zathura

    pkg_exists hunspell                                 # Spellcheck libraries
    pkg_exists hunspell-pt_pt                           # Portuguese spellcheck library
    pkg_exists hunspell-en_US                           # American English spellcheck library  
}

install_torrent_support() {
    pkg_exists transmission-gtk
}

install_media_manipulation_support() {
    pkg_exists gimp
    pkg_exists graphicsmagick
}

install_games_support() {
    pkg_exists steam
    pkg_exists legenday
    pkg_exists lutris
}

generate_ssh_keys() {
    echo "Generating SSH keys"
    ssh-keygen -t rsa -b 4096
}

install_browser_support() {
    pkg_exists brave-bin
    pkg_exists firefox
    pkg_exists ungoogled-chromium
}

install_system_utils() {
    pkg_exists lscolors                                 # A Rust library to colorize paths using LS_COLORS 
    pkg_exists galculator                               # Gnome calculator  
    pkg_exists gparted                                  # Disk utility
    pkg_exists neofetch                                 # Shows system info when you launch terminal          
    pkg_exists exa                                      # A modern replacement for ls
    pkg_exists htop                                     # Interactive system-monitor process-viewer and process-manager
    pkg_exists lf                                       # Terminal file manager written in Go with a heavy inspiration from ranger file manager.
    pkg_exists ueberzug                                 # command line util which allows to draw images on terminals by using child windows
    pkg_exists arandr                                   # designed to provide a simple visual front end for XRandR
    pkg_exists blueman                                  # designed to provide a simple yet effective means for controlling the BlueZ API and simplifying Bluetooth tasks
    pkg_exists zenity                                   # Display graphical dialog boxes via shell scripts       
    pkg_exists xlayoutdisplay                           # Display Configuration Tool    
    pkg_exists the_silver_searcher                      # A code searching tool similar to ack
    pkg_exists xclip                                    # copy paste and clipboard access operations from the command line interface                    
    pkg_exists bleachbit                                # BleachBit cleans files to free disk space and to maintain privacy.
    pkg_exists install_office_support                   # open source system optimizer and application monitor that helps users to manage entire system with different aspects
    pkg_exists catfish                                  # simple graphical file searching front-end for either slocate or GNU locate on
    pkg_exists flameshot                                # Powerful yet simple to use screenshot software
    pkg_exists rsync                                    # rsync is a fast and versatile command-line utility for synchronizing files and directories between two locations over a remote shell, or from/to a remote Rsync daemon
    pkg_exists timeshift                                # takes incremental snapshots of the file system at regular intervals      
    pkg_exists xclip                                    # provides an interface to X selections ("the clipboard") from the command line
    pkg_exists zenity                                   # allows the execution of GTK dialog boxes in command-line and shell scripts.
    pkg_exists autojump                                 # a faster way to navigate your filesystem
    pkg_exists neofetch                                 # displays information about your operating system, software and hardware in an aesthetic and visually pleasing way
    pkg_exists make                                     # utility for building and maintaining groups of programs
    pkg_exists jq                                       # Used to slice, filter, map and transform structured data
    pkg_exists jshon                                    # parses, reads and creates JSON
    pkg_exists cmake                                    # utility for building and maintaining groups of programs
    pkg_exists pkg-config                               # pkg-config program is used to retrieve information about installed libraries in the system  
    pkg_exists paru                                     # Feature packed AUR helper
    pkg_exists variety                                  # An automatic wallpaper changer, downloader and manager.
    pkg_exists csvkit                                   # csvkit is a suite of command-line tools for converting to and working with CSV
    pkg_exists ungit                                    # brings user friendliness to git without sacrificing the versatility of git
    pkg_exists shellcheck                               # finds bugs in your shell scripts
    pkg_exists plank                                    # lightweight and minimal dock
    pkg_exists plank-theme-arc                          # Arc theme for Plank
    pkg_exists plank-theme-tokyo-night                  # Tokyo Night theme for Plank
    pkg_exists plank-theme-sirius-deep-light            # Sirius Deep Light theme for Plank
    pkg_exists plank-theme-mohave                       # Mohave theme for Plank
    pkg_exists plank-theme-monterey                     # Monterey theme for Plank
    pkg_exists plank-theme-nordic-night-git             # Nordic Night theme for Plank

}

install_all() {
    printf "\n\a%s" "${BOLD}${FG_GREEN}System And Pkgs setup started\n${RESETS}"
    install_terminals
    install_term_essencials
    install_git
    install_zsh
    install_tmux
    install_vim
    install_emacs
    install_browser_support
    install_ides
    install_mongodb
    install_mariadb
    install_dev_env
    install_virtualization_support
    install_office_support
    install_media_support
    install_torrent_support
    install_media_manipulation_support
    install_games_support
    install_system_utils

    printf "\n\a%s" "${BOLD}${FG_GREEN}System And Pkgs setup ended\n${RESETS}"
}

### => Menu Functions

terminal_utils_menu() {
    echo -ne "
        $(green_print 'Terminal Utils')
        $(bold_yellow_print '1)') Terminal Apps
        $(bold_yellow_print '2)') ZSH
        $(bold_yellow_print '3)') Tmux
        $(bold_yellow_print '4)') Vim
        $(bold_yellow_print '5)') Emacs
        $(bold_yellow_print '6)') Curl & Wget
        $(bold_yellow_print '7)') Git
        $(blue_print '8)') Go Back to Update System & Install Software
        $(magenta_print '9)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        install_terminals 
        terminal_utils_menu
        ;;
    2)
        install_zsh
        terminal_utils_menu
        ;;
    3)
        install_tmux "$@"
        terminal_utils_menu
        ;;
    4)
        install_vim
        terminal_utils_menu 
        ;;
    5)
        install_emacs
        terminal_utils_menu 
        ;;
    6)
        install_term_essencials
        terminal_utils_menu 
        ;;
    7)
        install_git
        terminal_utils_menu 
        ;;
    8)
        system_pkgs_update_and_install_menu 
        ;;
    9)
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

db_menu() {
    echo -ne "
        $(green_print 'Database Utils')
        $(bold_yellow_print '1)') MariaDB
        $(bold_yellow_print '2)') MongoDB
        $(blue_print '3)') Go Back to Update System & Install Software
        $(magenta_print '4)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        install_mongodb
        db_menu 
        ;;
    2)
        install_mariadb
        db_menu 
        ;; 
    3)
        system_pkgs_update_and_install_menu
        ;;
    4)
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

ide_menu() {
    echo -ne "
        $(green_print "IDE's")
        $(bold_yellow_print '1)') Atom
        $(bold_yellow_print '2)') Sublime Text 4
        $(bold_yellow_print '3)') Visual Studio Code
        $(bold_yellow_print '4)') All
        $(blue_print '5)') Go Back to Update System & Install Software
        $(magenta_print '6)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists atom
        ide_menu 
        ;;
    2)
        pkg_exists sublime-text-4
        ide_menu 
        ;; 
    3)
        pkg_exists visual-studio-code-bin
        ide_menu 
        ;;
    4)
        install_ides
        ide_menu 
        ;;
    5)
        system_pkgs_update_and_install_menu 
        ;;
    6)
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

media_menu() {
    echo -ne "
        $(green_print "Media")
        $(bold_yellow_print '1)') Vlc
        $(bold_yellow_print '2)') Mpv
        $(bold_yellow_print '3)') youtube Utils
        $(bold_yellow_print '4)') image Viewers
        $(bold_yellow_print '5)') image Manipulation
        $(bold_yellow_print '6)') Video Stream/Capture
        $(bold_yellow_print '7)') All
        $(blue_print '8)') Go Back to Update System & Install Software
        $(magenta_print '9)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists vlc
        pkg_exists ffmpeg
        media_menu 
        ;;
    2)
        pkg_exists mpv
        media_menu 
        ;; 
    3)
        pkg_exists youtube-dl
        pkg_exists youtube-viewer
        media_menu 
        ;;
    4)
        pkg_exists nomacs                               # Image viewer
        pkg_exists ristretto                            # Multi image viewer
        media_menu 
        ;;
    5)
        pkg_exists gimp
        pkg_exists graphicsmagick
        pkg_exists pngcrush                             # Tools for optimizing PNG images
        media_menu                            
        ;;
    6)
        pkg_exists obs-studio                           #  video recording and live streaming
        media_menu 
        ;;
    7)
        install_media_support
        install_media_manipulation_support
        media_menu 
        ;;
    8)
        system_pkgs_update_and_install_menu 
        ;;
    9)
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

development_menu() {
    echo -ne "
        $(green_print "Development")
        $(bold_yellow_print '1)') Python
        $(bold_yellow_print '2)') Java
        $(bold_yellow_print '3)') Nodejs
        $(bold_yellow_print '4)') Rust
        $(bold_yellow_print '5)') Ruby
        $(bold_yellow_print '5)') All
        $(blue_print '6)') Go Back to Update System & Install Software
        $(magenta_print '7)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists python
        pkg_exists python-pip
        development_menu
        ;;
    2)
        pkg_exists jre8-openjdk
        pkg_exists jre11-openjdk
        development_menu
        ;; 
    3)
        pkg_exists nodejs

        pkg_exists nvm

        nvm install v17

        pkg_exists npm

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

        pkg_exists yarn

        development_menu
        ;;
    4)
        pkg_exists rust
        development_menu
        ;;
    5)
        pkg_exists ruby
        development_menu 
        ;;
    6)
        system_pkgs_update_and_install_menu
        ;;
    7)
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

office_menu() {
    echo -ne "
        $(green_print "Office")
        $(bold_yellow_print '1)') WPS Office
        $(bold_yellow_print '2)') Libre Office
        $(bold_yellow_print '3)') PDF Support
        $(bold_yellow_print '4)') Spellchecking Tools
        $(bold_yellow_print '5)') All
        $(blue_print '6)') Go Back to Update System & Install Software
        $(magenta_print '7)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists wps-office
        office_menu
        ;;
    2)
        pkg_exists libreoffice-fresh
        office_menu
        ;; 
    3)
        pkg_exists qpdfview
        pkg_exists zathura
        office_menu 
        ;;
    4)
        pkg_exists hunspell                                 # Spellcheck libraries
        pkg_exists hunspell-pt_pt                           # Portuguese spellcheck library
        pkg_exists hunspell-en_US                           # American English spellcheck library
        office_menu 
        ;;
    5)
        pkg_exists wps-office
        pkg_exists libreoffice-fresh
        pkg_exists qpdfview
        pkg_exists zathura
        pkg_exists hunspell                                 # Spellcheck libraries
        pkg_exists hunspell-pt_pt                           # Portuguese spellcheck library
        pkg_exists hunspell-en_US                           # American English spellcheck library
        office_menu 
        ;;
    6)
        system_pkgs_update_and_install_menu
        ;;
    7)
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

torrent_menu() {
    echo -ne "
        $(green_print "IDE's")
        $(bold_yellow_print '1)') qBittorrent
        $(bold_yellow_print '2)') Transmission
        $(bold_yellow_print '3)') Deluge
        $(bold_yellow_print '4)') All
        $(blue_print '5)') Go Back to Update System & Install Software
        $(magenta_print '6)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists qbittorrent-qt5
        torrent_menu
        ;;
    2)
        pkg_exists transmission-gtk
        torrent_menu
        ;; 
    3)
        pkg_exists deluge
        torrent_menu
        ;;
    4)
        pkg_exists qbittorrent-qt5
        pkg_exists transmission-gtk
        pkg_exists deluge
        torrent_menu
        ;;
    5)
        system_pkgs_update_and_install_menu
        ;;
    6)
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

games_menu() {
    echo -ne "
        $(green_print "IDE's")
        $(bold_yellow_print '1)') Steam
        $(bold_yellow_print '2)') Legendary
        $(bold_yellow_print '3)') Lutris
        $(bold_yellow_print '4)') All
        $(blue_print '5)') Go Back to Update System & Install Software
        $(magenta_print '6)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists steam
        games_menu
        ;;
    2)
        # open-source replacement for the Epic Games Launcher
        pkg_exists legenday
        games_menu
        ;; 
    3)
        pkg_exists lutris
        games_menu
        ;;
    4)
        install_games_support
        games_menu
        ;;
    5)
        system_pkgs_update_and_install_menu
        ;;
    6)
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

browser_menu() {
    echo -ne "
        $(green_print "Browser")
        $(bold_yellow_print '1)') Brave
        $(bold_yellow_print '2)') Firefox
        $(bold_yellow_print '3)') Chromium
        $(bold_yellow_print '4)') All
        $(blue_print '5)') Go Back to Update System & Install Software
        $(magenta_print '6)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists brave-bin
        browser_menu 
        ;;
    2)
        pkg_exists firefox
        browser_menu 
        ;; 
    3)
        pkg_exists ungoogled-chromium
        browser_menu 
        ;;
    4)
        install_browser_support
        browser_menu 
        ;;
    5)
        system_pkgs_update_and_install_menu
        ;;

    6)
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

virtualization_menu() {
    echo -ne "
        $(green_print "Virtualization")
        $(bold_yellow_print '1)') Virtual Box
        $(bold_yellow_print '2)') Virt Manager
        $(bold_yellow_print '3)') All
        $(blue_print '4)') Go Back to Update System & Install Software
        $(magenta_print '5)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists virtualbox
        pkg_exists virtualbox-host-modules
        virtualization_menu
        ;;
    2)
        pkg_exists qemu
        pkg_exists virt-manager
        pkg_exists virt-viewer
        pkg_exists dnsmasq
        pkg_exists vde2
        pkg_exists bridge-utils
        pkg_exists openbsd-netcat

        yay -Qs "$1" > /dev/null
        
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

        virtualization_menu
        ;; 
    3)
        install_virtualization_support "$@"
        virtualization_menu
        ;;
    5)
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

system_utils_menu() {
    echo -ne "
        $(green_print "IDE's")
        $(bold_yellow_print '1)') lscolors
        $(bold_yellow_print '2)') gparted
        $(bold_yellow_print '3)') galculator
        $(bold_yellow_print '4)') neofetch
        $(bold_yellow_print '5)') exa
        $(bold_yellow_print '6)') lf
        $(bold_yellow_print '7)') ueberzug
        $(bold_yellow_print '8)') arandr
        $(bold_yellow_print '9)') blueman
        $(bold_yellow_print '10)') zenity
        $(bold_yellow_print '11)') xlayoutdisplay
        $(bold_yellow_print '12)') the_silver_searcher 
        $(bold_yellow_print '12)') ueberzug
        $(bold_yellow_print '13)') bleachbit   
        $(bold_yellow_print '14)') xclip
        $(bold_yellow_print '15)') bleachbit
        $(bold_yellow_print '16)') stacer
        $(bold_yellow_print '17)') catfish
        $(bold_yellow_print '18)') flameshot
        $(bold_yellow_print '19)') rsync
        $(bold_yellow_print '20)') timeshift
        $(bold_yellow_print '21)') xclip
        $(bold_yellow_print '22)') zenity
        $(bold_yellow_print '23)') autojump
        $(bold_yellow_print '24)') neofetch
        $(bold_yellow_print '25)') make
        $(bold_yellow_print '26)') jq
        $(bold_yellow_print '27)') jshon
        $(bold_yellow_print '28)') cmake
        $(bold_yellow_print '29)') pkg-config
        $(bold_yellow_print '30)') paru
        $(bold_yellow_print '31)') variety
        $(bold_yellow_print '32)') csvkit
        $(bold_yellow_print '33)') ungit
        $(bold_yellow_print '34)') shellcheck
        $(bold_yellow_print '35)') plank
        $(bold_yellow_print '36)') All
        $(blue_print '37)') Go Back to Update System & Install Software
        $(magenta_print '38)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        pkg_exists lscolors                                 # A Rust library to colorize paths using LS_COLORS 
        system_utils_menu
        ;;
    2)
        pkg_exists galculator                               # Gnome calculator  
        system_utils_menu
        ;; 
    3)
        pkg_exists gparted                                  # Disk utility
        system_utils_menu
        ;;
    4)
        pkg_exists neofetch                                 # Shows system info when you launch terminal
        system_utils_menu
        ;;
    5)
        pkg_exists exa                                      # A modern replacement for ls
        system_utils_menu
        ;;
    6)
        pkg_exists htop                                     # Interactive system-monitor process-viewer and process-manager
        system_utils_menu
        ;;
    7)
        pkg_exists lf                                       # Terminal file manager written in Go with a heavy inspiration from ranger file manager.
        system_utils_menu
        ;;
    8)    
        pkg_exists arandr                                   # designed to provide a simple visual front end for XRandR
        system_utils_menu
        ;;
    9)
        pkg_exists blueman                                  # designed to provide a simple yet effective means for controlling the BlueZ API and simplifying Bluetooth tasks
        system_utils_menu
        ;;
    10)
        pkg_exists zenity                                   # Display graphical dialog boxes via shell scripts       
        system_utils_menu
        ;;
    11)
        pkg_exists xlayoutdisplay                           # Display Configuration Tool    
        system_utils_menu
        ;;
    12)
        pkg_exists the_silver_searcher                      # A code searching tool similar to ack                              
        system_utils_menu
        ;;
    13)
        pkg_exists ueberzug                                 # command line util which allows to draw images on terminals by using child windows
        system_utils_menu
        ;;
    14)
        pkg_exists xclip                                    # copy paste and clipboard access operations from the command line interface                    
        system_utils_menu
        ;;
    15)
        pkg_exists bleachbit                                # BleachBit cleans files to free disk space and to maintain privacy.
        system_utils_menu
        ;;
    16)
        pkg_exists stacer                                   # open source system optimizer and application monitor that helps users to manage entire system with different aspects
        system_utils_menu
        ;;
    17)
        pkg_exists catfish                                  # simple graphical file searching front-end for either slocate or GNU locate on
        system_utils_menu
        ;;
    18)
        pkg_exists flameshot                                # Powerful yet simple to use screenshot software
        system_utils_menu
        ;;
    19)
        pkg_exists rsync                                    # rsync is a fast and versatile command-line utility for synchronizing files and directories between two locations over a remote shell, or from/to a remote Rsync daemon
        system_utils_menu
        ;;
    20)
        pkg_exists timeshift                                # takes incremental snapshots of the file system at regular intervals      
        system_utils_menu
        ;;
    21)
        pkg_exists xclip                                    # provides an interface to X selections ("the clipboard") from the command line
        system_utils_menu
        ;;
    22)
        pkg_exists zenity                                   # allows the execution of GTK dialog boxes in command-line and shell scripts.
        system_utils_menu
        ;;
    23)
        pkg_exists autojump                                 # a faster way to navigate your filesystem
        system_utils_menu
        ;;
    24)
        pkg_exists neofetch                                 # displays information about your operating system, software and hardware in an aesthetic and visually pleasing way
        system_utils_menu
        ;;
    25)
        pkg_exists make                                     # utility for building and maintaining groups of programs
        system_utils_menu
        ;;
    26)
        pkg_exists jq                                       # Used to slice, filter, map and transform structured data
        system_utils_menu
        ;;
    27)
        pkg_exists jshon                                    # parses, reads and creates JSON
        system_utils_menu
        ;;
    28)
        pkg_exists cmake                                    # utility for building and maintaining groups of programs
        system_utils_menu
        ;;
    29)
        pkg_exists pkg-config                               # pkg-config program is used to retrieve information about installed libraries in the system  
        system_utils_menu
        ;;
    30)
        pkg_exists paru                                     # Feature packed AUR helper
        system_utils_menu
        ;;
    31)
        pkg_exists variety                                  # An automatic wallpaper changer, downloader and manager.
        system_utils_menu
        ;;
    32)
        pkg_exists csvkit                                   # csvkit is a suite of command-line tools for converting to and working with CSV
        system_utils_menu
        ;;
    33)
        pkg_exists ungit                                    # brings user friendliness to git without sacrificing the versatility of git
        system_utils_menu
        ;;
    34)
        pkg_exists shellcheck                                    # brings user friendliness to git without sacrificing the versatility of git
        system_utils_menu
        ;;
    35)
        pkg_exists plank                                    # lightweight and minimal dock
        pkg_exists plank-theme-arc                          # Arc theme for Plank
        pkg_exists plank-theme-tokyo-night                  # Tokyo Night theme for Plank
        pkg_exists plank-theme-sirius-deep-light            # Sirius Deep Light theme for Plank
        pkg_exists plank-theme-mohave                       # Mohave theme for Plank
        pkg_exists plank-theme-monterey                     # Monterey theme for Plank
        pkg_exists plank-theme-nordic-night-git             # Nordic Night theme for Plank
        ;;
    36)
        install_system_utils
        ide_menu
        ;;
    37)
        system_pkgs_update_and_install_menu
        ;;
    38)
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

system_pkgs_update_and_install_menu() {
    installer_welcome

    echo -ne "
$(bold_green_print 'Update System & Install Software')
$(bold_yellow_print '1)') Terminal Utils
$(bold_yellow_print '2)') Browser Support
$(bold_yellow_print '3)') DB Utils
$(bold_yellow_print '4)') IDE's
$(bold_yellow_print '5)') Dev Env
$(bold_yellow_print '6)') Virtualization
$(bold_yellow_print '7)') Media
$(bold_yellow_print '8)') Office
$(bold_yellow_print '9)') Torrents
$(bold_yellow_print '10)') Games
$(bold_yellow_print '11)') System Utills
$(bold_cyan_print '12)') All
$(bold_blue_print '13)') Go Back to Main Menu
$(bold_red_print '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        #install_zsh
        terminal_utils_menu "$@"
        system_pkgs_update_and_install_menu
        ;;
    2)
        #install_browser_support
        browser_menu 
        system_pkgs_update_and_install_menu
        ;;

    3)
        db_menu 
        system_pkgs_update_and_install_menu
        ;;
    4)
        #install_ides
        ide_menu 
        system_pkgs_update_and_install_menu
        ;;
    5)
        #install_dev_env
        development_menu 
        system_pkgs_update_and_install_menu
        ;;
    6)
        #install_virtualization_support
        virtualization_menu "$@"
        system_pkgs_update_and_install_menu
        ;;
    7)
        #install_media_support
        media_menu
        system_pkgs_update_and_install_menu
        ;;
    8)
        #install_office_support
        office_menu
        system_pkgs_update_and_install_menu
        ;;
    9)
        #install_torrent_support
        torrent_menu
        system_pkgs_update_and_install_menu
        ;;
    10)
        #install_games_support
        games_menu
        system_pkgs_update_and_install_menu
        ;;
    11)
        #install_system_utils
        system_utils_menu
        system_pkgs_update_and_install_menu
        ;;
    12)
        install_all
        system_pkgs_update_and_install_menu "$@"
        ;;
    13)
        mainmenu
        ;;
    0)
        goodbye "$@"
        ;;
    *)
        opt_fail
        ;;
    esac
}