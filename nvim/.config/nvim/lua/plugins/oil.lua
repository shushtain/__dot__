-- TODO: Configure
return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        -- "icon",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        foldcolumn = "0",
        spell = false,
        list = false,
      },
      delete_to_trash = true,
      skip_confirmation_for_simple_edits = true,
      set_default_keymaps = false,
      keymaps = {
        ["<Leader>e?"] = {
          "actions.show_help",
          mode = "n",
          desc = "Explorer : Keymaps",
        },
        ["<CR>"] = { "actions.select", desc = "Explorer : Open" },
        ["<S-CR>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Explorer : Open Split",
        },
        ["<C-CR>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Explorer : Open Stacked",
        },
        ["<Leader>ep"] = { "actions.preview", desc = "Explorer : Preview" },
        ["<Leader>ee"] = {
          "actions.close",
          mode = "n",
          desc = "Explorer : Toggle",
        },
        ["<Leader>er"] = { "actions.refresh", desc = "Explorer : Refresh" },
        ["-"] = { "actions.parent", mode = "n", desc = "Explorer : Parent" },
        ["_"] = { "actions.open_cwd", mode = "n", desc = "Explorer : Root" },
        ["`"] = { "actions.cd", mode = "n", desc = "Explorer : Set as Root" },
        ["<Leader>es"] = {
          "actions.change_sort",
          mode = "n",
          desc = "Explorer : Sort",
        },
        ["<Leader>et"] = {
          "actions.open_external",
          desc = "Explorer : External",
        },
        ["<Leader>eh"] = {
          "actions.toggle_hidden",
          mode = "n",
          desc = "Explorer : Hidden",
        },
        ["<Leader>ex"] = {
          "actions.toggle_trash",
          mode = "n",
          desc = "Explorer : Trash",
        },
      },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set(
      "n",
      "<Leader>ee",
      "<Cmd> Oil <CR>",
      { noremap = true, desc = "Explorer : Toggle" }
    )
  end,
}
