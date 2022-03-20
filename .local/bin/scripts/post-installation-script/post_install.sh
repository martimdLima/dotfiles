#!/bin/bash

source ./colors.sh

echo
echo 	'######################################'
echo 	'##                           	    ##'
echo -e "## ${BOLD_GREEN}MDLima Post-Installation Script ${RESET} ##"
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
	'hunspell-pt_PT'        # Portuguese spellcheck library
	'hunspell-en_US'        # Portuguese spellcheck library
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
  	'xlayoutdisplay'		# Display Configuration Tool
  	'the_silver_searcher'	# A code searching tool similar to ack
  	'xclip'					# copy paste and clipboard access operations from the command line interface
	'dialog'				# displays various kinds of dialog boxes that can be incorporate into shell scripts
)

echo -e "${BOLD_GREEN}Post Installation Script Started ${RESET}"

echo -e "${BOLD_GREEN}Updating and Upgrading Mirrors and Packages ${RESET}"

# Update Mirros List
sudo pacman-mirrors -c all

# Update and Upgrade Packages
sudo pacman -Syyu --noconfirm

# Checks if yay is installed, if it's not installed, install it and update Aur packages
echo "Installing yay"
pacman -Qs yay && echo "${GREEN}Yay already installed${RESET}" || sudo pacman -S yay --noconfirm

# Install packages
for PKG in "${INIT_PKGS[@]}"; do
    echo -e "${GREEN}Installing ${PKG} ${RESET}"
    pacman -Qs ${PKG} && tput setaf 1; echo $("${GREEN}${PKG} already installed${RESET}") || sudo pacman -S ${PKG} --noconfirm
done

#Install System Utils
echo -e "${GREEN}Installing System Utils ${RESET}"

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
			yay -S alacritty --noconfirm --needed
			;;
		2)
			#Install Guake
			echo "Installing Guake"
			yay -S guake --noconfirm --needed
			;;
		3)
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
			$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

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
			;;
		4)
			echo "Installing Tmux"
			yay -S tmux --noconfirm --needed

			echo "Installing Oh My Tmux"
			git clone https://github.com/gpakosz/.tmux.git
			ln -s -f .tmux/.tmux.conf
			cp .tmux/.tmux.conf.local .
			;;
		5)
			echo "Installing Brave"
			#yay -S brave --noconfirm --needed
			yay -S brave
			;;
		6)
			echo "Installing Firefox"
			yay -S firefox --noconfirm --needed
			;;
		7)
			echo "Installing SpaceVim"
			curl -sLf https://spacevim.org/install.sh | zsh
			;;
		8)
			echo "Installing emacs"
			yay -S emacs --noconfirm --needed
			;;
		9)
			echo "Installing Doom emacs"
			git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
			~/.emacs.d/bin/doom install
			;;
		10)
			echo "Installing atom"
			yay -S atom --noconfirm --needed
			;;
		11)
			echo "Installing Sublime Text 4"
			yay -S sublime-text-4 --noconfirm --needed
			;;
		12)
			echo "Installing Visual Studio Code"
			yay -S visual-studio-code-bin --noconfirm --needed
			;;
		13)
			echo "Installing Python"
			yay -S python --noconfirm --needed
			yay -S  python-pip --noconfirm --needed
			;;
		14)
			echo "Installing JDK 8 & 11"
			echo "Installing JDK8"
			yay -S  jre8-openjdk --noconfirm --needed

			echo "Installing JDK11"
			yay -S jre11-openjdk --noconfirm --needed
			;;
		15)
			#Install Nodejs, Npm and Yarn

			# Cross-platform development using Javascript
			echo "Installing electron"
			yay -S electron --noconfirm --needed

			# Javascript runtime environment
			echo "Installing Nodejs"
			yay -S nodejs --noconfirm --needed

			# Node Version Manager
			echo "Installing Nvm"
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

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
			;;
		16)
			# Rust
			echo "Installing Rust"
			yay -S rust --noconfirm --needed
			;;
		17)
			echo "Installing Ruby"
			yay -S ruby --noconfirm --needed
			;; 
		18)
			#MariaDB
			echo "Installing MariaDB"
			yay -S mariadb --noconfirm --needed

			# Before starting the MariaDB service, initialize the database
			sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

			# Finally, start and enable the MariaDB service
			sudo systemctl enable --now mariadb
			sudo systemctl start mysqld

			# Once the service is up, verify the status of the MariaDB service
			systemctl status mariadb

			# After installing MariaDB, run the mysql_secure_installation command to remove anonymous users, test databases, and disallow remote root login.
			 sudo mysql_secure_installation
			;;
		19)
			# DBeaver
			echo "Installing DBeaver"
			yay -S dbeaver --noconfirm --needed
			;;
		20)
			# MySQL Workbench
			echo "Installing MySQL Workbench"
			yay -S mysql-workbench --noconfirm --needed
			;;
		21)
			# Office Support
			echo "Installing wps-office"
			yay -S wps-office --noconfirm --needed
			;;
		22)
			# PDF Support
			echo "Installing qpdfview"
			yay -S qpdfview --noconfirm --needed

			echo "Installing zathura"
			yay -S zathura --noconfirm --needed
			;;
		23)
			# Media Support
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
		24)
			# Torrent Support
			echo "Installing transmission-gtk"
			yay -S transmission-gtk --noconfirm --needed
			;;
		25)
			# Image Processing
			echo "Installing gimp"
			yay -S gimp --noconfirm --needed

			echo "Installing graphicsmagick"
			yay -S graphicsmagick --noconfirm --needed
			;;
		26)
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
		27)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
    esac
done

echo "Cleaning up orphaned packages and cache"
# remove orphaned packages
sudo pacman -Rns $(pacman -Qtdq)
sudo pacman -Sc
yay -Sc

# Installing and configuring dotfiles
. dot_files_config.sh

echo -e "${BOLD_GREEN}Post Installation Script Complete${RESET}"

printf "Would you like to reboot? (y/N)"
read -r reboot
[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot
