return {
  "windwp/nvim-autopairs",
  -- enabled = false,
  event = { "InsertEnter" },
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    })

    require("nvim-autopairs").add_rules({
      require("nvim-autopairs.rule").new("```", "```"),
      require("nvim-autopairs.ts-rule").endwise(
        "then$",
        "end",
        "lua",
        "if_statement"
      ),
      require("nvim-autopairs.ts-rule").endwise(
        "do$",
        "end",
        "lua",
        "for_statement"
      ),
    })
  end,
}
