---@type vim.lsp.Config
return {
  cmd = { "typos-lsp" },
  root_markers = {
    "typos.toml",
    "_typos.toml",
    ".typos.toml",
    "pyproject.toml",
    "Cargo.toml",
  },
  init_options = {
    diagnosticSeverity = "Hint",
    -- config = "~/.config/nvim/typos.toml",
  },
}
