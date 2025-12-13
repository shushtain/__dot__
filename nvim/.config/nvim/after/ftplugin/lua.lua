vim.bo.shiftwidth = 2

vim.lsp.enable("emmylua")

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
