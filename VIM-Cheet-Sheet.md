# Jason's Big but Brief -> Vim Cheat Sheet  
    
### Quitting  
   **ZZ** `-exit, saving changes`  
   **:w** `-write/save changes`  
   **ZQ** `-exit, ignore changes`  
    
## Files  
   **:w file** `-write to file`  
   **:r file** `-read file in after line`  
   **:Explore** `-open vim file explorer`  
   **vim file1 file2** `-open 2 arg files`  
   **:args** `-see list of open args`  
   **:argadd t.txt** `-add to args list`  
   **:argdelete t.txt** `-delete arg(s)`  
   **:argedit t.txt** `-add to args list`  
   **:fir** `<-edit first args list file`  
   **:la** `->edit last args list file`  
   **:n** `->goto next file`  
   **:2n** `->go 2 files right`  
   **:N** `<-goto previous file`  
   **:2N** `<-go 2 files left`  
   **:e file.txt** `-open file in vim`  
    
## File Tabs  
   **vim -p file1 file2** `-open 2 tabs`  
   **:Texplore** `-open file explorer tab`  
   **:mksession work.vim** `-save session`  
   **vim -S work.vim** `-open session`  
   **:source work.vim** `-open session`  
   **:mks!** `-save changes to session`  
   **:tabe file.txt** `-open new tab`  
   **:tabonly** `-close all but current`  
   **:tabn** `-Goto next tab file`  
   **:tabp** `-Goto previous tab file`  
   **gt** `-goto next tab file (cycle)`  
   **2gt** `-takes you to 2nd tab`  
    
## Split Window  
   **:split file** `-split, load file`  
   **:vsplit file** `-vertical split`  
   **ctrl-w up** `-move up a window`  
   **ctrl-w left** `-move left a window`  
   **ctrl-w ctrl-w** `-cycle windows`  
   **ctrl-w _** `-maximize vertically`  
   **ctrl-w |** `-maximize horizontally`  
   **ctrl-w =** `-make all equal size`  
   **:sview file** `-split readonly`  
   **:close** `-close current window`  
   **:Sexplore** `-split, open file explorer`  
   **:Vexplore** `-vertical file explorer`  
   **:Vexplore!** `-open f. explorer on right`  
  *Resizing:*  
   **ctrl-w 2 -** `-drop window height`  
   **ctrl-w 2 +** `-rise window height`  
   **ctrl-w 2 <** `-narrow window width`  
   **ctrl-w 2 >** `-widen window width`  
    
## Settings  
   **:set nu** `-numbered lines`  
   **:set nonu** `-no numbered lines`  
   **:set rnu** `-relative numbered lines`  
   **:set nornu** `-no rel. numbered lines`  
   **:syntax on** `-syntax highlighting on`  
   **:set ruler** `-show current position`  
   **:setlocal spell!** `-spell check on`  
   **:setlocal nospell!** `-spell check off`  
   **:set so=2** `-top & bottom padding`  
   **:set ignorecase** `-when searching`  
   **:noh** `-unsets last search pattern`  
   **:set magic** `-for regular expressions`  
   **:set ai** `-auto indent`  
   **:set si** `-smart indent`  
   **:set wrap** `-wrap lines`  
   **:set tabstop=4** `-␣ width of tab char`  
   **:set softtabstop=0** `-tabstop width`  
   **:set expandtab** `-make tab key spaces`  
   **:set noexpandtab** `-make tab key tabs`  
   **:set shiftwidth=4** `-width of indent`  
   **:set smarttab** `-auto indent on`  
   **:help smarttab** `-more details`  
    
## Inserting text  
   **i** `-insert`  
   **I** `-insert at line beginning`  
   **a** `-append`  
   **A** `-append end of line`  
   **o** `-open on lower line`  
   **O** `-open on Upper line`  
   **s** `-substitute character`  
    
## Insert Mode Shortcuts  
   **ctrl+w** `-delete word b4 cursor`  
   **ctrl+u** `-delete line b4 cursor`  
   **ctrl+n** `-autocomplete`  
    
## Text Objects  
   **ca'** `-change all quotes & 'quoted'`  
   **ci'** `-change inside quotes'`  
   **caw** `-change all word`  
   **diw** `-delete in word`  
   **di'** `-delete text inside quotes'`  
   **da'** `-delete all quotes & 'quoted'`  
   **df␣** `-delete to space include space`   
   **dt␣** `-delete till space`  
   **va'** `-vis. select all quotes & 'quoted'`  
   **vi'** `-vis. select text inside quotes'`  
   **ya'** `-yank all quotes & 'quoted'`  
   **yi'** `-yank text inside quotes'`  
    
