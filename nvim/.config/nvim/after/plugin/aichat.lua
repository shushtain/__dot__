local function ai_expand_line(role)
  local prompt = vim.api.nvim_get_current_line()
  if role == "%code%" then
    prompt = "[" .. vim.bo.filetype .. "]\n" .. prompt
  end
  prompt = vim.fn.shellescape(prompt)

  vim.system(
    { "aichat", "-r", role, vim.fn.trim(prompt) },
    { text = true },
    function(obj)
      if obj.code ~= 0 then
        vim.schedule(function()
          vim.notify(
            obj.code .. "/" .. obj.signal .. ": " .. obj.stderr,
            vim.log.levels.WARN
          )
        end)
        return
      end

      local result = vim.split(obj.stdout, "\n")
      vim.schedule(function()
        local comment = vim.o.commentstring
        comment = comment:gsub("%%s", "AI")
        for i, row in ipairs(result) do
          if row:match("```") then
            result[i] = comment
          end
        end
        vim.api.nvim_put(result, "l", true, false)
      end)
    end
  )
end

local function ai_improve(retry)
  local request = vim.g.u_last_prompt or ""
  if not retry then
    request = vim.fn.input({ prompt = "Request: " })
  end
  if not request then
    return nil
  end

  vim.g.u_last_prompt = request
  if request:gsub("%s", "") == "" then
    request =
      "Rewrite it into a clear, grammatically correct version while preserving the original meaning as closely as possible. Correct any spelling mistakes, punctuation errors, verb tense issues, word choice problems, and other grammatical mistakes. Keep the original paragraph structure, formatting quirks, etc"
  end
  local ft = vim.bo.filetype
  request = request .. " [" .. ft .. "]"

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local prompt = table.concat(lines, "\n")
  prompt = "::: " .. request .. " :::\n" .. prompt
  prompt = vim.fn.shellescape(prompt)

  vim.system(
    { "aichat", "-r", "improve", vim.fn.trim(prompt) },
    { text = true },
    function(obj)
      if obj.code ~= 0 then
        vim.schedule(function()
          vim.notify(
            obj.code .. "/" .. obj.signal .. ": " .. obj.stderr,
            vim.log.levels.WARN
          )
        end)
        return
      end

      local result = vim.split(obj.stdout, "\n")
      vim.schedule(function()
        local buf = vim.api.nvim_create_buf(true, true)
        vim.bo[buf].filetype = ft
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)
        vim.api.nvim_open_win(buf, true, { split = "right" })
        vim.cmd("windo diffthis")
      end)
    end
  )
end

vim.keymap.set("n", "<Leader>ic", function()
  ai_expand_line("%code%")
end, { desc = "AI : Code" })

vim.keymap.set("n", "<Leader>ie", function()
  ai_expand_line("emoji")
end, { desc = "AI : Emoji" })

vim.keymap.set("n", "<Leader>ii", function()
  ai_improve()
end, { desc = "AI : Improve" })

vim.keymap.set("n", "<Leader>ir", function()
  ai_improve(true)
end, { desc = "AI : Resume" })
