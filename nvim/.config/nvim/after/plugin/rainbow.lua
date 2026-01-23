local function rainbow_loop(step, ms)
  if not vim.g.u_rainbow then
    return
  end

  vim.g.u_rainbow = (vim.g.u_rainbow + (step or 6)) % 360
  local dyn = vim.g.u_rainbow

  ---@type Farba.Config
  local theme = {
    cache = true,
    transparency = { normal = true },
    palette = {
      general = {
        gray = { hue = dyn, sat = 0 },
        red = { hue = dyn, sat = 100 },
        yellow = { hue = dyn + 30, sat = 75 },
        green = { hue = dyn + 80, sat = 50 },
        cyan = { hue = dyn + 150, sat = 50 },
        blue = { hue = dyn + 200, sat = 50 },
        magenta = { hue = dyn + 280, sat = 50 },
      },
      status = {
        gray = { hue = 0, sat = 0 },
        red = { hue = 0, sat = 100 },
        yellow = { hue = 30, sat = 75 },
        green = { hue = 80, sat = 50 },
        cyan = { hue = 150, sat = 50 },
        blue = { hue = 200, sat = 50 },
        magenta = { hue = 280, sat = 50 },
      },
      syntax = {
        yellow = { hue = dyn + 25, sat = 75 },
        cyan = { hue = dyn, sat = 60 },
        blue = { hue = dyn + 80, sat = 50 },
        magenta = { hue = dyn + 80, sat = 30 },
      },
    },
  }

  require("farba").setup(theme)
  vim.cmd("colorscheme farba")
  vim.defer_fn(rainbow_loop, ms or 1000)
end

vim.keymap.set("n", "<Leader>g9", function()
  if not vim.g.u_rainbow then
    vim.g.u_rainbow = 0
    rainbow_loop()
  else
    vim.g.u_rainbow = false
    require("farba").setup(vim.g.u_theme)
    vim.cmd("colorscheme farba")
  end
end)

vim.keymap.set("n", "<Leader>g8", function()
  if not vim.g.u_rainbow then
    vim.g.u_rainbow = 0
    rainbow_loop(27, 30)
  else
    vim.g.u_rainbow = false
    require("farba").setup(vim.g.u_theme)
    vim.cmd("colorscheme farba")
  end
end)

vim.keymap.set("n", "<Leader>g0", function()
  vim.g.u_rainbow = false
  require("farba").setup(vim.g.u_theme)
  vim.cmd("colorscheme farba")
end)

vim.keymap.set("n", "<Leader>g1", function()
  vim.g.u_rainbow = false
  require("farba").setup({
    transparency = { normal = false, float = false },
    palette = {
      general = {
        gray = { hue = 0, sat = 100 },
        red = { hue = 0, sat = 100 },
        yellow = { hue = 25, sat = 100 },
        green = { hue = 25, sat = 100 },
        cyan = { hue = 0, sat = 100 },
        blue = { hue = 25, sat = 100 },
        magenta = { hue = 0, sat = 100 },
      },
    },
  })
  vim.cmd("colorscheme farba")
end)

vim.keymap.set("n", "<Leader>g2", function()
  vim.g.u_rainbow = false
  require("farba").setup({
    transparency = { normal = false, float = false },
    palette = {
      general = {
        gray = { hue = 200, sat = 100 },
        red = { hue = 0, sat = 100 },
        yellow = { hue = 60, sat = 50 },
        green = { hue = 200, sat = 100 },
        cyan = { hue = 90, sat = 100 },
        blue = { hue = 200, sat = 100 },
        magenta = { hue = 200, sat = 100 },
      },
    },
  })
  vim.cmd("colorscheme farba")
end)

vim.keymap.set("n", "<Leader>g3", function()
  vim.g.u_rainbow = false
  require("farba").setup({
    transparency = { normal = false, float = false },
    palette = {
      general = {
        gray = { hue = 90, sat = 30 },
        red = { hue = 0, sat = 100 },
        yellow = { hue = 30, sat = 100 },
        green = { hue = 90, sat = 50 },
        cyan = { hue = 0, sat = 100 },
        blue = { hue = 70, sat = 100 },
        magenta = { hue = 90, sat = 50 },
      },
    },
  })
  vim.cmd("colorscheme farba")
end)
