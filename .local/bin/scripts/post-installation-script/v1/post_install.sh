#!/bin/bash

SCRIPTS_DIR="$HOME/Downloads/scripts"

source $SCRIPTS_DIR/colors.sh

INIT_PKGS=(
	'yay'
	'dialog'				# displays various kinds of dialog boxes that can be incorporate into shell scripts
	'git'
	'wget'
	'curl'
	'rust'
	'cmake'                 # Cross-platform open-source make system
	'make'
	'pkg-config'
	'paru'
	'firefox'
	'brave-bin'
	'guake'
	'neofetch'              # Shows system info when you launch terminal
	'autojump'
	'zenity'                # Display graphical dialog boxes via shell scripts
  	'xclip'					# copy paste and clipboard access operations from the command line interface
)

color_green() {
	echo -ne${BOLD}${FG_GREEN}$1${RESETS}
}

color_blue() {
	echo -ne${BOLD}${FG_BLUE}$1${RESETS}
}

color_red() {
	echo -ne${BOLD}${FG_RED}$1${RESETS}
}

welcome() {
  printf "${BOLD}${FG_SKYBLUE}%s\n" ""
  printf "%s\n" "##############################################"
  printf "%s\n" "#                                            #"
  printf "%s\n" "#      Post Installation Packages Setup      #"     
  printf "%s\n" "#                                            #"
  printf "%s\n" "##############################################"
  printf "${RESETS}\n%s" ""

  printf "\n\a%s" "${BOLD}${FG_GREEN}Post Installation Script Starting${RESETS}"
  echo
}

sysupdate() {
	echo -e "${BOLD}${FG_GREEN}==> Updating and Upgrading Mirrors and Packages ${RESETS}"

	# Update Mirros List
	sudo pacman-mirrors -c all

	# Update and Upgrade Packages
	sudo pacman -Syu --noconfirm
}

# Searches the package in the system, if it's found skips the installation proccess, otherwise installs the package
packexists() {
	# silence non-error output, redirects stdout to /dev/null
	pacman -Qs $1 > /dev/null
    
    	PKG_EXISTS=$?
    
    if((PKG_EXISTS == 0)) 
    then
        echo "${BOLD}${FG_RED}Skipping $1. $1 already installed in the system${RESETS}"
    else
        echo "${BOLD}Installing $1${RESETS}"

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
        echo -e "${BOLD}${FG_RED}Skipping $2 installation. $2 directory was found in the system${RESETS}"
    else
        echo "${BOLD}Installing $2${RESETS}"
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
	[ "$(tr '[:upper:]' '[:lower:]' <<< "$package")" = "y" ] && $2
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
	direxists $HOME/.zplug "zplug" 'curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh'
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
		cp .tmux/.tmux.conf.local 
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
		exec ~/.emacs.d/bin/doom install
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
    	exec sudo mysql_secure_installation
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

	direxists $HOME/.nvm "Node Version Manager" "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash"

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
	#packexists rust
	packexists ruby
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
	packexists nomacs								  # Image viewer
	packexists pngcrush								  # Tools for optimizing PNG images
	packexists ristretto							  # Multi image viewer
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

install_system_utils() {
	packexists lscolors									 # Gnome calculator
	packexists galculator 								 # A Rust library to colorize paths using LS_COLORS    
	packexists gparted								     # Disk utility
	packexists neofetch								     # Shows system info when you launch terminal          
	packexists exa
	packexists htop
	packexists lf
	packexists ueberzug
	packexists arandr
	packexists blueman
	packexists zenity									# Display graphical dialog boxes via shell scripts       
	packexists xlayoutdisplay							# Display Configuration Tool	
  	packexists the_silver_searcher 						# A code searching tool similar to ack
  	packexists xclip									# copy paste and clipboard access operations from the command line interface					
  	packexists hunspell              					# Spellcheck libraries
	packexists hunspell-pt_pt        					# Portuguese spellcheck library
	packexists hunspell-en_US						   # American English spellcheck library       
	packexists bleachbit
	packexists stacer
	packexists catfish
	packexists flameshot
	packexists rsync
	packexists timeshift
}

init_dialog() {
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install from the present list of choices. Use the UP/DOWN arrow keys to move through the list. Press SPACE to toggle an option on/off." 22 76 16)
	options=(
		1 "ZSH" off
		2 "Tmux" off
		3 "Vim" off
		4 "Emacs" off
		5 "IDEs" off
		6 "MongoDB" off
		7 "MariaDB" off
		8 "Dev Env" off
		9 "Virtualization" off
		10 "Media" off
		11 "Offfice" off
		12 "Torrents" off
		13 "Media Manipulation" off
		14 "Games" off
		15 "System Utils" off
		16 "Generate SSH Keys" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear

	for choice in $choices
		do
		case $choice in
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
			13)
				generate_ssh_keys
				;;
	    esac
	done
}

init_menu() {
    	printf "\n%s" "${BOLD}1${RESET} ZSH"
	    printf "\n%s" "${BOLD}2${RESET} Tmux"
	    printf "\n%s" "[${BOLD}3${RESET}] Vim"
	    printf "\n%s" "[${BOLD}4${RESET}] Emacs"
	    printf "\n%s" "[${BOLD}5${RESET}] IDE's"
	    printf "\n%s" "[${BOLD}6${RESET}] MongoDB"
	    printf "\n%s" "[${BOLD}7${RESET}] MariaDB"
	    printf "\n%s" "[${BOLD}8${RESET}] Dev Env"
	    printf "\n%s" "[${BOLD}9${RESET}] Virtualization"
	    printf "\n%s" "[${BOLD}10${RESET}] Media"
	    printf "\n%s" "[${BOLD}11${RESET}] Office"
	    printf "\n%s" "[${BOLD}12${RESET}] Torrents"
	   	printf "\n%s" "[${BOLD}13${RESET}] Media Manipulation"
	    printf "\n%s" "[${BOLD}14${RESET}] Games"
	    printf "\n%s" "[${BOLD}15${RESET}] System Utils"
	    printf "\n%s" "[${BOLD}16${RESET}] All Applications"
	    printf "\n%s" "[${BOLD}17${RESET}] Generate SSH keys"
	    printf "\n%s\n" "${BOLD}0${RESET} Quit Session"
read a
case $a in
    1) install_zsh ; init_menu ;;
    2) install_tmux ; init_menu ;;
    3) install_vim ; init_menu ;;
    4) install_emacs ; init_menu ;;
    5) install_ides ; init_menu ;;
