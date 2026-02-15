---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 80,
      lint = {
        preview = true,
        -- extendSelect = {},
        -- ignore = {},
      },
    },
  },
}
