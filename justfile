default:
    @just --list

[private]
cook items:
    @if ! stow -R --no-folding --target="$HOME" "{{ items }}"; then \
        dunstify -u critical -a shush "dot error" "{{ items }}"; \
        exit 1; \
    fi

all: __bin__ aichat alacritty btop cliphist desktop dmentia dunst fastfetch firefox fontconfig fuzzel git gtk_3 gtk_4 hypr kitty mpv nvim openvpn ripgrep shell systemd templates tldr waybar xdg xkb yay yazi auto-cpufreq

__bin__:
    just cook "__bin__"

aichat:
    just cook "aichat"

alacritty:
    just cook "alacritty"

btop:
    just cook "btop"

cliphist:
    just cook "cliphist"

desktop:
    just cook "desktop"

dmentia:
    just cook "dmentia"

dunst:
    just cook "dunst"

fastfetch:
    just cook "fastfetch"

firefox:
    just cook "firefox"

fontconfig:
    just cook "fontconfig"

fuzzel:
    just cook "fuzzel"

git:
    just cook "git"

gtk_3:
    just cook "gtk_3"

gtk_4:
    just cook "gtk_4"

hypr:
    just cook "hypr"

kitty:
    just cook "kitty"

mpv:
    just cook "mpv"

nvim:
    just cook "nvim"

openvpn:
    just cook "openvpn"

ripgrep:
    just cook "ripgrep"

shell:
    just cook "shell"

systemd:
    just cook "systemd"

templates:
    just cook "templates"

tldr:
    just cook "tldr"

waybar:
    just cook "waybar"

xdg:
    just cook "xdg"

xkb:
    just cook "xkb"

yay:
    just cook "yay"

yazi:
    just cook "yazi"

auto-cpufreq:
    just cook "auto-cpufreq"
