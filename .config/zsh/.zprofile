[ "$(tty)" = "/dev/tty1" ] && dbus-run-session Hyprland
# [ "$(tty)" = "/dev/tty2" ] && ! pidof -s Xorg >/dev/null 2>&1 && sx sh "${XDG_CONFIG_HOME}/X11/.xinitrc"
