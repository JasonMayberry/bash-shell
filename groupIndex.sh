#!/bin/bash

#------> An input file name followed by an output file name must be given
#------> Example:~$ groupIndex ~/your-file.txt groupIndex-file.txt

# Accepts a -p flag as a second parameter if you want the OUTPUT PRINTED TO THE SCREEN.
#------> Example:~$ groupIndex ~/your-file.txt -p

# This script was originally designed to take a list of movies in the order that they are
# physically stored. The album they are stored in holds 4 movies in each page.
# The script numbers each line in groups of 4 movies with their corresponding
# page number then sorts all the lines alphabetically. Now it can take any list on file.

# initialize shell variables
IFS=$'\n'
arr=()
list=()
sortedList=()
i=0
# Parameter Default Value
inFile=${1:-}
outFile=${2:-}

if [[ -z $1 ]]; then
    echo '###------> An input file name followed by an output file name must be given'
    echo '###------> Example:~$ groupIndex ~/your-file.txt groupIndex-file.txt'
fi
if [[ -f "$1" ]]; then # True if file File or Directory Exists
    while read line # read each line in the input file. Store in $line
    do
        arr[$i]="$line" # Transfer each line into an array item
        i=$((i+1))
    done < $1

    # loop each line item in the array stopping at its length
    for ((i = 0 ; i < ${#arr[@]} ; i++)); do
        # If the line number is evenly divisible by 4 then add 1 to $j
        if (( $i%4 == 0 )); then
            j=$(( j + 1 ))
        fi
        # Append the same number on the end of 4 consecutive lines. Making it a unique group.
        list+=( "${arr[$i]} ----- PAGE #$j" )
    done

# sort all of the list array into new sorted array
sortedList=($(sort <<<"${list[*]}"))
    # Accepts a -p flag as a second parameter if you want the output printed to the screen.
    if [[ $2 == "-p" ]]; then
        printf '%s\n' "${sortedList[@]}"
    else
        if [[ -n $2 ]]; then
        printf '%s\n' "${sortedList[@]}" > $2
        # Uncomment below to see the length of the list array
        # echo "list Array is ${#arr[@]} items long"
        else
            echo '!----------------> No output file name provided'
        fi
    fi
else
    echo '!----------------> Input File Not Found'
fi
