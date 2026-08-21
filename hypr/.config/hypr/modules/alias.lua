return {
  term = "alacritty",
  app = {
    editor = "$term -e nvim",
    explorer = "$term -e yazi",
    ai = "$term -e aichat",
    resources = "$term -e btop",
    camera = "snapshot",
    browser = "firefox",
    messenger = "signal-desktop --password-store=basic",
  },
}
