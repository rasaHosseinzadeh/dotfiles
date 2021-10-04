setbg &
unclutter &
mpd &
dunst &
xcompmgr &
dwmblocks &
play-with-mpv
xset r rate 300 50 &
sxhkd &
xbacklight -set 25 &
setxkbmap -option caps:escape
# This line autostarts an instance of Pulseaudio that does not exit on idle.
# This is "necessary" on Artix due to a current bug between PA and
# Chromium-based browsers where they fail to start PA and use dummy output.
# Copied from Luke Smith
pidof -s runit &&
	! pidof -s pulseaudio >/dev/null 2>&1 &&
	setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1
exec dwm
