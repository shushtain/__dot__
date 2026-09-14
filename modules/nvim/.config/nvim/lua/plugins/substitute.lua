return {
  "gbprod/substitute.nvim",
  -- enabled = false,
  config = function()
    require("substitute").setup({
      yank_substituted_text = false,
      highlight_substituted_text = { timer = 250 },
    })

    vim.api.nvim_set_hl(0, "SubstituteSubstituted", { link = "IncSearch" })

    vim.keymap.set("n", "s", function()
      require("substitute").operator()
    end, { desc = "Substitute" })

    vim.keymap.set("n", "ss", function()
      require("substitute").line()
    end, { desc = "Substitute : Line" })

    vim.keymap.set("n", "S", function()
      require("substitute").eol()
    end, { desc = "Substitute : EOL" })

    vim.keymap.set("x", "s", function()
      require("substitute").visual()
    end, { desc = "Substitute" })
  end,
}
