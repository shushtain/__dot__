---@type vim.lsp.Config
return {
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        requirePattern = { "?.lua", "?/init.lua" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data"),
          vim.fn.stdpath("state") .. "/luasnip_env",
        },
        ignoreDir = { "lua/plugins" },
      },
      completion = {
        autoRequire = false,
      },
      diagnostics = {
        disable = {
          "missing-fields",
        },
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
  root_dir = function(bufnr, on_dir)
    local fname = vim.fn.bufname(bufnr)
    if not fname:find(".config/nvim/lua/snippets/") then
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
    if not project_root then
      return
    end
    on_dir(project_root)
  end,
}
