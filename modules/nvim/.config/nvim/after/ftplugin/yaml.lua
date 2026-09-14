vim.bo.shiftwidth = 2

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("yamlls")
