return {
  "danymat/neogen",
  config = function()
    require("neogen").setup({
      input_after_comment = true,
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        python = { template = { annotation_convention = "reST" } },
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>yy",
      "<Cmd> Neogen <CR>",
      {   }
    )
    vim.keymap.set(
      "n",
      "<Leader>yf",
      "<Cmd> Neogen func <CR>",
      {   }
    )
    vim.keymap.set(
      "n",
      "<Leader>yc",
      "<Cmd> Neogen class <CR>",
      {   }
    )
    vim.keymap.set(
      "n",
      "<Leader>yt",
      "<Cmd> Neogen type <CR>",
      {   }
    )
    vim.keymap.set(
      "n",
      "<Leader>yb",
      "<Cmd> Neogen file <CR>",
      {   }
    )
  end,
}
