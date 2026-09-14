{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.dmentia;
in
{
  options = {
    modules.dmentia.enable = lib.mkEnableOption "dmentia";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.choose
      pkgs.fuzzel
    ];
  };
}
