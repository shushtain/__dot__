vim.bo.shiftwidth = 2
vim.lsp.enable("tombi")

vim.keymap.set("n", "<Leader>;", function()
  local lnum = vim.fn.line(".")
  local line = vim.fn.getline(lnum)
  local pkg, ver = line:match('^(%S-)%s*=%s*"(%S*)"')
  if pkg and ver then
    line = ('%s = { version = "%s" }'):format(pkg, ver)
    vim.fn.setline(lnum, line)
    return
  end
  pkg, ver = line:match('(%S-)%s*=%s*{%s*version%s*=%s*"(%S*)"%s*,?%s*}')
  if pkg and ver then
    line = ('%s = "%s"'):format(pkg, ver)
    vim.fn.setline(lnum, line)
  end
end, { buffer = true, desc = "Toggle Inline Table" })
