return {
  "kylechui/nvim-surround",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = false,
        insert_line = false,
        normal = false,
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = false,
        visual_line = false,
        delete = false,
        change = false,
        change_line = false,
      },
      surrounds = {
        ["«"] = {
          add = { "« ", " »" },
          find = function()
            return require("nvim-surround.config").get_selection({
              pattern = "«.-»",
            })
          end,
          delete = "^(. ?)().-( ?.)()$",
        },
        ["»"] = {
          add = { "«", "»" },
          find = function()
            return require("nvim-surround.config").get_selection({
              pattern = "«.-»",
            })
          end,
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
