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
verbose=1	# 1=verbosing mode (log things to stdout)
author="lapingenieur"	# list of authors

# The following variables are some kind of constants (which actually don't exist in bash)
# They are only used to simplify editing
slogan="friendly interface for man"
utils_slogan="utilities for mancho.sh"

### Mancho.sh Utility Functions ###

log(){
# log - log errors to $config-dir/mancho.sh/logs
# usage : log PRE MSG
#   PRE : infos about where comes the error and its type (PRE means Pre-message)
#     `=> by ex. 'utils.vecho/warn' : warning in mancho-utils in function vecho
#     `=> types can be anything, but should be warn (warning), err (error, continues), cri (critical error but continues), fatal (like cri but exits)
#   MSG : the message to give/log
# example : 'log "utils.utils_quickhelp/err" "wrong qhelp vers ('1.3', old)"'
#   `=> outputs (by ex.) 'log: 10d03m2021@12:10:44 v2.0/utils.utils_quickhelp/err : wrong qhelp vers ('1.3', old)'
	echo "log: $(date "+%dd%mm%Y@%H:%M:%S") v$vers/$1 : $2"
}

vecho(){
# vecho - verbosing echo
# print only if $verbose == 1
# usage : vecho EOPT PRINT
#   EOPT : wether PRINT contains escapes (add -e or not), boolean value (1 = use -e, 0 = don't use -e)
#   PRINT : string to print out
	if test "$verbose" = 1
	then
		if test "$1" = "1"
		then
			echo -e "verb: $2"
		elif test "$1" = "0"
		then
			echo "verb: $2"
		else
			log "utils.vecho/warn" "wrong arg 1 ('$1') => not verbosing"
		fi
	fi
}

version(){
# version - print mancho*.sh's version
# usage : version DIST
#   DIST : choose which slogan to print ( >> 1=mancho.sh ; 2=mancho-dmenu.sh ; 3=mancho-utils.sh << )
#     `=> NOTE : prints if finds the character in $1 (31 = print mancho.sh and mancho-utils.sh ; 231 = print all ; 2 = print only mancho-dmenu.sh)
	echo "$1" | grep "1" -q && echo -e "mancho.sh - $slogan"
	echo "$1" | grep "2" -q && echo -e "mancho-dmenu.sh - $slogan (dmenu distribution)"
	echo "$1" | grep "3" -q && echo -e "mancho-utils.sh - $utils_slogan"
	echo "version : v$vers"
}

utils_quickhelp(){
	uqh_vers=2.0
	version 3
	vech
}

vecho "0" "wrong try"
