#!/bin/bash
#-Metadata----------------------------------------------------#
#   Filename: deploy.sh                (Updated: 2016-09-22)  #
#-Info--------------------------------------------------------#
#   Auto-deploy script for opencanary                         #
#   (https://github.com/thinkst/opencanary)                   #
#-Author(s)---------------------------------------------------#
#   sk4ro - https://twitter.com/AnarchistDalek                #
#   Colors culturally appropriated from g0tmi1k's os-scripts  #
#   (https://github.com/g0tmi1k/os-scripts)                   #
#-Operating Systems-------------------------------------------#
#   CentOS 7, Debian family, OSX (Macports/Homebrew)          #
#	Tested on: CentOS 7, Ubuntu 16.04 LTS                     #
#-License-----------------------------------------------------#
#   MIT License ~ http://opensource.org/licenses/MIT          #
#-Notes-------------------------------------------------------#
#   Start this script from an active virtualenv.              #
#-------------------------------------------------------------#

# Pretty colors because why not
RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
BOLD="\033[01;01m"
RESET="\033[00m"

function deploy {
		printf "${YELLOW}[?]${RESET} ${BOLD}Please enter the name of this canary:${RESET} "

		read canary

		pip install opencanary

		printf "${BLUE}[*]${RESET} ${BOLD}Installation complete. Generating config and applying SPACE MAGIC!${RESET} \n"

		# Sed in-place the generated config template to name the canary
		# Also seds in-place 9 lines of malformed hpfeeds irrelevance explored further at
		# https://github.com/thinkst/opencanary/issues/9
		opencanaryd --copyconfig && sed -i 's/opencanary-1/'$canary'/' ~/.opencanary.conf && sed -i 58,66d ~/.opencanary.conf

		printf "${GREEN}[!]${RESET} ${BOLD}Starting opencanaryd. (Stop with opencanaryd --stop) ${RESET} \n"

		opencanaryd --start

		exit 1
}

# Select host OS
PS3='Select your host OS (1-5): '
ospick=("CentOS" "Ubuntu" "OSX (Macports)" "OSX (Homebrew)" "GTFO")
select gibs in "${ospick[@]}"
do
	case $gibs in
		"CentOS")
			printf "${BOLD}You have chosen CentOS. Installing... \n${RESET}"
			deploy
			;;
		"Ubuntu")
			printf "${BOLD}You have chosen Debian/Ubuntu. Installing dependencies... \n${RESET}"
			sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
			deploy
			;;
		"OSX (Macports)")
			printf "${BOLD}You have chosen OSX (Macports). Installing dependencies... \n${RESET}"
			sudo port install openssl
			env ARCHFLAGS="-arch x86_64" LDFLAGS="-L/opt/local/lib" CFLAGS="-I/opt/local/include" pip install cryptography
			deploy
			;;
		"OSX (Homebrew)")
			printf "${BOLD}You have chosen OSX (Homebrew). Installing dependencies... \n${RESET}"
			brew install openssl
			env ARCHFLAGS="-arch x86_64" LDFLAGS="-L/usr/local/opt/openssl/lib" CFLAGS="-I/usr/local/opt/openssl/include" pip install cryptography
			deploy
			;;
		"GTFO")
			printf "${BOLD}Exiting. \n${RESET}"
			exit 1
			;;
		*)
			printf "${BOLD} Please enter a number between 1 and 5. \n${RESET}"
			exit 1
			;;
	esac
done