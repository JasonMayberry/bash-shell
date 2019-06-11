#!/bin/bash

#---------- PURPOSE -----------#
# Provides BASH Cheatsheet-pages Menu for the terminal
# It's a great way to keep your notes on the BASH Shell
#
#---------- COMPATIBILITY -----#
# Used only on "Ubuntu Linux" but I'm sure that with a few
# "brew installs" you could get it working on Mac or Windows.

#---------- USAGE -------------#
# [1]. Add files in a common Github.com Repository 
# [2]. Follow the instructions in the README.md
# [2]. Change repo_root_url to point at that repository as you see here:
repo_root_url='https://github.com/JasonMayberry/bash-shell'
#   Change this url    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# 
#---------- DEPENDENCIES -------#
# crepo requires "highlight" to be installed
# [me@linuxBox]~$ sudo apt install highlight
# 
#---------- NOTE ---------------#
# With crepo the file suffix must be ".sh" and the bash script must have the 
# shebang(#!/bin/bash) as the first line to view with syntax highlighting
# 
# That's it! The script will do the rest.

base_wget="wget -qO- "
base_less=" | less" 

while true; do
# Disable clear for troubleshooting
clear
echo "##### On which topic do you want see notes? #####"
echo "================================================="

if [ ${#pages[@]} -eq 0 ]; then
    echo -ne '###########                     (33%)\r'
    sleep 1
    echo -ne '###################             (66%)\r'
    sleep 1
    echo -ne '#############################   (100%)\r'
    echo -ne '\n'
	# Convert the repo_root_url into the raw base_url
	one=$(echo "$repo_root_url" | sed -e 's/github/raw.githubusercontent/g'); 
	base_url="$one/master/"
	# Get all file names in the Github Repository
    repo=$(wget -q https://github.com/JasonMayberry/bash-shell -O - | grep -i -o 'n-open" title=".*" id="' | sed -e 's/^n-open" title="\([^"]\+\)".*$/\1/g')
    declare -a pages=($repo)
fi


# get length of an array
tLen=${#pages[@]}

# Draw the Menu each time we loop
for (( i=0; i<${tLen}; i++ ));
do
    ii="[$(( $i+1 ))]. ${pages[$i]}"
    echo $ii
done



if [ "$sorry" != "" ]; then
    echo
fi
echo $sorry
if [ "$topic" != 'q' ]; then
    echo "[ q to Quit ]"
fi
echo -n "Type a topic number: "
read topic
echo
# This "if statement" is useful for troubleshooting
if [ "$topic" != "q" ]; then
echo "Topic #$topic: "
fi

echo
sorry=""

if [ $topic == 'q' ]; then
    # Disable clear for troubleshooting
    clear
    break
fi


function makePage() {
    # use for loop to read all pages
    for (( i=0; i<${tLen}; i++ ));
    do
        if [[ $topic =~ ^[0-9]{,2}$ ]]; then
            if (( $topic > ${tLen} )); then
                sorry="#-------------> Topic #$topic could not be found."
            else
                getPage "$topic"
                break
            fi
        else
            sorry="#-------------> Invalid Input -  Type a number from 1-99"
        fi
    done
 }

function check_highlight() {
	# A case statement should be used here to test for all file types that "highlight" suports
    if [[ $doc == *".sh" ]]; then
        if command -v highlight >/dev/null 2>&1 ; then
            highlight=" | highlight -O xterm256"
            base_less=" | less -R"
            page="$base_wget $base_url$doc $highlight $base_less"
            # echo "$page" # enable echo for troubleshooting
            eval "$page"
        else
            sorry="#> highlight not found <# To install it run: sudo apt install highlight"
            page="$base_wget $base_url$doc $base_less"
            eval "$page"
        fi
    else
    page="$base_wget $base_url$doc $base_less"
    eval "$page"
    fi
 }

function getPage() {
        doc=${pages[$(($1 - 1))]}
        check_highlight
 }

 if [[ $topic -gt 0 ]]; then
    makePage
else
    sorry="#-------------> Invalid Input -  Type a number from 1-99"
fi

echo

done

