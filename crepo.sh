#!/bin/bash
set -euo pipefail # Unofficial Bash Strict Mode
IFS=$'\n\t'

#------------ PURPOSE -------------#
# Provides Github.com Repository file viewer with Menu for the terminal
# Supported Syntax Highlighting for when viewing .sh files
# It's a great way to keep your notes on the BASH Shell
#
#---------- COMPATIBILITY ---------#
# Used only on "Ubuntu Linux" but I'm sure that with a few
# "brew installs" you could get it working on Mac or Windows.

#------------- USAGE --------------#
# [1]. Place some files in a common Github.com Repository
#
# [2]. Follow the instructions in the README.md here:
#      https://github.com/JasonMayberry/bash-shell/blob/master/README.md
#
# [3]. Run crepo with or without a repo url as folows:
#      Without a repo url = View Default Repository
#      [me@linuxBox]~$ crepo
#      [me@linuxBox]~$ crepo https://github.com/epety/100-shell-script-examples
#
# [4]. Change repo_URL to set the default repository, 
#      located on the first uncommented line this file.

#---------- DEPENDENCIES -----------#
# crepo requires "highlight" to be installed
# On any Debian derivative it can be installed 
# like this: [me@linuxBox]~$ sudo apt install highlight
#
#-------------- NOTE ---------------#
# With crepo the file suffix must be ".sh" and the bash script must have the
# shebang(#!/bin/bash) as the first line to view with syntax highlighting
#
# That's it! The script will do the rest.



# Change Default url HERE to set the default repository:
repo_URL=${1-'https://github.com/JasonMayberry/bash-shell'}
#--------------> Default URL     ^^^^^^^^^^^^^^^^^^^^^^^^

baseWget="wget -qO- "
baseLess=" | less"
menuFileNumber=""
sorry=""
invalidInput="#-------------> Invalid Input -  Type a number from 1-999"
declare -a fileNamesArray=()

while true; do
clear # Disable clear for troubleshooting
echo "##### Which Repository File Would you like to see? #####"
echo "========================================================"
if [ ${#fileNamesArray[@]} -eq 0 ]; then
    # Displays a fake loading bar
    echo -ne '###########                     (33%)\r'
    sleep 1
    echo -ne '###################                  (66%)\r'
    sleep 1
    echo -ne '#############################            (80%)\r'
    sleep 1
    echo -ne '######################################## (100%)\r'
    echo -ne '\n'
    # Convert the repo_URL into the rawBaseURL
    rawBaseURL="${repo_URL/github/raw.githubusercontent}"/master/ 
    # Get all file names on the main page of the Github Repository.
    getHTML=$(wget -qO- $repo_URL)
    searchHTML=$(grep -i -o 'n-open" title=".*" id="' <<<"$getHTML")
    # Trim prefix and suffix from each file name
    # trimFileName=$(sed -e 's/^n-open" title="\([^"]\+\)".*$/\1/g' <<<"$searchHTML")
    pre=${searchHTML//n-open\" title=\"/}; trimFileName=${pre//\" id=\"/}
fi

if [ ${#fileNamesArray[@]} -eq 0 ]; then
    sortNamesArray=($trimFileName) # Create an array from space delimited file names
    fileNamesArray=($(sort <<<"${sortNamesArray[*]}"))
fi

theLength=${#fileNamesArray[@]} # get length of the array
# Draw the Menu each time the array is looped over
for (( i=0; i<${theLength}; i++ ));
do
    ii="[$(( $i+1 ))]. ${fileNamesArray[$i]}"
    echo $ii
done

if [ -n "$sorry" ]; then # True if length non-zero
    echo
fi
echo $sorry
if [ "$menuFileNumber" != 'q' ]; then
    echo "[ q to Quit ]"
fi
# Instructional user data prompt
echo -n "Type a File Number from the Menu: "
# Get users data (file number choice)
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
    # Maybe case statement should be used here to test for all file types that "highlight" supports
    # Try, catch, might make it more robust
    # bash script must have the shebang(#!/bin/bash) as the first line to view
    # Add "read line" test for the shebang (#!/bin/bash) for syntax highlighting
    if [[ $doc == *".sh" ]]; then
        if command -v highlight >/dev/null 2>&1 ; then
            highlight=" | highlight -O xterm256"
            baseLess=" | less -R"
            page="$baseWget $rawBaseURL$doc $highlight $baseLess"
            echo "$page" # enable echo for troubleshooting
            eval "$page"
        else
            sorory="#> highlight not found <# To install it run: sudo apt install highlight"
            page="$baseWget $rawBaseURL$doc $baseLess"
            echo "$page" # enable echo for troubleshooting
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

# True if the length of $menuFileNumber is non-zero and also not the string "0"
 if [[ -n "$menuFileNumber" && "$menuFileNumber" != "0" ]]; then
    makePage
else
    sorry=$invalidInput
fi

echo
done
