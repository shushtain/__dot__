-- TODO: add simple mode for writing and other stuff, no IDE.

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

---@diagnostic disable-next-line
require("lazy").setup({
  ui = { border = "solid", backdrop = 100 },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  spec = {
    { import = "plugins" },
  },
})

require("ide.lsp")
require("ide.actions")

P = function(var)
  print(vim.inspect(var))
  return var
end

vim.api.nvim_set_hl(0, "NONE_Normal", {
  fg = vim.g.farba.colors.general.gray.v10,
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "NONE_Float", {
  fg = vim.g.farba.colors.general.gray.v15,
  bg = vim.g.farba.colors.general.gray.v15,
})

-- ~>: for fucking around
-- require("temp")
