{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.fuzzel;
in
{
  options = {
    modules.fuzzel.enable = lib.mkEnableOption "fuzzel";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.fuzzel
    ];
  };
}
