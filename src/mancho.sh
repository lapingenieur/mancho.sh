#!/bin/sh
# 
# mancho.sh - friendly interface for man

###### Variables Default Settings

# do not change variable values here, but in the config file (use 'mancho.sh --mk-config')

vers=1.2.8	# mancho.sh's version
synced=0	# do not syncronize 2 times
desc=0		# if found --desc parameter in $1 (ONLY $1), then use description mode
verbose=1	# if set to 1, will talk a little bit more
fzf_height=75	# default fzf height (in percent)
		# below : default fzf options
export FZF_DEFAULT_OPTS="--height=50% --border --layout=reverse --prompt='Manual: ' --preview='echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null'"

if test -f ~/.config/mancho.sh/config.sh
then
	grep -qE "^( |\t)*verbose=[01]( |\t|$)" ~/.config/mancho.sh/config.sh && verbose=$(grep -oE "^( |\t)*verbose=[01]" ~/.config/mancho.sh/config.sh | grep -E "=." | grep -oE ".$")
fi

##### functions define

sync(){
	echo -n "[1/3] Searching for updates..."
	upd_vers="$(curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/version | head -n 1)"
	if test "$upd_vers" = "$vers"
	then
		echo "Done : Already up to date."
	else
		echo "Done."
		echo "\033[0;36;1mThere is an available update \033[1;34;1m(Update version : v$(curl -s https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/version) ; Current version : v$vers).\033[0m"
	fi
	echo -n "[2/3] Creating today's standard cache file..."
	echo ":: $(date '+%dd%mm%yy')\n(0)    quit\n$(apropos -s ${SECTION:-''} ${@:-.} | grep -v -E '^.+ \(0\)' | awk '{print $2 "    " $1}' | sed "s/ ([1-9])//g" | sort)" > ~/.config/mancho.sh/list
	echo " Done."
	echo -n "[3/3] Creating today's expanded cache file..."
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

	mancho.sh [OPTION] [MAN_PAGE]
	mancho.sh MAN_OPTION...
	mancho.sh -- MAN_OPTION...

IMPORTANT NOTE:

   Some people think the 'man' pages/program are a reference to 'boys', 'male gender', and they define it as 'racism' and 'sexism'.

   This program, and in particular this long help page, uses frequently the word 'man' as a reference to the 'man' software or as a shorter
   word for 'manual' when talking about 'manual pages' (this becomes 'man pages').

   It is in NO CASE RACISM or SEXISM. These are just ACTUAL SOFTWARE NAMES and very used DIMINUTIVES.

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
      SYNCronization, syncronize the list files (more infos : part FILE) and search for updates

   --desc
      DESCription, activate description mode : if no more arguments, will do a fzf search within the description of each command.
      Not really useful unless you search for a description and not for a command name.

   -h, --help, -help, -q, --quick, --quick-help
      Print a quick/short help page (mancho.sh's quick help page)

   -H, --long-help
      Print this (long) help page (mancho.sh's long help page)
      NOTE: this is actually what would be mancho'sh manual page

   --man-help
      Print man's help page (pass "-h" options to man)

   --mk-config
      Print a configuration example to the config file.
      (the generated text is in fact just comments)

   --
      Give all the following arguments to man

FILES :

   Mancho.sh uses two files which he creates they don't exist :
   
      ~/.config/mancho.sh/list
         list of the installed manual pages (command names)

      ~/.config/mancho.sh/list.desc
         list of the installed manual pages (command names) followed by a short description

   These two files are updated automaticaly every day or if mancho.sh receives "--sync".

      ~/.config/mancho.sh/config.sh
         configuration file written in bash scripting. It is executed before the main part but after the first variable settings.
	 NOTE: this file is actually executed, so you can do whatever you want with this config file.

FAQ :

   Q: Why are there files for the lists, can't just make the list at each run ?
   A: These lists can be very long (several hundreds of lines) and it takes a bit of time to make them. It is more efficient to create a
        daily list and output it into a file than wait before using mancho.sh everytimes.

   Q: mancho.sh tells me I need to update, but HOW can I exactly ?
   A: Well, for now you would just reinstall it by hand following these steps ( >>> an updating function will probably come !! <<< ) :

       FIRST METHOD : if you still have the directory where yo udownloaded the first time

          - go to the directory where you downloaded all the stuff
	  - type 'git pull' in your shell
	  - execute these commands at a shell :

	      cp /tmp/mancho.sh.tmp ~/.local/bin/mancho.sh
	      chmod 755 ~/.local/bin/mancho.sh

       SECOND METHOD : if you deleted the directory where yo udownloaded the first time

	  - remove the old executable mancho.sh file
	    (how to find it ? execute 'which mancho.sh' and you''l get its location)
	  - execute these commands at a shell :

	      curl https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/src/mancho.sh > /tmp/mancho.sh.tmp
	      cp /tmp/mancho.sh.tmp ~/.local/bin/mancho.sh
	      chmod 755 ~/.local/bin/mancho.sh

ABOUT :

   mancho.sh - friendly interface for man
   version : $vers
   program and help pages written by : lapingenieur
   github repo : https://github.com/lapingenieur/mancho.sh

SEE ALSO :

   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh			(where comes the idea)
   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho-gui.sh			(where comes the idea, but using dmenu instead of fzf)
EOF
}

quickhelp(){
	version
	echo "\n================================\n"
	cat << EOF
USAGE :
   mancho.sh [--desc] [OPTION]... [-- MAN_OPTION...]
   mancho.sh MAN_OPTION...

OPTIONS :
   --sync			syncronize lists and search for updates
   --desc			use description mode
   -h, --help, -q, --quick	print short help page (this one)
   -H, --long-help		print long help page
   --man-help			print man's help
   --mk-config			generate an example configuration file
   --				give following arguments to man

More infos : mancho.sh --long-help
EOF
}

mkconfig(){
	if test -s ~/.config/mancho.sh/config.sh
	then
		echo -n "\033[0;31;1mThere is already a config file. \033[0;32m(your old configuration will be saved)\033[0m Overwrite ? (y/n) : "
		read awnser
		test "$awnser" != "y" && test "$awnser" != "yes" && exit
		mv ~/.config/mancho.sh/config.sh /tmp/mancho.sh.config.save.$$
		echo "\033[0;36mSaved your old config file in /tmp/mancho.sh.config.save.$$\033[0m"
	fi
	test $verbose = 1 && echo -n "Creating ~/.config/mancho.sh if didn't exist"
	mkdir -p ~/.config/mancho.sh/
	test $verbose = 1 && echo " and redirecting the default configuration to the wanted file..."
	cat > ~/.config/mancho.sh/config.sh << EOF
# List of the internal variables you may want to change :
# NAME :		DESCRIPTION :
# verbose		verbosing option
# desc			1 = use always description mode
# fzf_height		fzf's height
# fzf_options		fzf settings, merged into FZF_DEFAULT if set
#
# List of the environment variables you may want to change :
#    Note : you need to define these variables using the 'export' command (see your shell's manual)
# NAME :		DESCRIPTION :
# FZF_DEFAULT_OPTS	fzf settings (prefer using the fzf_options internal variable)
# MANPAGER		wanted program or script to print the manual page

EOF
	echo "All done. (configuration file path : ~/.config/mancho.sh/config.sh)"
	echo "You should modify it instead of changing the main-code file."
}

##### Include Shell Config file

test -f ~/.config/mancho.sh/config.sh && . ~/.config/mancho.sh/config.sh
fzf_height=$(echo "$fzf_height" | sed "s/%$//g") # corrects fzf_height if ends with %
test "$fzf_options" && export FZF_DEFAULT_OPTS="$fzf_options"

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
		"--sync" | "-h" | "--help" | "-help" | "-q" | "--quick" | "--quick-help" | "-H" | "--long-help" | "--man-help" | "--" | "--mk-config" )
			until test $# = 0 || test "$ok" = 1
			do
				case $1 in
					"--sync" ) version ; echo "" ; sync ;;
					"-h" | "--help" | "-help" | "-q" | "--quick" | "--quick-help" ) quickhelp ;;
					"-H" | "--long-help" ) help ;;
					"--man-help" ) man -h ;;
					"--mk-config" ) mkconfig ;;
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
		* ) echo "\033[0;33;1mERR: unknown description value [\$desc='$desc'].\n\033[0;33;1m  Which method to use ? 0 ) standart, 1 ) description, q ) exit\033[0;36;1m"
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
echo ""
