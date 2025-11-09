return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "┃" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "┃" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
    })

    vim.keymap.set(
      "n",
      "<Leader>tgs",
      "<Cmd> Gitsigns toggle_signs <CR>",
      { desc = "Toggle : Git : Signs" }
    )

    vim.keymap.set(
      "n",
      "<Leader>tgh",
      "<Cmd> Gitsigns toggle_linehl <CR>",
      { desc = "Toggle : Git : Highlights" }
    )

    vim.keymap.set(
      "n",
      "<Leader>tgw",
      "<Cmd> Gitsigns toggle_word_diff <CR>",
      { desc = "Toggle : Git : Word Diff" }
    )
  end,
}
