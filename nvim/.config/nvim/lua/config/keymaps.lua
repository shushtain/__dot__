-- [[ LEADER ]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<NOP>")

-- [[ FIXES ]]

vim.keymap.set(
  { "n", "x" },
  "j",
  "gj",
  { noremap = true, silent = true, desc = "Visual Down" }
)
vim.keymap.set(
  { "n", "x" },
  "k",
  "gk",
  { noremap = true, silent = true, desc = "Visual Up" }
)

vim.keymap.set({ "n", "x" }, "x", '"_x', { noremap = true, desc = "Cut" })
vim.keymap.set({ "n", "x" }, "X", '"_X', { noremap = true, desc = "Cut" })
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "Dedent" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "Indent" })
vim.keymap.set("x", "p", '"_dP', { noremap = true, desc = "Paste" })

vim.keymap.set("i", "<M-h>", "<C-o>h", { noremap = true, desc = "Move left" })
vim.keymap.set("i", "<M-l>", "<C-o>l", { noremap = true, desc = "Move right" })
vim.keymap.set("i", "<M-;>", "<C-o>A", { noremap = true, desc = "Edit end" })

vim.keymap.set("n", "<M-h>", "<<", { noremap = true })
vim.keymap.set("n", "<M-l>", ">>", { noremap = true })
vim.keymap.set("x", "<M-h>", "<gv", { noremap = true })
vim.keymap.set("x", "<M-l>", ">gv", { noremap = true })

vim.keymap.set(
  "n",
  "<M-p>",
  "0f{a<CR><Esc>P",
  { noremap = true, desc = "Paste Inside {}" }
)
vim.keymap.set("n", "<Leader>tk", function()
  if vim.o.keymap == "" then
    vim.o.keymap = "ukrainian-enhanced"
  else
    vim.o.keymap = ""
  end
end, { desc = "Toggle : Keymap" })

vim.keymap.set("n", "<Leader>tm", function()
  vim.wo.conceallevel = vim.wo.conceallevel ~= 0 and 0 or 2
end, { desc = "Toggle : Conceal" })

vim.keymap.set("n", "<M-j>", function()
  local cur = vim.fn.getcurpos()
  if cur[2] == vim.fn.getpos("$")[2] then
    return
  end
  vim.cmd('normal! "qdd"qp')
  vim.fn.cursor({ cur[2] + 1, cur[3], cur[4], cur[5] })
end, { noremap = true })

vim.keymap.set("n", "<M-k>", function()
  local cur = vim.fn.getcurpos()
  if cur[2] == 1 then
    return
  end
  if cur[2] == vim.fn.getpos("$")[2] then
    vim.cmd('normal! "qdd')
  else
    vim.cmd('normal! "qddk')
  end
  vim.cmd('normal! "qP')
  vim.fn.cursor({ cur[2] - 1, cur[3], cur[4], cur[5] })
end, { noremap = true })

vim.keymap.set("n", "<M-S-j>", function()
  local cur = vim.fn.getcurpos()
  vim.cmd('normal! "qyy"qp')
  vim.fn.cursor({ cur[2] + 1, cur[3], cur[4], cur[5] })
end, { noremap = true })

vim.keymap.set("n", "<M-S-k>", function()
  local cur = vim.fn.getcurpos()
  vim.cmd('normal! "qyy')
  vim.cmd('normal! "qP')
  vim.fn.cursor({ cur[2], cur[3], cur[4], cur[5] })
end, { noremap = true })

vim.keymap.set("x", "<M-j>", function()
  if vim.fn.mode() ~= "V" then
    return
  end
  local cur = vim.fn.getcurpos()
  vim.cmd("normal! \27")
  vim.cmd("normal! gv")
  local le = vim.fn.getpos("'<")
  local ri = vim.fn.getpos("'>")
  if ri[2] == vim.fn.getpos("$")[2] then
    return
  end
  vim.cmd('normal! "qd"qp')
  vim.fn.setpos("'<", { le[1], le[2] + 1, le[3], le[4] })
  vim.fn.setpos("'>", { ri[1], ri[2] + 1, ri[3], ri[4] })
  vim.cmd("normal! gv")
  vim.fn.cursor({ cur[2] + 1, cur[3], cur[4], cur[5] })
end, { noremap = true })

vim.keymap.set("x", "<M-k>", function()
  if vim.fn.mode() ~= "V" then
    return
  end
  local cur = vim.fn.getcurpos()
  vim.cmd("normal! \27")
  vim.cmd("normal! gv")
  local le = vim.fn.getpos("'<")
  if le[2] == 1 then
    return
  end
  local ri = vim.fn.getpos("'>")
  if ri[2] == vim.fn.getpos("$")[2] then
    vim.cmd('normal! "qd')
  else
    vim.cmd('normal! "qdk')
  end
  vim.cmd('normal! "qP')
  vim.fn.setpos("'<", { le[1], le[2] - 1, le[3], le[4] })
  vim.fn.setpos("'>", { ri[1], ri[2] - 1, ri[3], ri[4] })
  vim.cmd("normal! gv")
  vim.fn.cursor({ cur[2] - 1, cur[3], cur[4], cur[5] })
end, { noremap = true })

