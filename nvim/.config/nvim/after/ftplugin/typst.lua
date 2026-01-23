vim.bo.shiftwidth = 2

vim.keymap.set("n", "<Leader>;", function()
  local cur = vim.fn.getcurpos()
  local line = vim.fn.getline(cur[2])
  if line:sub(-1) == "," then
    vim.cmd('normal! $"_x')
  else
    vim.cmd("normal! A,")
  end
  vim.fn.cursor({ cur[2], cur[3], cur[4], cur[5] })
end, { buffer = true, desc = "Toggle ," })

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.keymap.set("n", "<Leader>,", function()
  vim.cmd("TypstPreviewToggle")
end, { buffer = true, desc = "Typst : Preview" })

vim.keymap.set("n", "<Leader>>", function()
  vim.cmd("!typst compile %")
end, { buffer = true, desc = "Typst : Compile" })

vim.keymap.set("n", "<Leader><Lt>", function()
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term typst watch %")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Typst : Watch" })

vim.lsp.enable("tinymist")
