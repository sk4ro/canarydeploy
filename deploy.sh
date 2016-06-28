#!/bin/bash
#-Metadata----------------------------------------------------#
#  Filename: deploy.sh             (Update: 2016-06-28)       #
#-Info--------------------------------------------------------#
#  Linux auto-deploy script for opencanaryd                   #
#  (https://github.com/thinkst/opencanary)                    #
#-Author(s)---------------------------------------------------#
#  sk4ro - https://twitter.com/AnarchistDalek                 #
#  Some features appropriated from g0tmi1k's os-scripts       #
#  (https://github.com/g0tmi1k/os-scripts)                    #
#-Operating System--------------------------------------------#
#  Designed for: CentOS 7.0 (VM - Virtualbox)                 #
#  Tested on: CentOS 7.0 VM, XUbuntu 16.04 VM                 #
#  PLACEHOLDER FOR OTHER OS FUNCTIONALITY                     #
#  PLACEHOLDER FOR OTHER OS FUNCTIONALITY                     #
#-License-----------------------------------------------------#
#  MIT License ~ http://opensource.org/licenses/MIT           #
#-Notes-------------------------------------------------------#
#                                                             #
#   For great justice, start this script from a virtualenv.   #
#                                                             #
#-------------------------------------------------------------#

##### Pretty colors because why not
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal
#####

# Command to confirm installation, in case user wishes to exit gracefully
confirm () {
		echo -e " ${YELLOW}[?]${RESET} ${BOLD}Do you wish to continue? [y/N]${RESET}"
		read response
		case $response in
			[yY][eE][sS]|[yY])
				true
				;;
		*)
				false
				exit 1
				;;
		esac		
}

# Select host OS
PS3='Select your host OS (1-5): '
ospick=("CentOS" "Ubuntu" "OSX (Macports)" "OSX (Homebrew)" "GTFO")
select gibs in "${ospick[@]}"
do
	case $gibs in
		"1")
			echo "You have chosen CentOS. Installing... "
			;;
		"2")
			echo "You have chosen Debian/Ubuntu. Installing dependencies... "
			sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
			;;
		"3")
			echo "You have chosen OSX (Macports). Installing dependencies... "
			sudo port install openssl
			env ARCHFLAGS="-arch x86_64" LDFLAGS="-L/opt/local/lib" CFLAGS="-I/opt/local/include" pip install cryptography
			;;
		"4")
			echo "You have chosen OSX (Homebrew). Installing dependencies..."
			brew install openssl
			env ARCHFLAGS="-arch x86_64" LDFLAGS="-L/usr/local/opt/openssl/lib" CFLAGS="-I/usr/local/opt/openssl/include" pip install cryptography
			;;
		"5")
			echo "Exiting."
			break
			;;
		"")
			echo "Please enter the number of your menu choice [1-5]"
		*)
			echo "Please enter the number of your menu choice [1-5]"
			exit 1
			;;
	esac
done

echo -e " ${BLUE}[*]${RESET} ${BOLD}OpenCanary auto-deploy script${RESET}"

echo -e " ${YELLOW}[?]${RESET} ${BOLD}Please enter the name of this canary:${RESET}"

read canary

pip install opencanary > /dev/null 2>&1 # Install opencanary via pip, suppressing installer output

echo -e " ${BLUE}[*]${RESET} ${BOLD}Installation complete. Generating config and applying SPACE MAGIC!${RESET}"

# Generate config while suppressing output, replace default canary name with user input, remove hpfeeds stuff
# Sed in-place the generated config template to name the canary
# Also seds in-place 9 lines of malformed hpfeeds irrelevance explored further at 
# https://github.com/thinkst/opencanary/issues/9
opencanaryd --copyconfig > /dev/null 2>&1 && sed -i 's/opencanary-1/'$canary'/' ~/.opencanary.conf && sed -i 58,66d ~/.opencanary.conf

echo -e " ${GREEN}[!]${RESET} ${BOLD}Stay safe out there. (Stop with opencanaryd --stop) ${RESET}"

opencanaryd --start