vim.bo.shiftwidth = 2
vim.b.u_delim = ","

vim.keymap.set("n", "<Leader>.", function()
  vim.notify(". " .. vim.fn.expand("%"), vim.log.levels.INFO)
  vim.cmd("update")
  vim.cmd("source")
end, { buffer = true, desc = "Run : File" })

vim.keymap.set(
  "n",
  "<Leader>,",
  "<Cmd> .lua <CR>",
  { buffer = true, desc = "Run : Line" }
)

-- ::: IDE
if vim.env.NVIM_NOIDE then
  return
end

vim.lsp.enable("emmylua_ls")
vim.lsp.enable("stylua")
