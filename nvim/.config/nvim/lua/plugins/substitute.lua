return {
  "gbprod/substitute.nvim",
  -- enabled = false,
  config = function()
    require("substitute").setup({
      yank_substituted_text = false,
    })

    vim.keymap.set(
      "n",
      "s",
      require("substitute").operator,
      { desc = "Substitute" }
    )

    vim.keymap.set(
      "n",
      "ss",
      require("substitute").line,
      { desc = "Substitute : Line" }
    )

    vim.keymap.set(
      "n",
      "S",
      require("substitute").eol,
      { desc = "Substitute : EOL" }
    )

    vim.keymap.set(
      "x",
      "s",
      require("substitute").visual,
      { desc = "Substitute" }
    )
  end,
}
