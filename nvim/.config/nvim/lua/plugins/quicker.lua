return {
  "stevearc/quicker.nvim",
  -- enabled = false,
  config = function()
    require("quicker").setup({
      follow = { enabled = true },
      keys = {
        {
          ">",
          function()
            require("quicker").expand({
              before = 2,
              after = 2,
              add_to_existing = true,
            })
          end,
          desc = "Quicker : Expand",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Quicker : Collapse",
        },
      },
    })

    vim.keymap.set("n", "<Leader>q", function()
      require("quicker").toggle()
    end, { desc = "Quicker : Toggle Quickfix" })

    vim.keymap.set("n", "<Leader>Q", function()
      require("quicker").toggle({ loclist = true })
    end, { desc = "Quicker : Toggle Loclist" })
  end,
}
