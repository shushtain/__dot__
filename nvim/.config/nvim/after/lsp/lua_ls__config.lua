---@type vim.lsp.Config
return {
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data"),
        },
        ignoreDir = {
          ".vscode",
          "**/lua/snippets",
        },
      },
      -- diagnostics = {
      --   disable = {}
      -- }
      completion = {
        callSnippet = "Replace",
      },
      format = {
        defaultConfig = {
          indent_style = "space",
          indent_size = 2,
        },
      },
    },
  },
  cmd = { "lua-language-server" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.fn.bufname(bufnr)
    if not fname:find(".config/nvim/") then
      return
    end
    local root_markers = {
      ".emmyrc.json",
      ".emmyrc.jsonc",
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    }
    local project_root = vim.fs.root(bufnr, root_markers)
    if project_root then
      on_dir(project_root)
    end
  end,
}
