return {
  "folke/lazydev.nvim",
  enabled = false,
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "~/.local/state/nvim/luasnip_env", words = { 's%("~' } },
    },
  },
}
