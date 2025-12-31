-- vim.bo.expandtab = false

vim.keymap.set("n", "<Leader>ga", function()
  vim.cmd('normal! "hyl')
  local ch = vim.fn.getreg("h")
  local hex = string.format("U%04x", vim.fn.char2nr(ch))
  vim.fn.setreg("h", hex)
  vim.cmd('normal! v"hp')
end, { desc = "Convert char to XKB Unicode hex" })
