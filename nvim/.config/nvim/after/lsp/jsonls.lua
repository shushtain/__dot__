local root_markers = {
  ".git",
}
local root = vim.fs.root(0, root_markers) or vim.fn.getcwd()

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
          fileMatch = { "**/*.json" },
          url = root .. "/source/meta/data.schema.json",
        },
      },
      format = { enable = false },
      validate = { enable = true },
    },
  },
  cmd = { "vscode-json-language-server", "--stdio" },
  root_markers = { ".git" },
}
