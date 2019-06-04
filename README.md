# bash-shell

This is just a collection of notes from my study of the BASH shell. They are indexed and used from the command line with the shell script “jdocs.sh”.  
  
I’m using Ubuntu Linux. I have not tested this code on any other platforms!  
  
Install jdocs  
\# add the line below too ~.bashrc file. It will add ~/bin folder to $PATH  
me@linuxBox:~$ export PATH="$HOME/bin:$PATH"  

me@linuxBox:~$ mkdir ~/bin  
me@linuxBox:~$ wget -qO- https://raw.githubusercontent.com/JasonMayberry/bash-shell/master/jdocs.sh | cat > ~/bin/jdocs  
me@linuxBox:~$ chmod 755 ~/bin/jdocs  
  
\# after that you should be able to run jdocs from any location in the terminal  
me@linuxBox:~$ jdocs  
