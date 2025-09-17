return {
  "shushtain/farba.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/farba.nvim"),
  dev = true,
  priority = 1000,
  config = function()
    ---@type Farba.Config
    local flowerpot = {
      light_mode = false,
      background = false,
      colors = {
        general = {
          gray = { 0, 0 },
          red = { 0, 100 },
          green = { 80, 50 },
          yellow = { 30, 75 },
          blue = { 200, 50 },
          magenta = { 280, 50 },
          cyan = { 150, 50 },
        },
        syntax = {
          blue = { 80, 50 },
          magenta = { 80, 35 },
          cyan = { 0, 100 },
        },
      },
    }

    local theme = flowerpot
    require("farba").setup(theme)
    vim.cmd("colorscheme farba")

    vim.keymap.set("n", "<Leader>tb", function()
      theme.light_mode = not theme.light_mode
      require("farba").setup(theme)
      vim.cmd("colorscheme farba")
    end, { desc = "Toggle : Theme" })
  end,
}
