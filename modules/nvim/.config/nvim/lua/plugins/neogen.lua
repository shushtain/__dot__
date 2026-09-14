return {
  "danymat/neogen",
  enabled = vim.env.NVIM_NOIDE == nil,
  config = function()
    require("neogen").setup({
      input_after_comment = true,
      snippet_engine = "nvim",
      languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        python = { template = { annotation_convention = "reST" } },
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>yf",
      "<Cmd> Neogen func <CR>",
      { desc = "Docs : Function" }
    )
    vim.keymap.set(
      "n",
      "<Leader>yc",
      "<Cmd> Neogen class <CR>",
      { desc = "Docs : Class" }
    )
    vim.keymap.set(
      "n",
      "<Leader>yt",
      "<Cmd> Neogen type <CR>",
      { desc = "Docs : Type" }
    )
    vim.keymap.set(
      "n",
      "<Leader>yb",
      "<Cmd> Neogen file <CR>",
      { desc = "Docs : File" }
    )
  end,
}
