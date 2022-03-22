#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh)

INIT_PKGS=(
	'git'
	'wget'
	'curl'
	'cmake'                 # Cross-platform open-source make system
	'make'
	'pkg-config'
	'paru'
	'dialog'				# displays various kinds of dialog boxes that can be incorporate into shell scripts
	'neofetch'              # Shows system info when you launch terminal
	'autojump'
	'zenity'                # Display graphical dialog boxes via shell scripts
  	'xclip'					# copy paste and clipboard access operations from the command line interface
)

echo -e "${BOLD}${FG_GREEN}Updating and Upgrading Mirrors and Packages ${RESETS}"

# Update Mirros List
sudo pacman-mirrors -c all

# Update and Upgrade Packages
sudo pacman -Syyu --noconfirm

# Checks if yay is installed, if it's not installed, install it and update Aur packages
echo "Installing yay"
pacman -Qs yay && echo "${FG_GREEN} Yay already installed ${RESETS}" || sudo pacman -S yay --noconfirm --needed

echo -e "${BOLD}${FG_GREEN}Installing Packages${RESETS}"

# Install packages
for PKG in "${INIT_PKGS[@]}"; do
    echo -e "${FG_GREEN}Installing ${PKG} ${RESETS}"
    pacman -Qs ${PKG} && echo "${RED} ${PKG} already installed ${RESETS}" || yay -S ${PKG} --noconfirm --needed
    #yay -S ${PKG} --noconfirm
done

