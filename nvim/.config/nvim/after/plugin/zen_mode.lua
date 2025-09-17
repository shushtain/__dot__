vim.g.zen = { active = false }

local function zenify(key, value)
  if vim.g.zen.active then
    vim.api.nvim_set_option_value(key, vim.g.zen[key], {})
  else
    local zen = vim.g.zen
    zen[key] = vim.api.nvim_get_option_value(key, {})
    vim.api.nvim_set_option_value(key, value, {})
    vim.g.zen = zen
  end
end

vim.api.nvim_create_user_command("Zen", function()
  zenify("number", false)
  zenify("relativenumber", false)
  zenify("signcolumn", "no")
  -- zenify("cursorline", false)
  zenify("scrolloff", 999)
  zenify("showmode", false)
  zenify("showcmd", false)
  zenify("list", false)
  zenify("wrap", true)
  zenify("hlsearch", false)
  zenify("cmdheight", 0)

  zenify("laststatus", 0)
  require("lualine").hide({
    unhide = vim.g.zen.active,
  })

  local zen = vim.g.zen
  zen.active = not zen.active
  vim.g.zen = zen
end, {})

vim.keymap.set(
  "n",
  "<Leader>tz",
  "<Cmd> Zen <CR>",
  { desc = "Toggle : Zen Mode" }
)

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("uLeaveZen", { clear = true }),
  callback = function()
    if vim.g.zen.active then
      vim.cmd("Zen")
    end
  end,
  desc = "Leave Zen Mode",
})
