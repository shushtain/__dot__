return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  version = "v2.*",
  build = "make install_jsregexp",
  -- dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip").setup({
      keep_roots = true,
      link_roots = true,
      link_children = true,
      exit_roots = false,
      -- enable_autosnippets = true,
      updateevents = "TextChanged, TextChangedI",
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            hl_group = "LuasnipNodeActive",
          },
        },
      },
    })

    vim.api.nvim_set_hl(0, "LuasnipNodeActive", { underline = true })

    require("luasnip.loaders.from_lua").load({ paths = { "./lua/snippets" } })
    -- require("luasnip.loaders.from_vscode").lazy_load() -- for friendly-snippets
    -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vscode" } })

    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      pcall(require("luasnip").change_choice, 1)
    end, { silent = true, desc = "Snippets : Next Choice" })

    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      pcall(require("luasnip").change_choice, -1)
    end, { silent = true, desc = "Snippets : Previous Choice" })

    vim.keymap.set({ "i", "s" }, "<C-e>", function()
      pcall(require("luasnip.extras.select_choice"))
    end, { silent = true, desc = "Snippets : Select Choice" })

    vim.keymap.set("n", '<Leader>"s', function()
      require("luasnip.loaders").edit_snippet_files()
    end, { desc = "Snippets : Edit" })
  end,
}