# Initializes the dialog with the specifed measurements
# any option can be set to default to "on"
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
	11 "Office" off
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
			#Install ZSH
			echo "Installing ZSH"
			#Install ZSH
			echo "Installing ZSH"
			yay -S zsh --needed

			echo "Installing Oh My ZSH"
			sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

			echo "Installing zsh-syntax-highlighting Plugin"
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

			echo "Installing zsh-autosuggestions Plugin"
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

			echo "Installing fzf-zsh-plugin Plugin"
			git clone https://github.com/unixorn/fzf-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin

			echo "Installing ZPlug"
			curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

			echo "Installing zsh-completions"
			git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
			
			echo "Installing Shell Color Scripts"
			yay -S shell-color-scripts

			echo "Powerlevel10k Theme"
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

			echo "Install patched powerline fonts for glyphs support"
			yay -S noto-fonts --needed
			yay -S powerline-fonts --needed
			. nerdfonts.sh
			;;
		2)
			echo "Installing Tmux"
			yay -S tmux --needed

			echo "Installing Oh My Tmux"
			cd ~
			git clone https://github.com/gpakosz/.tmux.git
			ln -s -f .tmux/.tmux.conf
			cp .tmux/.tmux.conf.local .
			;;
		3)
			echo "Installing Vim"
			yay -S vim --needed

			echo "Installing SpaceVim"
			curl -sLf https://spacevim.org/install.sh | zsh
			;;
		4)
			echo "Installing emacs"
			yay -S emacs --needed

			echo "Installing Doom emacs"
			git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
			~/.emacs.d/bin/doom install
			;;
		5)
			echo "Installing atom"
			yay -S atom --needed

			echo "Installing Sublime Text 4"
			yay -S sublime-text-4 --needed

			echo "Installing Visual Studio Code"
			yay -S visual-studio-code-bin --needed
			;;
		6) 
			#Install MongoDB
			echo "Installing MongoDb"
			yay -S patch --needed
			yay -S mongodb-bin --needed
			sudo systemctl enable mongodb.service
			sudo systemctl start mongodb.service
			;;
		7)
			#MariaDB
			echo "Installing MariaDB"
			yay -S mariadb --needed

			# Before starting the MariaDB service, initialize the database
			sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

			# Finally, start and enable the MariaDB service
			sudo systemctl enable --now mariadb
			sudo systemctl start mysqld

			# Once the service is up, verify the status of the MariaDB service
			systemctl status mariadb

			# After installing MariaDB, run the mysql_secure_installation command to remove anonymous users, test databases, and disallow remote root login.
			sudo mysql_secure_installation

			# DBeaver
			echo "Installing DBeaver"
			yay -S dbeaver --needed --noconfirm

			# MySQL Workbench
			echo "Installing MySQL Workbench"
			yay -S mysql-workbench --needed --noconfirm
			;;
		8)
			echo "Installing Python"
			yay -S python --needed --noconfirm
			yay -S  python-pip --needed --noconfirm

			echo "Installing JDK 8 & 11"
			echo "Installing JDK8"
			yay -S  jre8-openjdk --needed --noconfirm

			echo "Installing JDK11"
			yay -S jre11-openjdk --needed --noconfirm

			# Javascript runtime environment
			echo "Installing Nodejs"
			yay -S nodejs --needed --noconfirm

			# Node Version Manager
			echo "Installing Nvm"
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh

			 # Node package manager
			echo "Installing Npm"
			yay -S npm --needed --noconfirm

			echo "Installing create-react-app"
			npm i --global create-react-app 

			echo "Installing vue"
			npm i --global vue

			# Dependency management 
			echo "Installing Yarn"
			yay -S yarn --needed --noconfirm

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jq --needed --noconfirm

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jshon --needed --noconfirm

			# Rust
			echo "Installing Rust"
			yay -S rust --needed --noconfirm  

			echo "Installing Ruby"
			yay -S ruby --needed --noconfirm
			;;
		9)
			# Virtualization Support
			echo "Installing virtualbox"
			yay -S virtualbox --noconfirm --needed
			yay -S virtualbox-host-modules-arch --noconfirm --needed

			# Virt-manager
			echo "Installing virt-manager"
			yay -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat --noconfirm --needed

			sudo systemctl enable libvirtd.service
			sudo systemctl start libvirtd.service

			# Find some way to replace /etc/libvirt/libvirtd.conf with the edited version

			sudo usermod -aG libvirt mdlima

			sudo systemctl restart libvirtd.service
			;;
		10)
			# Media Support

			echo "Installing ffmpeg"
			yay -S nomacs --noconfirm --needed               # Image viewer

			echo "Installing ffmpeg"
			yay -S pngcrush --noconfirm --needed             # Tools for optimizing PNG images

			echo "Installing ffmpeg"
			yay -S ristretto --noconfirm --needed            # Multi image viewer

			echo "Installing ffmpeg"
			yay -S ffmpeg --noconfirm --needed

			echo "Installing vlc"
			yay -S vlc --noconfirm --needed

			echo "Installing mpv"
			yay -S mpv --noconfirm --needed

			echo "Installing youtube-dl"
			yay -S youtube-dl --noconfirm --needed

			echo "Installing youtube-viewer"
			yay -S youtube-viewer --noconfirm --needed
			;;
		11)
			# Office Support
			echo "Installing wps-office"
			yay -S wps-office --noconfirm --needed

			# PDF Support
			echo "Installing qpdfview"
			yay -S qpdfview --noconfirm --needed

			echo "Installing zathura"
			yay -S zathura --noconfirm --needed
			;;
		12)
			echo "Installing transmission-gtk"
			yay -S transmission-gtk --noconfirm --needed
			;;
		13)
			# Image Processing
			echo "Installing gimp"
			yay -S gimp --noconfirm --needed

			echo "Installing graphicsmagick"
			yay -S graphicsmagick --noconfirm --needed
			;;
		14)
			echo "Installing Steam"
			yay -S steam --noconfirm --needed
			;;
		15)
			echo "lInstalling lscolors"
			yay -S lscolors --noconfirm --needed           # Gnome calculator

			echo "Installing galculator"
			yay -S galculator --noconfirm --needed         # A Rust library to colorize paths using LS_COLORS

			echo "Installing gparted"
			yay -S gparted --noconfirm --needed            # Disk utility

			echo "Installing neoFetch"
			yay -S neofetch --noconfirm --needed           # Shows system info when you launch terminal

			echo "Installing exa"
			yay -S exa --noconfirm --needed

			echo "Installing htop"
			yay -S htop --noconfirm --needed

			echo "Installing lf"
			yay -S lf --noconfirm --needed

			echo "Installing ueberzug"
			yay -S ueberzug --noconfirm --needed

			echo "Installing arandr"
			yay -S arandr --noconfirm --needed

			echo "Installing blueman"
			yay -S blueman --noconfirm --needed

			echo "Installing zenity"
			yay -S zenity --noconfirm --needed                # Display graphical dialog boxes via shell scripts

			echo "Installing Sspeedtest-cli"
			yay -Sspeedtest-cli --noconfirm --needed        # Internet speed via terminal

			echo "Installing xlayoutdisplay"
		  	yay -S xlayoutdisplay --noconfirm --needed		# Display Configuration Tool

		  	echo "Installing the_silver_searcher"
		  	yay -S the_silver_searcher --noconfirm --needed	# A code searching tool similar to ack

		  	echo "Installing xclip"
		  	yay -S xclip --noconfirm --needed					# copy paste and clipboard access operations from the command line interface

		  	echo "Installing hunspell"
			yay -S hunspell --noconfirm --needed              # Spellcheck libraries

			echo "Installing hunspell-pt_PT"
			yay -S hunspell-pt_PT --noconfirm --needed        # Portuguese spellcheck library

			echo "Installing hunspell-en_US"
			yay -S hunspell-en_US --noconfirm --needed        # Portuguese spellcheck library

			echo "Installing bleachbit"
			yay -S bleachbit --noconfirm --needed

			echo "Installing stacer"
			yay -S stacer --noconfirm --needed

			echo "Installing catfish"
			yay -S catfish --noconfirm --needed

			echo "Installing Steam"
			yay -S flameshot --noconfirm --needed

			echo "Installing rsync"
			yay -S rsync --noconfirm --needed
			;;
		13)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
    esac
done

echo -e "${BOLD}${FG_GREEN}Cleaning up orphaned packages and cache${RESETS}"
# remove orphaned packages
sudo pacman -Sc
yay -Sc

echo -e "${BOLD}${FG_GREEN}Post Installation Script Complete${RESETS}"

printf "Would you like to reboot? (y/N)"
read -r reboot
[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot
