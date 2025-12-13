---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  settings = {
    ruff = {
      path = { vim.fn.exepath("ruff") },
      importStrategy = "fromEnvironment",
      organizeImports = true,
      fixAll = true,
      lint = {
        preview = true,
        extendSelect = {},
        ignore = {},
      },
    },
  },
}
