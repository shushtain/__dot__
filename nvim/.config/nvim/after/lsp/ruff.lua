---@type vim.lsp.Config
return {
  filetypes = { "python" },
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
  cmd = { "ruff", "server" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
}
