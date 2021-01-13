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

### NOTE ABOUT THE TIME/DATE FORMAT ###
# 
# Because the time formats aren't the same in each country, I decided to make it readable by anyone. It looks like this :
#   13d01m2021@10:41:27.338878621
# This means : on January 13th 2021 at 10 hour (in 24h format, not 12h) 41 minutes 27 seconds and 338878621 nanoseconds
# You can read it very simply : the value preceding the "d" is the "day", the one before "m" is the month and the 4 digit value is obviously the year.
# Then "@" means "end of date, now comes time" ; hour:minute:second ; the 9 digits after the dot "." are the nanoseconds
# Hope you understood !

### Default Variable Settings ###
# Do not change values here but in the config file (see help over the github page)

start_time="$(date "+%dd%mm%Y@%T.%N")"	# ~ time when executed, maybe needed for logs
vers=2.0	# current version
verbose=0	# 1=verbosing mode (log things to stdout)
author="lapingenieur"	# list of authors
repo="https://github.com/lapingenieur/mancho.sh"
repo_raw="https://raw.githubusercontent.com/lapingenieur/mancho.sh"
alrd_log=0	# = 0 if no logging during current execution, not = 0 if already logged in current execution

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
#     `=> types can be anything, but should be warn (warning), err (error, continues), cri (critical error but continues), fatal (like cri but exits).
#     `=> if an intern function cannot continue but the rest of the program will, add "-exit (<exit code>)" to the type (doesn't work with cri : utils must exit)
#   MSG : the message to give/log
# example : 'log "utils.utils_quickhelp/err" "wrong qhelp vers ('1.3', old)"'
#   `=> outputs (by ex.) 'log: 10d03m2021@12:10:44 v2.0/utils.utils_quickhelp/err : wrong qhelp vers ('1.3', old)'
	if test $alrd_log = 0
	then
		echo " === mancho-utils.sh v$vers pid=$$ start-date=$start_time ==="
		alrd_log=1
	fi
	echo "log: $(date "+%dd%mm%Y@%T.%N") v$vers/$1 : $2"
}

vecho(){
# vecho - verbosing echo . revision 2
# print only if $verbose == 1
# usage : vecho EOPT PRINT
#   EOPT : wether PRINT contains escapes (add -e or not) AND wether print "verb: " before PRINT
#     `=> 0 = no -e,  no verb
#     `=> 1 = use -e, no verb
#     `=> 2 = no -e,  print verb
#     `=> 3 = use -e, print verb
#   PRINT : string to print out
# rev 2 : added options to (not) print "verb"
	if test "$verbose" = 1
	then
		case "$1" in
			0) echo "$2" ;;
			1) echo -e "$2" ;;
			2) echo "verb: $2" ;;
			3) echo -e "verb: $2" ;;
			*) log "utils.vecho/err" "wrong arg 1 ('$1') => not verbosing" ;;
		esac
	fi
}

version(){
# version - print mancho*.sh's version
# usage : version DIST
#   DIST : choose which slogan to print ( >> 0=(nothing, print only version if no other) ; 1=mancho.sh ; 2=mancho-dmenu.sh ; 3=mancho-utils.sh << )
#     `=> NOTE : prints if finds the character in $1 (31 = print mancho.sh and mancho-utils.sh ; 231 = print all ; 2 = print only mancho-dmenu.sh)
	version_done=0
	echo "$1" | grep "1" -q && echo -e "mancho.sh - $slogan" && version_done=1
	echo "$1" | grep "2" -q && echo -e "mancho-dmenu.sh - $slogan (dmenu distribution)" && version_done=1
	echo "$1" | grep "3" -q && echo -e "mancho-utils.sh - $utils_slogan" && version_done=1
	echo "$1" | grep "0" -q && version_done=1
	if test $version_done = 0
	then
		log "utils.version/err" "wrong arg 1 : is void => printing only version"
	fi
	echo "version : v$vers"
}

utils_quickhelp(){
# utils_quickhelp - print the quick help (help's version = uqh_vers var)
	uqh_vers=2.0
	version 3
	vecho 0 "utils_quickhelp version : $uqh_vers"
	cat << EOF

================================

USAGE :
   mancho-utils COMMAND [COMMAND_OPTION]...
   mancho-utils OPTION...

COMMAND : inculded utility function to execute
NOTE : some are not so useful for users themselves (like log)
   update		manage mancho*.sh updates
   log			print out logs in a log file
   ping-repo		returns 0 if repository is reachable
COMMAND_OPTION : options given to utility functions
OPTION : options given to mancho-utils.sh
   --version, -v	print the current version
   --verbose, -V	use verbosing mode
   --help, -h		print this short help page
   --long, -l		open mancho-utils.sh's manual page
   --exec ARG...	execute the following commands internally

More infos in the manual page
EOF
}

