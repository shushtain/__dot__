require("config.options")
require("config.keymaps")
require("config.autocmd")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  ui = { border = "solid", backdrop = 100 },
  change_detection = { enabled = false, notify = false },
  spec = { { import = "plugins" } },
})

vim.keymap.set("n", "<Leader>gl", "<Cmd> Lazy check <CR>")

if not vim.env.NVIM_NOIDE then
  require("ide.lsp")
  require("ide.actions")
end

require("temp")
