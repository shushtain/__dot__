local root_markers = {
  "Cargo.toml",
  ".git",
}
local cargo_root = vim.fs.root(0, root_markers)

---@type vim.lsp.Config
return {
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "data/**/*.json" },
          url = cargo_root .. "/meta/data.schema.json",
        },
      },
      format = { enable = false },
      validate = { enable = true },
    },
  },
  cmd = { "vscode-json-language-server", "--stdio" },
  root_markers = { ".git" },
}
