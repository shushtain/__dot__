I see many people struggling with LSP configuration. It seems like there are many plugins required for this task, while "native" setups based on `vim.lsp` lack adoption. Here is my take on setting up LSP support. It's not a "quick fix" kind of setup, but it also doesn't present you with a couple of "black boxes" that are hard to interface with.

Firstly, we need to get our actual LSPs, which are programs that support a specific protocol based on JSON, nothing more. You can take your time to study "Mason", "mason-tool-installer" and other plugins, but I challenge you to install the needed LSPs natively.

Unless you are on a system with no simple way to acquire software packages, there is really no need to have a separate tool to install them. Most of the LSPs have websites and wikis to help you acquire them. And the links to their GitHub pages are often present as comments in <https://github.com/neovim/nvim-lspconfig/tree/master/lsp>.

Once you acquire those tools, take a closer look at the link above. Those are "sensible defaults" kind of configs for each LSP. Previously, we used `nvim-lspconfig` for all stages of the setup, but now this plugin is purely data (providing the configs you see).

Now, let's say we want to enable `bashls` support. We've got the actual software (for me, on Arch Linux, it's done with `sudo pacman -S bash-language-server`). We have two options here:

1. Copy the full recipe from the link above:

- more tedious but gives you full control;
- some servers require more convoluted setup.

2. Install `nvim-lspconfig` plugin first:

- sensible, default config is provided;
- you have one more plugin to worry about.

Regardless of your choice, we can configure it in the same way. Let's place `after/lsp/bashls.lua` inside your config folder. It will look something like `$HOME/.config/nvim/after/lsp/bashls.lua`. We could use `.config/nvim/lsp/` folder just as well, but it could override `nvim-lspconfig` defaults completely, or maybe Neovim decides to provide LSP configs natively as well. So the safest choice is to use `after/lsp/`.

Now we can copy the config from the link above and put it inside our file:

```lua
---@type vim.lsp.Config
return {
  filetypes = { "bash", "sh" },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
  cmd = { "bash-language-server", "start" },
  root_markers = { ".git" },
}
```

The first line is for our Lua LSP, if we use one, to provide suggestions as we edit the table. If we installed `nvim-lspconfig` in our main config, we actually don't need to copy this recipe. We could just do:

```lua
---@type vim.lsp.Config
return {
  settings = {
    -- for future settings
  },
}
```

But at least look at the recipes from the link above. If one day you decide to work on some special filetype `"kindalikebash"` that is totally Bash, but has a dinstic filetype for your evil purposes, you will know that all you need to do to enable LSP support is to add `"kindalikebash"` to the `filetypes` field.

Now all you need to do is to enable it. You can place `vim.lsp.enable("bashls")` inside your config, or inside `.config/nvim/after/ftplugin/sh.lua`. Yes, that's another special folder for all your filetype-local options.

We are almost done. If you plan to use something besides native completions, you may want to extended client capabilities (they tell your LSPs what Neovim supports). For example, this is for `blink.cmp`, and it's placed somewhere in your general config, not in some `after/` folder or file:

```lua
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})
```

This will make `"*"` (all) of our LSPs be aware of those capabilities.
