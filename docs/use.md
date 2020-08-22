# MANCHO.SH - Usage Help

# Index

* [First steps with mancho.sh](#First-Steps)
  * [Simplify executing mancho.sh](#Simplify-executing-mancho.sh)
* [Print a manual page](#Print-a-manualo-page)

## Get the built-in help

### From the command line

#### Minimal Help :

        mancho.sh --help

or

        mancho.sh -h

#### Complete Help :

        mancho.sh --long-help

or

        mancho.sh -H

### From the [Github page](https://www.github.com/lapingenieur/mancho.sh)

[Minimal Help](./quick-help.md)

[Complete Help](./long-help.md)

---

# First Steps

## Simplify executing mancho.sh

mancho.sh calls the `man` command if it needs to, so I highly recommend you to alias `man` to `mancho.sh` if you want to use its advanced options :

#### For `bash`

        echo "alias man='mancho.sh'" >> ~/.bashrc

#### For `zsh`

        echo "alias man='mancho.sh'" >> ~/.zshrc

# Print a manual page

## Basic Usage

### Print directly a manual page

(This one is always done at a prompt)

#### Situation :

> I want to look at `ls`'s manual

#### Command :

        mancho.sh ls

### Search for a manual page interactively and print it

#### Situation

> I want to look at `ls`'s  manual passing thrue the searching part

#### Command :

        mancho.sh

Then type in the name of the command (here : `ls`) and press **`return`**.

### Search for a manual page's description interactively and print it

#### Situation

> I know what king of command I am looking for but I can't remember its name
>
> I want to print the manual of a command which can set my X keyboard

#### Command :

        mancho.sh --desc

Then type in the description of the command ape press **`return`**.

        set X keyboard <return>
