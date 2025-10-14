vim.bo.shiftwidth = 2

vim.lsp.enable("emmylua_nvim")
vim.lsp.enable("emmylua_config")
vim.lsp.enable("emmylua_snippets")

vim.keymap.set("n", "<Leader>.", function()
  vim.cmd("update")
  vim.cmd("source")
  vim.notify(". " .. vim.fn.expand("%"), vim.log.levels.INFO)
end, { buffer = true, desc = "Source File" })

vim.keymap.set(
  "n",
  "<Leader>,",
  "<Cmd> .lua <CR>",
  { buffer = true, desc = "Run current line in Lua" }
)

vim.keymap.set(
  "n",
  "<Leader>:",
  "<Plug>PlenaryTestFile",
  { buffer = true, desc = "Test with Plenary" }
)
