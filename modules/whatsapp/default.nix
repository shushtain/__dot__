{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.whatsapp;
in
{
  options = {
    modules.whatsapp.enable = lib.mkEnableOption "whatsapp";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.whatsapp-electron
    ];
  };
}
