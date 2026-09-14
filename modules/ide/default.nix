{
  config,
  lib,
  pkgs,
  pkgr,
  currentUser,
  ...
}:
let
  mod = config.modules.ide;
in
{
  options = {
    modules.ide.enable = lib.mkEnableOption "ide";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.nodejs
      pkgs.tree-sitter
      pkgs.gcc
      pkgs.gnumake
      pkgs.ts_query_ls
      # bash
      pkgs.bash-language-server
      pkgs.shellcheck
      pkgs.shfmt
      # lua
      pkgs.emmylua-ls
      pkgs.lua-language-server
      pkgs.luajit
      pkgs.luarocks
      pkgs.stylua
      # rust
      pkgr.rustup
      # python
      pkgs.python3
      pkgs.ruff
      pkgs.ty
      pkgs.uv
      # data
      pkgs.markdownlint-cli
      pkgs.marksman
      pkgs.prettier
      pkgs.tombi
      pkgs.vscode-json-languageserver
      pkgs.yaml-language-server
      pkgs.yamllint
      # web
      pkgs.emmet-language-server
      pkgs.htmlhint
      pkgs.prettier
      pkgs.typescript-language-server
      pkgs.vscode-css-languageserver
      pkgs.superhtml # !!!
      # misc
      pkgs.glsl_analyzer
      pkgs.prettier
      pkgs.typos
      pkgs.typos-lsp
      pkgs.harper
      pkgs.hunspell
      pkgs.hunspellDicts.en_US
      pkgs.hunspellDicts.uk_UA
      pkgs.hyprls
      pkgs.systemd-lsp
      pkgs.vim-language-server
      pkgs.tinymist
      pkgs.just-lsp
      pkgs.nixfmt
      pkgs.nil
    ];
  };
}
