[ "$(tty)" = "/dev/tty1" ] && exec Hyprland
eval $(ssh-agent -s)
# [ "$(tty)" = "/dev/tty2" ] && ! pidof -s Xorg >/dev/null 2>&1 && sx sh "${XDG_CONFIG_HOME}/X11/.xinitrc"
