vim.keymap.set("n", "<Leader>pn", vim.lsp.buf.rename, { desc = "LSP : Rename" })

vim.keymap.set(
  { "n", "x" },
  "<Leader>pa",
  vim.lsp.buf.code_action,
  { desc = "LSP : Code Actions" }
)

vim.keymap.set(
  "n",
  "<Leader>pr",
  require("fzf-lua").lsp_references,
  { desc = "LSP : References" }
)

vim.keymap.set(
  "n",
  "<Leader>pm",
  require("fzf-lua").lsp_implementations,
  { desc = "LSP : Implementations" }
)

vim.keymap.set(
  "n",
  "<Leader>pi",
  require("fzf-lua").lsp_incoming_calls,
  { desc = "LSP : Incoming Calls" }
)

vim.keymap.set(
  "n",
  "<Leader>po",
  require("fzf-lua").lsp_outgoing_calls,
  { desc = "LSP : Outgoing Calls" }
)

vim.keymap.set(
  "n",
  "<Leader>pd",
  require("fzf-lua").lsp_definitions,
  { desc = "LSP : Definitions" }
)

vim.keymap.set(
  "n",
  "<Leader>pp",
  vim.lsp.buf.declaration,
  { desc = "LSP : Declaration" }
)

vim.keymap.set(
  "n",
  "<Leader>ps",
  require("fzf-lua").lsp_document_symbols,
  { desc = "LSP : Document Symbols" }
)

vim.keymap.set(
  "n",
  "<Leader>pS",
  require("fzf-lua").lsp_live_workspace_symbols,
  { desc = "LSP : Workspace Symbols" }
)

vim.keymap.set(
  "n",
  "<Leader>py",
  require("fzf-lua").lsp_typedefs,
  { desc = "LSP : Type Definitions" }
)

vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({ max_width = 80, border = "solid" })
end, { desc = "LSP : Documentation" })

vim.keymap.set(
  "i",
  "<C-k>",
  vim.lsp.buf.signature_help,
  { desc = "LSP : Signature" }
)

vim.keymap.set("n", "<Leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle : Hints" })

vim.keymap.set("n", "<Leader>tv", function()
  ---@diagnostic disable-next-line: need-check-nil
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle : Virtual Lines" })

vim.keymap.set(
  { "n", "x" },
  "<Leader>pf",
  vim.lsp.buf.format,
  { desc = "LSP : Format" }
)

vim.keymap.set("n", "<Leader>tf", function()
  vim.g.u_manual_formatting = not vim.g.u_manual_formatting
end, { desc = "Toggle : Formatting" })
