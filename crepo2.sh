#!/bin/bash
# set -euo pipefail # Unofficial Bash Strict Mode
# IFS=$'\n\t'

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
# [3]. Run crepo2 with or without a repo url as folows:
#      Without a repo url = View Default Repository
#      [me@linuxBox]~$ crepo2
#      [me@linuxBox]~$ crepo2 https://github.com/epety/100-shell-script-examples
#
# [4]. Change repo_URL to set the default repository, 
#      located on the first uncommented line this file.

#---------- DEPENDENCIES -----------#
# crepo2 requires "highlight" to be installed
# On any Debian derivative it can be installed 
# like this: [me@linuxBox]~$ sudo apt install highlight
#
#-------------- NOTE ---------------#
# With crepo2 the file suffix must be ".sh" and the bash script must have the
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
invalidInput="#-------------> Invalid Input"
declare -a fileNamesArray=()

clear
echo "#####   Which Repo File?     [Ctrl-c to Exit]   #####"
echo "====================================================="
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
    pre=${searchHTML//n-open\" title=\"/}; trimFileName=${pre//\" id=\"/}
fi

if [ ${#fileNamesArray[@]} -eq 0 ]; then
    fileNamesArray=($trimFileName) # Create an array from space delimited file names
fi

theLength=${#fileNamesArray[@]} # get length of the array

select menuFileNumber in ${fileNamesArray[*]} 
do
    if [[ -z $menuFileNumber ]]; then
         sorry=$invalidInput
    fi
    if [ -n "$sorry" ]; then # True if length non-zero
        echo $sorry
    fi

    sorry=""

    function check_highlight() {
        # Maybe case statement should be used here to test for all file types that "highlight" supports
        # Try, catch, might make it more robust
        # bash script must have the shebang(#!/bin/bash) as the first line to view
        # Add "read line" test for the shebang (#!/bin/bash) for syntax highlighting
        if [[ $menuFileNumber == *".sh" ]]; then
            if command -v highlight >/dev/null 2>&1 ; then
                highlight=" | highlight -O xterm256"
                baseLess=" | less -R"
                page="$baseWget $rawBaseURL$menuFileNumber $highlight $baseLess"
                echo "$rawBaseURL$menuFileNumber"
                eval "$page"
            else
                sorory="#> highlight not found <# To install it run: sudo apt install highlight"
                page="$baseWget $rawBaseURL$menuFileNumber $baseLess"
                echo "$rawBaseURL$menuFileNumber"
                eval "$page"
            fi
        else
        page="$baseWget $rawBaseURL$menuFileNumber $baseLess"
        echo "$rawBaseURL$menuFileNumber"
        eval "$page"
        fi
     }

    # True if the length of $menuFileNumber is non-zero and also not the string "0"
     if [[ -n "$menuFileNumber" && "$menuFileNumber" != "0" ]]; then
        check_highlight
    else
        sorry=$invalidInput
    fi

done
