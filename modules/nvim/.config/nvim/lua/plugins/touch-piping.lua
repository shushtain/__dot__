return {
  "shushtain/touch-piping.nvim",
  -- enabled = false,
  cmd = { "TouchPipingStart" },
  dir = vim.fn.expand("~/box/touch-piping"),
  dev = true,
  config = function()
    require("touch-piping").setup({
      size = { 8, 4 },
      style = "double",
      keymaps = { quit = "Q" },
    })
  end,
}
