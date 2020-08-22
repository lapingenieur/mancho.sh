# mancho.sh

![mancho.sh-logo2](mancho_logo2.png)

## IMPORTANT NOTE: (and name explainations :D)

> Some people think the `man` pages/program are a reference to `male gender`, `boys`, and they define it as `racism` and `sexism`.
> They also can think the word `master` (for the *master* branch) is a hierarchical ideology or something about slavery.
> 
> This program, and in particular help pages, uses frequently the word `man` as a reference to the `man` software or as a shorter word for `manual` when talking about `manual pages` (this becomes `man pages`).
> 
> Plus, the program name is `mancho.sh`. This could reflect the word `macho` (which doesn't improve our case ...), but I got explainations !
> * First, `mancho.sh` is highly inspired by a script called `macho.sh` (source [here](https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh))
> * Then, `mancho` is a kind of play on words :
>   * ***man**cho.sh* relfects the original `macho.sh` script _and_ the `man` program
>   * while ***mancho**.sh* tells about a french word, **manchot**, which is kind of **penguin** (and linux's mascot [is a penguin](https://en.wikipedia.org/wiki/Tux_(mascot)))
> 
> **It is in NO CASE RACISM or SEXISM. These are just SOFTWARE NAMES and DIMINUTIVES.**

---

## What is mancho.sh ?

Mancho.sh is a bash script which adds cool features to man, like a command and a description finder. Of course, if you already know the command you're searching for, you just need to specify its name to mancho.sh.

## Why should I use mancho.sh ?

Mancho.sh has an integrated searching feature. If you want to use a command which lists windows, all you need to do is search for "list window". Magic !

Mancho.sh does more than `man`, you can just alias it to `man` with `alias man='mancho.sh'` so you use a single command for everything.

## How can I install mancho.sh on my linux system ?

### Dependencies

mancho.sh needs `sed`, `awk`, `grep`, `less`, `cat`, `curl`, `apropos`, `man` and `bash`, but these are almost **always** installed by default.

#### fzf (the fuzzy finder)

> fzf's github : https://github.com/junegunn/fzf

* On Debian, Ubuntu, Linux Mint or any other Debian-based distro :

        sudo apt update && sudo apt install fzf

* On Fedora :

        sudo dnf install fzf

* On Arch-based distros :

        sudo pacman -S fzf

### Installation

Run the following lines in a terminal :

	curl https://raw.githubusercontent.com/lapingenieur/mancho.sh/master/src/mancho.sh > ~/.local/bin/mancho.sh
	chmod 755 ~/.local/bin/mancho.sh

---

#### _Warning_ ! If the following command outputs `not in PATH` :

	echo "$PATH" | grep -qE "$HOME/.local/bin|~/.local/bin" && echo "all right" || echo "not in PATH"

add the `~/.local/bin` directory to the PATH variable in your shell RC file (see just below)

##### for bash, execute :

	echo 'PATH=$PATH:~/.local/bin' >> ~/.bashrc

##### for zsh, execute :

	echo 'PATH=$PATH:~/.local/bin' >> ~/.zshrc

## How to use it ?

Take a look at its built-in help page**s** with `mancho.sh --help` (shorter) or `mancho.sh --long-help` (more complete), or read the documentation (in [this](https://github.com/lapingenieur/mancho.sh/tree/master/docs) folder).

## Configuration and advanced use

These are also written in the docs ([here](https://github.com/lapingenieur/mancho.sh/tree/master/docs)) and in mancho.sh's built-in help.

# Have a good time playing around with mancho.sh ;D

    ABOUT :

        mancho.sh - friendly interface for man
        current version : 1.3.1
	      (more up-to-date version values here : https://github.com/lapingenieur/mancho.sh/blob/master/version, last at the top)
        program and help pages written by : lapingenieur
        github repo : https://github.com/lapingenieur/mancho.sh
        inspired by DistroTube (Derek Taylor)

    SEE ALSO :

        https://gitlab.com/dwt1/dotfiles/-/blob/master/macho.sh                      (where comes the idea)
        https://gitlab.com/dwt1/dotfiles/-/blob/master/macho-gui.sh                  (where comes the idea, but using dmenu instead of fzf)
        https://github.com/junegunn/fzf                                              (from where comes fzf, the fuzzy finder)
