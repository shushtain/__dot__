---@type vim.lsp.Config
return {
  filetypes = { "markdown", "markdown.mdx" },
  cmd = { "marksman", "server" },
  root_markers = { ".marksman.toml", ".git" },
}
