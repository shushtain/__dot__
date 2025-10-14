vim.lsp.enable("rust_analyzer")

vim.keymap.set("n", "<Leader>;", function()
  local cur = vim.fn.getcurpos()
  vim.cmd("normal! A;")
  vim.fn.cursor({ cur[2], cur[3], cur[4], cur[5] })
end, { buffer = true, desc = "Append ;" })

vim.keymap.set("n", "<Leader>:", function()
  local cur = vim.fn.getcurpos()
  local line = vim.fn.getline(cur[2])
  if line:find(" mut ") then
    line = line:gsub(" mut ", " ")
  else
    line = line:gsub("let ", "let mut ")
  end
  vim.fn.setline(cur[2], line)
end, { buffer = true, desc = "Toggle mut" })

vim.keymap.set("n", "<Leader>.", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term cargo run -q --message-format short")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Run Code" })

vim.keymap.set("n", "<Leader>,", function()
  vim.cmd("update")
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
  vim.g.u_last_run_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term cargo test")
  vim.bo.bufhidden = "wipe"
  vim.api.nvim_set_current_win(cur)
end, { buffer = true, desc = "Test Code" })

local check = {
  command = "clippy",
  overrideCommand = {
    "cargo",
    "clippy",
    "--message-format=json",
    "--",
    "-W",
    "clippy::pedantic",
  },
}

vim.keymap.set("n", "<Leader>p.", function()
  vim.g.rust_penalyzer = not vim.g.rust_penalyzer
  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = { check = vim.g.rust_penalyzer and check or vim.NIL },
    },
  })
  vim.lsp.enable("rust_analyzer", false)
  vim.lsp.enable("rust_analyzer")
end, { buffer = true, desc = "LSP : Clippy Pedantic" })
