---@type vim.lsp.Config
return {
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "templ",
    "typescriptreact",
    "vue",
  },
  cmd = { "emmet-language-server", "--stdio" },
  root_markers = { ".git" },
}
