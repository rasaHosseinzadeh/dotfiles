setbg &
unclutter &
mpd &
dunst &
xcompmgr &
dwmblocks &
xset r rate 300 50 &
sxhkd &
backlight_control 25 &
# This line autostarts an instance of Pulseaudio that does not exit on idle.
# This is "necessary" on Artix due to a current bug between PA and
# Chromium-based browsers where they fail to start PA and use dummy output.
# Copied from Luke Smith
pidof -s runit &&
	! pidof -s pulseaudio >/dev/null 2>&1 &&
	setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1
exec dwm
