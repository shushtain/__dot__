return {
  "windwp/nvim-autopairs",
  -- enabled = false,
  config = function()
    require("nvim-autopairs").setup({
      disable_filetype = { "query" },
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    })

    local endwise = require("nvim-autopairs.ts-rule").endwise
    require("nvim-autopairs").add_rules({
      endwise("then$", "end", "lua", "if_statement"),
      endwise("do$", "end", "lua", { "for_statement", "while_statement" }),
    })
  end,
}
