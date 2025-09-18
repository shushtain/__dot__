---@type vim.lsp.Config
return {
  filetypes = { "hyprlang" },
  cmd = { "hyprls", "--stdio" },
  root_markers = { ".git" },
}
