#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

alias startx='startx &> ~/.xlog'
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
