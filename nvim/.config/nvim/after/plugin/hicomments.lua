local ft = vim.bo[0].filetype
local lang = vim.treesitter.language.get_lang(ft) or ft
vim.treesitter.query.set(
  lang,
  "highlights",
  [[;;extends
  ((comment) @todo)]]
)
vim.keymap.set("n", "<Leader>!", function()
  vim.treesitter.get_parser(0, lang):parse()
end)

vim.api.nvim_set_hl(0, "@todo", { bg = "#ff0000" })

-- TODO
