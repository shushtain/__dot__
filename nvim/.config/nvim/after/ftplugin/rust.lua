vim.lsp.enable("rust_analyzer")

vim.keymap.set("n", "<Leader>.", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term cargo run -q --message-format short")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Run Code" })

vim.keymap.set("n", "<Leader>,", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term cargo test")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Test Code" })

vim.keymap.set("n", "<Leader>p.", function()
  vim.diagnostic.enable(false)
  if vim.lsp.is_enabled("rust_analyzer") then
    vim.lsp.enable("rust_analyzer", false)
    vim.lsp.enable("rust_penalizer")
  else
    vim.lsp.enable("rust_penalizer", false)
    vim.lsp.enable("rust_analyzer")
  end
  vim.diagnostic.enable()
end, { desc = "LSP : Toggle Pedantic" })
