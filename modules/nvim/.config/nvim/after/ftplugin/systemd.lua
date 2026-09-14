-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("systemd_lsp")
