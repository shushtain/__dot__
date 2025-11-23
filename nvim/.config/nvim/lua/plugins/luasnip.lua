return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    require("luasnip").setup({
      link_children = true, -- jump between root and its children
      link_roots = true, -- jump between root snippets
      keep_roots = true, -- keep older snippets
      exit_roots = false, -- exit snippets that reached $0
      update_events = { "InsertLeave", "TextChanged", "TextChangedI" },
      region_check_events = { "InsertEnter" },
      -- delete_check_events = { "InsertLeave", "InsertEnter" },
      -- ext_opts = {
      --   [require("luasnip.util.types").choiceNode] = {
      --     active = {
      --       hl_group = "LuasnipNodeActive",
      --     },
      --   },
      -- },
    })

    -- vim.api.nvim_set_hl(0, "LuasnipNodeActive", { underline = true })

    require("luasnip.loaders.from_lua").load({ paths = { "./lua/snippets" } })
    -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vscode" } })

    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      pcall(require("luasnip").change_choice, 1)
    end, {  desc = "Snippets : Next Choice" })

    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      pcall(require("luasnip").change_choice, -1)
    end, {  desc = "Snippets : Previous Choice" })

    vim.keymap.set({ "i", "s" }, "<C-e>", function()
      pcall(require("luasnip.extras.select_choice"))
    end, {  desc = "Snippets : Select Choice" })

    vim.keymap.set("n", '<Leader>"s', function()
      require("luasnip.loaders").edit_snippet_files()
    end, { desc = "Snippets : Edit" })
  end,
}
