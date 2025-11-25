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
  return mode
end

function handler.branch()
  local git = vim.b.gitsigns_status_dict or {}
  local branch = git.head or ""
  if
    branch ~= ""
    and (git.added or 0) + (git.changed or 0) + (git.removed or 0) > 0
  then
    return "~" .. branch .. "~"
  end
  return branch
end

function handler.filename()
  local filename = vim.fn.bufname()
  filename = filename == "" and "⋯" or vim.fn.fnamemodify(filename, ":~:.")
  return filename
end

function handler.filestatus()
  -- if not vim.bo.modifiable then
  --   return "∅"
  -- end
  local readonly = vim.bo.readonly and "⦰" or ""
  local modified = vim.bo.modified and "🞸" or ""
  return readonly .. modified
end

function handler.filetype()
  return vim.bo.filetype
end

function handler.location()
  local pos = vim.fn.getcursorcharpos()
  return ("%2d:%-2d"):format(pos[2], pos[3])
end

function handler.selection()
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
end

function handler.diagnostics()
  if vim.lsp.status() ~= "" then
    vim.defer_fn(function()
      enqueue("diagnostics")
    end, 1000)
    return "𜱃"
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
  return errors .. warns .. infos .. hints
end

function handler.stats()
  local stats = {
    keymap = vim.o.keymap ~= "" and "⌥" or "",
    format = vim.g.u_manual_formatting and "⨂" or "",
  }
  stats = vim.tbl_filter(function(v)
    return v ~= ""
  end, stats)
  return vim.fn.join(stats, " ")
end

local function update()
  local updated = false
  for module, _ in pairs(queue) do
    if module ~= "diagnostics" or vim.fn.mode() == "n" then
      local callback = handler[module]
      ---@diagnostic disable-next-line: unnecessary-if
      if callback then
        state[module] = callback()
      else
        vim.notify_once("Statusline module " .. module .. " missing a callback")
      end
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

-- ::: COMPLETE REDRAW
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

-- HACK:
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  once = true,
  callback = function()
    vim.defer_fn(function()
      enqueue("branch")
    end, 100)
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
