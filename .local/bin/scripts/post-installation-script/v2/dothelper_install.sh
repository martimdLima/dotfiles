#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

installer_welcome() {
printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "##############################################"
  printf "%s\n" "#      DotHelper System And Pkgs Setup       #"     
  printf "%s\n" "##############################################"
  printf "${RESETS}%s" ""
  echo
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

install_terminals() {
    packexists guake
    packexists alacritty
}

install_term_essencials() {
    packexists curl
    packexists wget
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
    packexists obs
}

install_office_support() {
    packexists wps-office
    packexists qpdfview
    packexists zathura

    packexists hunspell                                 # Spellcheck libraries
    packexists hunspell-pt_pt                           # Portuguese spellcheck library
    packexists hunspell-en_US                           # American English spellcheck library  
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
    packexists legenday
    packexists lutris
}

generate_ssh_keys() {
    echo "Generating SSH keys"
    ssh-keygen -t rsa -b 4096
}

install_browser_support() {
    packexists brave-bin
    packexists firefox
    packexists ungoogled-chromium
}

install_system_utils() {
    packexists lscolors                                 # A Rust library to colorize paths using LS_COLORS 
    packexists galculator                               # Gnome calculator  
    packexists gparted                                  # Disk utility
    packexists neofetch                                 # Shows system info when you launch terminal          
    packexists exa                                      # A modern replacement for ls
    packexists htop                                     # Interactive system-monitor process-viewer and process-manager
    packexists lf                                       # Terminal file manager written in Go with a heavy inspiration from ranger file manager.
    packexists ueberzug                                 # command line util which allows to draw images on terminals by using child windows
    packexists arandr                                   # designed to provide a simple visual front end for XRandR
    packexists blueman                                  # designed to provide a simple yet effective means for controlling the BlueZ API and simplifying Bluetooth tasks
    packexists zenity                                   # Display graphical dialog boxes via shell scripts       
    packexists xlayoutdisplay                           # Display Configuration Tool    
    packexists the_silver_searcher                      # A code searching tool similar to ack
    packexists xclip                                    # copy paste and clipboard access operations from the command line interface                    
    packexists bleachbit                                # BleachBit cleans files to free disk space and to maintain privacy.
    packexists install_office_support                   # open source system optimizer and application monitor that helps users to manage entire system with different aspects
    packexists catfish                                  # simple graphical file searching front-end for either slocate or GNU locate on
    packexists flameshot                                # Powerful yet simple to use screenshot software
    packexists rsync                                    # rsync is a fast and versatile command-line utility for synchronizing files and directories between two locations over a remote shell, or from/to a remote Rsync daemon
    packexists timeshift                                # takes incremental snapshots of the file system at regular intervals      
    packexists xclip                                    # provides an interface to X selections ("the clipboard") from the command line
    packexists zenity                                   # allows the execution of GTK dialog boxes in command-line and shell scripts.
    packexists autojump                                 # a faster way to navigate your filesystem
    packexists neofetch                                 # displays information about your operating system, software and hardware in an aesthetic and visually pleasing way
    packexists make                                     # utility for building and maintaining groups of programs
    packexists jq                                       # Used to slice, filter, map and transform structured data
    packexists jshon                                    # parses, reads and creates JSON
    packexists cmake                                    # utility for building and maintaining groups of programs
    packexists pkg-config                               # pkg-config program is used to retrieve information about installed libraries in the system  
    packexists paru                                     # Feature packed AUR helper
    packexists variety                                  # An automatic wallpaper changer, downloader and manager.
    packexists csvkit                                   # csvkit is a suite of command-line tools for converting to and working with CSV
    packexists ungit                                    # brings user friendliness to git without sacrificing the versatility of git
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
    install_browser_support
    printf "\n\a%s" "${BOLD}${FG_GREEN}System And Pkgs setup ended\n${RESETS}"
}

scripts_cleanup() {
  test -d "$SCRIPTS_DIR" && rm -fr "$SCRIPTS_DIR"
}

system_cleanup()  {
    printf "\n\a%s" "${BOLD}${FG_GREEN}System And Pkgs setup ended\n\n${RESETS}"
    printf "\n${BOLD}${FG_GREEN}==> Perform Clean up Routine\n${RESETS}"
    printf "${BOLD}\nCleaning up orphaned packages and cache\n\n${RESETS}"
    # remove orphaned packages
    sudo pacman -Rns $(pacman -Qtdq)
    sudo pacman -Sc --noconfirm
    yay -Sc --noconfirm
}

goodbye() {
    system_cleanup

    printf "\nRemove Scripts?\n${BOLD}This action will delete all the scripts used. ${RESETS}"
    printf "Do you want to continue$1? ${BOLD}(y/N)${RESETS}"
    read -r package
    [ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && scripts_cleanup

    printf "\a\n%s\n${BOLD}Thanks for using dothelper.${RESETS}"
    echo
    exit 0
}

opt_fail() { echo "Wrong option." exit 1; }

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
        install_tmux
        terminal_utils_menu
        ;;
    4)
        install_vim
        system_pkgs_update_and_install_menu
        ;;
    5)
        install_emacs
        system_pkgs_update_and_install_menu
        ;;
    6)
        install_term_essencials
        system_pkgs_update_and_install_menu
        ;;
    7)
        install_git
        system_pkgs_update_and_install_menu
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
        install_zsh
        db_menu
        ;;
    2)
        install_tmux
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
        $(blue_print '3)') Go Back to Update System & Install Software
        $(magenta_print '4)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        packexists atom
        ide_menu
        ;;
    2)
        packexists sublime-text-4
        ide_menu
        ;; 
    3)
        packexists visual-studio-code-bin
        ide_menu
        ;;
    4)
        install_ides
        ide_menu
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
        packexists vlc
        packexists ffmpeg
        media_menu
        ;;
    2)
        packexists mpv
        media_menu
        ;; 
    3)
        packexists youtube-dl
        packexists youtube-viewer
        media_menu
        ;;
    4)
        packexists nomacs                               # Image viewer
        packexists ristretto                            # Multi image viewer
        media_menu
        ;;
    5)
        packexists gimp
        packexists graphicsmagick
        packexists pngcrush                             # Tools for optimizing PNG images
        media_menu                             
        ;;
    6)
        packexists obs-studio                           #  video recording and live streaming
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
        packexists python
        packexists python-pip
        development_menu
        ;;
    2)
        packexists jre8-openjdk
        packexists jre11-openjdk
        development_menu
        ;; 
    3)
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

        development_menu
        ;;
    4)
        packexists rust
        ;;
    5)
        packexists ruby
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
        packexists wps-office
        media_menu
        ;;
    2)
        packexists libreoffice-fresh
        media_menu
        ;; 
    3)
        packexists qpdfview
        packexists zathura
        ide_menu
        ;;
    4)
        packexists hunspell                                 # Spellcheck libraries
        packexists hunspell-pt_pt                           # Portuguese spellcheck library
        packexists hunspell-en_US                           # American English spellcheck library
        ide_menu
        ;;
    5)
        packexists wps-office
        packexists libreoffice-fresh
        packexists qpdfview
        packexists zathura
        packexists hunspell                                 # Spellcheck libraries
        packexists hunspell-pt_pt                           # Portuguese spellcheck library
        packexists hunspell-en_US                           # American English spellcheck library
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
        $(blue_print '3)') Go Back to Update System & Install Software
        $(magenta_print '4)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        packexists qbittorrent-qt5
        ide_menu
        ;;
    2)
        packexists transmission-gtk
        ide_menu
        ;; 
    3)
        packexists deluge
        ide_menu
        ;;
    4)
        packexists qbittorrent-qt5
        packexists transmission-gtk
        packexists deluge
        ide_menu
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

