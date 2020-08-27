# Quick Guide for mancho.sh

## Index

* [First steps](https://github.com/lapingenieur/mancho.sh/blob/master/docs/tutorial.md#first-steps) (ref to tutorial.md)
* [Print a manual page](#print-a-manual-page)
* [The Daily Lists](#daily-lists)
* [Updates](#updates)
* [Verbosing mode](#verbose)
* [Pass arguments to man](#pass-arguments-to-man)
* [Configuration](#configuration) (see also [config.md](./config.md))

More detailed infos in [the *good* tutorial](./tutorial.md) or in the [direct outputs](./output/)

Don't hesitate to open an issue or send me a mail if you con't figure out something !

---

## Print a manual page

I want to look at `ls`'s manual :

#### Print directly a manual page

        mancho.sh ls

#### Search for a manual page interactively and print it

        mancho.sh

Then type in the name of the command (here : `ls`) and press **`return`**.

#### Search for a manual page's description interactively and print it

I want to print the manual of a command which can print all my X windows but I can't remember its name :

        mancho.sh --desc
        mancho.sh -d

Then type in the description of the command, **choose** the right command with `up` and `down` and press **`return`**.

# Daily lists

| name             | location                        | description                                |
|------------------|---------------------------------|--------------------------------------------|
| standard list    | `~/.config/mancho.sh/list`      | contains each manual name and its category |
| description list | `~/.config/mancho.sh/list.desc` | same but adds a short description          |

More [here](./tutorial.md#daily-lists).

#### Update lists and check for updates

        mancho.sh --sync

# Updates

#### Get the version

        mancho.sh --version
        mancho.sh --vers
        mancho.sh -v

#### Search for updates

        mancho.sh --upd-s
        mancho.sh --update-search

#### Change logs

More logs [here](../global_change_logs.md). Print current and latest change logs :

        mancho.sh --update-log
        mancho.sh --upd-log
        mancho.sh --upd-l

#### Update mancho.sh

        mancho.sh --update
        mancho.sh --upd

#### Force update

        mancho.sh --update-force
        mancho.sh --upd-f

# Get the built-in help

For the *quick* help :

        mancho.sh -h
        mancho.sh -help
        mancho.sh --help
        mancho.sh -q
        mancho.sh --quick
        mancho.sh --quick-help

For the *complete* help :

        mancho.sh -H
        mancho.sh --long-help
        mancho.sh --help-long

For the `man` program's help

        mancho.sh --man-help
       	mancho.sh -- -h
        mancho.sh -- --help

# Verbose

Activate verbosing :

        mancho.sh --verbose
	mancho.sh -V

Deactivate verbosing :

        mancho.sh --silent
	mancho.sh -s

# Pass arguments to man

| mancho.sh...                                        | so ...                                                        |
|-----------------------------------------------------|---------------------------------------------------------------|
| doesn't recognize the **first** argument            | every argument goes into man in **a single command**          |
| recognizes the **first** argument                   | all the unknown arguments go into man **one at a time**       |
| recognizes the **first** argument and receives `--` | every argument after `--` go into man **in a single command** |
| recognizes the **first** argument and receives `++` | every argument after `++` go into man **one at a time**       |

# Configuration

> This is considered as *advanced use*, please reffer to [this](./config.md) file, which is made specially for help about configuration.

#### Generate default config file

        mancho.sh --mk-config
