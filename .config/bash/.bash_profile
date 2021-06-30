#
# ~/.bash_profile
#

BASHRC_CONFIG_DIR=~/.config/bash

[ -f "$BASHRC_CONFIG_DIR/.bashrc" ] && . "$BASHRC_CONFIG_DIR/.bashrc"

export GPG_TTY=$(tty)