games_menu() {
    echo -ne "
        $(green_print "IDE's")
        $(bold_yellow_print '1)') Steam
        $(bold_yellow_print '2)') Legendary
        $(bold_yellow_print '3)') Lutris
        $(bold_yellow_print '4)') All
        $(blue_print '3)') Go Back to Update System & Install Software
        $(magenta_print '4)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        packexists steam
        ide_menu
        ;;
    2)
        # open-source replacement for the Epic Games Launcher
        packexists legenday
        ide_menu
        ;; 
    3)
        packexists lutris
        ide_menu
        ;;
    4)
        install_games_support
        ide_menu
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
        packexists brave-bin
        ide_menu
        ;;
    2)
        packexists firefox
        ide_menu
        ;; 
    3)
        packexists ungoogled-chromium
        ide_menu
        ;;
    4)
        install_browser_support
        ide_menu
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
        packexists virtualbox
        packexists virtualbox-host-modules
        ide_menu
        ;;
    2)
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

        ide_menu
        ;; 
    3)
        install_virtualization_support
        ide_menu
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
        $(bold_yellow_print '34)') All
        $(blue_print '35)') Go Back to Update System & Install Software
        $(magenta_print '36)') Go Back to Main Menu
        $(red_print '0)') Exit
        Choose an option:  "
    read -r ans
    case $ans in
    1)
        packexists lscolors                                 # A Rust library to colorize paths using LS_COLORS 
        system_utils_menu
        ;;
    2)
        packexists galculator                               # Gnome calculator  
        system_utils_menu
        ;; 
    3)
        packexists gparted                                  # Disk utility
        system_utils_menu
        ;;
    4)
        packexists neofetch                                 # Shows system info when you launch terminal
        system_utils_menu
        ;;
    5)
        packexists exa                                      # A modern replacement for ls
        system_utils_menu
        ;;
    6)
        packexists htop                                     # Interactive system-monitor process-viewer and process-manager
        system_utils_menu
        ;;
    7)
        packexists lf                                       # Terminal file manager written in Go with a heavy inspiration from ranger file manager.
        system_utils_menu
        ;;
    8)    
        packexists arandr                                   # designed to provide a simple visual front end for XRandR
        system_utils_menu
        ;;
    9)
        packexists blueman                                  # designed to provide a simple yet effective means for controlling the BlueZ API and simplifying Bluetooth tasks
        system_utils_menu
        ;;
    10)
        packexists zenity                                   # Display graphical dialog boxes via shell scripts       
        system_utils_menu
        ;;
    11)
        packexists xlayoutdisplay                           # Display Configuration Tool    
        system_utils_menu
        ;;
    12)
        packexists the_silver_searcher                      # A code searching tool similar to ack                              
        system_utils_menu
        ;;
    13)
        packexists ueberzug                                 # command line util which allows to draw images on terminals by using child windows
        system_utils_menu
        ;;
    14)
        packexists xclip                                    # copy paste and clipboard access operations from the command line interface                    
        system_utils_menu
        ;;
    15)
        packexists bleachbit                                # BleachBit cleans files to free disk space and to maintain privacy.
        system_utils_menu
        ;;
    16)
        packexists stacer                                   # open source system optimizer and application monitor that helps users to manage entire system with different aspects
        system_utils_menu
        ;;
    17)
        packexists catfish                                  # simple graphical file searching front-end for either slocate or GNU locate on
        system_utils_menu
        ;;
    18)
        packexists flameshot                                # Powerful yet simple to use screenshot software
        system_utils_menu
        ;;
    19)
        packexists rsync                                    # rsync is a fast and versatile command-line utility for synchronizing files and directories between two locations over a remote shell, or from/to a remote Rsync daemon
        system_utils_menu
        ;;
    20)
        packexists timeshift                                # takes incremental snapshots of the file system at regular intervals      
        system_utils_menu
        ;;
    21)
        packexists xclip                                    # provides an interface to X selections ("the clipboard") from the command line
        system_utils_menu
        ;;
    22)
        packexists zenity                                   # allows the execution of GTK dialog boxes in command-line and shell scripts.
        system_utils_menu
        ;;
    23)
        packexists autojump                                 # a faster way to navigate your filesystem
        system_utils_menu
        ;;
    24)
        packexists neofetch                                 # displays information about your operating system, software and hardware in an aesthetic and visually pleasing way
        system_utils_menu
        ;;
    25)
        packexists make                                     # utility for building and maintaining groups of programs
        system_utils_menu
        ;;
    26)
        packexists jq                                       # Used to slice, filter, map and transform structured data
        system_utils_menu
        ;;
    27)
        packexists jshon                                    # parses, reads and creates JSON
        system_utils_menu
        ;;
    28)
        packexists cmake                                    # utility for building and maintaining groups of programs
        system_utils_menu
        ;;
    29)
        packexists pkg-config                               # pkg-config program is used to retrieve information about installed libraries in the system  
        system_utils_menu
        ;;
    30)
        packexists paru                                     # Feature packed AUR helper
        system_utils_menu
        ;;
    31)
        packexists variety                                  # An automatic wallpaper changer, downloader and manager.
        system_utils_menu
        ;;
    32)
        packexists csvkit                                   # csvkit is a suite of command-line tools for converting to and working with CSV
        system_utils_menu
        ;;
    33)
        packexists ungit                                    # brings user friendliness to git without sacrificing the versatility of git
        system_utils_menu
        ;;

    34)
        install_system_utils
        ide_menu
        ;;
    35)
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
        terminal_utils_menu
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
        virtualization_menu
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
        system_pkgs_update_and_install_menu
        ;;
    13)
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