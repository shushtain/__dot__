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
  on_attach = function(client, _bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
