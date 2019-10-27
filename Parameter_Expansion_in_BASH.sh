#!/bin/bash

# Parameter Expansion in BASH

# https://www.youtube.com/watch?v=S4D9KaW3ERw
# Below I include the code samples shown in this screen cast.


# First demo script:

#!/bin/bash

name=protesilaos

# Replace parameter with its value
echo "$name"

# Get parameter length
echo "${#name}"

# Extract substring ${parameter:offset:length}
echo "${name:0:4}"

# Capitalise first character
echo "${name^}"

# Capitalise all characters
echo "${name^^}"



Second example:

#!/bin/bash

name=PROTESILAOS

# First character is lower case
echo "${name,}"

# All characters are lowercase
echo "${name,,}"

# Use default value if parameter is unset/null
unset name
echo "$name"
echo "${name:-Protesilaos}"
echo "${name:-$USER}"



Third sample:

#!/bin/bash

freedom='GNU Not UNIX ; GNU plus Linux'

# Replace first occurence of pattern with string
echo "${freedom/GNU/Gahnoo}"

# Replace all matches of pattern with string
echo "${freedom//GNU/Gahnoo}"

# Remove first match of pattern
echo "${freedom/* ; /}"

freedom='GNU Not UNIX ; GNU is Not Unix ; Gahnoo slash Linaks ; GNU/Linux'

echo "$freedom"

# Remove all occurences of pattern
echo "${freedom//* ; /}"








# Command Groups
# Treat group as single unit for redirection or branching
	# Subshell:
		# Evaluate list of commands in a subshell, meaning that its
		# environment is distinct from the current shell and its
		# parameters are contained.
		# (list)
			## Example 62 / 91
			unset x
			(x=hello; echo "x: $x")
			echo "x: $x"
			# x: hello
			# x:

	# Group command:
		# Evaluate list of commands in the current shell, sharing
		# the current shell's environment and parameter scope.
		# { list; }
		# The spaces and trailing
		# semicolon are obligatory
			## Example 63 / 91
			unset x
			{ x=hello; echo "x: $x"; }
			echo "x: $x"
			# x: hello
			# x: hello


# This is a simple script that displays the values of the variables $0-$9. 

#!/bin/bash
# posit-param: script to view command line parameters
echo "
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
\$5 = $5
\$6 = $6
\$7 = $7
\$8 = $8
\$9 = $9
"

# When executed with no command line arguments:
# [me@linuxbox ~]$ posit-param
$0 = /home/me/bin/posit-param
$1 =
$2 =
$3 =
$4 =
$5 =
$6 =
$7 =
$8 =
$9 =

# Even when no arguments are provided, $0 will always contain the first item appearing 
# on the command line, which is the pathname of the program being executed.


# The shell also provides a variable, $#, 
# that contains the number of arguments on the command line:

#!/bin/bash
# posit-param: script to view command line parameters
echo "
Number of arguments: $#
\$0 = $0
\$1 = $1
\$2 = $2
\$3 = $3
\$4 = $4
\$5 = $5
\$6 = $6
\$7 = $7
\$8 = $8
\$9 = $9
"
# This is the result:
# [me@linuxbox ~]$ posit-param a b c d
Number of arguments: 4
$0 = /home/me/bin/posit-param
$1 = a
$2 = b
$3 = c
$4 = d
$5 =
$6 =
$7 =
$8 =
$9 =


$*
# Expands into the list of positional parameters, starting with 1. 
# When surrounded by double quotes, it expands into a double-quoted 
# string containing all of the positional parameters, each separated 
# by the first character of the IFS shell variable 
# (by default a space character).

 $@ 
# Expands into the list of positional parameters, starting with 1. 
# When surrounded by double quotes, it expands each positional
# parameter into a separate word as if it was surrounded by double quotes.

# Here is a script that shows these special parameters in action:

#!/bin/bash
# posit-params3: script to demonstrate $* and $@
print_params () {
    echo "\$1 = $1"
    echo "\$2 = $2"
    echo "\$3 = $3"
    echo "\$4 = $4"
}
pass_params () {
    echo -e "\n" '$* :';
    echo -e "\n" '"$*" :'; print_params "$*"
    echo -e "\n" '$@ :';   print_params $@
    echo -e "\n" '"$@" :'; print_params "$@"
}
pass_params "word" "words with spaces"




# interactive mode with break, exit and continue
if [[ -n "$interactive" ]]; then
    while true; do
        read -p "Enter name of output file: " filename
        if [[ -e "$filename" ]]; then
             read -p "'$filename' exists. Overwrite? [y/n/q] > "
             case "$REPLY" in
                Y|y) break
                    ;;
                Q|q) echo "Program terminated." exit
                    ;;
                *) continue
                    ;;
             esac
        elif [[ -z "$filename" ]]; then
             continue
        else
             break
        fi 
    done
fi






