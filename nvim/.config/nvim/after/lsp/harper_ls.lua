---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  root_markers = { ".git" },
  filetypes = {
    "asciidoc",
    "gitcommit",
    "html",
    "markdown",
    "typst",
    "text",
    "json",
    "jsonc",
  },
  settings = {
    ["harper-ls"] = {
      linters = {
        PossessiveNoun = true,
        BoringWords = true,
        UseGenitive = true,
        --
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
}
