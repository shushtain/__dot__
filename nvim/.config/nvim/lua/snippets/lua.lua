return {
  s(
    "~notify",
    fmta([[ vim.notify("<1>", vim.log.levels.<2>) ]], {
      i(1, "!"),
      i(2, "WARN"),
    })
  ),
}
