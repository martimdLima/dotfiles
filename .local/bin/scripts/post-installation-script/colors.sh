#!/bin/sh

if ! command -v tput &> /dev/null; then
  # Regular Colors
BLACK="\e[0;30m"
RED="\e[0;31m"      
GREEN="\e[0;32m" 
YELLOW="\e[0;33m"
BLUE="\e[0;34m"  
PURPLE="\e[0;35m" 
CYAN="\e[0;36m"   
WHITE="\e[0;37m "  

# BOLD
BOLD_BLACK="\e[1;30m"  
BOLD_RED=" \e[1;31m"  
BOLD_GREEN=" \e[1;32m"   
BOLD_YELLOW="\e[1;33m"  
BOLD_BLUE=" \e[1;34m"  
BOLD_PURPLE="\e[1;35m"  
BOLD_CYAN=" \e[1;36m"   
BOLD_WHITE="\e[1;37m"  

# UNDERLINE
UNDERLINE_BLACK="\e[4;30m"  
UNDERLINE_RED="\e[4;31m"  
UNDERLINE_GREEN="\e[4;32m"  
UNDERLINE_YELLOW="\e[4;33m"  
UNDERLINE_BLUE="\e[4;34m"   
UNDERLINE_PURPLE="\e[4;35m"   
UNDERLINE_CYAN="\e[4;36m"   
UNDERLINE_WHITE="\e[4;37m"  

# Background
BACKGROUND_BLACK="\e[40m"   
BACKGROUND_RED="\e[41m"  
BACKGROUND_GREEN="\e[42m "  
BACKGROUND_YELLOW="\e[43m"   
BACKGROUND_BLUE="\e[44m "  
BACKGROUND_PURPLE="\e[45m"  
BACKGROUND_CYAN="\e[46m"   
BACKGROUND_WHITE="\e[47m"  

# High Intensty
HIGH_INTENSITY_BLACK="\e[0;90m"   
HIGH_INTENSITY_RED=" \e[0;91m"   
HIGH_INTENSITY_GREEN="\e[0;92m"  
HIGH_INTENSITY_YELLOW="\e[0;93m"  
HIGH_INTENSITY_BLUE="\e[0;94m"   
HIGH_INTENSITY_PURPLE="\e[0;95m"   
HIGH_INTENSITY_CYAN="\e[0;96m"   
HIGH_INTENSITY_WHITE="\e[0;97m"   

# BOLD High Intensty
BOLD_HIGH_INTENSITY_BLACK="\e[1;90m"  
BOLD_HIGH_INTENSITY_RED=" \e[1;91m"   
BOLD_HIGH_INTENSITY_GREEN="\e[1;92m"   
BOLD_HIGH_INTENSITY_YELLOW="\e[1;93m"   
BOLD_HIGH_INTENSITY_BLUE=" \e[1;94m "  
BOLD_HIGH_INTENSITY_PURPLE="\e[1;95m "  
BOLD_HIGH_INTENSITY_CYAN="\e[1;96m "  
BOLD_HIGH_INTENSITY_WHITE="\e[1;97m"  

# High Intensty backgrounds 
HIGH_INTENSITY_BACKGROUND_BLACK="\e[0;100m"  
HIGH_INTENSITY_BACKGROUND_RED=" \e[0;101m"   
HIGH_INTENSITY_BACKGROUND_GREEN="\e[0;102m"  
HIGH_INTENSITY_BACKGROUND_YELLOW="\e[0;103m"   
HIGH_INTENSITY_BACKGROUND_BLUEk="\e[0;104m"  
HIGH_INTENSITY_BACKGROUND_PURPLE="\e[0;105m"  
HIGH_INTENSITY_BACKGROUND_CYAN=" \e[0;106m"  
HIGH_INTENSITY_BACKGROUND_WHITE="\e[0;107m"

RESET='\e[0m'
else
  BG_BLACK=$(tput setab 0)
  FG_RED=$(tput setaf 1)
  FG_GREEN=$(tput setaf 2)
  FG_YELLOW=$(tput setaf 3)
  FG_BLUE=$(tput setaf 4)
  FG_MAGENTA=$(tput setaf 5)
  FG_CYAN=$(tput setaf 6)
  FG_WHITE=$(tput setaf 7)
  FG_SKYBLUE=$(tput setaf 122)
  FG_ORANGE=$(tput setaf 208)
  BG_AQUA=$(tput setab 45)
  FG_BLACK=$(tput setaf 16)
  FG_ORANGE=$(tput setaf 214)

  BOLD=$(tput bold)
  RESETS=$(tput sgr0)
  UL=$(tput smul)
  RUL=$(tput rmul)
fi

