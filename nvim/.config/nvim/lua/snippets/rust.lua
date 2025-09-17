return {
  s(
    "~derivecommon",
    fmta(
      [[
        #[derive(Debug, Clone, Default, PartialEq, <>)]
      ]],
      {
        i(1, "Copy"),
      }
    )
  ),

  s("~deriveDebug", {
    t("#[derive(Debug)]"),
  }),
}
