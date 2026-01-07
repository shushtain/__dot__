#!/usr/bin/env bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE

pkill xdg-desktop-portal-termfilechooser
pkill xdg-desktop-portal-hyprland
pkill xdg-desktop-portal-gtk
pkill xdg-desktop-portal

sleep 1

/usr/lib/xdg-desktop-portal-gtk &
/usr/lib/xdg-desktop-portal-hyprland &
/usr/lib/xdg-desktop-portal-termfilechooser &

sleep 2

/usr/lib/xdg-desktop-portal &
