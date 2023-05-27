
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
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

export PATH=$PATH:$HOME/.local/bin/

export CARGO_HOME=$XDG_DATA_HOME/share/cargo

export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='o:fzopen;p:preview-tui;i:imgview;z:fzz'

export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config


export SUDO_ASKPASS="${HOME}/.local/bin/dm-pass"

export FZF_DEFAULT_OPTS="-i  --multi --layout=reverse --height 40%"

export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

export BROWSER=brave
export TERMINAL=st
export EDITOR=nvim
export VISUAL=nvim


export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode


export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

export MANPAGER="sh -c 'col  -bx |  bat -l man -p'"
