[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && sx sh "${XDG_CONFIG_HOME}/X11/.xinitrc"
