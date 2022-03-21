#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/martimdLima/dotfiles/master/.local/bin/scripts/post-installation-script/colors.sh)

INIT_PKGS=(
	'git'
	'vim'
	'wget'
	'curl'
	'cmake'                 # Cross-platform open-source make system
	'make'
	'paru'
	'pkg-config'
	'autojump'
	'dialog'			# displays various kinds of dialog boxes that can be incorporate into shell scripts
)

echo -e "${BOLD_GREEN}Updating and Upgrading Mirrors and Packages ${RESET}"

# Update Mirros List
sudo pacman-mirrors -c all

# Update and Upgrade Packages
sudo pacman -Syyu --noconfirm

# Checks if yay is installed, if it's not installed, install it and update Aur packages
echo "Installing yay"
pacman -Qs yay && echo "${GREEN} Yay already installed ${RESET}" || sudo pacman -S yay --noconfirm

echo -e "${BOLD_GREEN}Installing Packages${RESET}"

# Install packages
for PKG in "${INIT_PKGS[@]}"; do
    echo -e "${GREEN}Installing ${PKG} ${RESET}"
    pacman -Qs ${PKG} && echo "${RED} ${PKG} already installed ${RESET}" || sudo pacman -S ${PKG} --noconfirm
done

# Initializes the dialog with the specifed measurements
# any option can be set to default to "on"
cmd=(dialog --separate-output --checklist "Please Select Software you want to install from the present list of choices. Use the UP/DOWN arrow keys to move through the list. Press SPACE to toggle an option on/off." 22 76 16)
options=(
	1 "Shell" off    
	2 "Browsers" off
	3 "IDEs" off
	4 "Dev Env" off
	5 "Dbs" off
	6 "Virtualization" off
	7 "Media" off
	8 "Office" off
	9 "Torrents" off
	10 "Media Manipulation" off
	11 "Games" off
	12 "System Utils" off
	13 "Generate SSH Keys" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear

for choice in $choices
	do
	case $choice in
    	1)	
			#Install Alacrity
			yay -S alacritty --noconfirm --needed

			#Install Guake
			echo "Installing Guake"
			yay -S guake --noconfirm --needed

			#Install ZSH
			echo "Installing ZSH"
			yay -S zsh --noconfirm --needed

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
			yay -S noto-fonts --noconfirm --needed
			yay -S powerline-fonts --noconfirm --needed
			. nerdfonts.sh

			echo "Installing Tmux"
			yay -S tmux --noconfirm --needed

			echo "Installing Oh My Tmux"
			cd ~
			git clone https://github.com/gpakosz/.tmux.git
			ln -s -f .tmux/.tmux.conf
			cp .tmux/.tmux.conf.local .

			;;
		2)
			echo "Installing Brave"
			yay -S brave-bin --noconfirm --needed

			echo "Installing Firefox"
			yay -S firefox --noconfirm --needed

			;;
		3)
			echo "Installing SpaceVim"
			curl -sLf https://spacevim.org/install.sh | zsh

			echo "Installing emacs"
			yay -S emacs --noconfirm --needed

			echo "Installing Doom emacs"
			git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
			~/.emacs.d/bin/doom install

			echo "Installing atom"
			yay -S atom --noconfirm --needed

			echo "Installing Sublime Text 4"
			yay -S sublime-text-4 --noconfirm --needed

			echo "Installing Visual Studio Code"
			yay -S visual-studio-code-bin --noconfirm --needed
			;;
		4)
			echo "Installing Python"
			yay -S python --noconfirm --needed
			yay -S  python-pip --noconfirm --needed

			echo "Installing JDK 8 & 11"
			echo "Installing JDK8"
			yay -S  jre8-openjdk --noconfirm --needed

			echo "Installing JDK11"
			yay -S jre11-openjdk --noconfirm --needed

			# Javascript runtime environment
			echo "Installing Nodejs"
			yay -S nodejs --noconfirm --needed

			# Node Version Manager
			echo "Installing Nvm"
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh

			 # Node package manager
			echo "Installing Npm"
			yay -S npm --noconfirm --needed

			# Dependency management 
			echo "Installing Yarn"
			yay -S yarn --noconfirm --needed

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jq --noconfirm --needed

			# JSON parsing library
			echo "Installing Yarn"
			yay -S jshon --noconfirm --needed  

			# Rust
			echo "Installing Rust"
			yay -S rust --noconfirm --needed   

			echo "Installing Ruby"
			yay -S ruby --noconfirm --needed 
			;;
		5) 
			#Install MongoDB
			echo "Installing MongoDb"
			yay -S patch --noconfirm --needed
			yay -S mongodb --noconfirm --needed
			sudo systemctl enable mongodb.service
			sudo systemctl start mongodb.service

			#MariaDB
			echo "Installing MariaDB"
			yay -S mariadb --noconfirm --needed

			# Before starting the MariaDB service, initialize the database
			sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

			# Finally, start and enable the MariaDB service
			sudo systemctl enable --now mariadb
			sudo systemctl start mysqld

			# Once the service is up, verify the status of the MariaDB service
			#systemctl status mariadb

			# After installing MariaDB, run the mysql_secure_installation command to remove anonymous users, test databases, and disallow remote root login.
			sudo mysql_secure_installation

			# DBeaver
			echo "Installing DBeaver"
			yay -S dbeaver --noconfirm --needed

			# MySQL Workbench
			echo "Installing MySQL Workbench"
			yay -S mysql-workbench --noconfirm --needed
			;;
		6)
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
		7)
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
		8)
			# Office Support
			echo "Installing wps-office"
			yay -S wps-office --noconfirm --needed

			# PDF Support
			echo "Installing qpdfview"
			yay -S qpdfview --noconfirm --needed

			echo "Installing zathura"
			yay -S zathura --noconfirm --needed
			;;
		9)
			echo "Installing transmission-gtk"
			yay -S transmission-gtk --noconfirm --needed
			;;
		10)
			# Image Processing
			echo "Installing gimp"
			yay -S gimp --noconfirm --needed

			echo "Installing graphicsmagick"
			yay -S graphicsmagick --noconfirm --needed
			;;
		11)
			echo "Installing Steam"
			yay -S steam --noconfirm --needed
			;;
		12)
			
			echo "Installing Steam"
			yay -S galculator --noconfirm --needed           # Gnome calculator

			echo "Installing Steam"
			yay -S gparted --noconfirm --needed               # Disk utility

			echo "Installing Steam"
			yay -S neofetch --noconfirm --needed              # Shows system info when you launch terminal

			echo "Installing Steam"
			yay -S exa --noconfirm --needed

			echo "Installing Steam"
			yay -S htop --noconfirm --needed

			echo "Installing Steam"
			yay -S lf --noconfirm --needed

			echo "Installing Steam"
			yay -S ueberzug --noconfirm --needed

			echo "Installing Steam"
			yay -S arandr --noconfirm --needed

			echo "Installing Steam"
			yay -S blueman --noconfirm --needed

			echo "Installing Steam"
			yay -S zenity --noconfirm --needed                # Display graphical dialog boxes via shell scripts

			echo "Installing Steam"
			yay -Sspeedtest-cli --noconfirm --needed        # Internet speed via terminal

			echo "Installing Steam"
		  	yay -S xlayoutdisplay --noconfirm --needed		# Display Configuration Tool

		  	echo "Installing Steam"
		  	yay -S the_silver_searcher --noconfirm --needed	# A code searching tool similar to ack

		  	echo "Installing Steam"
		  	yay -S xclip --noconfirm --needed					# copy paste and clipboard access operations from the command line interface

		  	echo "Installing Steam"
			yay -Shunspell --noconfirm --needed              # Spellcheck libraries

			echo "Installing Steam"
			yay -Shunspell-pt_PT --noconfirm --needed        # Portuguese spellcheck library

			echo "Installing Steam"
			yay -S hunspell-en_US --noconfirm --needed        # Portuguese spellcheck library

			echo "Installing Steam"
			yay -S bleachbit --noconfirm --needed

			echo "Installing Steam"
			yay -S stacer --noconfirm --needed

			echo "Installing Steam"
			yay -S catfish --noconfirm --needed

			echo "Installing Steam"
			yay -S flameshot --noconfirm --needed

			echo "Installing Steam"
			yay -S rsync --noconfirm --needed
			;;
		
		13)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
    esac
done

echo -e "${BOLD_GREEN}Cleaning up orphaned packages and cache${RESET}"
# remove orphaned packages
sudo pacman -Sc
yay -Sc

echo -e "${BOLD_GREEN}Post Installation Script Complete${RESET}"

printf "Would you like to reboot? (y/N)"
read -r reboot
[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot
