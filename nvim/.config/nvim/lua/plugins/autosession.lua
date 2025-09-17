return {
  "rmagatti/auto-session",
  -- enabled = false,
  lazy = false,
  config = function()
    require("auto-session").setup({
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
      suppressed_dirs = { "~/", "/" },
      -- close_filetypes_on_save = { "checkhealth", "toml" },
      auto_delete_empty_sessions = true,
      purge_after_minutes = 10080,
      cwd_change_handling = true,
      legacy_cmds = false,
      session_lens = {
        mappings = {
          delete_session = { "i", "<M-d>" },
        },
      },
    })

    vim.cmd("AutoSession purgeOrphaned")

    vim.keymap.set(
      "n",
      "<Leader>z",
      "<Cmd> AutoSession search <CR>",
      { desc = "Sessions : Search" }
    )
  end,
}