-- [[ SPECIAL ]]

vim.keymap.set("n", "<Leader>:j", function()
  local tw = vim.o.textwidth
  tw = tw == 0 and 80 or tw

  if #vim.fn.getline(".") >= tw then
    return nil
  end

  local cmd = vim.api.nvim_replace_termcodes("<Cmd>", true, false, true)
  local tsp = string.rep(" ", vim.bo.shiftwidth)

  local e1 = "a∅\27V" .. cmd .. "s/ /≣/eg\r\27"
  local e2 = cmd .. "ri\r\27V" .. cmd .. "s/\t/" .. tsp .. "/eg\r\27"
  local e3 = "0dwf∅PV" .. cmd .. "s/≣/ /eg\r\27" .. "0f∅r "
  local e4 = cmd .. "nohlsearch\r"

  vim.api.nvim_feedkeys(e1 .. e2 .. e3 .. e4, "n", false)
end, { silent = true, desc = "Split-justify here" })

vim.keymap.set("n", "U", "<Cmd> redo <CR>", { desc = "Redo" })
vim.keymap.set("n", "<M-u>", "<Cmd> redo <CR>", { desc = "Redo" })

vim.keymap.set(
  "n",
  "<Leader>+",
  "<Cmd> vert resize | resize <CR>",
  { desc = "Window : Maximize" }
)

-- comments

vim.keymap.set("n", "gco", function()
  local comment = vim.bo.commentstring
  comment = comment:gsub("%%s", "")
  vim.fn.feedkeys("o" .. comment)
end, { noremap = true, desc = "Comment : Below" })

vim.keymap.set("n", "gcO", function()
  local comment = vim.bo.commentstring
  comment = comment:gsub("%%s", "")
  vim.fn.feedkeys("O" .. comment)
end, { noremap = true, desc = "Comment : Above" })

vim.keymap.set("n", "gc;", function()
  local comment = vim.bo.commentstring
  comment = comment:gsub("%%s", "")
  vim.fn.feedkeys("A " .. comment)
end, { noremap = true, desc = "Comment : Append" })

-- end comments

vim.keymap.set("n", "<Leader>ts", function()
  vim.opt.spell = not vim.o.spell
  local ns = vim.api.nvim_get_namespaces()["vim.lsp.typos_lsp.1"]
  vim.diagnostic.enable(vim.o.spell, { ns_id = ns })
end, { noremap = true, desc = "Toggle : Spelling" })

