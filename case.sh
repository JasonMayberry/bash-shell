#!/bin/bash

#--  Pattern Examples used by case  --#
#=====================================#
# +--------------+---------------------------------------------------+
# | Pattern      | Description                                       |
# +--------------+---------------------------------------------------+
# | a)           | Matches if word equals “a”.                       |
# +--------------+---------------------------------------------------+
# | [[:alpha:]]) | Matches if word is a single alphabetic character. |
# +--------------+---------------------------------------------------+
# | ???)         | Matches if word is exactly three characters long. |
# +--------------+---------------------------------------------------+
# | *.txt)       | Matches if word ends with the characters “.txt”.  |
# +--------------+---------------------------------------------------+
# | *)           | Matches any value of word.                        |
# +--------------+---------------------------------------------------+

#!/bin/bash
read -p "enter word > "
case "$REPLY" in
	[[:alpha:]]) echo "is a single alphabetic character." ;;
	[ABC][0-9]) echo "is A, B, or C followed by a digit." ;;
	???) echo "is three characters long." ;;
	*.txt) echo "is a word ending in '.txt'" ;;
	*) echo "is something else." ;;
esac


#--  Vertical bar creates an “or” conditional pattern.  --#
#=========================================================#
#!/bin/bash
# case-menu: a menu driven system information program
clear
echo "
Please Select:
A. Display System Information
B. Display Disk Space
C. Display Home Space Utilization
Q. Quit
"
read -p "Enter selection [A, B, C or Q] > "
case "$REPLY" in
	q|Q) echo "Program terminated."
		exit
		;;
	a|A) echo "Hostname: $HOSTNAME"
		uptime 
		;; 
	b|B) df -h
		;;
	c|C) if [[ "$(id -u)" -eq 0 ]]; then
	         echo "Home Space Utilization (All Users)"
	         du -sh /home/*
	    else
	         echo "Home Space Utilization ($USER)"
	         du -sh "$HOME"
	    fi
		;;
	*) echo "Invalid entry" >&2
		exit 1
		;; 
esac


#--  The addition of the ;;& syntax allows case to continue to the next test rather than simply terminating.  --#
#===============================================================================================================#
#!/bin/bash
# case4-2: test a character
read -n 1 -p "Type a character > "
echo
case "$REPLY" in
    [[:upper:]])    echo "'$REPLY' is upper case." ;;&
    [[:lower:]])    echo "'$REPLY' is lower case." ;;&
    [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
    [[:digit:]])    echo "'$REPLY' is a digit." ;;&
    [[:graph:]])    echo "'$REPLY' is a visible character." ;;&
    [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;&
    [[:space:]])    echo "'$REPLY' is a whitespace character." ;;&
    [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;&
esac








