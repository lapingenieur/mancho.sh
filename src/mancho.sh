#!/bin/sh
# 
# mancho.sh - friendly interface for man

vers=1.2.2	# mancho.sh's version
synced=0	# do not syncronize 2 times
desc=0		# if found --desc parameter in $1 (ONLY $1), then use description mode

################################
#   HERE : Variable settings   #
################################

verbose=1	# if set to 1, will talk a little bit more ;;			values : 1 = verbose		;	2 = don't verbose	;	default = 1
fzf_height=75	# default fzf height (in percent WITHOUT the percent) ;;	values : between 0 and 100					;	default = 75
		# set a customized manpager (optional) ;;			values : a command which can display the manual page		;	default = [commented]
#export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

		# This next variable defines fzf's format. Don't touch this variable unless you don't really know what you're doing
		#   (or unless you follow the indications from my github page :D).
		# values : default ="--height=50% --border --layout=reverse --prompt='Manual: ' --preview='echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null'"
export FZF_DEFAULT_OPTS="--height=50% --border --layout=reverse --prompt='Manual: ' --preview='echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null'"

################################
#   END OF variable settings   #
################################

##### functions define

sync(){
	echo -n "[1/2] Creating today's standard cache file..."
	echo ":: $(date '+%dd%mm%yy')\n(0)    quit\n$(apropos -s ${SECTION:-''} ${@:-.} | grep -v -E '^.+ \(0\)' | awk '{print $2 "    " $1}' | sed "s/ ([1-9])//g" | sort)" > ~/.config/mancho.sh/list
	echo " Done."
	echo -n "[2/2] Creating today's expanded cache file..."
	echo ":: $(date '+%dd%mm%yy')\n(0)    quit\n$(apropos -s ${SECTION:-''} ${@:-.} | grep -v -E '^.+ \(0\)' | awk '{print $2 "    " $0}' | sed "s/ ([1-9])//g" | sort)" > ~/.config/mancho.sh/list.desc
	echo " Done."
	synced=1
}

version(){
	echo "mancho.sh : friendly interface for man\nmancho.sh script's version : $vers"
}

