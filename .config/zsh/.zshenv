
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="/$HOME/.local/state"


export ZDOTDIR=$XDG_CONFIG_HOME/zsh
mkdir -p "$XDG_STATE_HOME"/zsh/     #Make sure directory exists
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export GNUPGHOME=~/.local/share/gnupg

export GOPATH=$XDG_DATA_HOME/go
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc

export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

mkdir -p $XDG_CACHE_HOME/less
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history

export PATH=$PATH:$HOME/.local/bin/

export CARGO_HOME=$XDG_DATA_HOME/share/cargo

export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='o:fzopen;p:preview-tui;i:imgview;z:fzz'


export BROWSER=firefox
export TERMINAL=st
export EDITOR=nvim
export VISUAL=nvim


export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
