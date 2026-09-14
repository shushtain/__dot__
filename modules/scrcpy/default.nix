{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.scrcpy;
in
{
  options = {
    modules.scrcpy.enable = lib.mkEnableOption "scrcpy";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser} = {
      packages = [
        pkgs.scrcpy
        pkgs.android-tools
      ];
      extraGroups = [ "adbusers" ];
    };
  };
}
