{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.signal;
in
{
  options = {
    modules.signal.enable = lib.mkEnableOption "signal";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.signal-desktop
    ];
  };
}
