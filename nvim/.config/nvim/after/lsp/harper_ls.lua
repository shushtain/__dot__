---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  root_markers = { ".git" },
  filetypes = {
    "asciidoc",
    "gitcommit",
    "markdown",
    "text",
    "html",
    "json",
    "jsonc",
    "typst",
  },
  settings = {
    ["harper-ls"] = {
      linters = {
        PossessiveNoun = true,
        UseGenitive = true,
        --
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
}
