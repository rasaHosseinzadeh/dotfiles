# Extend Path
export PATH=$PATH:~/.scripts/
# Vim like keybindings
bindkey -v
# Arrow keys to search only the matching
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (true||( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

#-----------------------------
# Syntax highlighting
#-----------------------------
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.config/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export EDITOR="nvim"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS
#-----------------------------
# Ailiases
#-----------------------------
alias lsda="lsd -alh"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias lsa='ls --color=auto --human-readable --group-directories-first --classify -la'
alias ~="cd ~"
alias .="cd .."
alias ..="cd ..;cd .."
alias grep=rg
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist 
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

# The following lines were added by compinstall

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' menu select=1
zstyle :compinstall filename "$HOME/.config//.zshrc"

autoload -Uz compinit
compinit


#------------------------------
# Prompt
#------------------------------
source ~/.config/zsh/git-prompt.zsh/git-prompt.zsh
source ~/.config/zsh/git-prompt.zsh/examples/pure.zsh
PROMPT=$'%F{cyan}[%f%(!.%F{red}%n%f.%F{green}%n%f)%F{cyan}@%f${p_host}%F{cyan}]%F{green}%F{blue}%~%f %F{242}$(gitprompt)%f%(12V.%F{242}%12v%f.)
%(?.%F{green}.%F{red})❯%f '

RPROMPT=''

# Fancy cd that can cd into parent directory, if trying to cd into file.
# useful with ^F fuzzy searcher.
cd() {
    if (( $+2 )); then
        builtin cd "$@"
        return 0
    fi

    if [ -f "$1" ]; then
        echo "${yellow}cd ${1:h}${NC}" >&2
        builtin cd "${1:h}"
    else
        builtin cd "${@}"
    fi
}

