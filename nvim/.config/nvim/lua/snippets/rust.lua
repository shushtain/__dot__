return {
  s(
    "~derivecommon",
    fmta(
      "#[derive(Debug, Clone, Default, PartialEq, PartialOrd, Hash, <>)]",
      { i(1, "Eq, Ord, Copy") }
    )
  ),

  s("~deriveDebug", {
    t("#[derive(Debug)]"),
  }),
}
