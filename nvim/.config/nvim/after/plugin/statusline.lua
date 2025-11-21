local modes = {
  ["N"] = "",
  ["I"] = "Insert",
  ["V"] = "Visual",
  ["C"] = "Command",
  ["O"] = "Command",
  ["R"] = "Replace",
  ["S"] = "Replace",
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
  if not module then
    for mod, _ in pairs(state) do
      queue[mod] = true
    end
  end
  if not queue[module] then
    queue[module] = true
  end
end

local handler = {
  _mode = function()
    local mode = vim.fn.mode()
    mode = mode:upper()
    mode = mode:gsub("\22", "V")
    return mode
  end,
  _branch = function()
    local git = vim.b.gitsigns_status_dict or {}
    return git.head or ""
  end,
  _filename = function()
    local filename = vim.fn.bufname()
    filename = filename == "" and "⋯" or vim.fn.fnamemodify(filename, ":~:.")
    return filename
  end,
  _filestatus = function()
    -- if not vim.bo.modifiable then
    --   return "∅"
    -- end
    local readonly = vim.bo.readonly and "⦰" or ""
    local modified = vim.bo.modified and "🞸" or ""
    return readonly .. modified
  end,
  _filetype = function()
    return vim.bo.filetype
  end,
  _location = function()
    local pos = vim.fn.getcursorcharpos()
    return ("%2d:%-2d"):format(pos[2], pos[3])
  end,
  _selection = function()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
      return ""
    end

    local sel, cur = vim.fn.getpos("v"), vim.fn.getpos(".")
    local srow, scol, erow, ecol = sel[2], sel[3], cur[2], cur[3]
    ---@diagnostic disable-next-line: need-check-nil
    local cnum = math.abs(scol - ecol) + 1
    ---@diagnostic disable-next-line: need-check-nil
    local lnum = math.abs(srow - erow) + 1

    local range = mode == "\22" and (lnum .. ":" .. cnum)
      or ((mode == "V" or lnum > 1) and lnum or cnum)
    return "<" .. range .. ">"
  end,
  _diagnostics = function()
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
    return errors .. warns .. infos .. hints
  end,
  _stats = function()
    local stats = {
      smart_kbd = vim.g.smart_keyboard and "⌨" or "",
      keymap = vim.o.keymap ~= "" and "⌥" or "",
      format = vim.g.u_manual_formatting and "⨂" or "",
    }
    stats = vim.tbl_filter(function(v)
      return v ~= ""
    end, stats)
    return vim.fn.join(stats, " ")
  end,
}

local function update()
  for module, _ in pairs(queue) do
    local tmp = handler["_" .. module]
    if tmp then
      state[module] = tmp()
    else
      vim.notify_once("Statusline module " .. module .. " missing a callback")
    end
    queue[module] = nil
  end
end

-- this redraws statusline
local function redraw()
  if vim.o.laststatus == 0 then
    return
  end
  update()

  local theme = "%#StatusLine" .. (modes[state.mode] or "Error") .. "#"
  local sep = theme .. "  "

  local file = "%<" .. state.filename
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

  local statusline = {
    theme,
    mode,
    branch,
    file,
    " %=",
    selection,
    diagnostics,
    stats,
    filetype,
    location,
    "%*",
  }

  statusline = vim.tbl_filter(function(v)
    return v and v ~= ""
  end, statusline)
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

vim.api.nvim_create_autocmd({
  "ModeChanged",
  "BufEnter",
}, {
  group = group,
  callback = function()
    enqueue("mode")
    redraw()
  end,
})

vim.api.nvim_create_autocmd({
  "BufEnter",
  "FileChangedShellPost",
  "BufWritePost",
}, {
  group = group,
  callback = function()
    enqueue("branch")
    enqueue("filename")
  end,
})

vim.api.nvim_create_autocmd({
  "BufModifiedSet",
  "BufEnter",
  "FileChangedShellPost",
  "BufWritePost",
  -- "ModeChanged",
}, {
  group = group,
  callback = function()
    enqueue("filestatus")
    redraw()
  end,
})

vim.api.nvim_create_autocmd({ "OptionSet" }, {
  pattern = {
    "readonly",
    "modifiable",
  },
  group = group,
  callback = function()
    enqueue("filestatus")
    redraw()
  end,
})

vim.api.nvim_create_autocmd({
  "BufEnter",
  "FileChangedShellPost",
  "BufWritePost",
  "FileType",
}, {
  group = group,
  callback = function()
    enqueue("filetype")
  end,
})

vim.api.nvim_create_autocmd({
  "CursorMoved",
  "ModeChanged",
}, {
  group = group,
  callback = function()
    enqueue("selection")
    redraw()
  end,
})

vim.api.nvim_create_autocmd({
  "CursorMoved",
  "CursorMovedI",
  "BufEnter",
}, {
  group = group,
  callback = function()
    enqueue("location")
    redraw()
  end,
})

vim.api.nvim_create_autocmd({
  "DiagnosticChanged",
  "BufEnter",
}, {
  group = group,
  callback = function()
    enqueue("diagnostics")
  end,
})
