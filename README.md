# bash-shell

This is just a collection of notes from my study of the BASH shell. They are indexed and used from the command line with the shell script “crepo.sh”.  
  
I’m using Ubuntu Linux. I have not tested this code on any other platforms!  
  
```  
Install crepo  
# add the line below too ~.bashrc file. It will add ~/bin folder to $PATH  
    me@linuxBox:~$ export PATH="$HOME/bin:$PATH"  

    me@linuxBox:~$ mkdir ~/bin  
    me@linuxBox:~$ wget -P ~/bin https://raw.githubusercontent.com/JasonMayberry/bash-shell/master/crepo.sh  
    me@linuxBox:~$ mv ~/bin/crepo.sh crepo
    me@linuxBox:~$ chmod 755 ~/bin/crepo  
  
# after that you should be able to run crepo from any location in the terminal  
    me@linuxBox:~$ crepo  
```
