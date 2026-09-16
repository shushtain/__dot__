{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.blender;
in
{
  options = {
    modules.blender.enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.blender
    ];
  };
}
