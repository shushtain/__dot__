{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.telegram;
in
{
  options = {
    modules.telegram.enable = lib.mkEnableOption "telegram";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.telegram-desktop
    ];
  };
}
