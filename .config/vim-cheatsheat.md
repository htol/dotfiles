# Absolute minimum you should know about vim

## Moving around
j, k, h, l - up/down/left/right  
w, b, e - word forward/backward/to the end of word  
f, F - stops on first symbol in current line. ex. f( - going to first '(' / backward  
t, T - stops before symbol in current line / backward  
{} - goto previos/next paragraph (empty line)  
% - if cursor placed on {} or [], than moved between open/close bracers of this level  
$, _ - goto begin/end of the line  
I, A - goto first/last character of the line and enter insert mode  
0 - goto begin of the line  

## Copy/paste
yy - copy current line  
dd - cut current line  
p/P - put (paste) on next/current line  

## Operation with characters
x - delete one character  
s - delete one character and enter insert mode  
S - delete line and enter insert mode  
~ - capitalyse character  
r - replace current character  

## Ins ans outs
di{, ci{, yi{, vi{  
da, ca, ya, va, =a  

## g for gump
gi - jump to last insert mode  
gv - jump to last visual mode  
gq - adjust very long comment  

## Working with windows
Ctrl+w Ctrl+v - vertical split  
Ctrl+w Ctrl+ - horisontal split  
Ctrl+w h/j/k/l - move between panes  
Ctrl+w Ctrl+O - close all non active pane  

:Ex - file manager  

## Exit vim

:!sudo shutdown now - just kidding  
ZZ - exit vim without any changes  


## Save wile without required permission

:w !sudo tee %  
