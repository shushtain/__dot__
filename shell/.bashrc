#
# ~/.bashrc
#

[[ $- != *i* ]] && return
[[ -f $HOME/.profile ]] && . "$HOME/.profile"
[[ -f $HOME/.secrets ]] && . "$HOME/.secrets"
[[ -f $HOME/.bash_aliases ]] && . "$HOME/.bash_aliases"

hyprctl switchxkblayout at-translated-set-2-keyboard 0 >/dev/null

HISTCONTROL=ignorespace:erasedups

__ps1_vspace=""
__ps1() {
    local title="\[\e]0;\w\a\]"

    local dir_raw="\w"
    local dir="\[\e[1;92m\]$dir_raw\[\e[0m\] "

    local symbol_raw="\\$"
    local symbol="\[\e[1;90m\]$symbol_raw\[\e[0m\] "

    local vspace_check
    vspace_check=$(history 1 | awk '{$1=""; print $0}' | xargs)
    if [[ "$vspace_check" == "clear"* || "$vspace_check" == "reset"* || "$vspace_check" == "c" ]]; then
        __ps1_vspace=""
    fi

    local jobs_raw=""
    local jobs=""
    if [ -n "$(jobs -s)" ]; then
        jobs_raw="&"
        jobs="\[\e[1;91m\]$jobs_raw\[\e[0m\] "
    fi

    local venv_raw=""
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv_raw="$(basename "$VIRTUAL_ENV")"
        venv="\[\e[1;95m\]$venv_raw\[\e[0m\] "
    fi

    local git_raw=""
    local git=""
    local git_branch
    git_branch="$(git branch --show-current 2>/dev/null)"
    if [ -n "$git_branch" ]; then
        local git_color="\[\e[1;94m\]"
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            git_color="\[\e[1;93m\]"
        fi
        git_raw="$git_branch"
        git="$git_color$git_raw\[\e[0m\] "
    fi

    local style="\[\e[1;96m\]"

    PS1="$title$__ps1_vspace$jobs$dir$git$venv\n$symbol$style"

    __ps1_vspace="\n"

    # for alacritty
    echo -e -n "\\x1b[0 q"
}
PROMPT_COMMAND=__ps1
PS0="\[\e[0m\]"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
eval "$(batman --export-env)"