ping-repo(){
# ping-repo - test if mancho.sh's repo is reachable
# usage : ping-repo [n|no-echo]
# n, no-echo : no output (silent mode, only prints verboses if active)
	no=0
	ping_repo="repo"
	ping_timeout=10	# max time in seconds
	case "$1" in
		"n" | "no-echo" ) no=1 ;;
		"r" | "raw" ) ping_repo="raw" ;;
		"" ) true ;;
		* ) log "utils.ping-repo/err" "wrong arg 1 ('$1') => skipping arg 1" ;;
	esac
	case "$ping_repo" in
		"repo" )
			if curl -Is -m $ping_timeout $repo > /dev/null	# '-m .' means max . seconds
			then
				test $no = 0 && echo "fetched the repo"
				unset no
				return 0
			else
				test $no = 0 && echo "repo is not reachable"
				unset no
				return 1
			fi ;;
		"raw" )
			if curl -Is -m $ping_timeout $repo_raw > /dev/null	# '-m .' means max . seconds
			then
				test $no = 0 && echo "fetched the raw repo"
				unset no
				return 0
			else
				test $no = 0 && echo "repo is not raw reachable"
				unset no
				return 1
			fi ;;
		* ) log "utils.ping-repo/err-exit (2)" "wrong \$ping_repo value '$ping_repo'"
			test $no = 0 && echo -e "\033[0;33merror : wrong address to check (logs $$)\033[0m"
			unset no
			return 3 ;;
	esac
}

update(){
# Updating function
# usage : update OPTION...
# options for OPTION :
#   s, search	search for available updates
#   n, no-echo	no output (silent mode, only prints verboses if active)
	no=0
	until test $# = 0
	do
		case "$1" in
			"n" | "no-echo" ) no=1 ;;
			"s" | "search" )
				vecho 0 "update : testing repo connection..."
				if ping-repo n
				then
					vecho 0 "update : reached the repo"
					upd_vers="$(curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/version | head -n 1)"
					vecho 0 "update : online version is $upd_vers"
					vecho 0 "update : installed version is $vers"
					if test "$upd_vers" = "$vers"
					then
						echo -e "\033[0;32mupdate : already up-to-date (version $vers)\033[0m"
					else
						echo -e "\033[0;32mupdate : there's an update !\033[0m"
						echo -e "\033[0;32mupdate : current version : v$vers, up-to-date version : v$upd_vers\033[0m"
					fi
				else
					echo -e "\033[0;33;1mERR : Update/search : repo is not reachable\033[0m"
				fi
				;;
			"i" | "install" | "" ) true ;;
			* ) log "utils.update/err" "wrong arg 1 ('$1') => skipping arg 1" ;;
		esac
		shift
	done
	unset no
	echo "update : done"
}

### mancho-utils.sh arguments detection/decoding ###

if test $# -gt 0
then
##### first argument detection : global settings (like verbosing mode)
	arg=0	# not shifting there, arg will be deleted
	until test $arg -eq $#
	do
		arg=$((arg+1))
		case "$(eval "echo \$$arg")" in
			"--verbose" | "-V" ) verbose=1 ;;
		esac
	done
	unset arg
##### second argument detection : running actions
	until test $# = 0
	do	# I don't like using single dashed long styled options like '-help' but I still put -help and -version for those who want it that way
		case "$1" in
			"--verbose" | "-V" ) true ;;	# --verbose == true because it's detected above
			"-version" | "--version" | "--vers" | "-v" ) version 3 ;;
			"-help" | "--help" | "-h" ) utils_quickhelp ;;
			"--exec" ) shift
				$*
				shift $(($# - 1))	# shifting until 0 to skip every other argument
				;;
			"update" | "upd" | "u" )
				shift
				update $*
				shift $(($# - 1));;
			* ) echo "This argument is unknown : '$1'" ;;
		esac
		test $# != 0 && shift
	done
else
	version 3
	echo -e "\nmancho-utils.sh must receive at least one argument. Try out 'mancho-utils.sh --help'"
fi
