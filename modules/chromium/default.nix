{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.chromium;
in
{
  options = {
    modules.chromium.enable = lib.mkEnableOption "chromium";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.chromium
    ];
  };
}
