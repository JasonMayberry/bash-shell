#!/bin/bash

#---------- PURPOSE -----------#
# Provides BASH Cheatsheet-pages Menu for the terminal
# It's a great way to keep your notes on the BASH Shell
#
#---------- COMPATIBILITY -----#
# Used only on "Ubuntu Linux" but I'm sure that with a few
# "brew installs" you could get it working on a Mac machine.

#---------- USAGE -------------#
# [1]. Add file names of files in a common Repository to the 
#      pages array in the same format as you see in the example here.
# [2]. Reset the base_url to point at that repository as you see in the example here.
# 
#---------- DEPENDENCIES -------#
# jdocs requires "highlight" to be installed but is functional without it.
# To install it run: [me@linuxBox]~$ sudo apt install highlight
# 
#---------- NOTE ---------------#
# With jdocs the file suffix must be ".sh" and the bash script must have the 
# shebang(#!/bin/bash) as the first line to view with syntax highlighting
# 
# That's it! The script will do the rest.

while true; do
# Disable clear for troubleshooting
clear
echo "##### On which topic do you want see notes? #####"
echo "================================================="
declare -a pages
pages=( 
'[1]. 30-Bash-Script-Examples.txt'
'[2]. a-z-index-of-bash-commands'
'[3]. bash-doc.txt'
'[4]. BASH-Script-Cheatsheet.sh'
'[5]. define-a-printer.txt'
'[6]. encrypt-decrypt-a-file-in-Linux.txt'
'[7]. Example-Bash-Scripting.sh'
'[8]. Executable-Permissions.txt'
'[9]. gzip.txt'
'[10]. How-to-run-MySQL-Command-from-terminal.txt'
'[11]. Info-Links'
'[12]. printf.txt'
'[13]. Regular-Expression-Basics-Examples.txt'
'[14]. Regular-Expressions.txt'
'[15]. SHELL-SCRIPTING-TUTORIAL.txt'
'[16]. sort.txt'
'[17]. Start-Stop-MySQL-Server-from-Command-Line.txt'
'[18]. sublime-text-documentation.txt'
'[19]. Synchronizing-Files-and-Directories.txt'
'[20]. xargs.txt'
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

function check_highlight() {
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

function getPage_0_9() {
        str=${pages[$(($1 - 1))]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        check_highlight
 }

function getPage_10_99() {
        str=${pages[$(($1 - 1))]}
        doc=${str/\[[0-9][0-9]\]\.[[:space:]]/}
        check_highlight
 }

if [[ $topic -gt 0 ]]; then
    makePage
else
    sorry="#-------------> Invalid Input -  Type a number from 1-99"
fi

echo

done
