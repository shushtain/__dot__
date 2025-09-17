---@type vim.lsp.Config
return {
  filetypes = { "toml" },
  cmd = { "tombi", "lsp" },
  root_markers = {
    "tombi.toml",
    "pyproject.toml",
    ".taplo.toml",
    "taplo.toml",
    ".git",
  },
}
