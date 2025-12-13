return {
  "shushtain/touch-piping.nvim",
  -- enabled = false,
  cmd = { "TouchPipingStart" },
  dir = vim.fn.expand("~/box/touch-piping.nvim"),
  dev = true,
  config = function()
    require("touch-piping").setup({
      size = { 8, 4 },
      style = "double",
      keymaps = { quit = "Q" },
    })
  end,
}
