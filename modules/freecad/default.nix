{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.freecad;
in
{
  options = {
    modules.freecad.enable = lib.mkEnableOption "freecad";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.freecad
    ];
  };
}
