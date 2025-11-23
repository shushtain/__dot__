return {
  s({ trig = "~UUID", snippetType = "autosnippet" }, {
    f(function()
      return vim.fn.system("uuidgen"):gsub("\n", "")
    end),
  }),

  s("~EXP", {
    i(1, "%:~"),
    t(" "),
    f(function(args)
      return args == nil and "" or vim.fn.expand(args[1][1])
    end, { 1 }),
  }),
}
