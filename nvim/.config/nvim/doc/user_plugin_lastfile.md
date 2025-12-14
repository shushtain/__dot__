# One-file LastFile plugin

> Neovim 0.11.5

There are already some great native capabilities like `:mksession` and great plugins like [rmagatti/auto-session](https://github.com/rmagatti/auto-session). But I couldn't make it work for me. Either something breaks because a naughty plugin doesn't clean unrecoverable buffers on `VimLeave`, or I open a huge Rust project and wonder why everything is slow while having basically every buffer open from all the previous sessions.

Making a plugin that opens the last file (or several last files) you were working on is a leaner, make-it-and-forget-it kind of setup. And it is also a great exercise for working with cached files that improved my other plugins.

```lua
---Grouping autocmds is a good practice.
---And we will be able to disable caching this way
local group = vim.api.nvim_create_augroup("uLastFile", { clear = false })
---Cache location
local state = vim.fn.stdpath("state") .. "/lastfile/"
---Hashing function, since we want OS-friendly filenames
local function hash()
  return state .. vim.fn.sha256(vim.fn.getcwd()) .. ".data"
end

---Restore last file
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function(env)
    ---Ignore temporary, util files
    if
      vim.bo[env.buf].buftype == ""
      and vim.bo[env.buf].filetype == ""
      and vim.api.nvim_buf_get_name(env.buf) == ""
      and vim.api.nvim_buf_line_count(env.buf) == 1
    then
      local path = hash()
      ---Check if cache exists for this directory
      ---"1" means file exists. I always second-guess it,
      ---since "1" is also a shell error return code
      if vim.fn.filereadable(path) == 1 then
        local file = vim.fn.readfile(path)
        local filename = file[1]
        ---Check if cached file still exists
        if vim.fn.filereadable(filename) == 1 then
          local curpos = { file[2], file[3] }
          ---Schedule it after Neovim is fully loaded.
          ---Wrap in pcalls, not to break occasional
          ---swap file notifications and their restoration
          vim.schedule(function()
            -- open file
            pcall(vim.cmd, "e " .. filename)
            -- restore cursor position
            pcall(vim.fn.cursor, curpos)
            -- center cursor line in view
            pcall(vim.cmd, "normal! zz")
          end)
        end
        return
      end

      ---[[ Optional ]]
      ---What's cool about custom plugins is that you can make things like
      ---open the main Rust file if I didn't work on this repo before.
      path = vim.fn.getcwd() .. "/src/"
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

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = group,
  callback = function(env)
    local filetype = vim.bo[env.buf].filetype
    local bufname = vim.api.nvim_buf_get_name(env.buf)
    local buftype = vim.bo[env.buf].buftype
    local cwd = vim.fn.getcwd()
    ---Ignore temp files, ignore $HOME directory
    if
      bufname ~= ""
      and buftype == ""
      and filetype ~= "gitcommit"
      and cwd ~= vim.fn.getenv("HOME")
    then
      ---Make cache directory if it doesn't exist
      if vim.fn.isdirectory(state) == 0 then
        vim.fn.mkdir(state, "p")
      end
      local path = hash()
      local curpos = vim.fn.getcurpos()
      local tbl = { bufname, curpos[2], curpos[3] }
      vim.fn.writefile(tbl, path)
    end
  end,
})

---Disable caching for this session
vim.keymap.set("n", "<Leader>ze", function()
  vim.api.nvim_del_augroup_by_id(group)
  vim.fn.delete(hash())
  vim.notify("LastFile is off")
end, { desc = "Purge : LastFile" })

---Purge cache for all directories
vim.keymap.set("n", "<Leader>zo", function()
  vim.fn.delete(state, "rf")
  vim.notify("Purged LastFile cache")
end, { desc = "Purge : LastFile All" })
```
