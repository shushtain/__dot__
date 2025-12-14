# One-file statusline plugin

> Neovim 0.11.5

There are endless ways to customize a statusline once you know what you are doing. I will share my personal setup at the end, but the main goal is to explore ways to make the update loop more efficient.

## Idea

We can't just update everything on every tracked event. First of all, we don't need to update branch on mode change, etc. Secondly, events like `LspProgress` may fire 100 times a second, while we could wait a full second to see if the LSP is ready.

- Redraw statusline passively every 1-2 seconds.
- Prevent bottlenecks with a queue of updates.

## Concept

We need a lightweight queue to see if update is needed but not required instantly.

```lua
local queue = {}
---Enqueue a specific module or all of them
local function enqueue(module)
  if module then
    queue[module] = true
  else
    for mod, _ in pairs(state) do
      queue[mod] = true
    end
  end
end
```

We need a state object for the results of module updates, and a handler that will hold update functions (could be done with separate functions just as well).

```lua
local state = {
  mode = "N",
  branch = "",
  filename = "",
  location = "",
  ---...
}

local handler = {}
function handler.mode()
  local mode = vim.fn.mode()
  mode = mode:upper()
  mode = mode:gsub("\22", "V")
  return mode
end
---...
```

We need a function that will update module states without redrawing the statusline.

```lua
local function update()
  local updated = false
  for module, _ in pairs(queue) do
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
  return updated
end
```

We need a function that redraws statusline.

```lua
local function redraw()
  ---Statusline is hidden -> return
  if vim.o.laststatus == 0 then
    return
  end
  ---Update modules. If no updates -> return
  if not update() then
    return
  end
  ---Concatenate modules and send statusline
  local all_modules = { "TODO!" }
  statusline = table.concat(all_modules, sep)
  vim.wo.statusline = statusline
end
```

We need to create and start the main loop. `1000` is basically what defines passive FPS (1000/1000=1fps). We will force instant redraw on the most crucial changes: mode, location, etc.

```lua
local function run()
  ---Here we enqueue modules not tracked elsewhere
  enqueue("stats")
  redraw()
  vim.defer_fn(run, 1000)
end
run()
```

And we need some autocmds to enqueue modules.

```lua
---Grouping autocmds is a good practice
local group = vim.api.nvim_create_augroup("uStatusline", { clear = false })

---This one causes complete update
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

---This one updates diagnostics passively, since triggered often
---but redrawing with 1 sec delay is just fine
vim.api.nvim_create_autocmd("LspProgress", {
  group = group,
  callback = function()
    enqueue("diagnostics")
  end,
})
```

## Example

This is a highly personal setup, but it shows it all working together. I believe, this could be plug-and-play, except you will need several additional `StatusLine...` highlight groups defined, since [my theme](https://github.com/shushtain/farba.nvim) provides them for me.

<details>
<summary>Full code</summary>

```lua
---This is mainly to change to `StatusLineVisual`
---and other highlight groups
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

---"\22" is <C-v> (blockwise visual mode)
function handler.mode()
  local mode = vim.fn.mode()
  mode = mode:upper()
  mode = mode:gsub("\22", "V")
  return mode
end

---If there are changes, display "~main~"
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

---"⋯" replaces standard "[No Name]"
function handler.filename()
  local filename = vim.fn.bufname()
  filename = filename == "" and "⋯" or vim.fn.fnamemodify(filename, ":~:.")
  return filename
end

---Could as well use standard "[+]" and "[RO]"
function handler.filestatus()
  local readonly = vim.bo.readonly and "⌀" or ""
  local modified = vim.bo.modified and "🞷" or ""
  return readonly .. modified
end

---`blink.cmp` is a completion plugin, so I don't need to see
---its filetypes in pmenus and such
function handler.filetype()
  local ft = vim.bo.filetype
  if ft:find("blink%-cmp") then
    return state.filetype
  end
  return ft
end

---We could've used standard statusline expression for this,
---but we wouldn't track widechars and such properly,
---as the standard one shows bytes, not chars.
function handler.location()
  local pos = vim.fn.getcursorcharpos()
  return ("%2d:%-2d"):format(pos[2], pos[3])
end

---Shows how many row-columns are in selection.
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

---This is controversial. I want very noticeable diagnostic signs
---and don't care about the number of errors
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

---These are custom indicators
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
    ---If module is "diagnostics", wait for Normal mode to update
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

  ---This defines where to trim the text
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

---Complete redraw is best here
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

---I need a small delay on first load to get the branch
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
```

</details>
