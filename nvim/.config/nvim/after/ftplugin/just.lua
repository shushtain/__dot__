vim.b.u_delim = " \\"

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("just")
