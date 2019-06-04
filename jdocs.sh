#!/bin/bash

# This script provides BASH shell tips and info

while true; do
clear
echo "##### On which topic do you want see notes? #####"
echo "================================================="
declare -a pages
pages=( 
'[1]. bash-doc.txt' 
'[2]. a-z-index-of-bash-commands' 
'[3]. Regular-Expressions.txt' 
'[4]. Regular-Expression-Basics-Examples.txt' 
'[5]. SHELL-SCRIPTING-TUTORIAL.txt' 
'[6]. 30-Bash-Script-Examples.txt' 
'[7]. Example-Bash-Scripting.sh' 
'[8]. Start-Stop-MySQL-Server-from-Command-Line.txt' 
'[9]. How-to-run-MySQL-Command-from-terminal.txt' 
'[10]. encrypt-decrypt-a-file-in-Linux.txt' 
'[11]. Info-Links' 
'[12]. sublime-text-documentation.txt' 
)

for i in "${pages[@]}"
do
    echo $i
done

echo $list

# echo ${pages[2]}

base_wget="wget -qO- "
base_url="https://raw.githubusercontent.com/JasonMayberry/bash-shell/master/"
base_less=" | less" 

if [ "$sorry" != "" ]; then
    echo
fi
echo $sorry
if [ "$topic" != 'q' ]; then
    echo "[ q to Exit ]"
fi
echo -n "Type a topic number: "
read topic
echo
if [ "$topic" != "q" ]; then
echo "Topic #$topic: "
fi
echo
sorry=""

if [ $topic == 'q' ]; then
    break
fi


case "$topic" in
    '1')
        str=${pages[0]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '2')
        str=${pages[1]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '3')
        str=${pages[2]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '4')
        str=${pages[3]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '5')
        str=${pages[4]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '6')
        str=${pages[5]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '7')
        str=${pages[6]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '8')
        str=${pages[7]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '9')
        str=${pages[8]}
        doc=${str/\[[0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '10')
        str=${pages[9]}
        doc=${str/\[[0-9][0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '11')
        str=${pages[10]}
        doc=${str/\[[0-9][0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    '12')
        str=${pages[11]}
        doc=${str/\[[0-9][0-9]\]\.[[:space:]]/}
        page="$base_wget $base_url$doc $base_less" 
        eval "$page"
        ;;
    *)
       if [[ $topic =~ ^[0-9]{,2}$ ]]; then
             sorry="#-------------> Topic #$topic could not be found."
         else
             sorry="#-------------> Invalid Input -  Type a number from 0-99"
         fi
        ;;
esac

echo

done
