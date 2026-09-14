[[ -f $HOME/.profile ]] && . "$HOME/.profile"
[[ -f $HOME/.bashrc ]] && . "$HOME/.bashrc"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    while true; do
        read -r -p "Start Hyprland? [Y/n] " answer
        answer="${answer:-y}"
        case $answer in
        [Nn]*) break ;;
        [Yy]*) exec start-hyprland ;;
        *) echo "Please answer Y/y or N/n." ;;
        esac
    done
fi
