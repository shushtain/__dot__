return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    auto_close = true,
    auto_open = false,
    auto_preview = true,
    focus = true,
    restore = true,
    follow = true,
    indent_guides = true,
    multiline = true,
    warn_no_results = true,
    open_no_results = false,
  },
  keys = {
    {
      "<Leader>db",
      "<Cmd> Trouble diagnostics toggle filter.buf=0 <CR>",
      desc = "Trouble : Buffer",
    },
    {
      "<Leader>de",
      "<Cmd> Trouble diagnostics toggle <CR>",
      desc = "Trouble : Project",
    },
    {
      "<Leader>dq",
      "<Cmd> Trouble qflist toggle <CR>",
      desc = "Trouble : Quickfix",
    },

    --

    {
      "<Leader>dr",
      "<Cmd> Trouble lsp_references toggle <CR>",
      desc = "Trouble : References",
    },
    {
      "<Leader>dm",
      "<Cmd> Trouble lsp_implementations toggle <CR>",
      desc = "Trouble : Implementations",
    },
    {
      "<Leader>di",
      "<Cmd> Trouble lsp_incoming_calls toggle <CR>",
      desc = "Trouble : Incoming Calls",
    },
    {
      "<Leader>do",
      "<Cmd> Trouble lsp_outgoing_calls toggle <CR>",
      desc = "Trouble : Outgoing Calls",
    },
    {
      "<Leader>dd",
      "<Cmd> Trouble lsp_definitions toggle <CR>",
      desc = "Trouble : Definitions",
    },
    {
      "<Leader>ds",
      "<Cmd> Trouble lsp_document_symbols toggle <CR>",
      desc = "Trouble : Document Symbols",
    },
    {
      "<Leader>dS",
      "<Cmd> Trouble symbols toggle <CR>",
      desc = "Trouble : Symbols",
    },
    {
      "<Leader>dy",
      "<Cmd> Trouble lsp_type_definitions toggle <CR>",
      desc = "Trouble : Type Definitions",
    },
  },
}
