return {
  "folke/which-key.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "helix",
      win = {
        border = "solid",
        title = false,
        padding = { 0, 1 },
      },
      icons = {
        breadcrumb = "»",
        separator = " ",
        group = "",
        ellipsis = "…",
        mappings = false,
        keys = {
          Up = "↑",
          Down = "↓",
          Left = "←",
          Right = "→",
          C = "C-",
          M = "M-",
          D = "D-",
          S = "S-",
          CR = "⮐",
          Esc = "∅",
          ScrollWheelDown = "⤈",
          ScrollWheelUp = "⤉",
          NL = "↲",
          BS = "↩",
          Space = "␣",
          Tab = "⭾",
        },
      },
      show_help = false,
      show_keys = false,
      plugins = { spelling = { suggestions = 10 } },
    })

    -- require("which-key").add({
    --   { "<Leader>f", group = "Find" },
    -- })
  end,
}
