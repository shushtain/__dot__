{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.btop;
in
{
  options = {
    modules.btop.enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.btop
    ];
  };
}