vim.keymap.set("n", "<Leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { noremap = true, desc = "Toggle : Diagnostics" })

vim.keymap.set(
  "n",
  "<Tab>",
  "<Cmd> b # <CR>",
  { noremap = true, desc = "Buffer : Back" }
)
vim.keymap.set(
  "n",
  "H",
  "<Cmd> bprevious <CR>",
  { noremap = true, desc = "Buffer : Prev" }
)
vim.keymap.set(
  "n",
  "L",
  "<Cmd> bnext <CR>",
  { noremap = true, desc = "Buffer : Next" }
)
vim.keymap.set(
  "n",
  "<Leader>`",
  "<Cmd> tabnew <CR>",
  { noremap = true, desc = "Tab : New" }
)
vim.keymap.set(
  "n",
  "<Leader>~",
  "<Cmd> tabclose <CR>",
  { noremap = true, desc = "Tab : Close" }
)
vim.keymap.set(
  "n",
  "<Leader><Tab>",
  "<Cmd> tabnext <CR>",
  { noremap = true, desc = "Tab : Next" }
)
vim.keymap.set(
  "n",
  "<Leader><S-Tab>",
  "<Cmd> tabprevious <CR>",
  { noremap = true, desc = "Tab : Prev" }
)
vim.keymap.set(
  "n",
  "<Leader>tw",
  "<Cmd> set wrap! <CR>",
  { noremap = true, desc = "Toggle : Wrap" }
)
vim.keymap.set("n", "<Leader>t|", function()
  if #vim.wo.colorcolumn > 0 then
    vim.cmd("set cc=")
  else
    vim.cmd("set cc=+1")
  end
end, { noremap = true, desc = "Toggle : ColorColumn" })

-- [[ BUFFER : •b ]]

vim.keymap.set("n", "<Leader>bb", function()
  vim.fn.setreg("+", vim.fn.expand("%:~"))
  print('["+] ' .. vim.fn.expand("%:~"))
end, { noremap = true, desc = "Buffer : Copy Path" })
vim.keymap.set(
  "n",
  "<Leader>by",
  "ggVGy<C-o>",
  { noremap = true, desc = "Buffer : Copy All" }
)
vim.keymap.set(
  "n",
  "<Leader>bv",
  "ggVG",
  { noremap = true, desc = "Buffer : Select All" }
)
vim.keymap.set(
  "n",
  "<Leader>bd",
  "ggVGd",
  { noremap = true, desc = "Buffer : Delete All" }
)
vim.keymap.set(
  "n",
  "<Leader>bq",
  "<Cmd> bd <CR>",
  { noremap = true, desc = "Buffer : Quit" }
)
vim.keymap.set(
  "n",
  "<Leader>bQ",
  "<Cmd> %bd <CR>",
  { noremap = true, desc = "Buffer : Quit All" }
)

-- [[ WINDOW : •w ]]

vim.keymap.set(
  "n",
  "<Leader>wh",
  "<Cmd> abo vsplit <CR>",
  { noremap = true, desc = "Window : Split Left" }
)
vim.keymap.set(
  "n",
  "<Leader>wj",
  "<Cmd> bel split <CR>",
  { noremap = true, desc = "Window : Split Down" }
)
vim.keymap.set(
  "n",
  "<Leader>wk",
  "<Cmd> abo split <CR>",
  { noremap = true, desc = "Window : Split Up" }
)
vim.keymap.set(
  "n",
  "<Leader>wl",
  "<Cmd> bel vsplit <CR>",
  { noremap = true, desc = "Window : Split Right" }
)
vim.keymap.set(
  "n",
  "<Leader>wH",
  "<Cmd> to vsplit <CR>",
  { noremap = true, desc = "Window : Attach Left" }
)
vim.keymap.set(
  "n",
  "<Leader>wJ",
  "<Cmd> bo split <CR>",
  { noremap = true, desc = "Window : Attach Down" }
)
vim.keymap.set(
  "n",
  "<Leader>wK",
  "<Cmd> to split <CR>",
  { noremap = true, desc = "Window : Attach Up" }
)
vim.keymap.set(
  "n",
  "<Leader>wL",
  "<Cmd> bo vsplit <CR>",
  { noremap = true, desc = "Window : Attach Right" }
)

vim.keymap.set(
  "n",
  "<Leader>h",
  "<Cmd> wincmd h <CR>",
  { noremap = true, desc = "Window : Left" }
)
vim.keymap.set(
  "n",
  "<Leader>j",
  "<Cmd> wincmd j <CR>",
  { noremap = true, desc = "Window : Down" }
)
vim.keymap.set(
  "n",
  "<Leader>k",
  "<Cmd> wincmd k <CR>",
  { noremap = true, desc = "Window : Up" }
)
vim.keymap.set(
  "n",
  "<Leader>l",
  "<Cmd> wincmd l <CR>",
  { noremap = true, desc = "Window : Right" }
)

vim.keymap.set(
  "n",
  "<Leader>H",
  "<Cmd> wincmd H <CR>",
  { noremap = true, desc = "Window : Move Left" }
)
vim.keymap.set(
  "n",
  "<Leader>J",
  "<Cmd> wincmd J <CR>",
  { noremap = true, desc = "Window : Move Down" }
)
vim.keymap.set(
  "n",
  "<Leader>K",
  "<Cmd> wincmd K <CR>",
  { noremap = true, desc = "Window : Move Up" }
)
vim.keymap.set(
  "n",
  "<Leader>L",
  "<Cmd> wincmd L <CR>",
  { noremap = true, desc = "Window : Move Right" }
)

vim.keymap.set(
  "n",
  "<Leader>=",
  "<Cmd> wincmd = <CR>",
  { noremap = true, desc = "Window : Equalize" }
)
vim.keymap.set(
  "n",
  "<Leader>wq",
  "<Cmd> q <CR>",
  { noremap = true, desc = "Window : Quit" }
)

vim.keymap.set("n", "<C-h>", "<C-w>5<")
vim.keymap.set("n", "<C-l>", "<C-w>5>")
vim.keymap.set("n", "<C-j>", "<C-w>-")
vim.keymap.set("n", "<C-k>", "<C-w>+")

-- [[ DIAGNOSTICS ]]

vim.keymap.set(
  "n",
  "<M-d>",
  vim.diagnostic.open_float,
  { desc = "Diagnostics : Current" }
)

vim.keymap.set("n", "<M-S-d>", function()
  vim.diagnostic.open_float({ source = true })
end, { desc = "Diagnostics : Current Raw" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
    },
  })
end, { desc = "Diagnostics : Next" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
    },
  })
end, { desc = "Diagnostics : Prev" })

vim.keymap.set("n", "]D", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  })
end, { desc = "Diagnostics : Next All" })

vim.keymap.set("n", "[D", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  })
end, { desc = "Diagnostics : Prev All" })

-- [[ TERMINAL ]]

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

vim.keymap.set("n", "<Leader>\\", function()
  if pcall(vim.api.nvim_set_current_win, vim.g.u_last_term) then
    return
  end
  vim.g.u_last_term =
    vim.api.nvim_open_win(0, true, { height = 8, split = "below" })
  vim.cmd("term")
  vim.cmd("startinsert!")
end, { desc = "Switch to Terminal" })

vim.keymap.set("n", "<Leader>|", function()
  pcall(vim.api.nvim_win_close, vim.g.u_last_term, false)
  vim.g.u_last_term = nil
end, { desc = "Close Terminal" })
