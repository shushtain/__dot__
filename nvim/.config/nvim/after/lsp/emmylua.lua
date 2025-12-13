---@type vim.lsp.Config
return {
  filetypes = { "lua" },
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
  cmd = { "emmylua_ls" },
  root_markers = {
    ".emmyrc.json",
    ".emmyrc.jsonc",
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".git",
  },
  on_attach = function(client, _bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
