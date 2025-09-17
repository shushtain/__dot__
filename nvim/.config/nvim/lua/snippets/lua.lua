return {
  s(
    "~PLUGIN",
    fmta(
      [[
      return {
        "<1>",
        -- enabled = false,
        dependencies = {},
        config = function()
          require("<2>").setup(<3>)
        end,
      }
      ]],
      {
        i(1, "author/repo"),
        d(2, function(args)
          if args == nil or args[1] == nil then
            return sn(nil, { i(1, "plugin") })
          end
          local parts =
            vim.split(args[1][1], "/", { plain = true, trimempty = true })
          local name =
            vim.split(parts[#parts], ".", { plain = true, trimempty = true })
          local out = name[1]
          return sn(nil, { i(1, out) })
        end, { 1 }),
        i(0),
      }
    )
  ),

  s(
    "~warn",
    fmta(
      [[
      vim.notify("<1>", vim.log.levels.<2>)
      ]],
      {
        i(1, "Warning"),
        i(2, "WARN"),
      }
    )
  ),
}
