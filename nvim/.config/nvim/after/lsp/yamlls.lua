---@type vim.lsp.Config
return {
  filetypes = {
    "yaml",
    "yaml.docker-compose",
    "yaml.gitlab",
    "yaml.helm-values",
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = { enable = true },
      -- schemas = {
      --   ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      --   ["../path/relative/to/file.yml"] = "/.github/workflows/*",
      --   ["/path/from/root/of/project"] = "/.github/workflows/*",
      -- },
    },
  },
  cmd = { "yaml-language-server", "--stdio" },
  root_markers = { ".git" },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
