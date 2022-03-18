#!/bin/bash

RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
LIGHT_GREEN='\e[1;32m'
NC=$'\e[0m'

echo
echo 	'######################################'
echo 	'##                           	    ##'
echo -e "## ${LIGHT_GREEN}MDLima Post-Installation Script ${NC} ##"
echo 	'##                           	    ##'
echo 	'######################################'
echo

INIT_PKGS=(
	'pkg-config'
	'paru'
	'vim'
	'git'
	'wget'
	'curl'
    'cmake'                 # Cross-platform open-source make system
    'galculator'            # Gnome calculator
    'hunspell'              # Spellcheck libraries
    'hunspell-en'           # Portuguese spellcheck library
	'nomacs'                # Image viewer
    'pngcrush'              # Tools for optimizing PNG images
    'ristretto'             # Multi image viewer
    'gparted'               # Disk utility
    'neofetch'              # Shows system info when you launch terminal
    'autojump'
    'exa'
    'htop'
    'lf'
    'ueberzug'
    'arandr'
    'blueman'
    'bleachbit'
    'stacer'
    'catfish'
    'flameshot'
    'rsync'
    'zenity'                # Display graphical dialog boxes via shell scripts
    'speedtest-cli'         # Internet speed via terminal
	'dialog'				# displays various kinds of dialog boxes that can be incorporate into shell scripts
)

echo -e "${LIGHT_GREEN}Post Installation Script Started ${NC}"

# Update and Upgrade Packages
echo -e "${LIGHT_GREEN}Updating and Upgrading Mirrors and Packages ${NC}"
sudo pacman -Syyu --noconfirm

# Checks if yay is installed, if it's not installed, install it and update Aur packages
echo "Installing yay"
pacman -Qs yay && echo "${GREEN}Yay already installed${NC}" || sudo pacman -S yay --noconfirm

#if [ $(pacman -Qs yay) == "" ];
#then
#	echo "Installing yay"
#	sudo pacman -S yay --noconfirm
#	yay -Syu --noconfirm
#fi

for PKG in "${INIT_PKGS[@]}"; do
    echo -e "${GREEN}Installing ${PKG} ${NC}"
    #if [ $(which ${PKG}) == "" ];
	#then
	#	yay -S "$PKG" --noconfirm --needed
	#fi
	tput setaf 1; echo $(pacman -Qs ${PKG}) && echo "${GREEN}${PKG} already installed${NC}" || sudo pacman -S ${PKG} --noconfirm
done

#Install System Utils
echo -e "${GREEN}Installing System Utils ${NC}"



