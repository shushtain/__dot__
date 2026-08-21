local theme = require("modules.theme")

hl.config({
  general = {
    layout = "dwindle",
    allow_tearing = true,
    gaps_in = 1,
    gaps_out = 0,
    gaps_workspaces = 2,
    border_size = 0,
    resize_on_border = true,
    col = {
      active_border = theme.color.gray.v01,
      inactive_border = theme.color.gray.v01,
      nogroup_border = theme.color.gray.v01,
      nogroup_border_active = theme.color.gray.v01,
    },
    snap = {
      enabled = true,
    },
  },
})

hl.config({
  decoration = {
    rounding = 4,
    dim_modal = true,
    dim_inactive = false,
    dim_strength = 0.2,
    dim_special = 0.2,
    dim_around = 0.4,
    blur = {
      enabled = false,
    },
    shadow = {
      enabled = false,
    },
  },
})

hl.config({
  animations = {
    enabled = false,
  },
})
