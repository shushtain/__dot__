vim.filetype.add({
  extension = {
    ebnf = "ebnf",
    -- colson = "colson",
  },
  -- pattern = {
  --   -- [".aliases"] = "sh",
  -- },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(env)
    -- if vim.bo[env.buf].filetype == "colson" then
    --   vim.treesitter.language.add("colson", {
    --     path = vim.fn.getenv("HOME")
    --       .. "/box/colson/tree-sitter-colson/colson.so",
    --   })
    --   vim.treesitter.start(env.buf, "colson")
    -- end
    -- vim.opt_local.formatoptions:remove("c")
    -- vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")

    vim.opt_local.listchars = {
      tab = "▏ ",
      multispace = "·",
      lead = "·",
      leadmultispace = "▏" .. string.rep(" ", vim.bo.shiftwidth - 1),
      trail = "·",
      nbsp = "␣",
    }

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

    if not vim.bo.modifiable then
      vim.wo.conceallevel = 2
      vim.wo.spell = false
    end
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

vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("RustStarter", { clear = true }),
  once = true,
  callback = function(env)
    if vim.g.u_after_init then
      return nil
    end
    vim.g.u_after_init = true

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

vim.api.nvim_create_user_command("E", function(cmd)
  local result = vim.fn.execute(cmd.args)
  local rows = vim.split(result, "\n")
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
  vim.api.nvim_open_win(buf, true, { split = "right" })
end, { nargs = "+" })

vim.api.nvim_create_user_command("P", function(cmd)
  local result = vim.fn.execute("lua print(vim.inspect(" .. cmd.args .. "))")
  local rows = vim.split(result, "\n")
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
  vim.api.nvim_open_win(buf, true, { split = "right" })
end, { nargs = "+" })
