return {
  "shushtain/farba.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/farba.nvim"),
  dev = true,
  priority = 1000,
  config = function()
    ---@type Farba.Config
    local flowerpot = {
      cache = true,
      transparency = { normal = true, float = false },
      palette = {
        general = {
          gray = { hue = 0, sat = 0 },
          red = { hue = 0, sat = 100 },
          yellow = { hue = 30, sat = 75 },
          green = { hue = 80, sat = 50 },
          cyan = { hue = 150, sat = 50 },
          blue = { hue = 200, sat = 50 },
          magenta = { hue = 280, sat = 50 },
        },
        syntax = {
          yellow = { hue = 25, sat = 75 },
          cyan = { hue = 0, sat = 60 },
          blue = { hue = 80, sat = 50 },
          magenta = { hue = 80, sat = 30 },
        },
      },
    }

    vim.g.u_theme = flowerpot
    require("farba").setup(vim.g.u_theme)
    vim.cmd("colorscheme farba")

    vim.keymap.set("n", "<Leader>zb", function()
      require("farba").purge()
    end, { desc = "Toggle : Theme" })

    vim.keymap.set("n", "<Leader>tb", function()
      local theme = vim.g.u_theme
      ---@diagnostic disable-next-line: undefined-field, need-check-nil
      theme.transparency.normal = not theme.transparency.normal
      vim.g.u_theme = theme

      require("farba").setup(vim.g.u_theme)
      vim.cmd("colorscheme farba")
    end, { desc = "Toggle : Theme" })
  end,
}
