#!/bin/bash

###############################################################################################################
# +-----------------------------------------------------------------------------------------------------------+
# |                                            File Expressions                                               |
# +-----------------------------------------------------------------------------------------------------------+
# |     Expression   |  Is True If:                                                                           |
# +-----------------------------------------------------------------------------------------------------------+
# | file1 -ef file2  |  file1 and file2 have the same inode numbers (the two                                  |
# |                  |   filenames refer to the same file by hard linking).                                   |
# | file1 -nt file2  |  file1 is newer than file2                                                             |
# | file1 -ot file2  |  file1 is older than file2                                                             |
# |         -b file  |  file exists and is a block-special (device) file                                      |
# |         -c file  |  file exists and is a character-special (device) file                                  |
# |         -d file  |  file exists and is a directory                                                        |
# |         -e file  |  file exists                                                                           |
# |         -f file  |  file exists and is a regular file.                                                    |
# |         -g file  |  file exists and is set-group-ID                                                       |
# |         -G file  |  file exists and is owned by the effective group ID                                    |
# |         -k file  |  file exists and has its "sticky bit" set                                              |
# |         -L file  |  file exists and is a symbolic link                                                    |
# |         -O file  |  file exists and is owned by the effective user IID                                    |
# |         -p file  |  file exists and is a named pipe.                                                      |
# |         -r file  |  file exists and is readable (has readable permission for the effective user)          |
# |         -s file  |  file exists and has a length greater than zero                                        |
# |         -S file  |  file exists and is a network socket                                                   |
# |         -t fd    |  fd is a file descriptor directed to/from the terminal. This can be used to determine  |
# |                  |   whether standard input/output/ error is being redirected.                            |
# |         -u file  |  file exists and is setuid                                                             |
# |         -w file  |  file exists and is writable (has write permission for the effective user)             |
# |         -x file  |  file exists and is executable (has execute/search permission for the effective user)  |
# +-----------------------------------------------------------------------------------------------------------+
# 
# Numeric Conditional Operators
  -eq   equals
  -ne   not equals
  -lt   less than
  -le   less than or equal to
  -gt   greater than
  -ge   greater than or equal to

 if [ -f regularfile ]; then
# The above condition is true if the file ‘regularfile’ exists and
# is a regular file. A regular file means that it’s not a block or
# character device, or a directory. This way, you can make sure a usable
# file exists before doing something with it. You can even check if a
# file is readable!

#--- A More Modern Version of test ---#
#=====================================#
# Modern versions of bash include a compound command that acts as an enhanced replacement for test. 
# It uses the following syntax:
 [[ expression ]]
# where, like test, expression is an expression that evaluates to either a true or false result. 
# The [[ ]] command is similar to test (it supports all of its expressions), but adds an important new string expression.
 [[ string1 =~ regex ]]
# This returns true if string1 is matched by the extended regular expression regex. 
# This opens up a lot of possibilities for performing such tasks as data validation.

 Example:
#!/bin/bash
# test-integer2: evaluate the value of an integer.
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [ "$INT" -eq 0 ]; then
        echo "INT is zero."
    else
        if [ "$INT" -lt 0 ]; then
             echo "INT is negative."
        else
             echo "INT is positive."
        fi
        if [ $((INT % 2)) -eq 0 ]; then
             echo "INT is even."
        else
             echo "INT is odd."
        fi
    fi
else
    echo "INT is not an integer." >&2
    exit 1
fi


# Another added feature of [[ ]] is that the == operator supports pattern 
# matching the same way pathname expansion does. Here’s an example:
[me@linuxbox ~]$ FILE=foo.bar
[me@linuxbox ~]$ if [[ $FILE == foo.* ]]; then > echo "$FILE matches pattern 'foo.*'"
> fi
foo.bar matches pattern 'foo.*'


 (( )) - Designed for Integers
# In addition to the [[ ]] compound command, bash also provides the (( )) com- pound command, 
# which is useful for operating on integers. It supports a full set of arith- metic evaluations, 
# a subject we will cover fully in Chapter 34, "Strings and Numbers."
# (( )) is used to perform arithmetic truth tests. An arithmetic truth test results in true if 
# the result of the arithmetic evaluation is non-zero.
[me@linuxbox ~]$ if ((1)); then echo "It is true."; fi It is true.
[me@linuxbox ~]$ if ((0)); then echo "It is true."; fi [me@linuxbox ~]$
# Using (( )), we can slightly simplify the test-integer2 script like this:

#!/bin/bash
# test-integer2a: evaluate the value of an integer.
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then if ((INT == 0)); then
        echo "INT is zero."
    else
