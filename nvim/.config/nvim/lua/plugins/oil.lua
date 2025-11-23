return {
  "stevearc/oil.nvim",
  -- enabled = false,
  config = function()
    ---@type oil.SetupOpts
    local opts = {
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      set_default_keymaps = false,
      delete_to_trash = true,
      columns = {},
      view_options = { show_hidden = true, case_insensitive = true },
      confirmation = { border = "solid" },
      progress = { border = "solid" },
      ssh = { border = "solid" },
      keymaps = {
        ["<Leader>ey"] = {
          "actions.yank_entry",
          desc = "Oil : Yank Filepath",
        },
        ["<Leader>e?"] = {
          "actions.show_help",
          mode = "n",
          desc = "Oil : Keymaps",
        },
        ["<CR>"] = {
          "actions.select",
          desc = "Oil : Open",
        },
        ["<M-CR>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Oil : Open Split",
        },
        ["<M-BS>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Oil : Open Stacked",
        },
        ["<Leader>ep"] = {
          "actions.preview",
          opts = { vertical = true },
          desc = "Oil : Preview",
        },
        ["<Leader>eP"] = {
          "actions.preview",
          opts = { horizontal = true },
          desc = "Oil : Preview Stacked",
        },
        ["<Leader>ee"] = {
          "actions.close",
          mode = "n",
          desc = "Oil : Toggle",
        },
        ["<Leader>er"] = {
          "actions.refresh",
          desc = "Oil : Refresh",
        },
        ["-"] = {
          "actions.parent",
          mode = "n",
          desc = "Oil : Parent",
        },
        ["_"] = {
          "actions.open_cwd",
          mode = "n",
          desc = "Oil : Root",
        },
        ["<Leader>ex"] = {
          "actions.toggle_trash",
          mode = "n",
          desc = "Oil : Trash",
        },
        ["`"] = {
          "actions.cd",
          mode = "n",
          opts = { scope = "tab" },
          desc = "Oil : Root Tabbed",
        },
        ["~"] = {
          "actions.cd",
          mode = "n",
          desc = "Oil : Root",
        },
        ["<Leader>eq"] = {
          "actions.send_to_qflist",
          opts = { action = "a" },
          desc = "Oil : Quickfix Add",
        },
        ["<Leader>eQ"] = {
          "actions.send_to_qflist",
          opts = { action = "r" },
          desc = "Oil : Quickfix Replace",
        },
        ["<Leader>e,"] = {
          "actions.change_sort",
          mode = "n",
          desc = "Oil : Sort",
        },
        ["<Leader>e."] = {
          "actions.toggle_hidden",
          mode = "n",
          desc = "Oil : Hidden",
        },
      },
    }

    require("oil").setup(opts)

    vim.keymap.set("n", "<Leader>ee", function()
      local width = vim.api.nvim_win_get_config(0).width
      local preview = width > 100 and { vertical = true } or nil
      require("oil").open(nil, { preview = preview })
    end, { desc = "Oil : Toggle" })
  end,
}
