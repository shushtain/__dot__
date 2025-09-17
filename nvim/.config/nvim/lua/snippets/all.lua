return {
  s({ trig = "~UUID", snippetType = "autosnippet" }, {
    f(function()
      return vim.fn.system("uuidgen"):gsub("\n", "")
    end),
  }),

  s("~FILENAME", {
    c(1, {
      f(function()
        return vim.fn.expand("%:t")
      end),
      f(function()
        return vim.fn.expand("%:t:r")
      end),
    }),
  }),

  s("~FILEPATH", {
    c(1, {
      f(function()
        return vim.fn.expand("%:~")
      end),
      f(function()
        return vim.fn.expand("%:p")
      end),
    }),
  }),

  s("~FOLDER", {
    c(1, {
      f(function()
        return vim.fn.expand("%:h")
      end),
      f(function()
        return vim.fn.expand("%:~:h")
      end),
      f(function()
        return vim.fn.expand("%:p:h")
      end),
    }),
  }),

  s("~PWD", {
    c(1, {
      f(function()
        return string.gsub(vim.fn.getenv("PWD"), vim.fn.getenv("HOME"), "~")
      end),
      f(function()
        return vim.fn.expand("$PWD")
      end),
    }),
  }),

  s("~ENV", {
    t("$"),
    i(1, "SHELL"),
    t(": "),
    f(function(args)
      return args == nil and "" or vim.fn.expand("$" .. args[1][1])
    end, { 1 }),
  }),

  s(
    "~hxl",
    fmta(
      [[
        hxl(<> <> <>)
      ]],
      { i(1, "0"), i(2, "100"), i(3, "50") }
    )
  ),

  s(
    "~hxla",
    fmta(
      [[
        hxla(<> <> <> / <>)
      ]],
      {
        i(1, "0"),
        i(2, "100"),
        i(3, "50"),
        i(4, "1"),
      }
    )
  ),

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
