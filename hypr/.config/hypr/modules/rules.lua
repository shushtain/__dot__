hl.window_rule({
  name = "nogroup",
  match = { class = ".*" },
  group = "deny",
})

hl.window_rule({
  name = "idleinhibit",
  match = { class = ".*" },
  idle_inhibit = "fullscreen",
})

hl.window_rule({
  name = "supressmax",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "floatborder",
  match = { fullscreen = 0, float = 1 },
  border_size = 2,
})
