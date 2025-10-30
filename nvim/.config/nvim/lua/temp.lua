vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("uLspLocalConfigs", { clear = true }),
  once = true,
  callback = function()
    local configs = "_nvim"
    local root = vim.fn.getcwd() .. "/"
    if vim.fn.isdirectory(root .. configs) == 1 then
      local files = vim.fn.readdir(root .. configs)
      for _, file in ipairs(files) do
        local lsp = file:match("(.+)%.lua$")
        if lsp then
          local config = require(configs .. "." .. lsp)
          if config then
            vim.lsp.config(lsp, config)
          end
        end
      end
    end
  end,
})
