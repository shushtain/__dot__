{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.micro;
in
{
  options = {
    modules.micro.enable = lib.mkEnableOption "micro";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.kicad
      pkgs.arduino-cli
      pkgs.esptool
      pkgs.mpremote
    ];
  };
}
