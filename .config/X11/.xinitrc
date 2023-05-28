setbg &
unclutter &
mpd &
dunst &
xcompmgr &
dwmblocks &
xset r rate 300 50 &
sxhkd &
xbacklight -set 25 &
xuatolock -time 10 -locker "systemctl suspend" -detectsleep
export MENU=dmenu
setxkbmap -option caps:escape
exec dwm
