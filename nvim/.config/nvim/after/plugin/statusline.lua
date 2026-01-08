local modes = {
  ["N"] = "",
  ["I"] = "Insert",
  ["S"] = "Insert",
  ["V"] = "Visual",
  ["C"] = "Command",
  ["O"] = "Command",
  ["R"] = "Replace",
  ["T"] = "Terminal",
}

local queue = {}
local state = {
  mode = "N",
  branch = "",
  filename = "",
  filestatus = "",
  filetype = "",
  selection = "",
  diagnostics = "",
  stats = "",
  location = "",
}

local function enqueue(module)
  if module then
    queue[module] = true
  else
    for mod, _ in pairs(state) do
      queue[mod] = true
    end
  end
end

local handler = {}

function handler.mode()
  local mode = vim.fn.mode()
  mode = mode:upper()
  mode = mode:gsub("\22", "V")
  state.mode = mode
end

function handler.branch()
  local cmd = [[
    branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
      printf ""
    elif [ -n "$(git status --porcelain 2>/dev/null)" ]; then
      printf "~%s~" "$branch"
    elif [ -n "$(git rev-list @{u}.. 2>/dev/null)" ]; then
      printf "+%s+" "$branch"
    else
      printf "%s" "$branch"
    fi
  ]]
  vim.system({ "bash", "-c", cmd }, { text = true }, function(obj)
    local branch = vim.trim(obj.stdout or "")
    vim.schedule(function()
      state.branch = branch
    end)
  end)
end

function handler.filename()
  local filename = vim.fn.bufname()
  filename = filename == "" and "⋯" or vim.fn.fnamemodify(filename, ":~:.")
  state.filename = filename
end

function handler.filestatus()
  local readonly = vim.bo.readonly and "⌀" or ""
  local modified = vim.bo.modified and "🞷" or ""
  state.filestatus = readonly .. modified
end

function handler.filetype()
  if vim.bo.buftype == "" or vim.bo.buflisted then
    local ft = vim.bo.filetype
    state.filetype = ft
  end
end

function handler.location()
  local pos = vim.fn.getcursorcharpos()
  state.location = ("%2d:%-2d"):format(pos[2], pos[3])
end

function handler.selection()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    state.selection = ""
    return
  end

  local sel, cur = vim.fn.getpos("v"), vim.fn.getpos(".")
  local srow, scol, erow, ecol = sel[2], sel[3], cur[2], cur[3]
  ---@diagnostic disable-next-line: need-check-nil
  local cnum = math.abs(scol - ecol) + 1
  ---@diagnostic disable-next-line: need-check-nil
  local lnum = math.abs(srow - erow) + 1

  local range = mode == "\22" and (lnum .. ":" .. cnum)
    or ((mode == "V" or lnum > 1) and lnum or cnum)
  state.selection = "<" .. range .. ">"
end

function handler.diagnostics()
  if vim.lsp.status() ~= "" then
    vim.defer_fn(function()
      enqueue("diagnostics")
    end, 1000)
    state.diagnostics = "𜱃"
    return
  end

  local hl, sym = "DiagnosticSign", "█"
  local ndiags = vim.diagnostic.count(0)
  local errors = (ndiags[1] or 0) > 0
  local warns = (ndiags[2] or 0) > 0
  local infos = (ndiags[3] or 0) > 0
  local hints = (ndiags[4] or 0) > 0

  errors = errors and ("%#" .. hl .. "Error#" .. sym) or ""
  warns = warns and ("%#" .. hl .. "Warn#" .. sym) or ""
  infos = infos and ("%#" .. hl .. "Info#" .. sym) or ""
  hints = hints and ("%#" .. hl .. "Hint#" .. sym) or ""
  state.diagnostics = errors .. warns .. infos .. hints
end

function handler.stats()
  local stats = {
    keymap = vim.o.keymap ~= "" and "⌥" or "",
    format = vim.g.u_manual_formatting and "⨂" or "",
    macro = vim.fn.reg_recording() ~= "" and "⏺" or "",
  }
  stats = vim.tbl_filter(function(v)
    return v ~= ""
  end, stats)
  state.stats = vim.fn.join(stats, " ")
end

local function update()
  local updated = false
  for module, _ in pairs(queue) do
    if module ~= "diagnostics" or vim.fn.mode() == "n" then
      handler[module]()
      queue[module] = nil
      updated = true
    end
  end
  return updated
end

-- this redraws statusline
local function redraw()
  if vim.o.laststatus == 0 then
    return
  end
  if not update() then
    return
  end

  local theme = "%#StatusLine" .. (modes[state.mode] or "Error") .. "#"
  local sep = theme .. "  "

  local file = state.filename
  ---@diagnostic disable-next-line: unnecessary-if
  if state.filestatus ~= "" then
    file = file .. " " .. state.filestatus
  end

  local mode = state.mode
  local branch = state.branch
  local selection = state.selection
  local filetype = state.filetype
  local location = state.location
  local diagnostics = state.diagnostics
  local stats = state.stats

  local is_short = vim.go.columns < 60
  if branch == "" or is_short then
    file = "%<" .. file
  else
    branch = "%<" .. branch
  end

  local full = {
    theme,
    mode,
    branch,
    file,
    "%=",
    selection,
    diagnostics,
    stats,
    filetype,
    location,
    "%*",
  }

  local mini = {
    theme,
    file,
    "%=",
    diagnostics,
  }

  local statusline = is_short and mini or full
  statusline = vim.tbl_filter(function(v)
    return v and v ~= ""
  end, statusline)
  ---@diagnostic disable-next-line: assign-type-mismatch
  statusline = table.concat(statusline, sep)
  vim.wo.statusline = statusline
end

local function run()
  enqueue("stats")
  redraw()
  vim.defer_fn(run, 1000)
end
run()

local group = vim.api.nvim_create_augroup("uStatusline", { clear = false })

-- ::: events for complete redraw
vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufWritePost",
}, {
  group = group,
  callback = function()
    enqueue()
    redraw()
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = group,
  callback = function()
    enqueue("filestatus")
    enqueue("selection")
    enqueue("location")
    redraw()
  end,
})

vim.api.nvim_create_autocmd("CursorMovedI", {
  group = group,
  callback = function()
    enqueue("filestatus")
    enqueue("location")
    redraw()
  end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = group,
  callback = function()
    enqueue("diagnostics")
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  group = group,
  callback = function()
    enqueue("diagnostics")
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  callback = function()
    enqueue("mode")
    enqueue("filetype")
    enqueue("selection")
    redraw()
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  callback = function()
    enqueue("branch")
    enqueue("filename")
    enqueue("filetype")
    redraw()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function()
    enqueue("filetype")
    redraw()
  end,
})

vim.api.nvim_create_autocmd("TermLeave", {
  group = group,
  callback = function()
    enqueue("mode")
    redraw()
  end,
})
