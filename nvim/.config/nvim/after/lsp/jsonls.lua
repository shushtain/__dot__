---@type vim.lsp.Config
return {
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  cmd = { "vscode-json-language-server", "--stdio" },
  root_markers = { ".git" },
}
