local language_id_mapping = {
  bib = "bibtex",
  pandoc = "markdown",
  plaintex = "tex",
  rnoweb = "rsweave",
  rst = "restructuredtext",
  tex = "latex",
  text = "plaintext",
}

---@type vim.lsp.Config
return {
  filetypes = {
    "bib",
    "context",
    "gitcommit",
    "html",
    "markdown",
    "org",
    "pandoc",
    "plaintex",
    "quarto",
    "mail",
    "mdx",
    "rmd",
    "rnoweb",
    "rst",
    "tex",
    "text",
    "typst",
    "xhtml",
  },
  settings = {
    ltex = {
      diagnosticSeverity = { default = "hint" },
      language = "en-US",
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "uk-UA",
      },
      enabled = {
        "bib",
        "context",
        "gitcommit",
        "html",
        "markdown",
        "org",
        "pandoc",
        "plaintex",
        "quarto",
        "mail",
        "mdx",
        "rmd",
        "rnoweb",
        "rst",
        "tex",
        "latex",
        "text",
        "typst",
        "xhtml",
      },
    },
  },
  get_language_id = function(_, filetype)
    return language_id_mapping[filetype] or filetype
  end,
  cmd = { "ltex-ls-plus" },
  root_markers = { ".git" },
}
