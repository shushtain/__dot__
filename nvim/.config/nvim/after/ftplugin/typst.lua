vim.bo.shiftwidth = 2
vim.bo.textwidth = 80
vim.wo.colorcolumn = "+1"

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("tinymist")
