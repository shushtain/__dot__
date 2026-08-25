default:
    @just --list

[private]
cook items:
    @if ! stow -R --no-folding --target="$HOME" "{{ items }}"; then \
        dunstify -u critical -a shush "dot error" "{{ items }}"; \
        exit 1; \
    fi

[private]
wipe items:
    @if ! stow -D --target="$HOME" "{{ items }}"; then \
        dunstify -u critical -a shush "dot error" "{{ items }}"; \
        exit 1; \
    fi

all: bin aichat alacritty btop cliphist desktop dmentia dunst fastfetch firefox fontconfig fuzzel git gtk_3 gtk_4 hypr mpv nvim openvpn ripgrep shell systemd tpl xdg xkb yazi auto-cpufreq sway

bin:
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

tpl:
    just cook "tpl"

xdg:
    just cook "xdg"

xkb:
    just cook "xkb"

yazi:
    just cook "yazi"

auto-cpufreq:
    just cook "auto-cpufreq"

sway:
    just cook "sway"
