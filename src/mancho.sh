#!/bin/sh
# 
# mancho.sh - friendly interface for man

###### Variables Default Settings

# do not change variable values here, but in the config file (use 'mancho.sh --mk-config')

vers=1.6	# mancho.sh's version
synced=0	# do not syncronize 2 times
desc=0		# if found -d or --desc parameter in $1 (ONLY $1), then use description mode
verbose=0	# if set to 1, will talk a little bit more
fzf_height=75	# default fzf height (in percent)
		# below : default fzf options
export FZF_DEFAULT_OPTS="--height=50% --border --layout=reverse --prompt='Manual: ' --preview='echo {1} | sed -E \"s/^\((.+)\)/\1/\" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null'"

if test -f ~/.config/mancho.sh/config.sh
then
	grep -qE "^( |\t)*verbose=[01]( |\t|$)" ~/.config/mancho.sh/config.sh && verbose=$(grep -oE "^( |\t)*verbose=[01]" ~/.config/mancho.sh/config.sh | grep -E "=." | grep -oE ".$")
fi

##### functions define

sync(){
	echo -n "[1/3] "
	update --search
	echo -n "[2/3] Creating today's standard cache file..."
	echo ":: $(date '+%dd%mm%yy')\n(0)    quit\n$(apropos -s ${SECTION:-''} ${@:-.} | grep -v -E '^.+ \(0\)' | awk '{print $2 "    " $1}' | sed "s/ ([1-9])//g" | sort)" > ~/.config/mancho.sh/list
	echo " Done."
	echo -n "[3/3] Creating today's expanded cache file..."
	echo ":: $(date '+%dd%mm%yy')\n(0)    quit\n$(apropos -s ${SECTION:-''} ${@:-.} | grep -v -E '^.+ \(0\)' | awk '{print $2 "    " $0}' | sed "s/ ([1-9])//g" | sort)" > ~/.config/mancho.sh/list.desc
	echo " Done."
	synced=1
}

version(){
	echo "mancho.sh : friendly interface for man     <="
	echo "mancho-dmenu.sh : friendly graphical interface for man with dmenu\nversion : $vers"
}

