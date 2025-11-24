vim.lsp.enable("rust_analyzer")

vim.keymap.set("n", "<Leader>;", function()
  local cur = vim.fn.getcurpos()
  local line = vim.fn.getline(cur[2])
  if line:sub(-1) == ";" then
    vim.cmd('normal! $"_x')
  else
    vim.cmd("normal! A;")
  end
  vim.fn.cursor({ cur[2], cur[3], cur[4], cur[5] })
end, { buffer = true, desc = "Toggle ;" })

vim.keymap.set("n", "<Leader>'m", function()
  local cur = vim.fn.getcurpos()
  local line = vim.fn.getline(cur[2])
  if line:find("let mut ") then
    vim.cmd("s/let mut /let /")
  elseif line:find("let ") then
    vim.cmd("s/let /let mut /")
  else
    return
  end
  vim.cmd("nohlsearch")
end, { buffer = true, desc = "Toggle mut" })

vim.keymap.set("n", "<Leader>'p", function()
  local cur = vim.fn.getcurpos()
  local line = vim.fn.getline(cur[2])
  if line:find("pub ") then
    vim.cmd("s/pub //")
    vim.cmd("nohlsearch")
  else
    vim.cmd("normal! _ipub ")
  end
  vim.fn.cursor({ cur[2], cur[3], cur[4], cur[5] })
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

vim.keymap.set("n", "<Leader>>", function()
  vim.ui.input({ prompt = "cargo run -- " }, function(args)
    if not args then
      return
    end
    vim.cmd("update")
    local cur = vim.api.nvim_get_current_win()
    pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
    vim.g.u_last_run_term =
      vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
    vim.cmd("term cargo run -q --message-format short -- " .. args)
    vim.bo.bufhidden = "wipe"
    vim.api.nvim_set_current_win(cur)
  end)
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

vim.keymap.set("n", "<Leader><Lt>", function()
  vim.ui.input({ prompt = "cargo test " }, function(args)
    if not args then
      return
    end
    vim.cmd("update")
    local cur = vim.api.nvim_get_current_win()
    pcall(vim.api.nvim_win_close, vim.g.u_last_run_term, false)
    vim.g.u_last_run_term =
      vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
    vim.cmd("term cargo test " .. args)
    vim.bo.bufhidden = "wipe"
    vim.api.nvim_set_current_win(cur)
  end)
end, { buffer = true, desc = "Test Code" })

local function toggle_lint(settings)
  vim.lsp.config(
    "rust_analyzer",
    { settings = { ["rust-analyzer"] = { check = settings } } }
  )
  for _, client in ipairs(vim.lsp.get_clients({ name = "rust_analyzer" })) do
    ---@diagnostic disable-next-line: undefined-field
    client.settings = vim.lsp.config.rust_analyzer.settings
    client:notify("workspace/didChangeConfiguration", { settings = {} })
  end
end

vim.keymap.set("n", "<Leader>p..", function()
  toggle_lint(vim.NIL)
  vim.notify("Linter: cargo check")
end, { buffer = true, desc = "LSP : Lint : Default" })

vim.keymap.set("n", "<Leader>p.c", function()
  toggle_lint({
    command = "clippy",
    overrideCommand = { "cargo", "clippy", "--message-format=json" },
  })
  vim.notify("Linter: clippy")
end, { buffer = true, desc = "LSP : Lint : Clippy" })

vim.keymap.set("n", "<Leader>p.p", function()
  toggle_lint({
    command = "clippy",
    overrideCommand = {
      "cargo",
      "clippy",
      "--message-format=json",
      "--",
      "-W",
      "clippy::pedantic",
    },
  })
  vim.notify("Linter: clippy::pedantic")
end, { buffer = true, desc = "LSP : Lint : Clippy Pedantic" })
