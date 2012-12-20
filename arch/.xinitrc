[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#setxkbmap -layout "es"
#VBoxClient-all &

xsetroot -cursor_name left_ptr
feh --bg-fill ~/Images/background.jpg
compton --config ~/.compton.conf -b

while xmonad; do
    sleep 1
done
