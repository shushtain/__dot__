vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.laststatus = 3

vim.o.cursorline = true
vim.o.foldenable = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.smoothscroll = true

-- NOTE: this will be possible in 0.12
-- vim.o.winborder = "+,-,+,-,+,-,+,-"

vim.o.mouse = "a"
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.o.clipboard = "unnamedplus"
  end,
})

vim.o.showmode = false
vim.o.confirm = true
vim.o.showcmd = false

vim.o.tabstop = 8
vim.o.softtabstop = -1
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.breakindent = true

vim.o.list = true
vim.opt.fillchars = {
  fold = " ",
  eob = "·",
  lastline = "𜱃",
  msgsep = "─",
}

vim.o.conceallevel = 0

vim.o.spell = true
vim.o.spelllang = "en_us,uk"
vim.o.spelloptions = "camel"

vim.o.wrap = true
vim.o.linebreak = true

vim.o.backspace = "indent,eol,start"
vim.o.whichwrap = "b,s,[,]"
vim.o.virtualedit = "block"

vim.opt.matchpairs:append("<:>")
vim.opt.matchpairs:append("«:»")

vim.opt.nrformats:append("alpha")

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.inccommand = "split"

vim.o.completeopt = "fuzzy,menuone,noinsert,popup"

vim.diagnostic.config({
  severity_sort = true,
  float = {
    source = false,
    header = "",
    prefix = " ",
    suffix = function(dia, _, _)
      local suffix = dia.code and (" " .. dia.code .. " ") or " "
      return suffix, "FloatFooter"
    end,
  },
  underline = {
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "•",
      [vim.diagnostic.severity.WARN] = "•",
      [vim.diagnostic.severity.INFO] = "•",
      [vim.diagnostic.severity.HINT] = "•",
    },
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
  virtual_text = {
    source = false,
    virt_text_pos = "eol",
    spacing = 1,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
  jump = {
    float = true,
    wrap = true,
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
    },
  },
})

vim.o.updatetime = 500
vim.o.timeoutlen = 500
vim.o.timeout = false

vim.o.backup = false
vim.o.writebackup = true
vim.o.undofile = true
vim.o.swapfile = true

vim.opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  -- "terminal",
  -- "localoptions",
}

vim.opt.shortmess:append("c")
vim.opt.shortmess:append("I")
vim.opt.shortmess:append("a")

-- vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
