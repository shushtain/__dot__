[[ -f $HOME/.profile ]] && . "$HOME/.profile"
[[ -f $HOME/.bashrc ]] && . "$HOME/.bashrc"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    while true; do
        read -r -p "Start Hyprland? (N/n to cancel) " answer
        case $answer in
        [Nn]*)
            break
            ;;
        *)
            exec start-hyprland
            ;;
        esac
    done
fi