if ((INT < 0)); then
echo "INT is negative."
        else
             echo "INT is positive."
fi
if (( ((INT % 2)) == 0)); then
             echo "INT is even."
        else
             echo "INT is odd."
        fi
fi else
    echo "INT is not an integer." >&2
exit 1 fi

# Notice that we use less-than(<) and greater-than(>) signs and that == is used to test for equivalence.

#---- Combining Expressions -----#
#================================#
# It’s also possible to combine expressions to create more complex evaluations. Expressions are combined 
# by using logical operators. We saw these in Chapter 17, "Searching for Files," when we learned about 
# the find command. There are three logical operations for test and [[ ]]. They are AND, OR and NOT. 
# test and [[ ]] use different operators to represent these operations :
# +-----------+----------+---------------+
# | Operation | test [ ] | [[ ]]and(( )) |
# +-----------+----------+---------------+
# | AND       |    -a    | &&            |
# +-----------+----------+---------------+
# | OR        |    -o    | ||            |
# +-----------+----------+---------------+
# | NOT       |    !     | !             |
# +-----------+----------+---------------+

# Here’s an example of an AND operation. 
# The following script determines whether an integer is within a range of values:

#!/bin/bash
# test-integer3: determine if an integer is within a
# specified range of values.
MIN_VAL=1
MAX_VAL=100
INT=50
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [[ "$INT" -ge "$MIN_VAL" && "$INT" -le "$MAX_VAL" ]]; then
        echo "$INT is within $MIN_VAL to $MAX_VAL."
    else
        echo "$INT is out of range."
    fi
else
        echo "INT is not an integer." >&2
exit 1 fi
# In this script, we determine whether the value of integer INT lies between the values of MIN_VAL and MAX_VAL. 
# This is performed by a single use of [[ ]], which includes two expressions separated by the && operator.



Expressions
# An expression can be: String comparison, Numeric comparison, File operators 
# and Logical operators and it is represented by [expression]:

    Integer-Comparisons
#-- Number Comparisons: --#
#=========================#
-eq - is equal to - if [ "$a" -eq "$b" ]
-ne - is not equal to - if [ "$a" -ne "$b" ]
-gt - is greater than - if [ "$a" -gt "$b" ]
-ge - is greater than or equal to - if [ "$a" -ge "$b" ]
-lt - is less than - if [ "$a" -lt "$b" ]
-le - is less than or equal to - if [ "$a" -le "$b" ]
< - is less than - (("$a" < "$b"))
<= - is less than or equal to - (("$a" <= "$b"))
> - is greater than - (("$a" > "$b"))
>= - is greater than or equal to - (("$a" >= "$b"))

Examples:
[ n1 -eq n2 ]  (true if n1 same as n2, else false)
[ n1 -ge n2 ]  (true if n1greater then or equal to n2, else false)
[ n1 -le n2 ]  (true if n1 less then or equal to n2, else false)
[ n1 -ne n2 ]  (true if n1 is not same as n2, else false)
[ n1 -gt n2 ]  (true if n1 greater then n2, else false)
[ n1 -lt n2 ]  (true if n1 less then n2, else false)



    String-Comparisons:
#-- String Comparisons: --#
#=========================#
= - is equal to - if [ "$a" = "$b" ] 
== - is equal to - if [ "$a" == "$b" ] 
!= - is not equal to - if [ "$a" != "$b" ] 
< - is less than, in ASCII alphabetical order - if [[ "$a" < "$b" ]] 
> - is greater than, in ASCII alphabetical order - if [[ "$a" > "$b" ]] 
-z - string is null, that is, has zero length

Examples:
[ s1 = s2 ]  (true if s1 same as s2, else false)
[ s1 != s2 ]  (true if s1 not same as s2, else false)
[ s1 ]   (true if s1 is not empty, else false)
[ -n s1 ]   (true if s1 has a length greater then 0, else false)
[ -z s2 ]   (true if s2 has a length of 0, otherwise false)



Example Script

number.sh
#!/bin/bash
echo -n "Enter a number 1 < x < 10: "
read num
if [ "$num" -lt 10 ]; then
    if [ "$num" -gt 1 ]; then
          echo "$num*$num=$(($num*$num))"
    else
          echo "Wrong insertion !"
    fi
else
    echo "Wrong insertion !"
fi



string.sh
#! /bin/bash
word=a
if  [[ $word == "b" ]]
then
  echo "condition b is true"
elif [[ $word == "a" ]]
then 
  echo "condition a is true" 
else
  echo "condition is false"    
fi