help(){
	lh_vers=1.5
	less << EOF


	                                             /\$\$                             \$\$\\
	                                            | \$\$                             \$\$ |
	 /\$\$\$\$\$\$/\$\$\$\$   /\$\$\$\$\$\$  /\$\$\$\$\$\$\$   /\$\$\$\$\$\$\$| \$\$\$\$\$\$\$   /\$\$\$\$\$\$     \$\$\$\$\$\$\$\\ \$\$\$\$\$\$\$\\
	| \$\$_  \$\$_  \$\$ |____  \$\$| \$\$__  \$\$ /\$\$_____/| \$\$__  \$\$ /\$\$__  \$\$   \$\$  _____|\$\$  __\$\$\\
	| \$\$ \\ \$\$ \\ \$\$  /\$\$\$\$\$\$\$| \$\$  \\ \$\$| \$\$      | \$\$  \\ \$\$| \$\$  \\ \$\$   \\\$\$\$\$\$\$\\  \$\$ |  \$\$ |
	| \$\$ | \$\$ | \$\$ /\$\$__  \$\$| \$\$  | \$\$| \$\$      | \$\$  | \$\$| \$\$  | \$\$    \\____\$\$\\ \$\$ |  \$\$ |
	| \$\$ | \$\$ | \$\$|  \$\$\$\$\$\$\$| \$\$  | \$\$|  \$\$\$\$\$\$\$| \$\$  | \$\$|  \$\$\$\$\$\$/\$\$\\\$\$\$\$\$\$\$  |\$\$ |  \$\$ |
	|__/ |__/ |__/ \\_______/|__/  |__/ \\_______/|__/  |__/ \\______/ \\_,\\_______/ \\__|  \\__|

                                        mancho.sh - friendly interface for man   v$vers - long help version $lh_vers


USAGE :

	mancho.sh [OPTION] [MAN_PAGE]
	mancho.sh MAN_OPTION...
	mancho.sh -- MAN_OPTION...

IMPORTANT NOTE:

   Some people think the 'man' pages/program are a reference to 'male gender', 'boys', and they define it as 'racism' and 'sexism'.
   They also can think the word 'master' (for the 'master' branch) is a hierarchical ideology or something about slavery.

   This program, and in particular help pages, uses frequently the word 'man' as a reference to the 'man' software or as a shorter word for 'manual' when talking about 'manual pages' (this becomes 'man pages').

   Plus, the program name is 'mancho.sh'. This could reflect the word 'macho' (which doesn't improve our case ...), but I got explainations !
   * First, 'mancho.sh' is highly inspired by a script called 'macho.sh' (source here : https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh)
   * Then, 'mancho' is a kind of play on words :
     * *man*cho.sh relfects the original 'macho.sh' script _and_ the 'man' program
     * while *mancho*.sh tells about a french word, "manchot", which is kind of penguin (and linux's mascot is a penguin : https://en.wikipedia.org/wiki/Tux_(mascot) !)

   IT IS IN NO CASE RACISM OR SEXISM. THESE ARE JUST SOFTWARE NAMES AND DIMINUTIVES.

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

   -d, --desc
      DESCription, activate description mode : if no more arguments, will do a fzf search within the description of each command.
      Not really useful unless you search for a description and not for a command name.

   -h, --help, -help, -q, --quick, --quick-help
      Print a quick/short help page (mancho.sh's quick help page)

   -H, --long-help
      Print this (long) help page (mancho.sh's long help page)
      NOTE: this is actually what would be mancho'sh manual page

   --man-help
      Print man's help page (pass "-h" options to man)

   -v, --vers, --version
      Print th current version

   --mk-config
      Print a configuration example to the config file.
      (the generated text is in fact just comments)

   --upd, --update
      Update mancho.sh. In fact, download the source code and tell the user what to do with.

   --upd-f, --update-force
      Update mancho.sh EVEN if already up to date.

   --upd-l, --upd-log, --update-log
      Print current version and latest version (if newer than current) change logs

   --upd-s, --update-search
      Search for updates

   --
      Give all the following arguments to man (every arguments are given to man in the SAME command)

   ++
      Give all the following arguments to man (the arguments are given ONE at a time to man)

  NOTE: mancho.sh does not look at the arguments that follow '--' and '++', even if there's '--' or '++'.

   -V, --verbose
      Use verbosing mode.

   -s, --silent
      Unuse verbosing mode.

  NOTE: verbosing mode can change during  executing : 'mancho.sh -V --sync -s --sync' will syncronize two time, but will print different outputs.

FILES :

   Mancho.sh uses frequently two files which it creates if they don't exist :
   
      ~/.config/mancho.sh/list
         list of the installed manual pages (command names)

      ~/.config/mancho.sh/list.desc
         list of the installed manual pages (command names) followed by a short description

   The above two files are updated automaticaly every day or if mancho.sh receives "--sync".

      ~/.config/mancho.sh/config.sh
         configuration file written in bash scripting. It is executed before the main part but after the first variable settings.
	 NOTE: this file is actually executed, so you can do whatever you want with this config file.

FAQ :

   Q: Why are there files for the lists, can't just make the list at each run ?
   A: These lists can be very long (several hundreds of lines) and it takes a bit of time to make them. It is more efficient to create a
        daily list and output it into a file than wait before using mancho.sh everytimes.

   Q: mancho.sh tells me I need to update, but HOW can I exactly ?
   A: If you use mancho.sh 'v1.3.0' or newer, there is a parameter which downloads the code and tells exactly what to do with it.
        Just use : 'macho.sh --update'

ABOUT :

   mancho.sh - friendly interface for man
   macho.sh's version : $vers
   this help page's version : $lh_vers
   program and help pages written by : lapingenieur
   github repo : https://github.com/lapingenieur/mancho.sh
   inspired by DistroTube (Derek Taylor)

SEE ALSO :

   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh			(where comes the idea)
   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho-gui.sh			(where comes the idea)
   https://github.com/junegunn/fzf						(from where comes fzf, the fuzzy finder)
   https://suckless.org/dmenu							(from where comes dmenu, but using fzf instead of dmenu, TUI)
EOF
}

quickhelp(){
	qh_vers=1.5
	version
	echo "quick help page version : $qh_vers"
	echo "\n================================\n"
	cat << EOF
USAGE :
   mancho.sh [-d|--desc] [OPTION]... [-- MAN_OPTION...]
   mancho.sh MAN_OPTION...

OPTIONS :
   --sync			syncronize lists and search for updates
   -d, --desc			use description mode
   -h, --help, -q, --quick	print short help page (this one)
   -H, --long-help		print long help page
   --man-help			print man's help
   -v, --vers, --version	print the current version
   --mk-config			generate an example configuration file
   --upd, --update		update mancho.sh
   --upd-f, --update-force	update even if already latest version
   --upd-l, --update-log	show current and latest version change logs
   --upd-s, --update-search	search for updates
   --				give following arguments to man (in one command)
   ++				give following arguments to man (one at a time)
   -V, --verbose		use verbosing mode
   -s, --silent			unuse verbosing mode

More infos and credits : mancho.sh --long-help
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
# fzf_height		fzf's height						### mancho.sh
# fzf_options		fzf settings, merged into FZF_DEFAULT if set		### mancho.sh
# dmenu_opt		default options for dmenu				### mancho-dmenu.sh
# dmenu_cmd		a custom command to execute dmenu, like dmenu_run is	### mancho-dmenu.sh
# 
# PLEASE NOTE THAT the options you'll be able to add to dmenu DEPEND ON YOUR DMENU BUILD
#   Mancho-dmenu.sh expects you by default to have no patch installed, the script comes with basic options.
#   You can of course modify them as you want to improve its usage.
#
# List of the environment variables you may want to change :
#    Note : you need to define these variables using the 'export' command (see your shell's manual)
# NAME :		DESCRIPTION :
# FZF_DEFAULT_OPTS	fzf settings (prefer using the fzf_options internal variable)
# MANPAGER		wanted program or script to print the manual page
#
# More infos in the online docs :
#    https://github.com/lapingenieur/mancho.sh/blob/master/docs/config.md                configuration help
#    https://github.com/lapingenieur/mancho.sh/blob/master/docs/README.md                help index
EOF
	echo "All done. (configuration file path : ~/.config/mancho.sh/config.sh)"
	echo "You should modify it instead of changing the main-code file."
}

update(){
# update() arguments :
# --force : force an update
# --log : print the change-logs
# --search : search for update, used by sync() and --upd-s
#   if --search, then ($2 = "main") means called by --upd-s option
#   in same case, ($2 = "") means not called by --upd-s option, surely from sync()
	test "$1" = "--search" && echo -n "Searching for updates... "

	if test "$verbose" = "1"
	then
		test "$1" = "--search" && echo ""
		echo -n "> \033[0;32mTesting if the repo is reachable... "
	fi

	if ping -c 2 -W 1,5 -i 0,2 raw.githubusercontent.com >> /dev/null 2>&1
	then
		if test "$verbose" = "1"
		then
			echo "\033[0mDone : \033[0;32mreached the repo.\033[0m"
		fi
		upd_vers="$(curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/version | head -n 1)"
	else
		if test "$verbose" = "1"
		then
			echo "\033[0mDone : \033[0;33;1mthe repo is unreachable.\033[0m"
		fi
		upd_vers="$vers"
	fi
	case "$1" in
		"--search" ) 
			if ping -c 2 -W 1,5 -i 0,2 raw.githubusercontent.com >> /dev/null 2>&1
			then
				if test "$upd_vers" = "$vers"
				then
					if test "$verbose" = "1"
					then
						echo -n "> "
					elif test "$2" = "main"
					then
						true
					else
						echo -n " "
					fi
					echo "Done : \033[0;32mAlready up to date.\033[0m"
				else
					if test "$verbose" = "1"
					then
						echo -n "> "
					elif test "$2" = "main"
					then
						true
					else
						echo -n " "
					fi
					echo "Done."
					echo "\033[0;36;1mThere is an available update \033[1;34;1m(Update version : v$(curl -s https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/version| head -n 1 | sed -z "s/\n//g") ; Current version : v$vers).\033[0m"
				fi
			else
				echo " Done : \033[0;33;1mThe Github repository is not reachable (check your internet connection).\033[0m"
			fi ;;
		"--log" ) 
			shift
			if ping -c 2 -W 1,5 -i 0,2 raw.githubusercontent.com >> /dev/null 2>&1
			then
				echo "\033[0;37mCurrent mancho.sh version : $vers     ;     change logs :\033[34m"
				curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/chlogs/$vers
		
				if test "$upd_vers" = "$vers"
				then
					echo "\033[0;37mAlready up to date, no newer change log.\033[0m"
				else
					echo "\033[0;37mLatest mancho.sh version : $upd_vers     ;     change logs :\033[34m"
					curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/chlogs/$upd_vers
				fi
			else
				echo "\033[0;33;1mMancho.sh/update cannot list the change logs :"
				echo "The Github repository is not reachable (check your internet connection).\033[0m"
				echo "Current mancho.sh version : $vers"
			fi ;;
		"" )
			if ping -c 2 -W 1,5 -i 0,2 raw.githubusercontent.com >> /dev/null 2>&1
			then
				if test "$upd_vers" = "$vers" && test "$1" != "--force"
				then
					echo "\033[0;32mYour mancho.sh is already up to date.\033[0m"
				else
					echo "\033[0;32mDownloading latest version of mancho.sh script...\033[0m\n"
					curl https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/src/mancho.sh > /tmp/mancho.sh.tmp.$$
					echo ""
					echo "\033[0;34m################################################################\033[0m"
					echo ""
					echo "\033[0;32;1;4mDownloading done !\033[0;36;1m Now, you need to enter a few commands \033[0;35m(mancho.sh would panic if it did these...)\033[0;36;1m :\033[0;1m"
					cat << EOF
   mv /tmp/mancho.sh.tmp.$$ ~/.local/bin/mancho.sh
   chmod 755 ~/.local/bin/mancho.sh
EOF
					echo "\033[0;36;1mThis will overwrite your actual mancho.sh file, and end the update (config files will stay)\033[0m\n"
					echo -n "Show current version change logs ? (y/n) : "
					read awnser
					case "$awnser" in
						"y" ) curl --silent https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/chlogs/$upd_vers | less ;;
						"n" ) true ;;
						* ) echo "\033[0;33mDid not understand '$awnser', skipping change logs. \033[0mYou can print them with 'mancho.sh --upd-l'" ;;
					esac
				fi
				echo "\033[0;35;1mUpdate function finished.\033[0m"
			else
				echo "\033[0;33;1mMancho.sh/update cannot download newer version :"
				echo "The Github repository is not reachable (check your internet connection).\033[0m"
				echo "Current mancho.sh version : $vers"
			fi ;;
		* ) echo "\033[0;31;1mERR (INTERN): update() : received unknown argument '$1'\033[0m" >> /dev/stderr ;;
	esac
}