# Initializes the dialog with the specifed measurements
cmd=(dialog --separate-output --checklist "Please Select Software you want to install from the present list of choices. Use the UP/DOWN arrow keys to move through the list. Press SPACE to toggle an option on/off." 22 76 16)
options=(
	1 "Alacrity" off    # any option can be set to default to "on"
	2 "Guake" off
	3 "ZSH" off
	4 "Tmux" off
	5 "Brave" off
	6 "Firefox" off
	7 "SpaceVim" off
	8 "Emacs" off
	9 "Doom Emacs" off
	10 "Atom" off
	11 "Sublime Text 4" off
	12 "Visual Studio Code" off
	13 "Python" off
	14 "JDK 8 & 11" off
	15 "Nodejs/Npm/Yarn" off
	16 "Rust" off
	17 "Ruby" off
	18 "MariaDB" off
	19 "DBeaver" off
	20 "MySQl Workbench" off
	21 "WPS Office" off
	22 "PDF Support" off
	23 "Media Support" off
	24 "Torrent Support" off
	25 "Image Processing" off
	26 "Virtualization Support" off
	27 "Generate SSH Keys" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear

for choice in $choices
	do
	case $choice in
    	1)	
			#Install Alacrity
			echo "Installing Alacrity"
			yay -S alacritty
			;;
		2)
			#Install Guake
			echo "Installing Guake"
			yay -S guake
			;;
		3)
			#Install ZSH
			echo "Installing ZSH"
			yay -S zsh

			echo "Installing Oh My ZSH"
			sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

			echo "Installing zsh-syntax-highlighting Plugin"
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

			echo "Installing zsh-autosuggestions Plugin"
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

			echo "Installing fzf-zsh-plugin Plugin"
			git clone https://github.com/unixorn/fzf-zsh-plugin.git fzf-zsh-plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/

			echo "Installing zsh-completions"
			git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

			echo "Powerlevel10k Theme"
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

			echo "Install patched powerline fonts for glyphs support"
			yay -S noto-fonts
			yay -S powerline-fonts
			. nerdfonts.sh
			;;
		4)
			echo "Installing Tmux"
			yay -S tmux

			echo "Installing Oh My Tmux"
			git clone https://github.com/gpakosz/.tmux.git
			ln -s -f .tmux/.tmux.conf
			cp .tmux/.tmux.conf.local .
			;;
		5)
			echo "Installing Brave"
			yay -S brave
			;;
		6)
			echo "Installing Firefox"
			yay -S firefox
			;;
		7)
			echo "Installing SpaceVim"
			curl -sLf https://spacevim.org/install.sh | zsh
			;;
		8)
			echo "Installing emacs"
			yay -S emacs
			;;
		9)
			echo "Installing Doom emacs"
			git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
			~/.emacs.d/bin/doom install
			;;
		10)
			echo "Installing atom"
			yay -S atom
			;;
		11)
			echo "Installing Sublime Text 4"
			yay -S sublime-text-4
			;;
		12)
			echo "Installing Visual Studio Code"
			yay -S visual-studio-code-bin
			;;
		13)
			echo "Installing Python"
			yay -S python
			yay -S  python-pip
			;;
		14)
			echo "Installing JDK 8 & 11"
			echo "Installing JDK8"
			yay -S  jre8-openjdk

			echo "Installing JDK11"
			yay -S jre11-openjdk
			;;
		15)
			#Install Nodejs, Npm and Yarn

			# Cross-platform development using Javascript
			echo "Installing electron"
			yay -S electron

			# Javascript runtime environment
			echo "Installing Nodejs"
			yay -S nodejs

			 # Node package manager
			echo "Installing Npm"
			yay -S npm

			# Dependency management 
			echo "Installing Yarn"
			yay -S yarn

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jq

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jshon         
			;;
		16)
			# Rust
			echo "Installing Rust"
			yay -S rust
			;;
		17)
			echo "Installing Ruby"
			yay -S ruby
			;;
		18)
			#MariaDB
			echo "Installing MariaDB"
			yay -S mariadb

			# Before starting the MariaDB service, initialize the database
			mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

			# Finally, start and enable the MariaDB service
			systemctl enable --now mariadb

			# Once the service is up, verify the status of the MariaDB service
			systemctl status mariadb

			# After installing MariaDB, run the mysql_secure_installation command to remove anonymous users, test databases, and disallow remote root login.
			mysql_secure_installation
			;;
		19)
			# DBeaver
			echo "Installing DBeaver"
			yay -S dbeaver
			;;
		20)
			# MySQL Workbench
			echo "Installing MySQL Workbench"
			yay -S mysql-workbench
			;;
		21)
			# Office Support
			echo "Installing wps-office"
			yay -S wps-office
			;;
		22)
			# PDF Support
			echo "Installing qpdfview"
			yay -S qpdfview

			echo "Installing zathura"
			yay -S zathura
			;;
		23)
			# Media Support
			echo "Installing ffmpeg"
			yay -S ffmpeg

			echo "Installing vlc"
			yay -S vlc

			echo "Installing mpv"
			yay -S mpv

			echo "Installing youtube-dl"
			yay -S youtube-dl

			echo "Installing youtube-viewer"
			yay -S youtube-viewer
			;;
		24)
			# Torrent Support
			echo "Installing transmission-gtk"
			yay -S transmission-gtk
			;;
		25)
			# Image Processing
			echo "Installing gimp"
			yay -S gimp

			echo "Installing graphicsmagick"
			yay -S graphicsmagick
			;;
		26)
			# Virtualization Support
			echo "Installing virtualbox"
			yay -S virtualbox
			yay -S virtualbox-host-modules-arch

			# Virt-manager
			echo "Installing virt-manager"
			yay -S virt-manager
			;;
		27)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
    esac
done

echo -e "${LIGHT_GREEN}Post Installation Script Complete${NC}"

printf "Would you like to reboot? (y/N)"
read -r reboot
[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot