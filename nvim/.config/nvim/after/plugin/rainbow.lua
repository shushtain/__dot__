local function rainbow_loop()
  if not vim.g.u_rainbow then
    return
  end

  vim.g.u_rainbow = (vim.g.u_rainbow + 6) % 360
  local dyn = vim.g.u_rainbow

  ---@type Farba.Config
  local theme = {
    cache = true,
    transparency = { normal = true },
    palette = {
      general = {
        gray = { hue = 0, sat = 0 },
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
        cyan = { hue = dyn, sat = 100 },
        blue = { hue = dyn + 80, sat = 50 },
        magenta = { hue = dyn + 80, sat = 35 },
      },
    },
  }

  require("farba").setup(theme)
  vim.cmd("colorscheme farba")

  vim.defer_fn(rainbow_loop, 1000)
end

vim.keymap.set("n", "<Leader>:w", function()
  if not vim.g.u_rainbow then
    vim.g.u_rainbow = 0
  else
    vim.g.u_rainbow = false
  end
  rainbow_loop()

  if not vim.g.u_rainbow then
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
          cyan = { hue = 0, sat = 100 },
          blue = { hue = 80, sat = 50 },
          magenta = { hue = 80, sat = 35 },
        },
      },
    }
    require("farba").setup(flowerpot)
    vim.cmd("colorscheme farba")
  end
end)
