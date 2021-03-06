#!/bin/bash

# From: Bash Scripting Basics Part 1, 2 and 3
# https://www.youtube.com/watch?v=NSu4IWlOU7k

# viewing environment variables
echo "The value of the home variable is: "
echo $HOME

# issue a command
echo "The output of the pwd command is: "
pwd

# that's boring, grab output and make it readable
echo "The value of the pwd command is $(pwd)"

# assign command output to a variable
output-$(pwd)
echo "The value of the output variable is ${output}"

# view data on the command line
echo "I saw $@ on the command line"

# read data from the user
echo "Enter a value: "
read userinput
echo "You just entered $userinput"

# concatenate userinput with command output
echo "Enter a file extension: "
read ext
touch "yourfile. ${ext}"

# check to see if a file exists
If [ -d /etc/sysconfig ]; then
	echo "That file is there and a directory"
else
	echo "Not there or not a directory"
fi




#!/bin/bash
for i in $(seq 10)
do
	echo "Value is: $i"
done



#!/bin/bash
for i in $(ls)
do
	echo "Value is: $i"
done




#!/bin/bash
# Only supports integer arithmetic
# Cannot deal with floating point numbers
if [ $((${1} % 2)) -eq 0 ]; then
	echo "Even!"
else
	echo "Odd!"
fi



#!/bin/bash
# check-dependency.sh 
if command -v nodejs >/dev/null 2>&1 ; then
    echo "nodejs found"
    echo "version: $(nodejs -v)"
else
    echo "nodejs not found"
fi


#!/bin/bash
# keyDown-event-listener.sh
while true; do
read -rsn1 input
if [ "$input" = "a" ]; then
    echo "hello world"
fi
done


#!/bin/bash
#test-heredoc.sh
start="Hello everybody"
end="Good Luck"
cat <<_END_
$start
Welcome to Linux Blog Site.
$end
_END_



