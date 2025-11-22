local root_markers = { ".git" }
local root = vim.fs.root(0, root_markers) or vim.fn.getcwd()
local schema = root .. "/source/meta/data.schema.json"

---@type vim.lsp.Config
return {
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = false },
  settings = {
    json = {
      schemas = { { fileMatch = { "**/*.json" }, url = schema } },
      format = { enable = false },
      validate = { enable = true },
    },
  },
  cmd = { "vscode-json-language-server", "--stdio" },
  root_dir = function(bufnr, on_dir)
    if vim.fn.filereadable(schema) == 0 then
      return
    end
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
    on_dir(project_root)
  end,
}