##### Include Shell Config file

test -f ~/.config/mancho.sh/config.sh && . ~/.config/mancho.sh/config.sh
fzf_height=$(echo "$fzf_height" | sed "s/%$//g") # corrects fzf_height if ends with %
test "$fzf_options" && export FZF_DEFAULT_OPTS="$fzf_options"

##### Main Prog

if echo "$1" | grep -qw "\-\-desc" || echo "$1" | grep -qw "\-d"
then
	test $verbose = 1 && echo "\033[0;32mINFO: using description mode\033[0m"
	desc=1
	shift
fi

## Some needed stuff
	# is there a ~/.config/mancho.sh/ directory ?
test -d ~/.config/mancho.sh/ || mkdir -p ~/.config/mancho.sh/

	# is there a ~/.config/mancho.sh/current-upd-log file ?
if ! test -f ~/.config/mancho.sh/current-upd-log
then
	touch ~/.config/mancho.sh/current-upd-log
	test $synced = 0 && sync
fi

if test "$*"		## arguments decoding
then
	case "$1" in			## if argument recognized :
		"-V" | "--verbose" | "-s" | "--silent" | "-d" | "--desc" | "--sync" | "-h" | "--help" | "-help" | "-q" | "--quick" | "--quick-help" | "-H" | "--long-help" | "--help-long" | "--man-help" | "-v" | "--vers" | "--version" | "--" | "++" | "--mk-config" | "--upd" | "--update" | "--upd-f" | "--update-force" | "--upd-l" | "--upd-log" | "--update-log" | "--upd-s" | "--update-search" )
			until test $# = 0 || test "$ok" = 1
			do
				case $1 in
					"-s" | "--silent" ) verbose=0 ;;
					"-V" | "--verbose" ) verbose=1 ; echo "\033[0;32mINFO: using verbosing mode\033[0m" ;;
					"-d" | "--desc" ) desc=1 ; test $verbose = 1 && echo "\033[0;32mINFO: using description mode \033[1mfrom now on\033[0m" ;;
					"--sync" ) version ; echo "" ; sync ;;
					"-h" | "--help" | "-help" | "-q" | "--quick" | "--quick-help" ) quickhelp ;;
					"-H" | "--long-help" | "--help-long" ) help ;;
					"--man-help" ) man -h ;;
					"--mk-config" ) mkconfig ;;
					"-v" | "--vers" | "--version" ) version ;;
					"--" ) shift ; man $* ; ok=1 ;;
					"++" ) shift ; ok=1
						until test $# = 0
						do
							man $1
							shift
						done
						;;
					"--upd" | "--update" ) update ;;
					"--upd-f" | "--update-force" ) update --force ;;
					"--upd-l" | "--upd-log" | "--update-log" ) update --log ;;
					"--upd-s" | "--update-search" ) update --search main ;;
					* ) man $1 ;;
				esac
				test $# != 0 && shift
			done ;;		## if argument is not recognized, pass them all to man
		* ) man $* ;;
	esac
else			## list file making
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
		"0"*"version" ) echo "" ; version ; echo "\npress enter... " ; read awn ;;
		* ) man $manual ;;
	esac
fi
echo ""
