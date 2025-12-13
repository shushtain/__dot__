return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  -- cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  config = function()
    require("live-server").setup({
      args = {
        "--port=8080",
        "--browser=chromium",
      },
    })

    local offset = ""
    vim.keymap.set("n", "<Leader>tl", function()
      vim.cmd("LiveServerToggle " .. offset)
    end, { desc = "Toggle : Live Server" })
  end,
}
