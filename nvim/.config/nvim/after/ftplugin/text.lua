vim.bo.commentstring = "; %s"

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("harper_ls")
