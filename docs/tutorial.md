# MANCHO.SH - A *Good* Tutorial

## IMPORTANT NOTE:

> This program, and in particular help pages, uses frequently the word `man` as a reference to the `man` software or as a shorter word for `manual` when talking about `manual pages` (this becomes `man pages`).
> 
> **It is in NO CASE RACISM or SEXISM. These are just SOFTWARE NAMES and DIMINUTIVES.**
>
> More infos [here](../README.md#important-note-and-name-explainations-d)

---

# Index

* [Introduction](#introduction) (same as [global readme](../README.md))
* [First steps with mancho.sh](#first-steps)
* [Open a manual page](#open-a-manual-page)
* [The Daily Lists](#daily-lists)

---

# Introduction

## What is mancho.sh ?

Mancho.sh is a bash script which adds cool features to man, like a command and a description finder. Of course, if you already know the command you're searching for, you just need to specify its name to mancho.sh.

## Why should I use mancho.sh ?

Mancho.sh has an integrated searching feature. If you want to use a command which lists windows, all you need to do is search for "list window". Magic !

Mancho.sh does more than `man`, you can just alias it to `man` with `alias man='mancho.sh'` so you use a single command for everything. ([ref here](#simplify-executing-manchosh))

## How can I install mancho.sh on my linux system ?

Just follow [these instructions](../README.md#how-can-i-install-manchosh-on-my-linux-system-).

# First Steps

## Simplify executing mancho.sh

mancho.sh calls the `man` command if it needs to, so I highly recommend you to alias `man` to `mancho.sh` if you want to use it often :

#### For the `bash` shell

        echo "alias man='mancho.sh'" >> ~/.bashrc

#### For the `zsh` shell

        echo "alias man='mancho.sh'" >> ~/.zshrc

---

To apply the alias in the current session, just execute :

        alias man='mancho.sh'

> NOTE: in the following steps, you will not see the `man` command to do not be confused with the alias and the actual program.

# Open a manual page

It's for sure the thing you'll use the most with mancho.sh. To call a manual, just do as if you were using `man` :

        mancho.sh MANUAL_NAME

Now if you want to open the finder, maybe to have a preview of the man page, you'll juste use :

        mancho.sh

You'll probably see the script doing some stuff before even printing the finder : nothing to be affraid of ! It just searches for eventual updates and creates the program daily lists. For more infos about lists, look at [this](#daily-lists)

# Daily Lists
