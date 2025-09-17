-- TODO:
---@type vim.lsp.Config
return {
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = false },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  cmd = { "vscode-css-language-server", "--stdio" },
  root_markers = { "package.json", ".git" },
}
