# Static Configuration in mancho.sh

mancho.sh's configuration file is just a bash script. It is execute and included to the main code every time mancho.sh is used, so do not bloat it up !

The config file stays in `~/.config/mancho.sh/config.sh`. It is not created by default, but you can generate an example config (containing only commented stuff) using :

        mancho.sh --mk-config

This file is made to define some variables or a few personnal stuff ; but it's a bash script, so you can actually put what you want in it.

## Adviced variable settings

### List of the internal variables you may want to change :

| NAME :         | DESCRIPTION :        | VALUES :                  | Example :       | Example explaination :          |
|----------------|----------------------|---------------------------|-----------------|---------------------------------|
| verbose        | verbosing option     | 0, 1 (1 = always verbose) | `verbose=1`     |
| desc           | description mode     | 0, 1 (1 = always desc.)   | `desc=0`        | no description without `--desc` |
| fzf_height     | fzf's height         | 0-100 (in % of the term)  | `fzf_height=75` | take 75% of terminal height     |
| fzf_options    | fzf default settings | [more infos here](https://github.com/junegunn/fzf/blob/master/README.md) | `fzf_options="--border --layout=reverse --prompt='Manual: '"` etc | options passed to fzf |

### List of the environment variables you may want to change :

>   Note : you need to define these variables using the 'export' command in most shells (see your shell's manual at 'evironment variables')

| NAME :           | DESCRIPTION :              | VALUES :                  | Example :                                    | Example explaination :          |
|------------------|----------------------------|---------------------------|----------------------------------------------|---------------------------------|
| FZF_DEFAULT_OPTS | fzf default settings (direct) | [more infos here](https://github.com/junegunn/fzf/blob/master/README.md) | `export FZF_DEFAULT_OPTS="--border --layout=reverse --prompt='Manual: '"` etc | options passed to fzf |
| MANPAGER         | program to print man pages | *a shell command*         | `export MANPAGER="/bin/sh -c \"col -b \| vim --not-a-term -\""` | set vim as manpager *(shorter version)* |
