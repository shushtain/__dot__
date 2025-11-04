vim.filetype.add({
  extension = {
    ebnf = "ebnf",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(env)
    vim.opt_local.formatoptions:remove("o")

    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if not vim.treesitter.language.add(lang) then
      require("nvim-treesitter").install(lang)
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(env.buf, lang)
      vim.wo.foldmethod = "expr"
    end

    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("uOptsEnter", { clear = true }),
  callback = function()
    vim.opt_local.listchars = {
      -- tab = "▏ ⇥",
      tab = "▎ ",
      multispace = "·",
      lead = "·",
      leadmultispace = "▏" .. string.rep(" ", vim.bo.shiftwidth - 1),
      trail = "·",
      nbsp = "␣",
    }

    if vim.bo.modifiable then
      vim.wo.conceallevel = 0
      vim.wo.spell = true
    else
      vim.wo.conceallevel = 2
      vim.wo.spell = false
    end

    vim.o.title = true
    local title = vim.fn.expand("%:~")
    vim.o.titlestring = title ~= "" and title or "Neovim"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("uHighlightOnYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("uTermOpen", { clear = true }),
  callback = function()
    vim.wo.spell = false
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("uRustStarter", { clear = true }),
  once = true,
  callback = function(env)
    local bufname = vim.api.nvim_buf_get_name(env.buf)
    local line_count = vim.api.nvim_buf_line_count(env.buf)

    if bufname == "" and line_count == 1 then
      local path = vim.fn.getcwd() .. "/src/"
      if vim.fn.filereadable(path .. "main.rs") == 1 then
        vim.schedule(function()
          vim.cmd("e " .. path .. "main.rs")
        end)
      elseif vim.fn.filereadable(path .. "lib.rs") == 1 then
        vim.schedule(function()
          vim.cmd("e " .. path .. "lib.rs")
        end)
      end
    end
  end,
})
