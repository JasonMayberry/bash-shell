#!/bin/bash

        read #- Read Values from Standard Input -#
             #===================================#
# The read builtin command is used to read a single line of standard input. 
# This command can be used to read keyboard input or, when redirection is employed, 
# a line of data from a file. The command has the following syntax:
# read [-options] [variable...]
# where options is one or more of the available options listed below in the Table 
# and variable is the name of one or more variables used to hold the input value. 
# If no variable name is supplied, the shell variable REPLY contains the line of data.

##############################################################################
# +--------------------------------------------------------------------------+
# |                              read Options                                |
# +------------+-------------------------------------------------------------+
# |   Option   |                         Description                         |
# +------------+-------------------------------------------------------------+
# | -a array   | The first character in the string delimiter is used to      |
# |            | indicate the end of input, rather than a newline character. |
# +------------+-------------------------------------------------------------+
# | -e         | Use Readline to handle input. This permits input editing    |
# |            | in the same manner as the command line.                     |
# +------------+-------------------------------------------------------------+
# | -i string  | Use string as a default reply if the user simply presses    |
# |            | Enter. Requires the -e option.                              |
# +------------+-------------------------------------------------------------+
# | -n num     | Read num characters of input, rather than an entire line.   |
# +------------+-------------------------------------------------------------+
# | -p prompt  | Display a prompt for input using the string prompt.         |
# +------------+-------------------------------------------------------------+
# | -r         | Raw mode. Do not interpret backslash characters as          |
# |            | escapes.                                                    |
# +------------+-------------------------------------------------------------+
# | -s         | Silent mode. Do not echo characters to the display as       |
# |            | they are typed. This is useful when inputting passwords     |
# |            | and other confidential information.                         |
# +------------+-------------------------------------------------------------+
# | -t seconds | Timeout. Terminate input after seconds. read returns a      |
# |            | non-zero exit status if an input times out.                 |
# +------------+-------------------------------------------------------------+
# | -u fd      | Use input from file descriptor fd, rather than standard     |
# |            | input.                                                      |
# +------------+-------------------------------------------------------------+


#- read can assign input to multiple variables, as shown in this script: -#
#=========================================================================#
#!/bin/bash
# read-multiple: read multiple values from keyboard
echo -n "Enter one or more values > "
read var1 var2 var3 var4 var5
echo "var1 = '$var1'"
echo "var2 = '$var2'"
echo "var3 = '$var3'"
echo "var4 = '$var4'"
echo "var5 = '$var5'"

#If no variables are listed after the read command, a shell variable, REPLY, will be as- signed all the input.

#!/bin/bash
# read-single: read multiple values into default variable
echo -n "Enter one or more values > "
read
echo "REPLY = '$REPLY'"


                              #--  DEFAULT RESPONSE --#
                              #=======================#
# It's possible to supply the user with a default response using the -e and -i options together.

#!/bin/bash
# read-default: supply a default value if user presses Enter key.
read -e -p "What is your user name? " -i $USER
echo "You answered: '$REPLY'"

# In this script, we prompt the user to enter a username and use the environment variable USER to 
# provide a default value. When the script is run, it displays the default string and if the user 
# simply presses the Enter key, read will assign the default string to the REPLY variable.

[me@linuxbox ~]$ read-default
What is your user name? me 
You answered: 'me'


# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# XX    You Can’t Pipe read    XX
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

#--  Validating Input  --#
#========================#
# With our new ability to have keyboard input comes an additional programming challenge, 
# validating input. Often the difference between a well-written program and a poorly 
# written one lies in the program’s ability to deal with the unexpected.

# Here we have an example program that validates various kinds of input:
#!/bin/bash
# read-validate: validate input
invalid_input () {
    echo "Invalid input '$REPLY'" >&2
    exit 1
}
read -p "Enter a single item > "
####### input is empty (invalid) #######
[[ -z "$REPLY" ]] && invalid_input
####### input is multiple items (invalid) #######
(( "$(echo "$REPLY" | wc -w)" > 1 )) && invalid_input
####### is input a valid filename? #######
if [[ "$REPLY" =~ ^[-[:alnum:]\._]+$ ]]; then
    echo "'$REPLY' is a valid filename."
    if [[ -e "$REPLY" ]]; then
        echo "And file '$REPLY' exists."
    else
        echo "However, file '$REPLY' does not exist."
    fi
    ####### is input a floating point number? #######
    if [[ "$REPLY" =~ ^-?[[:digit:]]*\.[[:digit:]]+$ ]]; then
        echo "'$REPLY' is a floating point number."
    else
        echo "'$REPLY' is not a floating point number."
    fi
    ####### is input an integer? #######
    if [[ "$REPLY" =~ ^-?[[:digit:]]+$ ]]; then
        echo "'$REPLY' is an integer."
    else
        echo "'$REPLY' is not an integer."
    fi
else
    echo "The string '$REPLY' is not a valid filename."
fi



#--  Menus  --#
#=============#
# A common type of interactivity is called menu-driven. In menu-driven programs, 
# the user is presented with a list of choices and is asked to choose one.

#!/bin/bash
# read-menu: a menu driven system information program
clear
echo "
Please Select:
1. Display System Information
2. Display Disk Space
3. Display Home Space Utilization
0. Quit
"
read -p "Enter selection [0-3] > "
if [[ "$REPLY" =~ ^[0-3]$ ]]; then
    if [[ "$REPLY" == 0 ]]; then
        echo "Program terminated."
exit fi
    if [[ "$REPLY" == 1 ]]; then
        echo "Hostname: $HOSTNAME"
        uptime
        exit
    fi
    if [[ "$REPLY" == 2 ]]; then
df -h
exit fi
    if [[ "$REPLY" == 3 ]]; then
        if [[ "$(id -u)" -eq 0 ]]; then
             echo "Home Space Utilization (All Users)"
             du -sh /home/*
        else
             echo "Home Space Utilization ($USER)"
             du -sh "$HOME"
        fi
exit fi
else
    echo "Invalid entry." >&2
    exit 1
fi







