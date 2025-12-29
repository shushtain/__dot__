local group = vim.api.nvim_create_augroup("uSessions", { clear = false })
local sessions = vim.fn.stdpath("state") .. "/sessions/"

local function hash()
  return sessions .. vim.fn.sha256(vim.g.u_origin) .. ".vim"
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function(_env)
    if #vim.fn.argv() > 0 then
      return
    end

    local cwd = vim.fn.getcwd()
    if cwd == vim.fn.getenv("HOME") then
      return nil
    end

    vim.g.u_origin = vim.fn.getcwd()
    local session = hash()
    if vim.fn.filereadable(session) == 1 then
      vim.schedule(function()
        local fname = vim.fn.fnameescape(session)
        if fname == "" then
          return
        end
        vim.cmd("silent source " .. fname)
        pcall(function()
          vim.cmd("e")
        end)
      end)
      return
    end

    --[[ Bonus for Rust ]]

    local rust_src = vim.fn.getcwd() .. "/src/"
    if vim.fn.filereadable(rust_src .. "main.rs") == 1 then
      vim.schedule(function()
        vim.cmd("e " .. rust_src .. "main.rs")
      end)
    elseif vim.fn.filereadable(rust_src .. "lib.rs") == 1 then
      vim.schedule(function()
        vim.cmd("e " .. rust_src .. "lib.rs")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function(_env)
    if not vim.g.u_origin then
      return
    end

    -- for crates.nvim
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) then
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("Cargo.toml$") then
          -- vim.cmd("silent! bwipeout " .. buf)
          vim.cmd("bwipeout " .. buf)
        end
      end
    end

    local fname = vim.fn.fnameescape(hash())
    if fname == "" then
      return
    end
    if vim.fn.isdirectory(sessions) == 0 then
      vim.fn.mkdir(sessions, "p")
    end
    vim.cmd("mksession! " .. fname)
  end,
})

vim.keymap.set("n", "<Leader>zs", function()
  if not vim.g.u_origin then
    vim.notify("Session is not tracked", 3)
  end
  vim.api.nvim_del_augroup_by_id(group)
  vim.fn.delete(hash())
  vim.notify("Current session will not be saved")
end, { desc = "Purge : Session" })

vim.keymap.set("n", "<Leader>zS", function()
  vim.fn.delete(sessions, "rf")
  vim.notify("Sessions cache purged")
end, { desc = "Purge : Sessions" })
