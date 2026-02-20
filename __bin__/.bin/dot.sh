#!/usr/bin/env bash

stow_all=false

declare -A dotfiles
dotfiles=(
    ["nvim"]=""
    ["__bin__"]=""
    ["aichat"]=""
    ["alacritty"]=""
    ["btop"]=""
    ["cliphist"]=""
    ["desktop"]=""
    ["dmentia"]=""
    ["dunst"]=""
    ["fastfetch"]=""
    ["firefox"]=""
    ["fontconfig"]=""
    ["fuzzel"]=""
    ["git"]=""
    ["gtk-3.0"]=""
    ["gtk-4.0"]=""
    ["hypr"]=""
    ["kitty"]=""
    ["mpv"]=""
    ["nvim"]=""
    ["openvpn"]=""
    ["ripgrep"]=""
    ["shell"]=""
    ["systemd"]=""
    ["templates"]=""
    ["tldr"]=""
    ["waybar"]=""
    ["xdg"]=""
    ["xkb"]=""
    ["yay"]=""
    ["yazi"]=""
)

alert() {
    dunstify -u critical "dot.sh" "$1"
}

cook() {
    if [[ -z ${dotfiles[$1]+isset} ]]; then
        alert "unknown $1"
        return 1
    fi

    local flags=${dotfiles[$1]}
    echo "Cooking $1"
    stow -R "$flags" "$1" || alert "failed to stow $1"
}

while getopts "a" opt; do
    case $opt in
    a)
        stow_all=true
        ;;
    *)
        alert "invalid flag"
        exit 1
        ;;
    esac
done

shift $((OPTIND - 1))

cd "$HOME/box/__dot__/" || {
    alert "no __dot__/"
    exit 1
}

if [[ $# -gt 0 ]]; then
    if [[ $stow_all == true ]]; then
        alert "use either -a or dots"
        exit 1
    else
        for item in "${!dotfiles[@]}"; do
            stow -D "$item"
        done
    fi
fi

tasks=()
if [[ $stow_all == true ]]; then
    for item in "${!dotfiles[@]}"; do
        tasks+=("$item")
    done
else
    for item in "$@"; do
        tasks+=("$item")
    done
fi

for task in "${tasks[@]}"; do
    cook "$task"
done
