#!/bin/bash

# Nerdfonts
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts

RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
LIGHT_GREEN='\e[1;32m'
NC=$'\e[0m'

OUTPUT_DIR=/home/mdlima/.local/share/fonts/

echo
echo 	'######################################'
echo 	'##                           	    ##'
echo 	'##                           	    ##'
echo 	'##                           	    ##'
echo -e "## ${LIGHT_GREEN}NerdFonts Downloader Script ${NC} ##"
echo 	'##                           	    ##'
echo 	'## This script was developed to automate downloading patched nerdfonts por powerline                          	    ##'
echo 	'## https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts                           	    ##'
echo 	'######################################'
echo

if [ -d "$OUTPUT_DIR" ]; then
    # Take action if $DIR exists. #
    echo -e "${RED}$OUTPUT_DIR already exists.${EC}"
else
    echo "${GREEN}created directory $OUTPUT_DIR${EC}"
    mkdir $OUTPUT_DIR	
fi

echo "${GREEN}Started downloading fonts${EC}"

#Droid Sans Mono
curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf" --output-dir $OUTPUT_DIR

#Fira Mono
curl -fLo "Fira Mono Regular Nerd Font Complete Mono.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf" --output-dir $OUTPUT_DIR
curl -fLo "Fira Mono Regular Nerd Font Complete.otf"  "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete.otf" --output-dir $OUTPUT_DIR
 
# 3270
curl -fLo "3270 Medium for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/3270/Medium/complete/3270-Medium%20Nerd%20Font%20Complete.otf" --output-dir $OUTPUT_DIR
curl -fLo "3270 Narrow for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/3270/Narrow/complete/3270%20Narrow%20Nerd%20Font%20Complete.otf" --output-dir $OUTPUT_DIR
curl -fLo "3270 Semi Narrow for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/3270/Semi-Narrow/complete/3270%20Semi-Narrow%20Nerd%20Font%20Complete.otf" --output-dir $OUTPUT_DIR

# mononoki
curl -fLo "mononoki Bold Italic for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Mononoki/Bold-Italic/complete/mononoki%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "mononoki Bold for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Mononoki/Bold/complete/mononoki%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "mononoki Italic for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Mononoki/Italic/complete/mononoki%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "mononoki Regular for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Mononoki/Regular/complete/mononoki-Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR

# Space Mono
curl -fLo "Space Mono Bold Italic Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold-Italic/complete/Space%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Bold Italic for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold-Italic/complete/Space%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono BoldMono  for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold/complete/Space%20Mono%20Bold%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Bold  for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold/complete/Space%20Mono%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Italic Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Italic/complete/Space%20Mono%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Italic for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Italic/complete/Space%20Mono%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Regular Mono for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Italic/complete/Space%20Mono%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Regular for Powerline Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Italic/complete/Space%20Mono%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR


# Roboto Mono
curl -fLo "Roboto Mono Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Bold-Italic/complete/Roboto%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Bold/complete/Roboto%20Mono%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Italic/complete/Roboto%20Mono%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Light Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Light-Italic/complete/Roboto%20Mono%20Light%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Light Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Light/complete/Roboto%20Mono%20Light%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Medium Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Medium-Italic/complete/Roboto%20Mono%20Medium%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Medium Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Medium/complete/Roboto%20Mono%20Medium%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Thin Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Thin-Italic/complete/Roboto%20Mono%20Thin%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Roboto Mono Thin Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/RobotoMono/Thin/complete/Roboto%20Mono%20Thin%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR

# Source Code Pro
curl -fLo "Source Code Pro Black Italic Mono Nerd Font Complete.otf"  "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Black-Italic/complete/Sauce%20Code%20Pro%20Black%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Black Italic Nerd Font Complete.otf"  "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Black-Italic/complete/Sauce%20Code%20Pro%20Black%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Black Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Black Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Bold Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Bold-Italic/complete/Sauce%20Code%20Pro%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Bold Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Bold-Italic/complete/Sauce%20Code%20Pro%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Bold Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Extra Light Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Extra-Light/complete/Sauce%20Code%20Pro%20ExtraLight%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Extra Light Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Extra-Light/complete/Sauce%20Code%20Pro%20ExtraLight%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Extra Light Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/ExtraLight-Italic/complete/Sauce%20Code%20Pro%20ExtraLight%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Extra Light Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/ExtraLight-Italic/complete/Sauce%20Code%20Pro%20ExtraLight%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Light Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Light-Italic/complete/Sauce%20Code%20Pro%20Light%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Light Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Light-Italic/complete/Sauce%20Code%20Pro%20Light%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Light Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Light Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Medium Italic Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium-Italic/complete/Sauce%20Code%20Pro%20Medium%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Medium Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium-Italic/complete/Sauce%20Code%20Pro%20Medium%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Medium Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Medium Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Regular Mono Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Semibold Mono Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Semibold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Semibold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Source Code Pro Semibold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR

