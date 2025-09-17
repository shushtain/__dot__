---@type vim.lsp.Config
return {
  filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" },
  cmd = { "glsl_analyzer" },
  root_markers = { ".git" },
}
