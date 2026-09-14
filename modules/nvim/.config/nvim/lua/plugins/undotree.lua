return {
  "jiaoshijie/undotree",
  -- enabled = false,
  config = function()
    require("undotree").setup({
      float_diff = true,
      layout = "left_left_bottom",
      position = "right",
      ignore_filetype = {
        "undotree",
        "undotreeDiff",
        "qf",
        "TelescopePrompt",
        "spectre_panel",
        "tsplayground",
      },
      window = { winblend = 0 },
      keymaps = {
        ["move_next"] = "j",
        ["move_prev"] = "k",
        ["move2parent"] = "gj",
        ["move_change_next"] = "J",
        ["move_change_prev"] = "K",
        ["action_enter"] = "<CR>",
        ["enter_diffbuf"] = "p",
        ["quit"] = "q",
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>u",
      require("undotree").toggle,
      { desc = "Undotree" }
    )
  end,
}
