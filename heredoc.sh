#!/bin/bash

# - Heredoc - #
#=============#
cat <<END
hello world
END

# - Heredoc Using Variables - #
#=============================#
#!/bin/bash
start="Hello everybody"
end="Good Luck"
cat <<ADDTEXT3
$start
Welcome to Linux Blog Site.
$end
ADDTEXT3


           #--  here strings  --#
           #====================#
# The <<< operator indicates a here string. A here string is like a 
# here document, only shorter, consisting of a single string.
# A here string is used to for input redirection from text or a variable.

[me@linuxbox ~]$ words="word1 word2 word3"
[me@linuxbox ~]$ cat <<<$words
Output: 
# word1 word2 word3

[me@linuxbox ~]$ cat $words
Output: 
# cat: word1: No such file or directory
# cat: word2: No such file or directory
# cat: word3: No such file or directory


# Here String Syntax
COMMAND <<< text 

# Here String Example
#!/bin/bash
tr a-z A-Z <<< hello

Output: 
# HELLO


# Here String Example with a Variable
#!/bin/bash
myvariable="one two three four five six seven"
tr a-z A-Z <<< $myvariable

Output:
# ONE TWO THREE FOUR FIVE SIX SEVEN













