vim.filetype.add({
  extension = {
    ebnf = "ebnf",
    scm = "query",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    vim.opt_local.formatoptions:remove("o")

    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if not vim.treesitter.language.add(lang) then
      local available = vim.g.ts_available
        or require("nvim-treesitter").get_available()
      if not vim.g.ts_available then
        vim.g.ts_available = available
      end
      if vim.tbl_contains(available, lang) then
        require("nvim-treesitter").install(lang)
      end
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end
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
      vim.wo[0][0].conceallevel = 0
      vim.wo[0][0].spell = true
    else
      vim.wo[0][0].conceallevel = 2
      vim.wo[0][0].spell = false
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
    vim.wo[0][0].spell = false
  end,
})

vim.api.nvim_create_user_command("I", function(cmd)
  local result = vim.fn.execute(cmd.args)
  local rows = vim.split(result, "\n")
  if rows[1] == "" then
    table.remove(rows, 1)
  end
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
  vim.api.nvim_open_win(buf, true, { split = "right" })
end, { nargs = "+", complete = "command" })
