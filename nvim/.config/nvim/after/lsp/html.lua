---@type vim.lsp.Config
return {
  filetypes = { "html", "templ" },
  init_options = {
    provideFormatter = false,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  settings = {},
  cmd = { "vscode-html-language-server", "--stdio" },
  root_markers = { "package.json", ".git" },
}
