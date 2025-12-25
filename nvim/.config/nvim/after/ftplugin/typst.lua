vim.bo.shiftwidth = 2
-- vim.bo.textwidth = 80
-- vim.wo.colorcolumn = "+1"

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
end, { desc = "Toggle : Typst Preview" })

vim.lsp.enable("tinymist")
