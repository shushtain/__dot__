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

  s("~TODO:", {
    c(1, {
      t("TODO:"),
      t("WARN:"),
      t("NOTE:"),
      t("HACK:"),
      t("FAIL:"),
      t("PASS:"),
      t("TEST:"),
      t("PERF:"),
      t("FIX:"),
    }),
  }),
}
