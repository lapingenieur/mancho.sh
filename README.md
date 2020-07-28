# mancho.sh

![mancho.sh-logo2](mancho_logo2.png)

## What is mancho.sh ?

Mancho.sh is a bash script which adds a finder to man. You can search by name or by description. Of course, if you already know the command you're searching for, you just need to specify its name to mancho.sh.

## Why should I use mancho.sh ?

Mancho.sh has an integrated searching feature. If you want to use a command which lists windows, all you need to do is search for "list window". Magic !

## How can I install mancho.sh on my linux system ?

### Dependencies

#### fzf (the fuzzy finder)

* On Debian, Ubuntu, Linux Mint or any other Debian-based distro :

        sudo apt install fzf

* On Fedora :

        sudo dnf install fzf

* On Arch-based distros :

        sudo pacman -S fzf

### Installation

Run the following lines in a terminal :

	curl https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/src/mancho.sh > /tmp/mancho.sh.tmp

If you want to run mancho.sh with other users, execute :

	sudo cp /tmp/mancho.sh.tmp /usr/local/bin/mancho.sh
	sudo chmod 755 /usr/local/bin/mancho.sh

Otherwise : *(make sure `~/.local/bin` stays in $PATH)*

	cp /tmp/mancho.sh.tmp ~/.local/bin/mancho.sh
	chmod 755 ~/.local/bin/mancho.sh

## How to use it ?

Take a look at its built-in help with `mancho.sh --help` or read the documentation (in this folder).

## Configuration and advanced use

These are also written in the docs (here).

# Have a good time playing around with mancho.sh ;D