# Meslo LG
curl -fLo "Meslo LG L DZ Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L-DZ/Bold-Italic/complete/Meslo%20LG%20L%20DZ%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L DZ Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L-DZ/Bold/complete/Meslo%20LG%20L%20DZ%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L DZ Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L-DZ/Italic/complete/Meslo%20LG%20L%20DZ%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L DZ Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L-DZ/Regular/complete/Meslo%20LG%20L%20DZ%20Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L/Bold-Italic/complete/Meslo%20LG%20L%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L/Bold/complete/Meslo%20LG%20L%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L/Italic/complete/Meslo%20LG%20L%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG L Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L/Regular/complete/Meslo%20LG%20L%20Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M-DZ Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M-DZ/Bold-Italic/complete/Meslo%20LG%20M%20DZ%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M-DZ Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M-DZ/Bold/complete/Meslo%20LG%20M%20DZ%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M-DZ Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M-DZ/Italic/complete/Meslo%20LG%20M%20DZ%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M-DZ Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M-DZ/Italic/complete/Meslo%20LG%20M%20DZ%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M Bold Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Bold-Italic/complete/Meslo%20LG%20M%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M Bold Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Bold/complete/Meslo%20LG%20M%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Italic/complete/Meslo%20LG%20M%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG M Bold Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S-DZ Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S-DZ/Bold-Italic/complete/Meslo%20LG%20S%20DZ%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S-DZ Bold Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S-DZ/Bold/complete/Meslo%20LG%20S%20DZ%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S-DZ Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S-DZ/Italic/complete/Meslo%20LG%20S%20DZ%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S-DZ Regular Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S-DZ/Regular/complete/Meslo%20LG%20S%20DZ%20Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S/Bold-Italic/complete/Meslo%20LG%20S%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S/Bold/complete/Meslo%20LG%20S%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S/Italic/complete/Meslo%20LG%20S%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Meslo LG S Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/S/Regular/complete/Meslo%20LG%20S%20Regular%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR

# Terminess
curl -fLo "Terminess (TTF) Bold Italic Nerd Font Complete.otf" 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Terminus/terminus-ttf-4.40.1/Bold/complete/Terminess%20(TTF)%20Bold%20Nerd%20Font%20Complete.ttf' --output-dir $OUTPUT_DIR
curl -fLo "Terminess (TTF) Bold Nerd Font Complete.otf" 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Terminus/terminus-ttf-4.40.1/BoldItalic/complete/Terminess%20(TTF)%20Bold%20Italic%20Nerd%20Font%20Complete.ttf' --output-dir $OUTPUT_DIR
curl -fLo "Terminess (TTF) Italic Nerd Font Complete.otf" 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Terminus/terminus-ttf-4.40.1/Italic/complete/Terminess%20(TTF)%20Italic%20Nerd%20Font%20Complete.ttf' --output-dir $OUTPUT_DIR
curl -fLo "Terminess (TTF) Regular Nerd Font Complete.otf" 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Terminus/terminus-ttf-4.40.1/Regular/complete/Terminess%20(TTF)%20Nerd%20Font%20Complete.ttf' --output-dir $OUTPUT_DIR

# Space Mono
curl -fLo "Space Mono Nerd Font Complete Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold-Italic/complete/Space%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Nerd Font Complete Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Bold/complete/Space%20Mono%20Bold%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Nerd Font Complete Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Italic/complete/Space%20Mono%20Italic%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR
curl -fLo "Space Mono Nerd Font Complete Bold Italic Nerd Font Complete.otf" "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SpaceMono/Regular/complete/Space%20Mono%20Nerd%20Font%20Complete.ttf" --output-dir $OUTPUT_DIR

echo "${GREEN}Finished downloading fonts${EC}"