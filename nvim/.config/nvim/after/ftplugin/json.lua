vim.bo.shiftwidth = 2
vim.lsp.enable("jsonls")

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
