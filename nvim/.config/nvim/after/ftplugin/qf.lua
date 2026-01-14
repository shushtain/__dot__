vim.keymap.set("n", "<CR>", function()
  local qf_cursor = vim.fn.getpos(".")
  local qf_buf = vim.api.nvim_get_current_buf()
  local qf_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd W")
  local gf_win = vim.api.nvim_get_current_win()
  if qf_win == gf_win then
    vim.cmd("normal! 0gF")
    return
  end
  vim.api.nvim_set_current_win(qf_win)
  vim.cmd("normal! 0gF")
  local gf_buf = vim.api.nvim_get_current_buf()
  if qf_buf == gf_buf then
    return
  end
  local gf_cursor = vim.fn.getpos(".")
  vim.api.nvim_set_current_buf(qf_buf)
  vim.api.nvim_set_current_win(gf_win)
  vim.api.nvim_set_current_buf(gf_buf)
  vim.fn.setpos(".", gf_cursor)
  vim.api.nvim_set_current_win(qf_win)
  vim.fn.setpos(".", qf_cursor)
end, { buffer = true })
