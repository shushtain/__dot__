local wezterm = require("wezterm")
local cfg = wezterm.config_builder()

cfg.enable_wayland = false
cfg.front_end = "WebGpu"

return cfg
