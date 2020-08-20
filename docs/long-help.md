# NOTE: this file is the direct output of mancho.sh --long-help (line 42 : "IMPORTANT" is pushed to left)


	                                             /$$                             $$\
	                                            | $$                             $$ |
	 /$$$$$$/$$$$   /$$$$$$  /$$$$$$$   /$$$$$$$| $$$$$$$   /$$$$$$     $$$$$$$\ $$$$$$$\
	| $$_  $$_  $$ |____  $$| $$__  $$ /$$_____/| $$__  $$ /$$__  $$   $$  _____|$$  __$$\
	| $$ \ $$ \ $$  /$$$$$$$| $$  \ $$| $$      | $$  \ $$| $$  \ $$   \$$$$$$\  $$ |  $$ |
	| $$ | $$ | $$ /$$__  $$| $$  | $$| $$      | $$  | $$| $$  | $$    \____$$\ $$ |  $$ |
	| $$ | $$ | $$|  $$$$$$$| $$  | $$|  $$$$$$$| $$  | $$|  $$$$$$/$$\$$$$$$$  |$$ |  $$ |
	|__/ |__/ |__/ \_______/|__/  |__/ \_______/|__/  |__/ \______/ \_,\_______/ \__|  \__|

                                        mancho.sh - friendly interface for man   v1.3.0


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

   I recommend you to alias `man` to `mancho.sh` (add this line to ~/.bashrc if you are using bash : alias man='mancho.sh')

   Mancho.sh has some builtin options (like the one you are using to print this help page). If mancho.sh gets an option it doesn't know, it
   gives it to man, like `mancho.sh --usage` is gonna execute `man --usage`.

   IMPORTANT :
   
   Note that if the first argument (or the one after --desc) is not recognized, mancho.sh will give EVERY arguments to man in the SAME com-
   mand, whereas if it gets a known option for $1, it will execute EVERY man options but only ONE a time. That's why there's a -- argument
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

   Mancho.sh uses two files which he creates if they don't exist :
   
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

	- remove the old executable mancho.sh file
	  (how to find it ? execute 'which mancho.sh' and you'll get its location)
	- execute these commands at a shell :

	    curl https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/src/mancho.sh > /tmp/mancho.sh.tmp
	    cp /tmp/mancho.sh.tmp ~/.local/bin/mancho.sh
	    chmod 755 ~/.local/bin/mancho.sh

ABOUT :

   mancho.sh - friendly interface for man
   version : 1.3.0
   program and help pages written by : lapingenieur
   github repo : https://github.com/lapingenieur/mancho.sh
   inspired by DistroTube (Derek Taylor)

SEE ALSO :

   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh			(where comes the idea)
   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho-gui.sh			(where comes the idea, but using dmenu instead of fzf)

