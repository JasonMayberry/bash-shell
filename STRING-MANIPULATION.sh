#!/bin/bash

STRING MANIPULATION
# Removing ^M Windows line end characters from file
sed 's/\r//g' < input.txt > output.txt
# Search <pattern> in all files in the pwd
grep -RnisI <pattern> *
# Recursive search and replace old with new string, in pwd. 
grep -rl oldstring . |xargs perl -pi~ -e 's/oldstring/newstring'
grep -rl oldstring . |xargs sed -i -e 's/oldstring/newstring/'
# -e to search and replace, -i edits in place.
sed -e 's/dapper/edgy/g' -i /etc/apt/sources.list
# recursive search and replace, in pwd and in subdirs
find . -type f -exec sed -i s/oldstring/newstring/g {} +
grep . * # Read files recursively with file indication
# Quickly generate an MD5 hash for a string using OpenSSL
echo -n 'text to be encrypted' | openssl md5
# Print text string vertically, one character per line.
echo "vertical text" | grep -o '.'
# Convert the first character of a string to uppercase
echo 'example of the test text' | sed -e 's/^\(.\)/\U\1/'
# Convert the first character of every word to uppercase
echo 'example of the test text' | sed -e 's/\b\(.\)/\u\1/g'
# Convert all characters in a string to uppercase
echo 'example of the test text' | tr '[:lower:]' '[:upper:]'
# Convert all characters in a file to lowercase
cat file.txt | tr '[:upper:]' '[:lower:]' 
# Convert all characters in a file to uppercase
cat file.txt | tr '[:lower:]' '[:upper:]'
# output both to the screen (stdout) and to the file.
ls | tee file
# You can pipe your output to multiple files and stdout
ls | tee file1 file2 file3
#append to the file using the –a option
$ ls | tee –a file





#-- STRING MANIPULATION  --#
#==============================#
# -e is the script function, it performs search and replace like vi, 
# and -i is the edit the file in place.
sed -e 's/dapper/edgy/g' -i /etc/apt/sources.list


# Removing ^M (Windows line endings) characters from file with sed
sed 's/\r//g' < input.txt > output.txt


# Search for a <pattern> string inside all files in the current directory
# This is how I typically grep. 
# -R recurse into subdirectories, 
# -n show line numbers of matches, 
# -i ignore case, 
# -s suppress "doesn't exist" and "can't read" messages, 
# -I ignore binary files (technically, process them as having no matches, 
# 	important for showing inverted results with -v) 
# This line should be in your ~/.bashrc file: $ alias grep='grep --color=auto'
grep -RnisI <pattern> *


#This command will show you all the string (plain text) values in ram
sudo apt install binutils
sudo strings /dev/mem | less


#-- Recursive search and replace old with new string, inside files. --#
#---------------------------------------------------------------------#
# recursively traverse the directory structure from . down, look for 
# string "oldstring" in all files, and replace it with "newstring", 
# wherever found also: 
grep -rl oldstring . |xargs perl -pi~ -e 's/oldstring/newstring'
grep -rl oldstring . |xargs sed -i -e 's/oldstring/newstring/'


# Read bunch of small files recursively in a partition with file indication
grep . *


# Quickly generate an MD5 hash for a text string using OpenSSL
echo -n 'text to be encrypted' | openssl md5


# recursive search and replace old with new string, inside files
# This command find all files in the current dir and subdirs, and 
# replace all occurances of "oldstring" in every file with "newstring".
find . -type f -exec sed -i s/oldstring/newstring/g {} +


# Print text string vertically, one character per line.
echo "vertical text" | grep -o '.'


# Convert the first character of a string to uppercase
echo 'example of the test text' | sed -e 's/^\(.\)/\U\1/'

# Convert the first character of every word to uppercase
echo 'example of the test text' | sed -e 's/\b\(.\)/\u\1/g'

# Convert all characters in a string to uppercase
echo 'example of the test text' | tr '[:lower:]' '[:upper:]'

# Convert all characters in a file to lowercase
cat file.txt | tr '[:upper:]' '[:lower:]' 

# Convert all characters in a file to uppercase
cat file.txt | tr '[:lower:]' '[:upper:]'

 
# output only to the file and not to the screen.
ls > file

# output both to the screen (stdout) and to the file.
ls | tee file

# You can pipe your output to multiple files (including your terminal) 
ls | tee file1 file2 file3

# append to the file using the –a option
$ ls | tee –a file
