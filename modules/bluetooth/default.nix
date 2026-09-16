{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.bluetooth;
in
{
  options = {
    modules.bluetooth.enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.bluetui
      # pkgs.wlctl # XXX:
    ];
  };
}
