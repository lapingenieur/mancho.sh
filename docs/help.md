USAGE :

	mancho.sh [--desc] [OPTION]
	mancho.sh MAN_OPTION...
	mancho.sh -- MAN_OPTION...

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

FAQ :

   Q: Why are there files for the lists, can't just make the list at each run ?
   A: These lists can be very long (several hundreds of lines) and it takes a bit of time to make them. It is more efficient to create a
        daily list and output it into a file than wait before using mancho.sh everytimes.

ABOUT :

   mancho.sh - friendly interface for man
   version : 1.2.5
   program and help pages written by : lapingenieur
   github repo : https://github.com/lapingenieur/mancho.sh

SEE ALSO :

   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh
   https://gitlab.com/dwt1/dotfiles/-/blob/master/macho-gui.sh