## Navigation  
       ^  
       k  
    <h   l>  
       j  
       v     
   **8j** `-move 8 lines down`  
   **gj** `-down 1 wrapped line`  
   **8gg** `-goto line 8`  
   **:8** `-goto line 8`  
   **50%** `-goto middle of doc`  
   **%** `-focus on the opposite brace`  
   **gi** `-back to last insert`  
   **H** `-high on the screen`  
   **M** `-middle of the screen`  
   **L** `-bottom of the screen`  
   **zt** `-work on top of screen`  
   **zz** `-Center workspace`  
   **zb** `-work on bottom of screen`  
   **^** `-first non-blank char`  
   **g_** `-last non-blank char`  
   **ctrl+y** & **ctrl+e** `-scroll ONE line`  
   **ctrl+u** & **ctrl+d** `-scroll HALF-page`  
   **ctrl+b** & **ctrl+f** `-scroll FULL-page`  
   **ctrl+O** `-Retrace moves backwards`  
   **ctrl+I** `-Retrace moves forwards`  
   **/pat** `-iterate all matching words`  
   > `-iterate words same as current`  
   > - **N** `-next one up`  
   > - **n** `-next one down`  

   **#** `-goto previous match of current`  
   **G** `- goto to end of file`  
   **fc** `-go forward to 'c'`  
   **Fc** `-go backward to 'c'`  
   **w** `->goto next word`  
   **W** `->goto next word÷spaces`  
   **e** `->goto end of word`  
   **E** `->goto end of word÷spaces`  
   **b** `<-goto beginning of word`  
   **B** `<-goto begin of word÷spaces`  
   **0** `-goto beginning of line`  
   **$** `-goto end of line`  
   **ma** `-sets local mark`  
   **mA** `-sets global to path mark`  
   **\`a** `-goto mark a`  
   **:marks** `-list of all marks`  
    
## Change  
   **cc** `-change entire line`  
   **cw** `-change word`  
   **cW** `-change all to next space`  
   **C** `-change to the end of line`  
    
## Delete     
   **:1,$d** `-delete all lines`  
  `or :%d or ggdG`  
   **x** `->delete char to the right`  
   **X** `<-delete char to the left`  
   **D** `-delete to the end of line`  
   **dd** `-delete current line`  
   **:d** `-delete current line`  
   **dw** `-delete word`  
   **dW** `-delete all to next space`  
   **df?** `->delete through first "?"`  
   **dt?** `->delete to first "?"`  
   **dF?** `<-delete back through first "?"`  
   **dT?** `<-delete back to first "?"`  
    
## Replace  
   **r** `-replace char not insert`  
   **R** `-replace chars not insert`  
   **:s/pattern/string/flags**  
   **g** `-flag, replace all occurrences`  
   **c** `-flag, confirm replaces`  
    
## Copy & Paste  
   **yy** `-yank/copy line`  
   **5yy** `-yank 5 lines`  
   **:12,16y** `-yank 5 lines`  
   **p** `-put/paste on lower line`  
   **P** `-put/paste on Upper line`  
    
## Visual Mode  
   **v** `-enter visual mode`  
   **V** `-enter visual Line mode`  
   **ctrl+v** `-enter vis. Block mode`  
   **ggvG** `-visual select all`  
   **y** `-yank/copy selected`  
   **o** `-cursor to opposite end`  
   **O** `-cursor to opposite side`  
   **gv** `-restore previous selection`  
   **1v** `-selects area = to the last`  
   **r** `-replaces select with char`  
   **R** `-del. select, starts i mode`  
   **va'** `-vis. select all 'quoted'`  
   **vi'** `-vis. select inside quotes'`  
   > Select block, press c, change 1st  
   > line, press Esc twice, replaces   
   > block by the same text in 1st line.  
   > This also works with i, I or A
    
## Format  
   **==** `-auto format indentation`  
   **=i{** `-indent inside {}`  
   **gg=G** `-fix the indentation global`  
   **:66,70s/^/# /** `-Commenting`  
   **:66,70s/^#/** `-Uncommenting`  
   **:12,20>** `-Indent`  
   **:12,20>>>** `-Indents 3 times`  
   **5>>** `-Indents 5 lines`  
   **5>>..** `-Repeats 5>> twice`  
    
## Special  
   **:h** `-Great help info!`  
   **ctrl+]** `-goto tag when caret is over it`  
   **ctrl+G** `-display cursor location`  
   **:tag tagname** `-jump to the tag`  
   **:%retab** `-replace all tabs with spaces`  
   **xp** `-transpose two letters`  
   **&** `-repeat last :s cmd`  
   **sort** `-sort the whole doc`  
   **22,33sort** `-sort line 22-33`  
   **:'a,.sort** `-from marker a, to caret`  
   **:%sort!** `-sort in reverse`  
   **:%sort u** `-remove duplicate lines`  
   **:sort n** `-do numeric sort`  
   **:sort i** `-case is ignored`  
   **:help sort** `-more options`  
   **~** `-toggle case`  
   **.** `-repeat last cmd`  
   **:!** `-drop to external cmd`  
   **!!ls** `-insert output of cmd`  
   **==** `-duplicate operator`  
    
## Code Folding  
   **zf** `-fold visible line selected`  
   **2zfj** `-fold 3 lines down`  
   **za** `-unfold last fold`  
   **zR** `-unfold all `  
    
## Undo    
   **u** `-undo last change`  
   **U** `-undo all changes to line`  
