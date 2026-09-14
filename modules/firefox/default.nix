{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.firefox;
in
{
  options = {
    modules.firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.firefox
    ];
  };
}
