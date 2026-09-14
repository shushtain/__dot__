{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.nvim;
in
{
  options = {
    modules.nvim.enable = lib.mkEnableOption "nvim";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.neovim
    ];
  };
}
