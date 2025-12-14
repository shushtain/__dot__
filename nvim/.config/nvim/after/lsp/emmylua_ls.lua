---@type vim.lsp.Config
return {
  cmd = { "emmylua_ls" },
  filetypes = { "lua" },
  root_markers = {
    ".emmyrc.json",
    ".luarc.json",
    ".luacheckrc",
    ".git",
  },
  workspace_required = false,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        requirePattern = { "lua/?.lua", "lua/?/init.lua" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data") .. "/lazy",
        },
      },
      completion = {
        autoRequire = false,
        callSnippet = true,
        baseFunctionIncludesName = false,
      },
      format = {
        externalTool = {
          program = "stylua",
          args = { "-", "--stdin-filepath", "${file}" },
          timeout = 5000,
        },
      },
    },
  },
  before_init = function(init_params, config)
    if
      vim.tbl_get(
        config,
        "capabilities",
        "workspace",
        "didChangeWatchedFiles",
        "dynamicRegistration"
      )
    then
      local capabilities = config.capabilities
      ---@diagnostic disable-next-line: need-check-nil
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      ---@diagnostic disable-next-line: undefined-field
      vim.lsp.config.emmylua_ls.capabilities = capabilities
      init_params.capabilities = capabilities
    end
  end,
  on_attach = function(client, _bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
