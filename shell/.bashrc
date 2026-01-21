[[ $- != *i* ]] && return
[[ -f $HOME/.profile ]] && . "$HOME/.profile"
[[ -f $HOME/.secrets ]] && . "$HOME/.secrets"
[[ -f $HOME/.bash_aliases ]] && . "$HOME/.bash_aliases"

shopt -s histappend
HISTCONTROL=ignorespace:erasedups
HISTSIZE=500
HISTFILESIZE=5000

histclean() {
    if [ -f "$HISTFILE" ]; then
        local tmp="${HISTFILE}_tmp$$"
        tac "$HISTFILE" | awk '!x[$0]++' | tac | tail -n "$HISTFILESIZE" >"$tmp"
        mv "$tmp" "$HISTFILE"
    fi
}
trap histclean EXIT

__ps1_vspace=""
__ps1() {
    local c0="\[\e[1;90m\]"
    local c1="\[\e[1;91m\]"
    local c2="\[\e[1;92m\]"
    local c3="\[\e[1;93m\]"
    local c4="\[\e[1;94m\]"
    local c5="\[\e[1;95m\]"
    local c6="\[\e[1;96m\]"

    local title="\[\e]0;\w\a\]"
    local dir="$c2\w "
    local symbol="$c0\\$ "
    local input="$c6"

    local jobs=""
    if [ -n "$(jobs -s)" ]; then
        jobs="$c1& "
    fi

    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv="$c5${VIRTUAL_ENV##*/} "
    fi

    local git=""
    local git_branch
    git_branch="$(git branch --show-current 2>/dev/null)"
    if [ -n "$git_branch" ]; then
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            git="$c3$git_branch "
        elif [ -n "$(git rev-list '@{u}..' 2>/dev/null)" ]; then
            git="$c5$git_branch "
        else
            git="$c4$git_branch "
        fi
    fi

    if [[ "$(history 1)" =~ ^[[:space:]]*[0-9]+[[:space:]]+(clear|reset)([[:space:]]|$) ]]; then
        __ps1_vspace=""
    fi

    local line1="$jobs$dir$git$venv"
    local line2="$symbol$input"
    PS1="$title$__ps1_vspace$line1\n$line2"
    printf "\x1b[0 q"

    __ps1_vspace="\n"

    history -a
    history -n
}
PROMPT_COMMAND=__ps1
PS0="\[\e[0m\]"

eval "$(fzf --bash)"
eval "$(sk --shell bash)"
eval "$(zoxide init bash)"
eval "$(batman --export-env)"