0) goodbye;;
*) echo -e $(color_red 'Wrong option)') Exit; WrongCommand;;
esac
}

init_simple_dialog() {
	while :
    do

	    read -p "What do you want me to do ? [${BOLD}1${RESET}]: " -n 1 -r USER_INPUT
	    # Default choice is [1], See Parameter Expansion
	    USER_INPUT=${USER_INPUT:-1}
	    case $USER_INPUT in
	    	[1]* ) install_zsh ;;
	        [2]* ) install_tmux;;
	        [3]* ) install_vim;;
    	    [4]* ) install_emacs;;
	        [5]* ) install_ides;;
	        [6]* ) install_mongodb;;
			[7]* ) install_mariadb;;
	        [8]* ) install_dev_env;;
	        [9]* ) install_virtualization_support;;
    	    [10]* ) install_media_support;;
	        [11]* ) install_office_support;;
	        [12]* ) install_torrent_support;;
    	    [13]* ) install_media_manipulation_support;;
	        [14]* ) install_games_support;;
	        [15]* ) install_system_utils;;
			[16]* ) install_zsh
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
			[16]* ) generate_ssh_keys;;
	        [q/Q]* ) goodbye 
	             exit;;
	        * )     printf "\n%s\n" "[❌]Invalid Input 🙄, Try Again";;
	    esac
    done
}

cleanup() {
	echo -e "${BOLD}${FG_GREEN}==> Cleaning up orphaned packages and cache${RESETS}"
	echo
	# remove orphaned packages
	sudo pacman -Rns $(pacman -Qtdq)
	sudo pacman -Sc
	yay -Sc
}

goodbye() {
	cleanup
	
	echo
	echo -e "${BOLD}${FG_GREEN}Post Installation Script Complete${RESETS}"
	echo

	printf "Would you like to reboot? (y/N)"
	read -r reboot
	[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot || [ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "n" ] && $SCRIPTS_DIR/setup.sh
}

welcome

#sysupdate # Initiates Mirrors and Packages update

instalPkgs

init_menu

#init_dialog # Initializes the dialog with the specifed measurements. Any option can be set to default to "on"

#cleanup

goodbye