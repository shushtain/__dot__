-- ~>: Gradually move away
return {
  "Saghen/blink.cmp",
  version = "1.*",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    require("blink.cmp").setup({
      appearance = {
        kind_icons = {
          Text = "󰉿",
          Method = "m",
          Function = "󰊕",
          Constructor = "󰅪",
          Field = "",
          Variable = "≋",
          Class = "󰌗",
          Interface = "󱣴",
          Module = "",
          Property = "⌥",
          Unit = "󰘷",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌆",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰌷",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "≡",
          Struct = "",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
      },
      completion = {
        keyword = { range = "full" },
        trigger = {
          prefetch_on_insert = true,
          show_in_snippet = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_accept_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
        list = { selection = { preselect = true, auto_insert = false } },
        menu = { auto_show = true, scrollbar = true },
        ghost_text = {
          enabled = false,
          show_with_selection = true,
          show_without_selection = false,
          show_with_menu = true,
          show_without_menu = true,
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = { "score", "sort_text", "label" },
      },
      keymap = { preset = "default" },
      signature = {
        enabled = true,
        window = { winhighlight = "Normal:Pmenu" },
      },
      snippets = { preset = "luasnip" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      cmdline = {
        keymap = { preset = "inherit" },
        sources = { "buffer", "cmdline" },
        completion = {
          list = { selection = { preselect = true, auto_insert = false } },
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
          ghost_text = { enabled = true },
        },
      },
      term = {
        enabled = false,
        keymap = { preset = "inherit" },
        sources = { "path" },
        completion = {
          list = { selection = { preselect = true, auto_insert = false } },
          menu = { auto_show = true },
          ghost_text = { enabled = false },
        },
      },
    })
  end,
}
