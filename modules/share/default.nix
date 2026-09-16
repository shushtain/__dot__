{
  config,
  lib,
  pkgs,
  currentUser,
  ...
}:
let
  mod = config.modules.share;
in
{
  options = {
    modules.share.enable = lib.mkEnableOption "share";
  };

  config = lib.mkIf mod.enable {
    users.users.${currentUser}.packages = [
      pkgs.magic-wormhole
      pkgs.croc
    ];
  };
}
