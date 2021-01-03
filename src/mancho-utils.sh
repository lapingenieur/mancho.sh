#!/bin/bash
# 
# mancho-utils.sh - utilities for mancho.sh (<=)
# mancho.sh - friendly interface for man
# 
# This file contains "utilities" for the different mancho.sh distributions (fzf, dmenu, etc)
# 
# version 2.0
# made by lapingenieur _
# posted over github.com/lapingenieur/mancho.sh

### Default Variable Settings ###
# Do not change values here but in the config file (see help over the github page)

vers=2.0	# current version
verbose=0	# 1=verbosing mode (log things to stdout)
author="lapingenieur"	# list of authors

# The following variables are some kind of constants (which actually don't exist in bash)
# They are only used to simplify editing
slogan="friendly interface for man"
utils_slogan="utilities for mancho.sh"

### Mancho.sh Utility Functions ###

version(){
# version - print mancho*.sh's version
# usage : version DIST
#   DIST : choose which slogan to print (1=mancho.sh ; 2=mancho-dmenu.sh ; 3=mancho-utils.sh)
#     `=> NOTE : prints if finds the character in $1 (31 = print mancho.sh and mancho-utils.sh ; 231 = print all ; 2 = print only mancho-dmenu.sh)
	echo "$1" | grep "1" -q && echo -e "mancho.sh - $slogan"
	echo "$1" | grep "2" -q && echo -e "mancho-dmenu.sh - $slogan (dmenu distribution)"
	echo "$1" | grep "3" -q && echo -e "mancho-utils.sh - $utils_slogan"
	echo "version : v$vers"
}

utils_quickhelp(){
}
