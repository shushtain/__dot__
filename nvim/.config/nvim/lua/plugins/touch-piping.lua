return {
  "shushtain/touch-piping.nvim",
  -- enabled = false,
  dir = vim.fn.expand("~/box/touch-piping.nvim"),
  dev = true,
  lazy = false,
  config = function()
    require("touch-piping").setup({
      -- no_border = true,
      style = "double",
      keymaps = {
        quit = "Q",
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>:|",
      "<Cmd> TouchPipingStart <CR>",
      { noremap = true, desc = "Play : Touch Piping" }
    )
  end,
}
