# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export TERM=xterm-256color
export GOPATH=$HOME/gocode
export JAVA_HOME=/etc/alternatives/jre
export PATH=$GOPATH/bin:$PATH
export GDK_SCALE=2

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias vi='vim'
alias copy="xclip -sel c < $2"

function agent() {
    [ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent -s)
    ssh-add "$@"
}

function cd() {
    local __dest
    __dest="$*"
    [ $# -eq 0 ] && __dest=$HOME
    builtin cd "$__dest" && ls -a --group-directories-first
}

ap() {
    playbook=$1
    switch=$2
    env=$3
    shift 3
    printf 'Using profile: %s\n' "${env%%/*}"
    AWS_PROFILE="${env%%/*}" ansible-playbook "$playbook" "$switch" "$env" "$@"
}

# Set history format and update after every command
HISTFILESIZE=10000
HISTSIZE=10000
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
    [ -n "$VIRTUAL_ENV" ] && PS1="(venv) $PS1"
    history -a # Record history after each command
}
