---@type vim.lsp.Config
return {
  filetypes = { "python" },
  cmd = { "ty", "server" },
  root_markers = { "ty.toml", "pyproject.toml", ".git" },
}
