local theme = require("modules.theme")

hl.config({
  misc = {
    background_color = theme.color.gray.v01,
    font_family = theme.font,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    on_focus_under_fullscreen = 2,
    close_special_on_empty = true,
    focus_on_activate = false,
    middle_click_paste = false,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
    enable_anr_dialog = true,
    anr_missed_pings = 5,
  },
})

hl.config({
  binds = {
    workspace_back_and_forth = true,
    hide_special_on_workspace_change = true,
  },
})

hl.config({
  render = {
    new_render_scheduling = true,
  },
})

hl.config({
  xwayland = {
    enabled = true,
    use_nearest_neighbor = true,
    force_zero_scaling = true,
  },
})

hl.config({
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

hl.config({
  debug = {
    enable_stdout_logs = true,
  },
})
