vim.lsp.enable("bashls")

vim.keymap.set("n", "<Leader>.", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term source %")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Run Code" })
