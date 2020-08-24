# Quick Guide for mancho.sh

## Index

* [First steps](https://github.com/lapingenieur/mancho.sh/blob/master/docs/tutorial.md#first-steps) (ref to tutorial.md)
* [Print a manual page](#Print-a-manualo-page)

---

## Print a manual page

#### Print directly a manual page

(This one is always done at a prompt)

I want to look at `ls`'s manual :

        mancho.sh ls

#### Search for a manual page interactively and print it

I want to look at `ls`'s  manual passing thrue the searching part :

        mancho.sh

Then type in the name of the command (here : `ls`) and press **`return`**.

#### Search for a manual page's description interactively and print it

I want to print the manual of a command which can set my X keyboard but I can't remember its name :

        mancho.sh --desc

Then type in the description of the command ape press **`return`**.

        set X keyboard <return>
