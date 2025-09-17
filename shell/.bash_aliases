alias rc='source ~/.bashrc'

alias cp='cp -vi'
alias mv='mv -vi'
alias c='clear'

s() { if [[ $# == 0 ]]; then sudo "$(history -p '!!')"; else sudo "$@"; fi; }

alias ls='eza'
alias list='eza -al --group-directories-first --git'
alias tree='eza -T --group-directories-first'

alias man='batman'
alias dust='dust --depth 1'
alias systui='systemctl-tui'
alias ff='fastfetch'

alias parui='parui -p=yay'
bay() {
    yay -Qi "$@" | rg "^URL\s*:\s*(.*)\s*$" -r '$1' | xargs -r xdg-open
}

alias x='cd -'
alias ..='cd ..'
alias ...='cd ../../'

alias n='nvim'
alias xn='cd - && nvim'
zn() { z "$@" && nvim; }
zin() { zi "$@" && nvim; }

nsfw() {
    NVIM_APPNAME="$1" nvim "${@:2}"
}

alias e='yazi'
alias xe='cd - && yazi'
ze() { z "$@" && yazi; }
zie() { zi "$@" && yazi; }

# GIT

alias gs='git status'
alias gss='git status --short --branch'

alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias gstat='git diff --stat'
alias gdelta='DELTA_FEATURES=+side-by-side git diff'

alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -am'

alias gco='git checkout'
alias gcob='git checkout -b'
alias gcox='git checkout -'
alias gw='git switch'

alias gp='git push'
gpt() {
    git push "$@" --tags
}

alias gl='git log'
alias glo='git log --oneline'
alias glog='git log --graph --oneline --decorate'

alias gb='git branch'
alias gba='git branch --all'

alias gt='git tag'
gv() {
    local old
    old="$(git describe --tags --abbrev=0)"
    local new
    new="$(git cliff --bumped-version)"
    echo "$old -> $new"
}
gtv() {
    local ver
    ver="$(git cliff --bumped-version)"
    git tag "$ver"
}

# GIT END

alias cr='cargo run'
alias crr='cargo run --release'

alias ai='aichat'
alias air="aichat -r"
alias aic="aichat -c"
alias ais="aichat -s"
alias aie="aichat -e"

gsum() {
    local __gsum
    __gsum="$(git --no-pager diff). $*"
    SHUSH_GSUM="$(aichat -r gsum "$__gsum")"
    export SHUSH_GSUM
    echo "[${#SHUSH_GSUM}] $SHUSH_GSUM"
}

push() {
    git add --all
    if [ "$#" -eq 0 ]; then
        git commit || return 1
    elif [ "$*" == "." ]; then
        git commit -m "." || return 1
    elif [ "$1" == "gsum" ]; then
        git commit -m "$SHUSH_GSUM" || return 1
    else
        git commit "$@" || return 1
    fi
    git push
}

venv() {
    if command -V deactivate &>/dev/null; then
        echo "$VIRTUAL_ENV"
        deactivate
        echo "-> Deactivated"
        return 0
    fi

    if [ -f ".venv/bin/activate" ]; then
        # shellcheck source=/dev/null
        source .venv/bin/activate
        echo "$VIRTUAL_ENV"
        echo "-> Activated"
        return 0
    fi

    echo "Creating..."
    if python3 -m venv .venv; then
        # shellcheck source=/dev/null
        source .venv/bin/activate
        echo "$VIRTUAL_ENV"
        echo "-> Activated"
        return 0
    fi

    echo "Couldn't find or create virtual environment"
    return 1
}

purge() {
    trash-put -f "$HOME/box/dots/aichat/.config/aichat/messages.md"
    trash-put -f "$HOME/box/dots/aichat/.config/aichat/sessions/"
    trash-empty
}

pad() {
    local name="pad"
    if [[ $# -ge 1 ]]; then
        name="$1"
    fi

    local path="$HOME/desk/"
    if [[ $# -ge 2 ]]; then
        path="$2"
    fi
    if [[ $path != *"/" ]]; then
        path="$path/"
    fi

    local project
    project="$path${name}_$(date +"%y%m%d_%H%M%S")"
    cargo new "$project" || return 1
    cd "$project" || return 1
    nvim
}
