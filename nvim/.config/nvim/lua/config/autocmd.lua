vim.filetype.add({
  extension = {
    ebnf = "ebnf",
    scm = "query",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(env)
    vim.opt_local.formatoptions:remove("o")

    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- local filename = vim.fn.bufname()
    -- if filename:match("source/templates/.+%.html$") then
    --   lang = "tera"
    -- end

    if not vim.treesitter.language.add(lang) then
      require("nvim-treesitter").install(lang)
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(env.buf, lang)
      vim.wo.foldmethod = "expr"
    end

    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt_local.listchars = {
      tab = "▎ ",
      multispace = "·",
      lead = "·",
      leadmultispace = "▏" .. (" "):rep(vim.fn.shiftwidth() - 1),
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
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.wo.spell = false
  end,
})

vim.api.nvim_create_user_command("I", function(cmd)
  local result = vim.fn.execute(cmd.args)
  local rows = vim.split(result, "\n")
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
  vim.api.nvim_open_win(buf, true, { split = "right" })
end, { nargs = "+" })
