#!/bin/bash
#-Metadata----------------------------------------------------#
#  Filename: cnc.sh             (Update: 2016-06-28)          #
#-Info--------------------------------------------------------#
#  Linux auto-deploy script for opencanary-correlator         #
#  (https://github.com/thinkst/opencanary-correlator)         #
#-Author(s)---------------------------------------------------#
#  sk4ro - https://twitter.com/AnarchistDalek                 #
#  Some features appropriated from g0tmi1k's os-scripts       #
#  (https://github.com/g0tmi1k/os-scripts)                    #
#-Operating System--------------------------------------------#
#     Designed for: CentOS 7.0 (VM - Virtualbox)              #
#     Tested on: CentOS 7.0 VM, XUbuntu 16.04 VM              #
#     PLACEHOLDER FOR OTHER OS FUNCTIONALITY                  #
#     PLACEHOLDER FOR OTHER OS FUNCTIONALITY                  #
#-License-----------------------------------------------------#
#  MIT License ~ http://opensource.org/licenses/MIT           #
#-Notes-------------------------------------------------------#
#                                                             #
#        Start this script from an active virtualenv.         #
#                             ---                             #
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

