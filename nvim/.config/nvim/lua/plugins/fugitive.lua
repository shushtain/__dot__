return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<Leader>gg",
      "<Cmd> G <CR>",
      { desc = "Git : Dashboard" }
    )
    vim.keymap.set(
      "n",
      "<Leader>gd",
      "<Cmd> Gvdiff <CR>",
      { desc = "Git : Diff" }
    )
  end,
}
