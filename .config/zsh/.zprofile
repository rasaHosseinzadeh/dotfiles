[ "$(tty)" = "/dev/tty1" ] && start-hyprland
# [ "$(tty)" = "/dev/tty2" ] && ! pidof -s Xorg >/dev/null 2>&1 && sx sh "${XDG_CONFIG_HOME}/X11/.xinitrc"
