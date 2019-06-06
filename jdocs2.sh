#!/bin/bash

# PURPOSE
# Provides BASH Cheatsheet-pages Menu for the terminal
# It's a great way to keep your notes on the BASH Shell
#
# COMPATIBILITY
# Used only on "Ubuntu Linux" but I'm sure that with a few
# "brew installs" you could get it working on a Mac machine.

# USAGE
# [1]. Add file names of files in a common Repository to the 
#      pages array in the same format as you see in the example here.
# [2]. Reset the base_url to point at that repository as you see in the example here.
# 
# DEPENDENCIES
# jdocs2 requires "highlight" to be installed
# Source: http://www.andre-simon.de/doku/highlight/en/highlight.php
# [me@linuxBox]~$ sudo apt install highlight
# 
# With jdoc2 the file suffix must be ".sh" and the bash
# script must have the shebang(#!/bin/bash) as the first line.
# 
# That's it! The script will do the rest.

while true; do
# Disable clear for troubleshooting
clear
echo "##### On which topic do you want see notes? #####"
echo "================================================="
declare -a pages
pages=( 
'[1]. bash-doc.txt' 
'[2]. a-z-index-of-bash-commands' 
'[3]. Regular-Expressions.txt' 
'[4]. Regular-Expression-Basics-Examples.txt' 
'[5]. SHELL-SCRIPTING-TUTORIAL.txt' 
'[6]. 30-Bash-Script-Examples.txt' 
'[7]. Example-Bash-Scripting.sh' 
'[8]. Start-Stop-MySQL-Server-from-Command-Line.txt' 
'[9]. How-to-run-MySQL-Command-from-terminal.txt' 
'[10]. encrypt-decrypt-a-file-in-Linux.txt' 
'[11]. Info-Links' 
'[12]. sublime-text-documentation.txt'
'[13]. BASH-Script-Cheatsheet.sh'
)

for i in "${pages[@]}"
do
    echo $i
done

base_wget="wget -qO- "
base_url="https://raw.githubusercontent.com/JasonMayberry/bash-shell/master/"
base_less=" | less" 

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

# get length of an array
tLen=${#pages[@]}

function makePage() {
    # use for loop read all pages
    for (( i=0; i<${tLen}; i++ ));
    do
        if [[ $topic =~ ^[0-9]{,2}$ ]]; then
            if (( $topic > ${tLen} )); then
                sorry="#-------------> Topic #$topic could not be found."
            elif (( $topic < 10 )); then
                getPage_0_9 "$topic"
                break
            else
                getPage_10_99 "$topic"
                break
            fi
        else
            sorry="#-------------> Invalid Input -  Type a number from 1-99"
        fi
        # echo ${pages[$i]}
    done
 }

function getPage_0_9() {
        str=${pages[$(($1 - 1))]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        if [[ $doc == *".sh" ]]; then
            highlight=" | highlight -O xterm256"
            base_less=" | less -R"
            page="$base_wget $base_url$doc $highlight $base_less"
            # echo "$page" # enable echo for troubleshooting
            eval "$page"
        else
        page="$base_wget $base_url$doc $base_less"
        eval "$page"
    fi
 }

function getPage_10_99() {
        str=${pages[$(($1 - 1))]}
        doc=${str/\[[0-9][0-9]\]\.[[:space:]]/}
        if [[ $doc == *".sh" ]]; then
            highlight=" | highlight -O xterm256"
            base_less=" | less -R"
            page="$base_wget $base_url$doc $highlight $base_less"
            # echo "$page" # enable echo for troubleshooting
            eval "$page"
        else
        page="$base_wget $base_url$doc $base_less"
        eval "$page"
    fi
 }

if [[ $topic -gt 0 ]]; then
    makePage
else
    sorry="#-------------> Invalid Input -  Type a number from 1-99"
fi

echo

done
