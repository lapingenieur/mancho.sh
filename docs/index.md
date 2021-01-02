# Exhaustive argument list

| Argument          | Abreviation(s)          | Description                                                                   |
|-------------------|-------------------------|-------------------------------------------------------------------------------|
| `--sync`          |                         | Syncronize the lists and search for updates                                   |
| `--desc`          | `-d`                    | Use description mode when using fzf                                           |
| `--help`          | `-help`, `-h`           | Print a quick/short help page                                                 |
| `--quick-help`    | `--quick`, `-q`         | Same as above                                                                 |
| `--long-help`     | `-H`                    | Print a long/complete help page, kinda man page                               |
| `--man-help`      |                         | Print `man`'s help page (= use `\man -h`)                                     |
| `--version`       | `--vers`, `-v`          | Print the current version                                                     |
| `--mk-config`     | `--mk-config`           | Generate an example config file (only comments, see [here](./config.md))      |
| `--update`        | `--upd`                 | Update mancho.sh. (download the source code and tell the user what to do)     |
| `--update-force`  | `--upd-f`               | Update mancho.sh even if already got latest version                           |
| `--update-log`    | `--upd-log`, `--upda-l` | Print current and latest versions's change logs (latest if not up to date)    |
| `--update-search` | `--upd-s`               | Search for updates (similar to `--sync` but doesn't make list files)          |
| `--`              |                         | Give all the following arguments to man (every arguments in the SAME command) |
| `++`              |                         | Give all the following arguments to man (each argument given ONE AT A TIME)   |
| `--verbose`       | `-V`                    | Use verbosing mode                                                            |
| `--silent`        | `-s`                    | Unuse verbosing mode (this is not a *true* quiet or silent mode)              |
| (other)           |                         | If this is the first argument, everything is given to man in the SAME COMMAND. If it's not, this SINGLE argument is give nto man.

> NOTE: mancho.sh does not look at the arguments that follow '--' and '++', even if there's '--' or '++'.

> NOTE: verbosing mode can change during  executing : 'mancho.sh -V --sync -s --sync' will syncronize two times, but will print different outputs.

# Exhaustive installed file/directory list

| File path                       | Description                                                                |
|---------------------------------|----------------------------------------------------------------------------|
| `~/.local/bin/mancho.sh`        | Contains mancho.sh's source code                                           |
| `~/.config/mancho.sh/`          | DIR - directory containing needed files                                    |
| `~/.config/mancho.sh/list`      | List of all installed manual pages                                         |
| `~/.config/mancho.sh/list.desc` | List of all installed manual pages and their short description             |
| `~/.config/mancho.sh/config.sh` | Configuration file written in bash, included to mancho.sh's code if exists |
| `/tmp/mancho.sh.tmp.$$`         | Temporary file : updated mancho.sh's source code ($$ is a PID number)      |

# Online file/directory list (on the [github page](https://github.com/lapingenieur/mancho.sh))

> This list can be not exhaustive.

> NOTE: the `/` directory is considered as the [*root*](https://github.com/lapingenieur/mancho.sh)

| File path                           | Description                                                                |
|-------------------------------------|----------------------------------------------------------------------------|
| `/chlogs/`                          | DIR - directory containing change logs for each version in separate files. |
| `/chlogs/x.x.x`                     | (`x.x.x` is a version number) change logs for version `x.x.x`              |
| `/docs/`                            | DIR - Directory containing the documentation                               |
| `/docs/output/`                     | DIR - directory containing raw outputs of built-in help pages              |
| `/docs/output/output.long-help-md`  | raw output of `mancho.sh --long-help`                                      |
| `/docs/output/output.quick-help-md` | raw output of `mancho.sh --quick-help`                                     |
| `/docs/README.me`                   | documentation index                                                        |
| `/docs/index.md`                    | list of arguments and files                                                |
| `/docs/config-md`                   | help about configuration and config file                                   |
| `/docs/use.md`                      | a quick guide                                                              |
| `/docs/tutorial.md`                 | mancho.sh's *good* tutorial                                                |
| `/images/`                          | DIR - directory containing pictures                                        |
| `/src/`                             | DIR - directory containing source files                                    |
| `/src/config.sh`                    | a config file example                                                      |
| `/src/mancho.sh`                    | mancho.sh's source code                                                    |
| `/README.md`                        | kind of welcome page and quick jump in                                     |
| `/global_change_logs.md`            | change logs and other information of each version since 1.3.1              |
| `/version`                          | contains each version number since 1.3.1 (newer at the top)                |
