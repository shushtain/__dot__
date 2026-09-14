vim.g.nvim_surround_no_mappings = true

return {
  "kylechui/nvim-surround",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["«"] = {
          add = { "« ", " »" },
          find = "«.-»",
          delete = "^(. ?)().-( ?.)()$",
        },
        ["»"] = {
          add = { "«", "»" },
          find = "«.-»",
          delete = "^(.)().-(.)()$",
        },
      },
      aliases = { ["A"] = "»", ["?"] = "i" },
      highlight = { duration = 0 },
      move_cursor = "sticky",
    })

    vim.keymap.set(
      "n",
      "<Leader>s",
      "<Plug>(nvim-surround-normal)",
      { desc = "Surround : Add" }
    )

    vim.keymap.set(
      "n",
      "<Leader>S",
      "<Plug>(nvim-surround-normal-cur)",
      { desc = "Surround : Add Block" }
    )

    vim.keymap.set(
      "n",
      "<Leader>sd",
      "<Plug>(nvim-surround-delete)",
      { desc = "Surround : Delete" }
    )

    vim.keymap.set(
      "n",
      "<Leader>sr",
      "<Plug>(nvim-surround-change)",
      { desc = "Surround : Replace" }
    )

    vim.keymap.set(
      "n",
      "<Leader>Sr",
      "<Plug>(nvim-surround-change-line)",
      { desc = "Surround : Replace Block" }
    )

    vim.keymap.set(
      "x",
      "<Leader>s",
      "<Plug>(nvim-surround-visual)",
      { desc = "Surround : Add" }
    )

    vim.keymap.set(
      "x",
      "<Leader>S",
      "<Plug>(nvim-surround-visual-line)",
      { desc = "Surround : Add Block" }
    )
  end,
}
