#!/bin/bash

#---------- PURPOSE -----------#
# Provides Github.com Repository file viewer with Menu for the terminal
# Supported Syntax Highlighting for when viewing .sh files
# It's a great way to keep your notes on the BASH Shell
#
#---------- COMPATIBILITY -----#
# Used only on "Ubuntu Linux" but I'm sure that with a few
# "brew installs" you could get it working on Mac or Windows.

#---------- USAGE -------------#
# [1]. Add files in a common Github.com Repository
# [2]. Follow the instructions in the README.md here:
# https://github.com/JasonMayberry/bash-shell/blob/master/README.md
# [3]. Run crepo with or without an argument as folows:
# [me@linuxBox]~$ crepo   # will view default repo
# [me@linuxBox]~$ crepo https://github.com/epety/100-shell-script-examples
# [4]. Change repoRootURL to set the default repository as you see here:
repoRootURL='https://github.com/JasonMayberry/bash-shell'
#     Default URL      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

baseWget="wget -qO- "
baseLess=" | less"
invalidInput="#-------------> Invalid Input -  Type a number from 1-999"

while true; do
clear # Disable clear for troubleshooting

echo "##### On which File Number do you want see? #####"
echo "================================================="

if [ ${#fileNamesArray[@]} -eq 0 ]; then
    echo -ne '###########                     (33%)\r'
    sleep 1
    echo -ne '###################             (66%)\r'
    sleep 1
    echo -ne '#############################   (100%)\r'
    echo -ne '\n'

    function getFileNames() {
        # Convert the repoRootURL into the rawBaseURL
        rawBaseURL=$(sed -e 's/github/raw.githubusercontent/g' <<<"$repoRootURL/master/")
        # Get all file names on the main page of the Github Repository.
        getHTML=$(wget -qO- $repoRootURL)
        searchHTML=$(grep -i -o 'n-open" title=".*" id="' <<<"$getHTML")
        trimFileName=$(sed -e 's/^n-open" title="\([^"]\+\)".*$/\1/g' <<<"$searchHTML")
    }

    if [ "$1" != "" ]; then
        repoRootURL=$1
        getFileNames
    else
        getFileNames
    fi
fi

declare -a fileNamesArray=($trimFileName) # Create an array from space delimited file names

theLength=${#fileNamesArray[@]} # get length of the array

# Draw the Menu each time the array is looped over
for (( i=0; i<${theLength}; i++ ));
do
    ii="[$(( $i+1 ))]. ${fileNamesArray[$i]}"
    echo $ii
done



if [ "$sorry" != "" ]; then
    echo
fi
echo $sorry
if [ "$menuFileNumber" != 'q' ]; then
    echo "[ q to Quit ]"
fi
echo -n "Type a menuFileNumber number: "
read menuFileNumber
echo
# This "if statement" is useful for troubleshooting
if [ "$menuFileNumber" != "q" ]; then
echo "menuFileNumber #$menuFileNumber: "
fi

echo
sorry=""

if [ $menuFileNumber == 'q' ]; then
    clear # Disable clear for troubleshooting
    break
fi


function makePage() {
    # Use "for loop" to read file Names Array
    for (( i=0; i<${theLength}; i++ ));
    do
        if [[ $menuFileNumber =~ ^[0-9]{,3}$ ]]; then
            if (( $menuFileNumber > ${theLength} )); then
                sorry="#-------------> File #$menuFileNumber could not be found."
            else
                getPage "$menuFileNumber"
                break
            fi
        else
            sorry=$invalidInput
        fi
    done
 }

function check_highlight() {
    # Maybe a case statement should be used here to test for all file types that "highlight" supports
    # Try, catch, might make it more robust
    if [[ $doc == *".sh" ]]; then
        if command -v highlight >/dev/null 2>&1 ; then
            highlight=" | highlight -O xterm256"
            baseLess=" | less -R"
            page="$baseWget $rawBaseURL$doc $highlight $baseLess"
            # echo "$page" # enable echo for troubleshooting
            eval "$page"
        else
            sorry="#> highlight not found <# To install it run: sudo apt install highlight"
            page="$baseWget $rawBaseURL$doc $baseLess"
            eval "$page"
        fi
    else
    page="$baseWget $rawBaseURL$doc $baseLess"
    eval "$page"
    fi
 }

function getPage() {
        doc=${fileNamesArray[$(($1 - 1))]}
        check_highlight
 }

 if [[ $menuFileNumber -gt 0 ]]; then
    makePage
else
    sorry=$invalidInput
fi

echo

done
