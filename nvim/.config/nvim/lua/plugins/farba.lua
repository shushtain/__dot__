return {
  "shushtain/farba.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/farba.nvim"),
  dev = true,
  priority = 1000,
  config = function()
    ---@type Farba.Config
    local flowerpot = {
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
          cyan = { hue = 0, sat = 100 },
          blue = { hue = 80, sat = 50 },
          magenta = { hue = 80, sat = 35 },
        },
      },
    }

    require("farba").setup(flowerpot)
    vim.cmd("colorscheme farba")

    vim.keymap.set("n", "<Leader>zb", function()
      require("farba").purge()
    end, { desc = "Toggle : Theme" })

    vim.keymap.set("n", "<Leader>tb", function()
      flowerpot.transparency.normal = not flowerpot.transparency.normal
      require("farba").setup(flowerpot)
      vim.cmd("colorscheme farba")
    end, { desc = "Toggle : Theme" })
  end,
}
