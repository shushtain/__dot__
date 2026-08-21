hl.on("hyprland.start", function()
  hl.exec_cmd("startup.sh")

  hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
  hl.exec_cmd("systemctl --user enable --now hypridle.service")

  hl.exec_cmd("wl-clip-persist --clipboard regular")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  hl.exec_cmd("xhost +SI:localuser:root")

  hl.exec_cmd("udiskie")
  hl.exec_cmd("dropbox-cli start")
  hl.exec_cmd("waybar")
end)
