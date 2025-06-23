bindkey -v          # Vim like keybindings
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

#------------------------------
# History stuff
#------------------------------
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_FIND_NO_DUPS  # Do not find duplicate command when searching
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time
setopt inc_append_history_time # record how long the command took
setopt SHARE_HISTORY # share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS # Dont record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_SPACE # Dont record an entry starting with a space
#------------------------------
# Comp stuff
#------------------------------
autoload -Uz compinit
zmodload zsh/complist
# The following lines were added by compinstall
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' menu select
zstyle :compinstall filename "$HOME/.config//.zshrc"
#End of added

mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.


#------------------------------
# Make arrows go through matching
# entries in history
#------------------------------
typeset -g -A key
autoload -Uz add-zle-hook-widget
function zle_application_mode_start { echoti smkx }
function zle_application_mode_stop { echoti rmkx }
add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
bindkey -- "${key[Up]}"   up-line-or-beginning-search
bindkey -- "${key[Down]}" down-line-or-beginning-search

#------------------------------
# zoxide
#------------------------------
eval "$(zoxide init zsh)"



#------------------------------
# starship prompt
#------------------------------
eval "$(starship init zsh)"

#------------------------------
# yazi
#------------------------------
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


#-----------------------------
# Sources
#-----------------------------
source $XDG_CONFIG_HOME/zsh/aliasrc
source $XDG_CONFIG_HOME/zsh/private
#
#-----------------------------
# SSH
#-----------------------------
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
eval $(keychain --eval --quiet git_ed25519 ssh_rsa --absolute --dir "$XDG_RUNTIME_DIR"/keychain)

#------------------------------
# fzf
#------------------------------
eval "$(fzf --zsh)"
f ()
{
  sel=$(fzf)
  [ -f "$sel" ] && xdg-open "$sel"
  [ -d "$sel" ] && cd "$sel"
}

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset)  fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)          fzf --preview 'dig {}' ;;
    *)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "@$" ;;
  esac
}

bindkey -M emacs '\eo' fzf-cd-widget
bindkey -M viins '\eo' fzf-cd-widget
bindkey -M vicmd '\eo' fzf-cd-widget
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'


#-----------------------------
# uv
#-----------------------------
eval "$(uv generate-shell-completion zsh)" # you should already have these two lines
eval "$(uvx --generate-shell-completion zsh)"

# you will need to add the lines below
# https://github.com/astral-sh/uv/issues/8432#issuecomment-2453494736
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

#-----------------------------
# Syntax highlighting (Should be last)
#-----------------------------
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2> /dev/null


