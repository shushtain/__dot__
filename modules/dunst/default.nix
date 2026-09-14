{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.dunst;
in
{
  options = {
    modules.dunst.enable = lib.mkEnableOption "dunst";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.dunst
    ];
  };
}
