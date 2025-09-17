---@type vim.lsp.Config
return {
  filetypes = { "bash", "sh" },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  cmd = { "bash-language-server", "start" },
  root_markers = { ".git" },
}
