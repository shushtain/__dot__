# Lean LSP/IDE setup

> Neovim 0.11.5

I still remember my initial confusion and hopelessness with setting up IDE features when I switched to Neovim (back at v0.10). And things are better now. There are good guides on YouTube for the current state of things: [v0.11+](https://youtu.be/oBiBEx7L000?si=4vmjBfgNrduSbr2L) (uses Lazy plugin manager) and [v0.12](https://youtu.be/yI9R13h9IEE?si=SoObLGISQVUx9-s-) (requires `vim.pack.add()`).

However, if things were that easy, you could just copy-paste some config without even watching a video. Here I hope to provide more context for each aspect of LSP/IDE setup, focusing on doing more with less dependencies. Please consider it an attempt to help, not a definitive guide on how one should set up their work environment.

## Installing a server

For most servers, there are several options:

- installing a binary from your package manager/website
- installing a package from `npm`, `cargo`, etc
- using [mason.nvim](https://github.com/mason-org/mason.nvim)

I strongly recommend using the first two options, unless:

- your system doesn't have a package manager
- you don't have any setup for reproducing your OS configuration (GNU Stow, etc)
- your config is used on many machines that need to "auto-setup"

There is nothing wrong with Mason, it's a great tool. But I haven't seen a single config that would not become a maze. There always comes the need for `mason-tool-installer`, `mason-lspconfig`, etc. And then something breaks, and suddenly we have to study three plugins to debug the setup.

Just keep in mind that all you actually need is a binary for your server, either on `$PATH`, or a full link to the executable. That's all.

## Configuring LSP

First of all, there is the magnificent [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) which provides sensible defaults. You may have seen older configs that have elaborate setups around this plugin. As of 2025, you just install the plugin, no setup needed, and all it does is provide configs from its [lsp/](https://github.com/neovim/nvim-lspconfig/tree/master/lsp) folder.

You could also copy configs from those files right into your own `.config/nvim/lsp/`, or into `after/lsp/`, or into `vim.lsp.config("", {})`. Here, they are written from low to high priority, so if you do install `nvim-lspconfig`, consider `lsp/` folder to be "taken" by the plugin, and use the last two options, so your overrides "win".

For example, if I choose to install the plugin after all, it will provide this from its own `lsp/typos_lsp.lua`:

```lua
---@type vim.lsp.Config
return {
  cmd = { "typos-lsp" },
  root_markers = {
    "typos.toml",
    "_typos.toml",
    ".typos.toml",
    "pyproject.toml",
    "Cargo.toml",
  }
}
```

Then I can add some options into my `after/lsp/typos_lsp.lua`:

```lua
---@type vim.lsp.Config
return {
  init_options = {
    diagnosticSeverity = "Hint",
  }
}
```

And add even more settings inline:

```lua
---"*" stands for "all LSPs"
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})
```

## Enabling LSP

Don't forget to enable LSP(s).

```lua
---after vim.lsp.config()
vim.lsp.enable("typos_lsp")
vim.lsp.enable({ "ts_ls", "rust_analyzer" })
```

## Using LSP

Many things are already enabled by default. See `:h lsp-defaults`.

```help
These GLOBAL keymaps are created unconditionally when Nvim starts:
- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
- "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
```

If you plan on using native completion, you may want to map it to something more convenient:

```lua
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")
```

There are other useful things like `vim.lsp.buf.format()`, `vim.lsp.inlay_hint.enable()`, `vim.diagnostic.config()`, `vim.diagnostic.open_float()`, etc. I'll leave that for you to discover on your own.

## Fixing LSP

`:checkhealth vim.lsp` is the best way to see what's enabled, what settings are used, and what errors are logged (the path to logs is at the top of buffer). When that doesn't help, temporarily add `vim.lsp.set_log_level("debug")` to your config, reload Neovim, and check the logs again.

Before debugging further and asking for help, at the very least you need to know the answer to:

- Is the server binary seen/accessible?
- Does the LSP attach to the buffer you want?
- Does the LSP recognize the right project root?
- Are there logged errors related to the problem?

## Additional IDE features

### Completion and snippets

Native completion becomes more and more powerful. I believe, one day it will have everything you need and more. Until then, [blink.cmp](https://github.com/Saghen/blink.cmp) is probably the most sensible option. It covers some edge cases with [snippet expansion](https://github.com/olrtg/emmet-language-server/issues/55) and [dynamic completions](https://github.com/neovim/neovim/discussions/36823); and delivers many quality-of-life features on top of that. By default, it provides snippet support through native `vim.snippet`, but can also work with external engines: [mini.snippets](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-snippets.md) and [LuaSnip](https://github.com/L3MON4D3/LuaSnip).

### Formatting

Many LSPs come with built-in formatters. For those that don't, you could use [conform.nvim](https://github.com/stevearc/conform.nvim) or DIY it.

<details>
<summary>DIY example</summary>

If the formatter has no `stdin` support (works only by rewriting files), you will have to make `BufWritePost` autocmd, and then re-read the file changed outside Neovim. Letting something rewrite the file completely is not ideal, however. Fortunately, most formatters support `stdin`, which we should prefer using:

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    ---It's a good idea to have a manual toggle
    if vim.g.u_manual_formatting then
      return
    end

    local filetype = vim.bo[args.buf].filetype
    local filepath = vim.api.nvim_buf_get_name(args.buf)
    local cmd = nil

    ---Don't be confused by passing the path to the file.
    ---It's just a convenient way for prettier to know which
    ---parser to use. We will pass actual lines later.
    if filetype == "html" then
      cmd = { "prettier", "--stdin-filepath", filepath }
    elseif filetype == "json" then
      cmd = { "prettier", "--stdin-filepath", filepath, "--trailing-comma", "none" }
    else
      return
    end

    ---Gather lines and call formatter synchronously (max 500 ms delay).
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local result = vim.system(cmd, { text = true, stdin = lines }):wait(500)

    ---Typically, as other tools, formatters return code 0 for "success"
    if result.code ~= 0 then
      vim.notify(
        result.code .. "/" .. result.signal .. ": " .. result.stderr,
        vim.log.levels.WARN
      )
      return
    end

    ---Split output back into lines
    lines = vim.split(result.stdout, "\n")
    ---Optionally trim leading empty lines
    while #lines > 0 and lines[1] == "" do
      table.remove(lines, 1)
    end
    ---Optionally trim trailing empty lines
    while #lines > 0 and lines[#lines] == "" do
      table.remove(lines)
    end

    ---Replace buffer content with formatted lines
    vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
  end,
})
```

</details>

### Linting

Many LSPs come with built-in linters. For those that don't, you could use [nvim-lint](https://github.com/mfussenegger/nvim-lint). I won't encourage you to DIY it because many linters have uniquely structured outputs, and you will have to parse that output into Neovim diagnostics format, which is tedious.

### Debugging

Although I don't use any interactive debugger myself, I just know that the answer is [nvim-dap](https://github.com/mfussenegger/nvim-dap).
