{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.alacritty;
in
{
  options = {
    modules.alacritty.enable = lib.mkEnableOption "alacritty";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.alacritty
    ];
  };
}