help(){
	less << EOF
	                                             /\$\$                             \$\$\\
	                                            | \$\$                             \$\$ |
	 /\$\$\$\$\$\$/\$\$\$\$   /\$\$\$\$\$\$  /\$\$\$\$\$\$\$   /\$\$\$\$\$\$\$| \$\$\$\$\$\$\$   /\$\$\$\$\$\$     \$\$\$\$\$\$\$\\ \$\$\$\$\$\$\$\\
	| \$\$_  \$\$_  \$\$ |____  \$\$| \$\$__  \$\$ /\$\$_____/| \$\$__  \$\$ /\$\$__  \$\$   \$\$  _____|\$\$  __\$\$\\
	| \$\$ \\ \$\$ \\ \$\$  /\$\$\$\$\$\$\$| \$\$  \\ \$\$| \$\$      | \$\$  \\ \$\$| \$\$  \\ \$\$   \\\$\$\$\$\$\$\\  \$\$ |  \$\$ |
	| \$\$ | \$\$ | \$\$ /\$\$__  \$\$| \$\$  | \$\$| \$\$      | \$\$  | \$\$| \$\$  | \$\$    \\____\$\$\\ \$\$ |  \$\$ |
	| \$\$ | \$\$ | \$\$|  \$\$\$\$\$\$\$| \$\$  | \$\$|  \$\$\$\$\$\$\$| \$\$  | \$\$|  \$\$\$\$\$\$/\$\$\\\$\$\$\$\$\$\$  |\$\$ |  \$\$ |
	|__/ |__/ |__/ \\_______/|__/  |__/ \\_______/|__/  |__/ \\______/ \\_,\\_______/ \\__|  \\__|

                                        mancho.sh - friendly interface for man   v$vers

USAGE :

	mancho.sh [--desc] [OPTION]
	mancho.sh --mancho OPTION...
	mancho.sh MAN_OPTIONS...
	mancho.sh -- MAN_OPTIONS...

DESCRIPTION :

   Mancho.sh is a friendly interface for man. If you call it without any option (or just with "--desc"), mancho.sh will update its command
   list (if needed) and pull up a fzf (fuzzy finder) research. You'll just need to enter the name or the description of the command you're
   asking for and mancho.sh will open its manual page.

   I recommend you to alias \`man\` to \`mancho.sh\` (add this line to ~/.bashrc if you are using bash : alias man='mancho.sh')

   Mancho.sh has some builtin options (like the one you are using to print this help page). If mancho.sh gets an option it doesn't know, it
   gives it to man, like \`mancho.sh --usage\` is gonna execute \`man --usage\`.

      IMPORTANT :
   
   Note that if the first argument (or the one after --desc) is not recognized, mancho.sh will give EVERY arguments to man in the SAME com-
   mand, whereas if it gets a known option for \$1, it will execute EVERY man options but only ONE a time. That's why there's a -- argument
   which tells mancho.sh that all the following arguments are to be given to man. Ex:

   mancho.sh --help getcpu 2
     => this will print mancho.sh's help page, try to open getcpu's manual page (without the 2), and try to open 2's manual page

   mancho.sh --help -- getcpu 2
     => this will print mancho.sh's help page, and open getcpu (2)'s manual page.

OPTIONS :

   --sync
      SYNCronization, syncronize the list files (more infos : part FILE)

   --desc
      DESCription, activate description mode : if no more arguments, will do a fzf search within the description of each command.
      Not really useful unless you search for a description and not for a command name.

   -h, --help (and -help)
      Print this help page (mancho.sh's help page)

   -q, --quick, --quick-help
      Print a quick help (mancho.sh's quick help page)

   -H, --man-help
      Print man's help page (pass "-h" options to man)

   --
      Give all the following arguments to man

FILES :

   Mancho.sh uses two files which he creates they don't exist :
   
      ~/.config/mancho.sh/list
         list of the installed manual pages (command names)

      ~/.config/mancho.sh/list.desc
         list of the installed manual pages (command names) followed by a short description

   These two files are updated automaticaly every day or if mancho.sh receives "--sync".

FAQ :

   Q: Why are there files for the lists, can't just make the list at each run ?
   A: These lists can be very long (several hundreds of lines) and it takes a bit of time to make them. It is more efficient to create a
        daily list and output it into a file than wait before using mancho.sh everytimes.
EOF
}

quickhelp(){
	echo "TODO : quick-help"
}

########## DEFINE YOUR STUFF HERE
# If you wanna have some personalized stuff, write it below. Take the following lines as an example.

	### if there is 256 color mode support, declare an env variable called TERM_COLOR which I use in my vim config
#if test "$TERM"
#then
#	case "$TERM" in
#		xterm-color | *-256color ) export TERM_COLOR=1 ;;
#		* ) export TERM_COLOR=0 ;;
#	esac
#else
#	export TERM="linux" TERM_COLOR=0
#fi

##### Main Prog

if echo "$1" | grep -w "\-\-desc" >> /dev/null
then
	test $verbose = 1 && echo "\033[0;32mINFO: using description mode\033[0m"
	desc=1
	shift
fi

if test "$*"		## arguments decoding
then
	case "$1" in			## if argument recognized :
		"--sync" | "-h" | "--help" | "-help" | "-q" | "--quick" | "--quick-help" | "-H" | "--man-help" | "--" )
			until test $# = 0 || test "$ok" = 1
			do
				case $1 in
					"--sync" ) version ; echo "" ; sync ;;
					"-h" | "--help" | "-help" ) help ;;
					"-q" | "--quick" | "--quick-help" ) quickhelp ;;
					"-H" | "--man-help" ) man -h ;;
					"--" ) shift ; man $* ; ok=1 ;;
					* ) man $1 ;;
				esac
				shift
			done ;;		## if argument is not recognized, pass them all to man
		* ) man $* ;;
	esac
else			## list file making
	test -d ~/.config/mancho.sh/ || mkdir -p ~/.config/mancho.sh/

	if ! test -f ~/.config/mancho.sh/list
	then
		touch ~/.config/mancho.sh/list
		test $synced = 0 && sync
	fi
	if ! test -f ~/.config/mancho.sh/list.desc
	then
		touch ~/.config/mancho.sh/list.desc
		test $synced = 0 && sync
	fi

	if test "`head -n1 ~/.config/mancho.sh/list`" != ":: `date '+%dd%mm%yy'`" || test "`head -n1 ~/.config/mancho.sh/list.desc`" != ":: `date '+%dd%mm%yy'`"
	then
		test $synced = 0 && sync
	fi
			## mancho.sh's real face
	while getopts ":s:" opt; do
	    case $opt in
	        s ) SECTION=$OPTARG; shift; shift;;
	        \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
	        : ) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
	    esac
	done

	case "$desc" in
		"0" ) list=`grep -vE "^:: " ~/.config/mancho.sh/list` ;;
		"1" ) list=`grep -vE "^:: " ~/.config/mancho.sh/list.desc` ;;
		* ) echo "\033[0;31;1mERR (critical): unknown description value [\$desc='$desc'].\n\033[0;33;1m  Which method to use ?0 ) standart, 1 ) description, q ) exit\033[0;36;1m"
			read -p "=> " awnser
			echo -n "\033[0m"
			case "$awnser" in
				"0" ) list=`grep -vE "^:: " ~/.config/mancho.sh/list` ;;
				"1" ) list=`grep -vE "^:: " ~/.config/mancho.sh/list.desc` ;;
				"q" | "Q" | "quit" | "Quit" | "2" ) exit 0 ;;
				* ) echo "Did not understand '$awnser', exiting..." ; exit 1 ;;
			esac
			;;
	esac
	manual=$(echo "$list" | fzf | sed -E 's/^\((.+)\)/\1/' | sed "s/ - .*$//g")

	case $manual in
		"" | "0"*"quit" ) echo "" ; exit 0 ;;
		* ) man $manual ;;
	esac
fi
