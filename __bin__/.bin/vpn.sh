#!/usr/bin/env bash

vpn="de20"

ip_old=$(curl -s https://ipinfo.io/ip)
echo "$ip_old"

if pgrep -x "openvpn" >/dev/null; then
    echo "VPN $vpn is running"
    while true; do
        read -r -p "Kill VPN? [y/N] " answer
        answer="${answer:-n}"
        case $answer in
        [Yy]*)
            sudo killall openvpn
            ip_new=$(curl -s https://ipinfo.io/ip)
            echo "$ip_new"
            exit 0
            ;;
        [Nn]*) exit 0 ;;
        *) echo "Please answer Y/y or N/n." ;;
        esac
    done
fi

password=$(curl -s https://www.vpnbook.com/freevpn | rg -o 'Password.+?>(\S+)</code>' -r '$1')
echo "Password: $password"

while true; do
    echo "Use this password, quit, or use manual?"
    read -r -p "[Y/n/<password>] " answer
    answer="${answer:-y}"
    case $answer in
    [Yy]*) break ;;
    [Nn]*) exit 1 ;;
    *)
        password=$answer
        break
        ;;
    esac
done

AUTH_FILE=$(mktemp)
echo "vpnbook" >"$AUTH_FILE"
echo "$password" >>"$AUTH_FILE"
trap 'rm -f "$AUTH_FILE"' EXIT

if [[ $1 == "debug" ]]; then
    sudo openvpn --config "$HOME/.local/share/vpnbook/$vpn.ovpn" --auth-user-pass "$AUTH_FILE"
else
    echo "Enabling VPN $vpn"
    sudo openvpn --config "$HOME/.local/share/vpnbook/$vpn.ovpn" --auth-user-pass "$AUTH_FILE" --daemon --log /tmp/vpn_"$vpn".log >/dev/null

    ip_new=$ip_old
    attempts=10
    while [ $attempts -gt 0 ]; do
        ip_new=$(curl -s --max-time 2 https://ipinfo.io/ip)
        if [[ "$ip_new" != "$ip_old" && -n "$ip_new" ]]; then
            echo -e "\nGreat success!\n$ip_new"
            exit 0
        fi
        echo -n "."
        sleep 2
        ((attempts--))
    done

    echo "Timeout. Detected old IP. Try running with 'debug'"
    exit 1
fi
