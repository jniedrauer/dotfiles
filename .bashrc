# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f ~/.dpi ]; then
    . ~/.dpi
fi

export EDITOR=/usr/bin/vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias vi='vim'
alias wp='~/.wp.py'
alias eog='eog -f %U'
alias cfg='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias firefox='GDK_SCALE=1 firefox'
alias mybad='git add -u && git commit --amend --no-edit'

function tls() {
    echo | \
        openssl s_client -showcerts -connect \
        $1:443 -servername $1 2>/dev/null | \
        openssl x509 -inform pem -noout -text
}

function cd() {
    local __dest
    __dest="$*"
    [ $# -eq 0 ] && __dest=$HOME
    builtin cd "$__dest" && ls -a
}

function copy() {
    xclip -sel c < "$1"
}

# Distro specific aliases and env
case "$(uname -s)" in
     Linux*) __distro="$(awk -F '=' '/ID=/ {print $2}' /etc/os-release)" ;;
    Darwin*) __distro=mac ;;
esac

case "$__distro" in
      arch)
        export JAVA_HOME=/usr/lib/jvm/default-runtime
        export BROWSER=~/.local/bin/firefox
        export TERM=rxvt-unicode-256color
        alias ls='ls --color=auto --group-directories-first'
        ;;
    fedora)
        export JAVA_HOME=/etc/alternatives/jre
        export BROWSER=~/.local/bin/firefox
        export TERM=rxvt-unicode-256color
        alias ls='ls --color=auto --group-directories-first'
        ;;
       mac)
        JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
        export JAVA_HOME
        export BROWSER=~/bin/firefox
        export TERM=xterm-256color
        export PATH=$PATH:~/Library/Python/2.7/bin
        export CLICOLOR=1
        export LSCOLORS=ExFxCxDxBxegedabagacad
        export GOROOT=/usr/local/opt/go/libexec
        export PATH=$PATH:$GOROOT/bin
        ;;
esac

if [ "$HIDPI" -eq 1 ]; then
    export GDK_SCALE=2
else
    export GDK_SCALE=1
fi

# Source local aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Set history format and update after every command
HISTFILESIZE=100000
HISTSIZE=100000
HISTTIMEFORMAT="%Y/%m/%d %T  "
shopt -s histappend

# PS1 colors
. ~/.bash_colors
__u="\[$__user_color\]"
__s="\[$__symbol_color\]"
__h="\[$__host_color\]"
__p="\[$__path_color\]"
__y="\[$__success_color\]"
__n="\[$__fail_color\]"
__r="\[$(tput sgr0)\]"

export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    __exit="$?"
    local __e
    local __venv
    [ "$__exit" -eq 0 ] \
        && local __e="$__y" \
        || local __e="$__n"
    PS1="${__venv}${__u}\u${__s}@${__h}\h${__s}:${__p}[\w]${__e}${__exit}${__s}\\$ ${__r}"
    if [ -n "$VIRTUAL_ENV" ]; then
        __venv="${VIRTUAL_ENV##*/}"
        PS1="($__venv) $PS1"
    fi
    history -a # Record history after each command
}

source $(which virtualenvwrapper.sh)

# added by travis gem
[ -f /home/jniedrauer/.travis/travis.sh ] && source /home/jniedrauer/.travis/travis.sh || :
