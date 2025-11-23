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
        ["j"] = "move_next",
        ["k"] = "move_prev",
        ["gj"] = "move2parent",
        ["J"] = "move_change_next",
        ["K"] = "move_change_prev",
        ["<CR>"] = "action_enter",
        ["p"] = "enter_diffbuf",
        ["q"] = "quit",
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
